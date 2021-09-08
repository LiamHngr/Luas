-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Amorphic Spikes','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Sinker Drill','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive','Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Heavy Strike','Quadrastrike','Spinal Cleave',
        'Uppercut','Vertical Cleave','Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Quad. Continuum','Saurian Slide','Sub-zero Smash',
        'Bilgestorm','Tourbillion'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'',
        
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Heavy Strike','Quadrastrike','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Sinker Drill','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Saurian Slide', 'Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Anvil Lightning', 'Blastbomb','Blazing Bound','Blinding Fulgor','Bomb Toss','Cursed Sphere','Cesspool','Dark Orb','Death Ray',
        'Droning Whirlwind','Entomb','Embalming Earth','Firespit','Foul Waters','Ice Break',
        'Leafstorm','Maelstrom','Magic Hammer','Regurgitation','Rending Deluge','Retinal Glare',
        'Scouring Spate','Searing tempest','Spectral Floe','Silent Storm','Subduction','Tenebral Crush','Tem. Upheaval','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Sudden Lunge','Venom Shell','Voracious Trunk','Yawn','Blitzstrahl',
		'Frypan','Head Butt','Tail slap','Temporal Shift','Thunderbolt','Whirl of Rage','Sweeping Gouge',
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Occultation','Plasma Charge',
        'Pyric Bulwark','Restoral','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Mighty Guard','Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
        'Tourbillion'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {feet="Hashi. Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="assim. charuqs +1"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Hashishin Tayt +1"}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Dampening Tam",
        body="Vanir Cotehardie",hands="Adhemar Wristbands",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = { ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Crit. hit damage +2%','AGI+14','"Fast Cast"+8','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    body={ name="Luhlaza Jubbah +1", augments={'Enhances "Enchainment" effect',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Carmine Greaves +1", augments={'Accuracy+10','DEX+10','MND+15',}},
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
}
        
    

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Jukukik Feather",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Luhlaza Jubbah +1",hands="Adhemar Wristbands",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Fotia Belt",legs="Samnuha Tights", feet={ name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','STR+10','Attack+8',}},}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Herculean Gloves"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {ammo="Ginsen",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
    right_ear="Brutal Earring",
    left_ring="Rufescent Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
}

    sets.precast.WS['Sanguine Blade'] = {  ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Sacro Cord",
    left_ear="Regal Earring",
    right_ear="Ishvara Earring",
    left_ring="Stikini Ring +1",
    right_ring="Archon Ring",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}
		
		sets.precast.WS['Savage Blade'] = {
    ammo="Mavi Tathlum",
    head={ name="Herculean Helm", augments={'Accuracy+19','Weapon skill damage +4%','AGI+5',}},
    body="Assim. Jubbah +2",
    hands="Jhakri Cuffs +2",
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +5%','STR+3',}},
    neck="Nefarious Collar +1",
    waist="breeze belt",
    left_ear="Cessance Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Karieyh Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
		
		sets.precast.WS['Expiacion'] = {ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}
		
		sets.precast.WS['Chant du Cygne'] = {  ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Thereoid Greaves",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Crit. hit damage +2%','AGI+14','"Fast Cast"+8','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    body={ name="Luhlaza Jubbah +1", augments={'Enhances "Enchainment" effect',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Carmine Greaves +1", augments={'Accuracy+10','DEX+10','MND+15',}},
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Mavi Tathlum",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},neck="Combatant's Torque",ear1="Heartseeker Earring",ear2="Brutal Earring",
        body="Assim. Jubbah +2",hands="Herculean Gloves",ring1="Ifrit Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Metalsinger Belt",legs="Hashishin tayt +1",feet="Herculean Boots",}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Ginsen",
        head="Dampaning Tam",neck="Ej Necklace",ear1="Zennaroi Earring",ear2="Brutal Earring",
        body="Luhlaza Jubbah +1",hands="Herculean Gloves",ring1="Sangoma Ring",ring2="Vertigo Ring",
        back="Rosmerta's Cape",waist="Olseni Belt",legs="Hashishin tayt +1",feet="Herculean Boots"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},neck="Combatant's Torque",ear1="Heartseeker Earring",ear2="Brutal Earring",
        body="Assim. Jubbah +2",hands="Herculean Gloves",ring1="Ifrit Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Metalsinger Belt",legs="Hashishin tayt +1",feet="Herculean Boots"})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
    {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Luhlaza Charuqs +1",
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear="Digni, Earring",
    right_ear="Pixie Earring",
    left_ring="Petrov Ring",
    right_ring="Ilabrat Ring", 
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},})
		
			
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},neck="Combatant's Torque",ear1="Heartseeker Earring",ear2="Brutal Earring",
        body="Assim. Jubbah +2",hands="Herculean Gloves",ring1="Ilabrat Ring",ring2="spiral Ring",
        back="Cornflower Cape",waist="Metalsinger Belt",legs="Hashishin tayt +1",feet="Herculean Boots"})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Herculean Gloves",ring2="Stormsoul Ring",
         waist="Chaac Belt",feet="Iuitl Gaiters +1"})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Icesoul Ring",back="Toro Cape",feet="Hagondes Sabots"})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Aquasoul Ring",back="Refraction Cape"})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Refraction Cape",
         waist="Chaac Belt"})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = { ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Sanctity Necklace",
    waist="Sacro Cord",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Stikini Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}
    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Jhakri Cuffs +2",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Gwati Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}

    sets.midcast['Tenebral Crush'] = {ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet="Jhakri Pigaches +2",
    neck="Sanctity Necklace",
    waist="Sacro Cord",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Archon Ring",
    right_ring="Shiva Ring +1",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}


    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Orunmila's torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        back="Refraction Cape",legs="Psycloth Lappas",feet="Iuitl Gaiters +1"}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Hashishin Kavuk +1",neck="Lavalier +1",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Vrikodara Jupon",hands="Herculean Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Fravashi Mantle",waist="Hurch'lan Sash",legs="Psycloth Lappas",feet="Hagondes Sabots"}

    sets.midcast['Blue Magic'].Healing = {
    ammo="Hydrocera",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Vrikodara Jupon",
    hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
    legs="Gyve Trousers",
    feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
    neck="Phalaina Locket",
    waist="Luminary Sash",
    left_ear="Mendi. Earring",
    right_ear="Gifted Earring",
    left_ring="Stikini Ring +1",
    right_ring="Sirona's Ring",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}
    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
    head={ name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}},
    body="Assim. Jubbah +2",
    hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
    legs="Hashishin Tayt +1",
    feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
    neck="Incanter's Torque",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Cornflower Cape", augments={'MP+16','DEX+2','Accuracy+2','Blue Magic skill +8',}},
}

    sets.midcast['Blue Magic'].Buff = {}
    
  

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
   
    
    -- Idle sets
    sets.idle = {  ammo="Staunch Tathlum",
	head="Malignance Chapeau",
    body="Jhakri Robe +2",
    hands={ name="Herculean Gloves", augments={'Pet: INT+2','Accuracy+3','Damage taken-4%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonbeam Cape",
}
    sets.idle.Town = { ammo="Staunch Tathlum",
	head="Malignance Chapeau",
    body="Jhakri Robe +2",
    hands={ name="Herculean Gloves", augments={'Pet: INT+2','Accuracy+3','Damage taken-4%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Malignance Boots",
    neck="Loricate Torque",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonbeam Cape",
}
    

    
    -- Defense sets
    sets.defense.PDT = { ammo="Mavi Tathlum",
    head={ name="Herculean Helm", augments={'Attack+24','"Triple Atk."+3','Accuracy+12',}},
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+27','"Triple Atk."+4','DEX+8','Attack+10',}},
    feet={ name="Herculean Boots", augments={'Accuracy+12','"Triple Atk."+3',}},
    neck="Nefarious Collar +1",
    waist="Windbuffet Belt +1",
    left_ear="Cessance Earring",
    right_ear="Odr Earring",
    left_ring="Epona's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
    sets.defense.MDT = { ammo="Mavi Tathlum",
    head={ name="Herculean Helm", augments={'Accuracy+19','Weapon skill damage +4%','AGI+5',}},
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +5%','STR+3',}},
    neck="Twilight Torque",
    waist="Windbuffet Belt +1",
    left_ear="Cessance Earring",
    right_ear="Odr Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {    ammo="Mavi Tathlum",

}
    sets.engaged.Acc = {  head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','STR+10','Attack+8',}},
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Cessance Earring",
    right_ear="Odr Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
}

   

    sets.engaged.DW = { ammo="Ginsen",
   head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
   hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','STR+10','Attack+8',}},
    neck="Combatant's Torque",
    waist="Sarissapho. Belt",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
}

    sets.engaged.DW.Acc = {  head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+20 Attack+20','"Triple Atk."+4','STR+10','Attack+8',}},
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Cessance Earring",
    right_ear="Odr Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epona's Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
}

   


    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 7)
    else
        set_macro_page(5, 7)
    end
end
