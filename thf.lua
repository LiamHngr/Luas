-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

include('Global-Binds.lua') -- OK to remove this line

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Clotharius Torque"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.AugQuiahuiz = "Quiahuiz Trousers"

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Plunderer's Armlets +3", waist="Chaac Belt", feet="Skulker's Poulaines +1"}
    sets.Kiting = {feet="Faijin Boots"}

    

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter
	sets.precast.Ranged = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +2"}
    sets.precast.JA['Hide'] = {body="Malignance Tabard"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {""}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +3",feet="Skulk. Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}
	sets.precast.JA['Mug'] = {head="Plunderer's Bonnet +1"}
	
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Jukukik Feather",
        head="Adhemar Bonnet",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Malignance Tabard",hands="Plunderer's Armlets +1",ring1="Haverton Ring",ring2="Epona's Ring",
        back="Toutatis's Cape",waist="Windbuffet belt +1 +1",legs="Meg. Chausses +1",feet="Plunderer's Poulaines +1"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Yamarang",
    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+4','"Fast Cast"+6',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Meg. Chausses +2",
    feet="Fajin Boots",
    neck="Orunmila's Torque",
    waist="Sarissapho. Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back="Moonbeam Cape",
}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {head="Aurore Beret", hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','STR+7','Accuracy+9','Attack+15',}},ring2="Haverton Ring",
	legs="Meg. Chausses +1",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands="Meg. Gloves +2",
    legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +5%','STR+3',}},
    neck={ name="Asn. Gorget +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Karieyh Ring",
    right_ring="Ilabrat Ring",
	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = {ammo="Yetshila",
    head="Pill. Bonnet +2",
    body="Abnoba Kaftan",
    hands="Meg. Gloves +2",
    legs="Pill. Culottes +2",
    feet={ name="Herculean Boots", augments={'Attack+14','Weapon skill damage +4%','STR+8','Accuracy+6',}},
    neck="Anu Torque",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Ilabrat Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
   

    sets.precast.WS['Dancing Edge'] = {ammo="Yetshila",
    head="Pill. Bonnet +2",
    body="Abnoba Kaftan",
    hands="Meg. Gloves +2",
    legs="Pill. Culottes +2",
    feet={ name="Herculean Boots", augments={'Attack+14','Weapon skill damage +4%','STR+8','Accuracy+6',}},
    neck="Anu Torque",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
   left_ring="Ilabrat Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
    

    sets.precast.WS['Mercy Stroke'] = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Clotharius Torque",ear1="Flame Pearl",ear2="Flame Pearl",
        body="Malignance Tabard",hands="Herculean Gloves",ring1="Ifrit Ring",ring2="Ifrit Ring",
        back="Buquwik Cape Cape",waist="Metalsinger Belt",legs="Quiahuiz Trousers",feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}}}
   
	
	sets.precast.WS['Evisceration'] = {ammo="Seeth. Bomblet +1",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands="Meg. Gloves +2",
    legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +5%','STR+3',}},
    neck={ name="Asn. Gorget +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Karieyh Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Evasion+15',}},
}
   

    sets.precast.WS["Rudra\'s Storm"] = {ammo="Seeth. Bomblet +1",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands="Meg. Gloves +2",
    legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +5%','STR+3',}},
    neck={ name="Asn. Gorget +2", augments={'Path: A',}},
	--neck="Ygnas's Resolve +1",
    waist={ name="Kentarch Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Karieyh Ring",
    right_ring="Ilabrat Ring",
	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
   
    sets.precast.WS["Shark Bite"] = {ammo="Yetshila",
    head="Pill. Bonnet +2",
    body="Abnoba Kaftan",
    hands="Meg. Gloves +2",
    legs="Pill. Culottes +2",
    feet={ name="Herculean Boots", augments={'Attack+14','Weapon skill damage +4%','STR+8','Accuracy+6',}},
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Ilabrat Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
    
    sets.precast.WS['Mandalic Stab'] = {ammo="Yetshila",
    head="Pill. Bonnet +2",
    body="Abnoba Kaftan",
    hands="Meg. Gloves +2",
    legs="Pill. Culottes +2",
    feet={ name="Herculean Boots", augments={'Attack+14','Weapon skill damage +4%','STR+8','Accuracy+6',}},
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Odr Earring",
    left_ring="Ilabrat Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
   
    sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
    head={ name="Herculean Helm", augments={'Crit. hit damage +2%','AGI+14','"Fast Cast"+8','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+30','Phys. dmg. taken -1%','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20','Weapon skill damage +3%','AGI+15','"Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Novio Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Shiva Ring +1",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
    
	sets.precast.WS['Savage Blade'] = {ammo="Yetshila",
    head="Pill. Bonnet +2",
    body="Abnoba Kaftan",
    hands="Meg. Gloves +2",
    legs="Pill. Culottes +2",
    feet={ name="Herculean Boots", augments={'Attack+14','Weapon skill damage +4%','STR+8','Accuracy+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Ilabrat Ring",
    right_ring="Gere Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Whirlpool Mask",ear2="Loquacious Earring",
        body="Malignance Tabard",hands="Herculean Gloves",
        back="Toutatis's Cape",legs="Meg. Chausses +1",feet="Iuitl Gaiters +1"}

    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Whirlpool Mask",neck="Clotharius Torque",ear2="Loquacious Earring",
        body="Malignance Tabard",hands="Herculean Gloves",ring1="Beeline Ring",
        back="Toutatis's Cape",legs="Meg. Chausses +1",feet="Iuitl Gaiters +1"}

    -- Ranged gear
    sets.midcast.RA = {
        head="Whirlpool Mask",neck="Clotharius Torque",ear1="Clearview Earring",ear2="Volley Earring",
        body="Malignance Tabard",hands="Herculean Gloves",ring1="Hajduk Ring +1",ring2="Haverton Ring",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Meg. Chausses +1",feet="Iuitl Gaiters +1"}

    sets.midcast.RA.Acc = {
        head="Lilitu Headpiece",neck="Clotharius Torque",ear1="Clearview Earring",ear2="Volley Earring",
        body="Malignance Tabard",hands="Herculean Gloves",ring1="Hajduk Ring +1",ring2="Rajas Ring",
        back="Libeccio Mantle",waist="Aquiline Belt",legs="Meg. Chausses +1",feet="Pillager's Poulaines +1"}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},
    legs="Pill. Culottes +2",
    feet="Faijin Boots",
    neck={ name="Asn. Gorget +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Karieyh Ring",
    right_ring="Warp Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Evasion+15',}},

}

sets.idle.town = {ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Herculean Gloves", augments={'Pet: INT+2','Accuracy+3','Damage taken-4%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    legs="Malignance Tights",
    feet="Fajin Boots",
    neck="Loricate Torque",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back="Moonbeam Cape",
}

   


    -- Defense sets

   
    sets.defense.PDT = {
	head="Pill. Bonnet +3",
    body="Malignance Tabard",
    hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Twilight Torque",
    --neck="Ygnas's Resolve +1",  
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Evasion+15',}},
}	
	
	-- ammo="Yamarang",
    -- head="Malignance Chapeau",
    -- body="Malignance Tabard",
    -- hands={ name="Herculean Gloves", augments={'Pet: INT+2','Accuracy+3','Damage taken-4%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    -- legs="Meg. Chausses +1",
    -- feet="Fajin Boots",
    -- neck="Loricate Torque",
    -- waist="Flume Belt",
    -- left_ear="Infused Earring",
    -- right_ear="Etiolation Earring",
    -- left_ring="Defending Ring",
    -- right_ring="Gelatinous Ring +1",
    -- back="Moonbeam Cape",

    sets.defense.MDT = {
	head="Pill. Bonnet +3",
    body="Malignance Tabard",
    hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Twilight Torque",
    --neck="Ygnas's Resolve +1",  
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Defending Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Evasion+15',}},
}
	-- ammo="Demonry Stone",
        -- head="Adhemar Bonnet",neck="Loricate Torque",
        -- body="Malignance Tabard",hands="Herculean Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        -- back="Engulfer Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Iuitl Gaiters +1"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
	sets.engaged ={
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Pill. Culottes +2",
    feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
    neck={ name="Asn. Gorget +2", augments={'Path: A',}},
    --neck="Ygnas's Resolve +1",   
	waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Epona's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Evasion+15',}},
}
	
    sets.engaged.Acc = { ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','STR+10','Attack+8',}},
    neck="Anu Torque",
    waist="Sarissapho. Belt",
    left_ear="Odr Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Dingir ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
}
    

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.

--[[
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

--]]
-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(5, 2)
    else
        set_macro_page(6, 2)
    end
end
