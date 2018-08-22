local __exports = LibStub:NewLibrary("ovale/scripts/ovale_monk_spells", 80000)
if not __exports then return end
local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts
__exports.register = function()
    local name = "ovale_monk_spells"
    local desc = "[8.0.1] Ovale: Monk spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you their power for 274739d.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(battle_potion_of_agility 279152)
# Increases your Agility by s1 for d.
  SpellInfo(battle_potion_of_agility cd=1 duration=25 gcd=0 offgcd=1)
  # Agility increased by w1.
  SpellAddBuff(battle_potion_of_agility battle_potion_of_agility=1)
Define(berserking 26297)
# Increases your haste by s1 for d.
  SpellInfo(berserking cd=180 duration=10 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(berserking berserking=1)
Define(black_ox_brew 115399)
# Chug some Black Ox Brew, which instantly refills your Energy, and your Ironskin Brew and Purifying Brew charges.
  SpellInfo(black_ox_brew cd=120 talent=black_ox_brew_talent gcd=0 offgcd=1 energy=-200)
Define(blackout_combo_buff 228563)
# @spelldesc196736
  SpellInfo(blackout_combo_buff duration=15 gcd=0 offgcd=1)
  # Your next ability is empowered.
  SpellAddBuff(blackout_combo_buff blackout_combo_buff=1)
Define(blackout_kick_windwalker 261917)
# Blackout Kick costs s1 fewer Chi.
  SpellInfo(blackout_kick_windwalker channel=0 gcd=0 offgcd=1)
  SpellAddBuff(blackout_kick_windwalker blackout_kick_windwalker=1)
Define(blackout_strike 205523)
# Strike with a blast of Chi energy, dealing s1 Physical damage?s117906[ and generating a stack of Elusive Brawler][].
  SpellInfo(blackout_strike cd=3)
Define(breath_of_fire 115181)
# Breathe fire on targets in front of you, causing s1 Fire damage.rnrnTargets affected by Keg Smash will also burn, taking 123725o1 Fire damage and dealing 123725s2 reduced damage to you for 123725d.
  SpellInfo(breath_of_fire cd=15 gcd=1)
Define(chi_burst 123986)
# Hurls a torrent of Chi energy up to 40 yds forward, dealing 148135s1 Nature damage to all enemies, and 130654s1 healing to the Monk and all allies in its path.?c1[rnrnCasting Chi Burst does not prevent avoiding attacks.][]?c3[rnrnChi Burst generates 1 Chi per enemy target damaged, up to a maximum of s3.][]
  SpellInfo(chi_burst cd=30 duration=1 talent=chi_burst_talent)
Define(chi_wave 115098)
# A wave of Chi energy flows through friends and foes, dealing 132467s1 Nature damage or 132463s1 healing. Bounces up to s1 times to targets within 132466a2 yards.
  SpellInfo(chi_wave cd=15 talent=chi_wave_talent)
Define(crackling_jade_lightning 117952)
# Channel Jade lightning, causing o1 Nature damage over 117952d to the target?a154436[, generating 1 Chi each time it deals damage,][] and sometimes knocking back melee attackers.
  SpellInfo(crackling_jade_lightning energy=20 energy=20 duration=4 channel=4 tick=1)
  # Taking w1 damage every t1 sec.
  SpellAddTargetDebuff(crackling_jade_lightning crackling_jade_lightning=1)
Define(dampen_harm 122278)
# Reduces all damage you take by m2 to m3 for d, with larger attacks being reduced by more.
  SpellInfo(dampen_harm cd=120 duration=10 talent=dampen_harm_talent gcd=0 offgcd=1)
  # Damage taken reduced by m2 to m3 for d, with larger attacks being reduced by more.
  SpellAddBuff(dampen_harm dampen_harm=1)
Define(energizing_elixir 115288)
# Chug an Energizing Elixir, refilling all your Energy and instantly generate s2 Chi.
  SpellInfo(energizing_elixir cd=60 max_stacks=3 talent=energizing_elixir_talent gcd=1 energy=-200 chi=-2)
Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 265226d. 
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(fist_of_the_white_tiger 261947)
# Strike with the technique of the White Tiger, dealing s1+261977s1 Physical damage.rnrn|cFFFFFFFFGenerates 261978s1 Chi.
  SpellInfo(fist_of_the_white_tiger energy=40 cd=30 talent=fist_of_the_white_tiger_talent gcd=1)
Define(fists_of_fury 113656)
# Pummels all targets in front of you, dealing 5*s5 damage over 113656d to your primary target and 5*s5*s6/100 damage over 113656d to other targets. Can be channeled while moving.
  SpellInfo(fists_of_fury chi=3 cd=24 duration=4 channel=4 gcd=1 tick=0.166)
  # w3 damage every t3 sec. ?s125671[Parrying all attacks.][]
  SpellAddBuff(fists_of_fury fists_of_fury=1)
Define(fortifying_brew 115203)
# Turns your skin to stone for 120954d, increasing your current and maximum health by <health>, increasing the effectiveness of Stagger by s1, and reducing all damage you take by <damage>.
  SpellInfo(fortifying_brew cd=420 gcd=0 offgcd=1)
Define(ironskin_brew 115308)
# A swig of strong brew allows you to Stagger substantially more damage for 215479d. rnrnShares charges with Purifying Brew.
  SpellInfo(ironskin_brew cd=1 cd=15 gcd=0 offgcd=1)
Define(keg_smash 121253)
# Smash a keg of brew on the target, dealing s2 damage to all enemies within A2 yds and reducing their movement speed by m3 for d.rnrnReduces the remaining cooldown on your Brews by s4 sec.
  SpellInfo(keg_smash energy=40 cd=1 cd=8 duration=15 gcd=1)
  # ?w3!=0[Movement speed reduced by w3.rn][]Drenched in brew, vulnerable to Breath of Fire.
  SpellAddTargetDebuff(keg_smash keg_smash=1)
Define(leg_sweep 119381)
# Knocks down all enemies within A1 yards, stunning them for d.
  SpellInfo(leg_sweep cd=60 duration=3)
  # Stunned.
  SpellAddTargetDebuff(leg_sweep leg_sweep=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)
Define(paralysis 115078)
# Incapacitates the target for d. Limit 1. Damage will cancel the effect.
  SpellInfo(paralysis energy=20 energy=20 cd=45 duration=60)
  # Incapacitated.
  SpellAddTargetDebuff(paralysis paralysis=1)
Define(purifying_brew 119582)
# Clears s1 of your damage delayed with Stagger.rnrnShares charges with Ironskin Brew.
  SpellInfo(purifying_brew cd=1 cd=15 gcd=0 offgcd=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for d, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(rising_sun_kick 107428)
# Kick upwards, dealing ?s137025[185099s1*<CAP>/AP][185099s1] Physical damage?s128595[, and reducing the effectiveness of healing on the target for 115804d][].
  SpellInfo(rising_sun_kick chi=2 cd=10)
Define(rushing_jade_wind 116847)
# Summons a whirling tornado around you, causing (1+d/t1)*148187s1 damage over d to enemies within 107270A1 yards.?s220357[ Applies Mark of the Crane to up to s2 nearby targets.][]
  SpellInfo(rushing_jade_wind chi=1 cd=6 duration=6 talent=rushing_jade_wind_talent tick=0.75)
Define(serenity 152173)
# Enter an elevated state of mental and physical serenity for ?s115069[s1 sec][d]. While in this state, you deal s2 increased damage and healing, and all Chi consumers are free and cool down s4 more quickly.
  SpellInfo(serenity cd=90 duration=12 talent=serenity_talent gcd=1)
  # Damage and healing increased by w2.rnAll Chi consumers are free and cool down w4 more quickly.
  SpellAddBuff(serenity serenity=1)
Define(spear_hand_strike 116705)
# Jabs the target in the throat, interrupting spellcasting and preventing any spell from that school of magic from being cast for 116705d.
  SpellInfo(spear_hand_strike cd=15 duration=4 gcd=0 offgcd=1 interrupt=1)
Define(spinning_crane_kick 101546)
# Spin while kicking in the air, dealing ?s137025[4*107270s1*<CAP>/AP][4*107270s1] Physical damage over d to enemies within 107270A1 yds.?c3&s116847[rnrnSpinning Crane Kick's damage is increased by 220358s1 for each unique target you've struck in the last 220358d with Tiger Palm, Blackout Kick, Rising Sun Kick, or Rushing Jade Wind.]?c3[rnrnSpinning Crane Kick's damage is increased by 220358s1 for each unique target you've struck in the last 220358d with Tiger Palm, Blackout Kick, or Rising Sun Kick.][]
  SpellInfo(spinning_crane_kick chi=2 chi=3 duration=1.5 channel=1.5 tick=0.5)
  # Attacking all nearby enemies for Physical damage every 101546t1 sec.
  SpellAddBuff(spinning_crane_kick spinning_crane_kick=1)
Define(the_emperors_capacitor_buff 235054)
# @spelldesc235053
  SpellInfo(the_emperors_capacitor_buff max_stacks=20 gcd=0 offgcd=1)
  # Damage of next Crackling Jade Lightning increased by s1.rnEnergy cost of next Crackling Jade Lightning reduced by s2.
  SpellAddBuff(the_emperors_capacitor_buff the_emperors_capacitor_buff=1)
Define(tiger_palm 100780)
# Attack with the palm of your hand, dealing s1 damage.?a137384[rnrnTiger Palm has an 137384m1 chance to make your next Blackout Kick cost no Chi.][]?a137023[rnrnReduces the remaining cooldown on your Brews by s3 sec.][]?a137025[rnrn|cFFFFFFFFGenerates s2 Chi.][]
  SpellInfo(tiger_palm energy=50 energy=50 chi=0)
Define(touch_of_death 115080)
# Inflict mortal damage on an enemy, causing the target to take damage equal to s2 of your maximum health after d, reduced against players.rnrnDuring the d duration, 271232s1 of all other damage you deal to the target will be added to the final damage dealt.
  SpellInfo(touch_of_death cd=120 duration=8 tick=8)
  # Taking w1 damage when this effect expires.
  SpellAddTargetDebuff(touch_of_death touch_of_death=1)
Define(touch_of_karma 122470)
# All damage you take is redirected to the enemy target as Nature damage over 124280d. Damage cannot exceed s3 of your maximum health. Lasts d.
  SpellInfo(touch_of_karma cd=90 duration=10 gcd=0 offgcd=1)
  # All damage dealt to the Monk is redirected to you as Nature damage over 124280d.
  SpellAddTargetDebuff(touch_of_karma touch_of_karma=1)
  # All damage dealt to the Monk is redirected to you as Nature damage over 124280d.
  SpellAddBuff(touch_of_karma touch_of_karma=1)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for d.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(whirling_dragon_punch 152175)
# Performs a devastating whirling upward strike, dealing 3*158221s1 damage to all nearby enemies. Only usable while both Fists of Fury and Rising Sun Kick are on cooldown.
  SpellInfo(whirling_dragon_punch cd=24 duration=1 talent=whirling_dragon_punch_talent gcd=1 tick=0.25)
  SpellAddBuff(whirling_dragon_punch whirling_dragon_punch=1)
Define(black_ox_brew_talent 9) #19992
# Chug some Black Ox Brew, which instantly refills your Energy, and your Ironskin Brew and Purifying Brew charges.
Define(blackout_combo_talent 21) #22108
# Blackout Strike also empowers your next ability:rnrnTiger Palm: Damage increased by s1.rnBreath of Fire: Cooldown reduced by s2 sec.rnKeg Smash: Reduces the remaining cooldown on your Brews by s3 additional sec.rnIronskin Brew: Pauses Stagger damage for s4 sec.
Define(chi_burst_talent 3) #20185
# Hurls a torrent of Chi energy up to 40 yds forward, dealing 148135s1 Nature damage to all enemies, and 130654s1 healing to the Monk and all allies in its path.?c1[rnrnCasting Chi Burst does not prevent avoiding attacks.][]?c3[rnrnChi Burst generates 1 Chi per enemy target damaged, up to a maximum of s3.][]
Define(chi_wave_talent 2) #19820
# A wave of Chi energy flows through friends and foes, dealing 132467s1 Nature damage or 132463s1 healing. Bounces up to s1 times to targets within 132466a2 yards.
Define(dampen_harm_talent 15) #20175
# Reduces all damage you take by m2 to m3 for d, with larger attacks being reduced by more.
Define(energizing_elixir_talent 9) #22096
# Chug an Energizing Elixir, refilling all your Energy and instantly generate s2 Chi.
Define(fist_of_the_white_tiger_talent 8) #19771
# Strike with the technique of the White Tiger, dealing s1+261977s1 Physical damage.rnrn|cFFFFFFFFGenerates 261978s1 Chi.
Define(good_karma_talent 11) #23364
# Touch of Karma can now redirect an additional s1 of your maximum health.
Define(rushing_jade_wind_talent_windwalker 17) #23122
# Summons a whirling tornado around you, causing (1+d/t1)*148187s1 damage every t1 sec to all enemies within 107270A1 yards.
Define(rushing_jade_wind_talent 17) #20184
# Summons a whirling tornado around you, causing (1+d/t1)*148187s1 damage over d to enemies within 107270A1 yards.?s220357[ Applies Mark of the Crane to up to s2 nearby targets.][]
Define(serenity_talent 21) #21191
# Enter an elevated state of mental and physical serenity for ?s115069[s1 sec][d]. While in this state, you deal s2 increased damage and healing, and all Chi consumers are free and cool down s4 more quickly.
Define(whirling_dragon_punch_talent 20) #22105
# Performs a devastating whirling upward strike, dealing 3*158221s1 damage to all nearby enemies. Only usable while both Fists of Fury and Rising Sun Kick are on cooldown.
Define(drinking_horn_cover_item 137097)
Define(hidden_masters_forbidden_touch_item 137057)
Define(the_emperors_capacitor_item 144239)
    ]]
    code = code .. [[
ItemRequire(shifting_cosmic_sliver unusable 1=oncooldown,!fortifying_brew,buff,!fortifying_brew_buff)

## Spells

	SpellInfo(blackout_combo_buff duration=15)

	SpellInfo(blackout_kick cd=3)
	SpellInfo(blackout_kick chi=1 specialization=windwalker)
	SpellRequire(blackout_kick chi_percent 0=buff,blackout_kick_free specialization=windwalker)
	SpellAddBuff(blackout_kick blackout_kick_buff=0)
	SpellAddBuff(blackout_kick teachings_of_the_monastery_buff=0)
	SpellAddTargetDebuff(blackout_kick mark_of_the_crane_debuff=1 specialization=!mistweaver)
Define(blackout_kick_buff 116768)
	SpellInfo(blackout_kick_buff duration=15)
SpellList(blackout_kick_free blackout_kick_buff serenity_buff)

	
	SpellAddBuff(blackout_strike blackout_combo_buff=1 talent=blackout_combo_talent)

	SpellInfo(black_ox_brew cd=120 gcd=0 offgcd=1 talent=black_ox_brew_talent)

	SpellInfo(breath_of_fire cd=15)
	SpellAddTargetDebuff(breath_of_fire breath_of_fire_debuff=1 if_target_debuff=keg_smash_debuff)
	SpellAddBuff(breath_of_fire blackout_combo_buff=0)
Define(breath_of_fire_debuff 123725)
	SpellInfo(breath_of_fire_debuff duration=12 tick=2)

	SpellInfo(chi_burst cd=30 travel_time=1 tag=main)
	SpellInfo(chi_burst chi=-1 max_chi=-2 specialization=windwalker)
Define(chi_torpedo 115008)
	SpellInfo(chi_torpedo charges=2 cd=20)
	SpellAddBuff(chi_torpedo )
Define(chi_torpedo_buff 119085)
	SpellInfo(chi_torpedo_buff duration=10)

	SpellInfo(chi_wave cd=15)

	SpellInfo(crackling_jade_lightning channel=4)
	SpellInfo(crackling_jade_lightning haste=melee specialization=!mistweaver)
	SpellInfo(crackling_jade_lightning haste=spell specialization=mistweaver)

	SpellInfo(dampen_harm cd=120 gcd=0 offgcd=1)
	SpellAddBuff(dampen_harm dampen_harm_buff=1)
Define(dampen_harm_buff 122278)
	SpellInfo(dampen_harm_buff duration=10)
Define(detox_mistweaver 115450)
	SpellInfo(detox_mistweaver cd=8)
Define(detox 218164)
	SpellInfo(detox energy=20 cd=8)
Define(diffuse_magic 122783)
	SpellInfo(diffuse_magic cd=90 gcd=0 offgcd=1)
Define(diffuse_magic_buff 122783)
	SpellInfo(diffuse_magic_buff duration=6)
Define(disable 116095)
	SpellInfo(disable energy=15)
	SpellAddTargetDebuff(disable disable_debuff=1)
	SpellAddTargetDebuff(disable disable_root_debuff=1 if_target_debuff=disable_debuff)
Define(disable_debuff 116095)
	SpellInfo(disable_debuff duration=15)
Define(disable_root_debuff 116706)
	SpellInfo(disable_root_debuff duration=8)
Define(elusive_brew_stacks_buff 128939)
	SpellInfo(elusive_brew_stacks_buff duration=30 max_stacks=15)
Define(elusive_dance_buff 196739)
	SpellInfo(elusive_dance_buff duration=6)

	SpellInfo(energizing_brew chi=-2 cd=60 gcd=0 offgcd=1)
Define(enveloping_mist 124682)
	SpellAddBuff(enveloping_mist thunder_focus_tea_buff=-1 if_spell=thunder_focus_tea)
	SpellAddTargetBuff(enveloping_mist enveloping_mist_buff=1)
Define(enveloping_mist_buff 132120)
	SpellInfo(enveloping_mist_buff duration=6 tick=1 haste=spell)
Define(essence_font 191837)
	SpellInfo(essence_font cd=12 channel=3 haste=spell)
Define(essence_font_buff 191837)
	SpellInfo(essence_font_buff duration=8 tick=2 haste=spell)
Define(expel_harm 115072)
	SpellInfo(expel_harm energy=15 specialization=brewmaster unusable=1)
	SpellRequire(expel_harm unusable 0=spellcount_min,1,debuff,!healing_immunity_debuff)
Define(eye_of_the_tiger_debuff 196608)
	SpellInfo(eye_of_the_tiger_debuff duration=8)

	SpellInfo(fist_of_the_white_tiger cd=30 chi=-3 energy=40)
	SpellAddTargetDebuff(fist_of_the_white_tiger mark_of_the_crane_debuff=1 specialization=!mistweaver)

	SpellInfo(fists_of_fury chi=3 channel=4 cd=24 cd_haste=melee haste=melee)
	SpellRequire(fists_of_fury chi_percent 0=buff,serenity_buff)
Define(flying_serpent_kick 101545)
	SpellInfo(flying_serpent_kick cd=25)

	
	SpellAddBuff(fortifying_brew fortifying_brew_buff=1)
Define(fortifying_brew_buff 120954)
	SpellInfo(fortifying_brew_buff duration=15)
Define(fortifying_brew_mistweaver 243435)
	SpellInfo(fortifying_brew_mistweaver cd=90 gcd=0 offgcd=1)	SpellAddBuff(fortifying_brew_mistweaver fortifying_brew_mistweaver_buff=1)
Define(fortifying_brew_mistweaver_buff 243435)
	SpellInfo(fortifying_brew_mistweaver_buff duration=15)
Define(guard 115295)
	SpellInfo(guard cd=30)
	SpellAddBuff(guard guard_buff=1)
Define(guard_buff 115295)
	SpellInfo(guard_buff duration=8)
Define(healing_elixir 122281)
	SpellInfo(healing_elixir charges=2 cd=30 unusable=1)
	SpellInfo(healing_elixir unusable=0 talent=healing_elixir_talent specialization=brewmaster)
	SpellInfo(healing_elixir unusable=0 talent=healing_elixir_talent_mistweaver specialization=mistweaver)
	SpellRequire(healing_elixir unusable 1=debuff,healing_immunity_debuff)
Define(invoke_chiji_the_red_crane 198664)
	SpellInfo(invoke_chiji_the_red_crane cd=180 talent=invoke_chiji_talent)
Define(invoke_niuzao_the_black_ox 132578)
	SpellInfo(invoke_niuzao_the_black_ox cd=180 talent=invoke_niuzao_talent)
Define(invoke_xuen_the_white_tiger 123904)
	SpellInfo(invoke_xuen_the_white_tiger cd=180 talent=invoke_xuen_talent)

	SpellInfo(ironskin_brew cd=15 charges=3 gcd=0 offgcd=1 cd_haste=melee)
	SpellInfo(ironskin_brew add_cd=-3 charges=4 talent=light_brewing_talent)
	SpellAddBuff(ironskin_brew ironskin_brew_buff=1)
	SpellAddBuff(ironskin_brew blackout_combo_buff=0)
Define(ironskin_brew_buff 215479)
	SpellInfo(ironskin_brew_buff duration=7)

	SpellInfo(keg_smash charges=1 cd=8 energy=40 cd_haste=melee)
	SpellAddTargetDebuff(keg_smash keg_smash_debuff=1)
	SpellAddBuff(keg_smash blackout_combo_buff=0)
Define(keg_smash_debuff 121253)
	SpellInfo(keg_smash_debuff duration=15)

	SpellInfo(leg_sweep cd=60 interrupt=1)
	SpellInfo(leg_sweep add_cd=-10 talent=tiger_tail_sweep_talent)
	SpellAddTargetDebuff(leg_sweep leg_sweep_debuff=1)
Define(leg_sweep_debuff 119381)
	SpellInfo(leg_sweep_debuff duration=3)
Define(life_cocoon 116849)
	SpellInfo(life_cocoon cd=120)
	SpellAddTargetBuff(life_cocoon life_cocoon_buff=1)
Define(life_cocoon_buff 116849)
	SpellInfo(life_cocoon_buff duration=12)
Define(mana_tea 197908)
	SpellInfo(mana_tea cd=90)
Define(mana_tea_buff 197908)
	SpellInfo(mana_tea_buff duration=12)
Define(mark_of_the_crane_debuff 228287)
    SpellInfo(mark_of_the_crane_debuff duration=15)
Define(mystic_touch 8647)
Define(mystic_touch_debuff 113746)

	SpellInfo(paralysis cd=45 interrupt=1)
Define(provoke 115546)
	SpellInfo(provoke cd=8)

	SpellInfo(purifying_brew cd=15 charges=3 gcd=0 offgcd=1 cd_haste=melee)
	SpellInfo(purifying_brew add_cd=-3 charges=4 talent=light_brewing_talent)
	SpellInfo(purifying_brew unusable=1)
	SpellAddBuff(purifying_brew blackout_combo_buff=0)
	SpellRequire(purifying_brew unusable 0=debuff,any_stagger_debuff)
Define(reawaken 212051)
Define(refreshing_jade_wind 196725)
	SpellInfo(refreshing_jade_wind cd=9 mana=700 cd_haste=spell)
Define(refreshing_jade_wind_buff 196725)
	SpellInfo(refreshing_jade_wind_buff duration=9 tick=0.8 haste=spell)
Define(renewing_mist 115151)
	SpellInfo(renewing_mist cd=9)
	SpellAddBuff(renewing_mist thunder_focus_tea_buff=-1 if_spell=thunder_focus_tea)
	SpellAddTargetBuff(renewing_mist renewing_mist_buff=1)
Define(renewing_mist_buff 119611)
	SpellInfo(renewing_mist_buff duration=18 haste=spell tick=2)
	SpellInfo(renewing_mist_buff add_duration=1 talent=mist_wrap_talent)
Define(resuscitate 115178)
Define(revival 115310)
	SpellInfo(revival cd=180)
Define(ring_of_peace 116844)
	SpellInfo(ring_of_peace cd=45)

	SpellInfo(rising_sun_kick cd=10 chi=2 specialization=windwalker cd_haste=melee)
	SpellRequire(rising_sun_kick chi_percent 0=buff,serenity_buff)
	SpellAddBuff(rising_sun_kick thunder_focus_tea_buff=-1 if_spell=thunder_focus_tea specialization=mistweaver)
	SpellAddTargetDebuff(rising_sun_kick mark_of_the_crane_debuff=1 specialization=!mistweaver)
Define(roll 109132)
	SpellInfo(roll cd=20 charges=2)
	SpellInfo(roll charges=3 talent=celerity_talent)
	SpellInfo(roll replace=chi_torpedo talent=chi_torpedo_talent)

	SpellInfo(rushing_jade_wind cd=6 cd_haste=melee talent=rushing_jade_wind_talent)
	SpellAddBuff(rushing_jade_wind rushing_jade_wind_buff=1)
Define(rushing_jade_wind_buff 116847)
	SpellInfo(rushing_jade_wind_buff duration=9 haste=melee)
Define(rushing_jade_wind_windwalker 261715)
	SpellInfo(rushing_jade_wind cd=6 cd_haste=melee talent=rushing_jade_wind_talent)
Define(rushing_jade_wind_windwalker_buff 261715)
	SpellInfo(rushing_jade_wind_windwalker_buff tick=0.88 haste=melee)

	SpellInfo(serenity cd=90)
	SpellAddBuff(serenity serenity_buff=1)
Define(serenity_buff 152173)
	SpellInfo(serenity_buff duration=12)
Define(song_of_chiji 198898)
	SpellInfo(song_of_chiji cd=30)
	SpellAddTargetDebuff(song_of_chiji song_of_chiji_debuff=1)
Define(song_of_chiji_debuff 198909)
	SpellInfo(song_of_chiji_debuff duration=20)
Define(soothing_mist 115175)
	SpellInfo(soothing_mist cd=1 channel=8 haste=spell)
	SpellInfo(soothing_mist soothing_mist_buff=1)
Define(soothing_mist_buff 115175)
	SpellInfo(soothing_mist_buff duration=8 haste=spell tick=1)

	SpellInfo(spear_hand_strike cd=15 gcd=0 interrupt=1 offgcd=1)

	SpellInfo(spinning_crane_kick channel=1.5 tick=0.5)
	SpellInfo(spinning_crane_kick chi=2 haste=melee specialization=windwalker)
	SpellInfo(spinning_crane_kick haste=spell specialization=mistweaver)
	SpellRequire(spinning_crane_kick chi_percent 0=buff,serenity_buff)
Define(storm_earth_and_fire 137639)
	SpellInfo(storm_earth_and_fire tag=cd gcd=0 offgcd=1 charges=2)
	SpellInfo(storm_earth_and_fire replace=serenity talent=serenity_talent)
	SpellAddBuff(storm_earth_and_fire storm_earth_and_fire_buff=1)
Define(storm_earth_and_fire_buff 137639)
	SpellInfo(storm_earth_and_fire_buff duration=15)
Define(summon_black_ox_statue 115315)
	SpellInfo(summon_black_ox_statue cd=10 duration=900 totem=1)
Define(summon_jade_serpent_statue 115313)
	SpellInfo(summon_jade_serpent_statue cd=10 duration=900 totem=1)
Define(teachings_of_the_monastery 116645)
Define(teachings_of_the_monastery_buff 202090)
	SpellInfo(teachings_of_the_monastery_buff duration=12 max_stacks=3)
Define(thunder_focus_tea 116680)
	SpellInfo(thunder_focus_tea cd=30 gcd=0 offgcd=1)
	SpellAddBuff(thunder_focus_tea thunder_focus_tea_buff=1)
	SpellAddBuff(thunder_focus_tea thunder_focus_tea_buff=2 talent=focused_thunder_talent)
Define(thunder_focus_tea_buff 116680)
	SpellInfo(thunder_focus_tea_buff duration=30)

	SpellInfo(tiger_palm energy=50 specialization=windwalker)
	SpellInfo(tiger_palm energy=25 specialization=brewmaster)
	SpellAddBuff(tiger_palm teachings_of_the_monastery_buff=1)
	SpellAddBuff(tiger_palm blackout_combo_buff=0 specialization=mistweaver)
	SpellAddTargetDebuff(tiger_palm eye_of_the_tiger_debuff=1 specialization=!mistweaver talent=eye_of_the_tiger_talent)
	SpellAddTargetDebuff(rising_sun_kick mark_of_the_crane_debuff=1 specialization=!mistweaver)
Define(tigers_lust 116841)
	SpellInfo(tigers_lust cd=30)
	SpellAddBuff(tigers_lust tigers_lust_buff=1)
Define(tigers_lust_buff 116841)
	SpellInfo(tigers_lust_buff duration=6)

	SpellInfo(touch_of_death cd=120 tag=main)
	SpellAddTargetDebuff(touch_of_death touch_of_death_debuff=1)
	SpellRequire(touch_of_death unusable 1=target_debuff,touch_of_death_debuff)
Define(touch_of_death_debuff 115080)
	SpellInfo(touch_of_death_debuff duration=8)

	SpellInfo(touch_of_karma cd=90 tag=cd gcd=0 offgcd=1)
	SpellAddTargetDebuff(touch_of_karma touch_of_karma_debuff=1)
Define(touch_of_karma_debuff 122470)
	SpellInfo(touch_of_karma_debuff duration=10)
Define(transcendence 101643)
Define(transcendence_transfer 119996)
Define(vivify 116670)
	SpellAddBuff(vivify thunder_focus_tea_buff=-1 if_spell=thunder_focus_tea)

	SpellInfo(whirling_dragon_punch cd=24 unusable=1 cd_haste=melee)
	SpellRequire(whirling_dragon_punch unusable 0=oncooldown,rising_sun_kick)
	SpellRequire(whirling_dragon_punch unusable 0=oncooldown,fists_of_fury)
Define(zen_meditation 115176)
	SpellInfo(zen_meditation cd=300 gcd=0 offgcd=1)
	SpellAddBuff(zen_meditation zen_meditation_buff=1)
Define(zen_meditation_buff 115176)
	SpellInfo(zen_meditation_buff duration=8)
	
## Stagger
Define(stagger 115069)
Define(heavy_stagger_debuff 124273)
	SpellInfo(heavy_stagger_debuff duration=10 tick=1)
	SpellInfo(heavy_stagger_debuff add_duration=3 talent=bob_and_weave_talent)
Define(light_stagger_debuff 124275)
	SpellInfo(light_stagger_debuff duration=10 tick=1)
	SpellInfo(light_stagger_debuff add_duration=3 talent=bob_and_weave_talent)
Define(moderate_stagger_debuff 124274)
	SpellInfo(moderate_stagger_debuff duration=10 tick=1)
	SpellInfo(moderate_stagger_debuff add_duration=3 talent=bob_and_weave_talent)
SpellList(any_stagger_debuff light_stagger_debuff moderate_stagger_debuff heavy_stagger_debuff)

## Items
Define(convergence_of_fates_item 140806)

Define(firestone_walkers_item 137027)
Define(fundamental_observation_item 137063)
	SpellInfo(zen_meditation cd=150 if_equipped=fundamental_observation)

Define(hidden_masters_forbidden_touch_buff 213114)
	SpellInfo(hidden_masters_forbidden_touch_buff duration=5)
Define(katsuos_eclipse_item 137029)
	SpellInfo(fists_of_fury chi=2 if_equipped=katsuos_eclipse)
Define(salsalabims_lost_tunic_item 137016)
Define(stormstouts_last_gasp_item 151788)
	SpellInfo(keg_smash charges=2 if_equipped=stormstouts_last_gasp)

	SpellAddBuff(crackling_jade_lightning the_emperors_capacitor_buff=0)


## Tiers
SpellInfo(rising_sun_kick add_cd=-1 specialization=windwalker itemset=T19 itemcount=2)
Define(rising_fist_debuff 242259) # T20 2p bonus
	SpellInfo(rising_fist_debuff duration=8)
	SpellAddBuff(fists_of_fury rising_fist_debuff=1 itemset=T20 itemcount=4)
	SpellAddTargetDebuff(rising_sun_kick rising_fist_debuff=0)
Define(pressure_point_buff 247255) # T20 4p bonus
	SpellInfo(pressure_point_buff duration=5)

## Talents
Define(ascension_talent 7)


Define(bob_and_weave_talent 13)
Define(celerity_talent 4)

Define(chi_torpedo_talent 5)


Define(diffuse_magic_talent 14)

Define(eye_of_the_tiger_talent 1)

Define(focused_thunder_talent 19)

Define(guard_talent 20)
Define(healing_elixir_talent 14)
Define(healing_elixir_talent_mistweaver 13)
Define(high_tolerance_talent 19)
Define(hit_combo_talent 16)
Define(inner_strength_talent 13)
Define(invoke_chiji_talent 18)
Define(invoke_niuzao_talent 18)
Define(invoke_xuen_talent 18)
Define(lifecycles_talent 7)
Define(light_brewing_talent 7)
Define(mana_tea_talent 9)
Define(mist_wrap_talent 1)
Define(refreshing_jade_wind_talent 17)
Define(ring_of_peace_talent 12)
Define(rising_mist_talent 21)



Define(song_of_chiji_talent 11)
Define(special_delivery_talent 16)
Define(spirit_of_the_crane_talent 8)
Define(spiritual_focus_talent 19)
Define(spitfire_talent 8)
Define(summon_black_ox_statue_talent 11)
Define(summon_jade_serpent_statue_talent 16)
Define(tiger_tail_sweep_talent 10)
Define(tigers_lust_talent 6)
Define(upwelling_talent 20)


# Non-default tags for OvaleSimulationCraft.
	SpellInfo(chi_brew tag=main)
	SpellInfo(chi_torpedo tag=shortcd)
	SpellInfo(dampen_harm tag=cd)
	SpellInfo(diffuse_magic tag=cd)
]]
    OvaleScripts:RegisterScript("MONK", nil, name, desc, code, "include")
end
