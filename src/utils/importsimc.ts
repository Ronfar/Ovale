import { format } from "@wowts/string";
import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from "fs";
import { Ovale } from "../Ovale";
import { eventDispatcher, ClassId } from "@wowts/wow-mock";
import { OvaleEquipment } from "../Equipment";
import { OvaleSpellBook } from "../SpellBook";
import { OvaleStance } from "../Stance";
import { OvaleSimulationCraft, Annotation } from "../SimulationCraft";
import  { registerScripts } from "../scripts/index";
import { getSpellData, PowerType, SpellPowerData, isFriendlyTarget, EffectType, SpellData, SpellAttributes } from "./importspells";
import { ipairs } from "@wowts/lua";
import { PowerType as OvalePowerType } from "../Power";

let outputDirectory = "src/scripts";
const simcDirectory = process.argv[2];
const profilesDirectory = simcDirectory + '/profiles/PreRaids';
const SIMC_CLASS = [
    "deathknight",
    "demonhunter",
    "druid",
    "hunter",
    "mage",
    "monk",
    "paladin",
    "priest",
    "rogue",
    "shaman",
    "warlock",
    "warrior"
];

function Canonicalize(s: string) {
    let token = "xXxUnDeRsCoReXxX";
    s = s.toLowerCase();
    s = s.replace(/[\s\-\_\(\)\{\}\[\]]/g, token);
    s = s.replace(/\./g, "");
    s = s.replace(/xXxUnDeRsCoReXxX/g, "_");
    s = s.replace("_+", "_");
    s = s.replace("^_", "");
    s = s.replace("_$", "");
    return s;
}

if (!existsSync(outputDirectory)) mkdirSync(outputDirectory);

const spellData = getSpellData(simcDirectory);

const limitLine1 = "// THE REST OF THIS FILE IS AUTOMATICALLY GENERATED";
const limitLine2 = "// ANY CHANGES MADE BELOW THIS POINT WILL BE LOST";

function truncateFile(fileName: string) {
    const file = readFileSync(fileName, { encoding: "utf8" });
    const lines = file.split("\n");
    let output: string[] = []
    for (const line of lines) {
        if (line.indexOf(limitLine1) >= 0) {
            break;
        }
        output.push(line);
    }
    output.push(limitLine1);
    output.push(limitLine2);
    output.push("");
    writeFileSync(fileName, output.join("\n"));
}

for (const simcClass of SIMC_CLASS) {
    truncateFile(outputDirectory + "/ovale_" + simcClass + ".ts");
}

let files: string[] = []
{
    let dir = readdirSync(profilesDirectory);
    for (const name of dir) {
        files.push(name);
    }
    files.sort();
}


const spellsByClass = new Map<string, number[]>();
const talentsByClass = new Map<string, number[]>();
const itemsByClass = new Map<string, number[]>();
const azeriteTraitByClass = new Map<string, number[]>();

for (const filename of files) {
    // if (filename.indexOf('Death_Knight') < 0) continue;
    if (!filename.startsWith("generate")) {
        let output: string[] = []
        let inputName = profilesDirectory + "/" + filename;
        let simc = readFileSync(inputName, { encoding: "utf8" });
        if (simc.indexOf("optimal_raid=") < 0) {
            let source: string, className: string, specialization: string;
            for (const line of simc.match(/[^\r\n]+/g)) {
                if (!source) {
                    if (line.substring(0, 3) == "### ") {
                        source = line.substring(4);
                    }
                }
                if (!className) {
                    for (const simcClass of SIMC_CLASS) {
                        let length = simcClass.length;
                        if (line.substring(0, length + 1) == simcClass + "=") {
                            className = simcClass.toUpperCase();
                        }
                    }
                }
                if (!specialization) {
                    if (line.substring(0, 5) == "spec=") {
                        specialization = line.substring(5);
                    }
                }
                if (className && specialization) {
                    break;
                }
            }
            
            console.log(filename);
            Ovale.playerGUID = "player";
            Ovale.playerClass = <ClassId>className;
            eventDispatcher.DispatchEvent("ADDON_LOADED", "Ovale");
            OvaleEquipment.UpdateEquippedItems();
            OvaleSpellBook.Update();
            OvaleStance.UpdateStances();
            registerScripts();

            const annotation: Annotation = {
                dictionary: Object.assign({}, spellData.identifiers)
            };
            let profile = OvaleSimulationCraft.ParseProfile(simc, annotation);
            let profileName = profile.annotation.name.substring(1, profile.annotation.name.length - 1);
            let name: string, desc: string;
            if (source) {
                desc = format("%s: %s", source, profileName);
            } else {
                desc = profileName;
            }
            name = Canonicalize(desc);
            output.push("");
            output.push("{");
            output.push(format('	const name = "sc_%s"', name));
            output.push(format('	const desc = "[8.0] Simulationcraft: %s"', desc));
            output.push("	const code = `");
            output.push(OvaleSimulationCraft.Emit(profile, true));
            output.push("`");
            output.push(format('	OvaleScripts.RegisterScript("%s", "%s", name, desc, code, "%s")', profile.annotation.class, profile.annotation.specialization, "script"));
            output.push("}");
            output.push("");
            let outputFileName = "ovale_" + className.toLowerCase() + ".ts";
            console.log("Appending to " + outputFileName + ": " + name);
            let outputName = outputDirectory + "/" + outputFileName;
            writeFileSync(outputName, output.join("\n"), { flag: 'a' });

            let classSpells = spellsByClass.get(className);
            if (!classSpells) {
                classSpells = [];
                spellsByClass.set(className, classSpells);
            }
            let classTalents = talentsByClass.get(className);
            if (!classTalents) {
                classTalents = [];
                talentsByClass.set(className, classTalents);
            }
            let classItems = itemsByClass.get(className);
            if (!classItems) {
                classItems = [];
                itemsByClass.set(className, classItems);
            }
            let azeriteTraits = azeriteTraitByClass.get(className);
            if (!azeriteTraits){
                azeriteTraits = [];
                azeriteTraitByClass.set(className, azeriteTraits);
            }
            const identifiers = ipairs(profile.annotation.symbolList).map(x => x[1]).sort();
            for (const symbol of identifiers) {
                const id = spellData.identifiers[symbol];
                if (symbol.match(/_talent/)) {
                    if (id && classTalents.indexOf(id) < 0) {
                        classTalents.push(id);
                    }
                } else if (symbol.match(/_item$/)) {
                    if (id && classItems.indexOf(id) < 0) {
                        classItems.push(id);
                    }
                } else if (symbol.match(/_trait$/)) {
                    if (id && azeriteTraits.indexOf(id) < 0) {
                        azeriteTraits.push(id);
                    }
                } else {
                    if (id && classSpells.indexOf(id) < 0) {
                        classSpells.push(id)
                    }
                }
            }
        }
    }
}

function getPowerName(power: PowerType): OvalePowerType | "runes" | "health" {
    switch (power) {
        case PowerType.POWER_ASTRAL_POWER:
            return "lunarpower";
        case PowerType.POWER_CHI:
            return "chi";
        case PowerType.POWER_COMBO_POINT:
            return "combopoints";
        case PowerType.POWER_ENERGY:
            return "energy";
        case PowerType.POWER_FOCUS:
            return "focus";
        case PowerType.POWER_FURY:
            return "fury";
        case PowerType.POWER_HEALTH:
            return "health";
        case PowerType.POWER_HOLY_POWER:
            return "holypower";
        case PowerType.POWER_INSANITY:
            return "insanity";
        case PowerType.POWER_MAELSTROM:
            return "maelstrom";
        case PowerType.POWER_MANA:
            return "mana";
        case PowerType.POWER_PAIN:
            return "pain";
        case PowerType.POWER_RAGE:
            return "rage";
        case PowerType.POWER_RUNE:
            return "runes";
        case PowerType.POWER_RUNIC_POWER:
            return "runicpower";
        case PowerType.POWER_SOUL_SHARDS:
            return "soulshards";
        case PowerType.POWER_ARCANE_CHARGES:
            return "arcanecharges";
        default:
            throw Error(`Unknown power type ${power}`);
    }
}

function getPowerDataValue(powerData: SpellPowerData) {
    return getPowerValue(powerData.power_type, powerData.cost);
}

function getPowerValue(powerType: PowerType, cost: number) {
    let divisor = 1;
    switch (powerType) {
        case PowerType.POWER_MANA:
            divisor = 100;
            break;
        case PowerType.POWER_RAGE:
        case PowerType.POWER_RUNIC_POWER:
        case PowerType.POWER_BURNING_EMBER:
        case PowerType.POWER_ASTRAL_POWER:
        case PowerType.POWER_PAIN:
        case PowerType.POWER_SOUL_SHARDS:
            divisor = 10;
            break;
        //case PowerType.POWER_DEMONIC_FURY:
          // return percentage ? 0.1 : 1.0;  
    }
    return cost / divisor;
}


function getTooltip(spell: SpellData) {
    return spell.tooltip.replace(/[\$\\{}%]/g, '');
}

function getDesc(spell: SpellData) {
    return spell.desc.replace(/[\$\\{}%]/g, '');
}

for (const [className, spellIds] of spellsByClass) {
    let output = `// THIS PART OF THIS FILE IS AUTOMATICALLY GENERATED
${limitLine2}
    let code = \``;        
    const talentIds = talentsByClass.get(className) || [];
    const spells: SpellData[] = [];
    for (const spellId of spellIds) {
        const spell = spellData.spellDataById.get(spellId);
        spells.push(spell);
    }

    for (const spell of spells.sort((x, y) => x.name < y.name ? -1 : 1)) {
        if (!spell) continue;
        output += `Define(${spell.identifier} ${spell.id})\n`;
        if (spell.desc) output += `# ${getDesc(spell)}\n`;
        output += `  SpellInfo(${spell.identifier}`;
        if (spell.spellPowers) {
            for (const power of spell.spellPowers) {
                const powerName = getPowerName(power.power_type);
                if (power.cost) {
                    output += ` ${powerName}=${getPowerDataValue(power)}`
                }
            }
        }
        if (spell.cooldown) {
            output += ` cd=${spell.cooldown / 1000}`;
        }
        if (spell.charge_cooldown) {
            output += ` cd=${spell.charge_cooldown / 1000}`;
        }
        if (spell.duration && spell.duration > 0) {
            output += ` duration=${spell.duration / 1000}`;
        }
        if (spell.attributes.some(x => (x & (SpellAttributes.Channeled | SpellAttributes.Channeled2)) > 0)) {
            output += ` channel=${spell.duration / 1000}`;
        }
        if (spell.max_stack) {
            output += ` max_stacks=${spell.max_stack}`;
        }
        if (spell.replace_spell_id && spellIds.indexOf(spell.replace_spell_id) >= 0) {
            const replacedSpell = spellData.spellDataById.get(spell.replace_spell_id);
            if (replacedSpell) {
                output += ` replace=${replacedSpell.identifier}`;
            }
        }
        if (spell.talent) {
            output += ` talent=${spell.talent.identifier}`;
            if (talentIds.indexOf(spell.talent.id) < 0) talentIds.push(spell.talent.id);
        }
        
        if (spell.gcd !== 1500) {
            output += ` gcd=${spell.gcd/1000}`;
            if (spell.gcd === 0) {
                output += ` offgcd=1`;
            }
        }

        let tick = 0;
        if (spell.spellEffects) {
            for (const effect of spell.spellEffects) {
                if (effect.type === EffectType.E_ENERGIZE) {
                    output += ` ${getPowerName(effect.misc_value)}=${-getPowerValue(effect.misc_value, effect.base_value)}`;
                } else if (effect.type === EffectType.E_INTERRUPT_CAST) {
                    output += ` interrupt=1`;
                }
                if (effect.amplitude > 0) {
                    tick = effect.amplitude / 1000;
                }
            }
        }
        if (tick > 0) {
            output += ` tick=${tick}`;
        }

        output += `)\n`;
        let buffAdded = false;
        let debuffAdded = false;
        if (spell.spellEffects) {
            for (const effect of spell.spellEffects) {
                if (effect.trigger_spell_id) {
                    const triggerSpell = spellData.spellDataById.get(effect.trigger_spell_id);
                    if (triggerSpell === undefined) {
                        // console.log(`Can't find spell ${effect.trigger_spell_id} triggered by ${spell.name}`);
                        continue;
                    }
                    if (spellIds.indexOf(triggerSpell.id) < 0) continue;
                    if (triggerSpell.tooltip) output += `  # ${getTooltip(triggerSpell)}\n`;
                    if (isFriendlyTarget(effect.targeting_1)) {
                        output += `  SpellAddBuff(${spell.identifier} ${triggerSpell.identifier}=1)\n`;
                    } else {
                        output += `  SpellAddTargetDebuff(${spell.identifier} ${triggerSpell.identifier}=1)\n`;
                    }
                } else if (effect.type === EffectType.E_APPLY_AURA) {
                    if (isFriendlyTarget(effect.targeting_1)) {
                        if (!buffAdded) {
                            buffAdded = true;
                            if (spell.tooltip) output += `  # ${getTooltip(spell)}\n`;
                            output += `  SpellAddBuff(${spell.identifier} ${spell.identifier}=1)\n`;
                        }
                    } else if (!debuffAdded) {
                        debuffAdded = true;
                        if (spell.tooltip) output += `  # ${getTooltip(spell)}\n`;
                        output += `  SpellAddTargetDebuff(${spell.identifier} ${spell.identifier}=1)\n`;
                    }
                }
            }
        }

//         if (!buffAdded && !debuffAdded && !spell.tooltip && spell.duration) {
//             output += `Define(${spell.identifier}_dummy -${spell.id})
//     SpellInfo(${spell.identifier}_dummy duration=${spell.duration})
//     SpellAddBuff(${spell.identifier} ${spell.identifier}_dummy=1)
// `
//         }
    }

    const talents = talentIds.map(x => spellData.talentsById.get(x)).filter(x => x !== undefined).sort((x,y) => x.name > y.name ? 1 : -1);
    for (let i = 0; i < talents.length; i++) {
        const talent = talents[i];
        output += `Define(${talent.identifier} ${talent.talentId}) #${talent.id}\n`;
        const spell = spellData.spellDataById.get(talent.spell_id);
        if (spell && spell.desc) {
            output += `# ${getDesc(spell)}\n`;
        }
    }
    
    const itemIds = itemsByClass.get(className);
    if (itemIds) {
        for (const itemId of itemIds) {
            const item = spellData.itemsById.get(itemId);
            output += `Define(${item.identifier} ${itemId})\n`;
        }
    }

    const traitsIds = azeriteTraitByClass.get(className);
    if (traitsIds) {
        for (const traitId of traitsIds) {
            const trait = spellData.azeriteTraitById.get(traitId);
            output += `Define(${trait.identifier} ${trait.spellId})\n`;
        }
    }

    output+=`    \`;
// END`;

    const fileName = outputDirectory + "/ovale_" + className + "_spells.ts";
    let existing = readFileSync(fileName, { encoding: 'utf8'});
    const lines = output.split('\n');
    for (const line of lines) {
        if (line.indexOf("//") >= 0 || line.indexOf('`') >= 0) continue;
        existing = existing.split(line.trim()).join("");
    }
    output = existing.replace(/\/\/ THIS PART OF THIS FILE IS AUTOMATICALLY GENERATED[^]*\/\/ END/, output);
    writeFileSync(fileName, output, { encoding: 'utf8'});
}