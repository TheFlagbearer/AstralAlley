/* Paint and crayons */

/datum/reagent/crayon_dust
	name = "Crayon dust"
	id = "crayon_dust"
	description = "Intensely coloured powder obtained by grinding crayons."
	taste_description = "powdered wax"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5
	price_tag = 0.1

/datum/reagent/crayon_dust/red
	name = "Red crayon dust"
	id = "crayon_dust_red"
	color = "#FE191A"

/datum/reagent/crayon_dust/orange
	name = "Orange crayon dust"
	id = "crayon_dust_orange"
	color = "#FFBE4F"

/datum/reagent/crayon_dust/yellow
	name = "Yellow crayon dust"
	id = "crayon_dust_yellow"
	color = "#FDFE7D"

/datum/reagent/crayon_dust/green
	name = "Green crayon dust"
	id = "crayon_dust_green"
	color = "#18A31A"

/datum/reagent/crayon_dust/blue
	name = "Blue crayon dust"
	id = "crayon_dust_blue"
	color = "#247CFF"

/datum/reagent/crayon_dust/purple
	name = "Purple crayon dust"
	id = "crayon_dust_purple"
	color = "#CC0099"

/datum/reagent/crayon_dust/grey //Mime
	name = "Grey crayon dust"
	id = "crayon_dust_grey"
	color = "#808080"

/datum/reagent/crayon_dust/brown //Rainbow
	name = "Brown crayon dust"
	id = "crayon_dust_brown"
	color = "#846F35"

/datum/reagent/marker_ink
	name = "Marker ink"
	id = "marker_ink"
	description = "Intensely coloured ink used in markers."
	taste_description = "extremely bitter"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5

/datum/reagent/marker_ink/black
	name = "Black marker ink"
	id = "marker_ink_black"
	color = "#000000"

/datum/reagent/marker_ink/red
	name = "Red marker ink"
	id = "marker_ink_red"
	color = "#FE191A"

/datum/reagent/marker_ink/orange
	name = "Orange marker ink"
	id = "marker_ink_orange"
	color = "#FFBE4F"

/datum/reagent/marker_ink/yellow
	name = "Yellow marker ink"
	id = "marker_ink_yellow"
	color = "#FDFE7D"

/datum/reagent/marker_ink/green
	name = "Green marker ink"
	id = "marker_ink_green"
	color = "#18A31A"

/datum/reagent/marker_ink/blue
	name = "Blue marker ink"
	id = "marker_ink_blue"
	color = "#247CFF"

/datum/reagent/marker_ink/purple
	name = "Purple marker ink"
	id = "marker_ink_purple"
	color = "#CC0099"

/datum/reagent/marker_ink/grey //Mime
	name = "Grey marker ink"
	id = "marker_ink_grey"
	color = "#808080"

/datum/reagent/marker_ink/brown //Rainbow
	name = "Brown marker ink"
	id = "marker_ink_brown"
	color = "#846F35"

/datum/reagent/paint
	name = "Paint"
	id = "paint"
	description = "This paint will stick to almost any object."
	taste_description = "chalk"
	reagent_state = LIQUID
	color = "#808080"
	overdose = REAGENTS_OVERDOSE * 0.5
	color_weight = 20

/datum/reagent/paint/touch_turf(var/turf/T)
	if(istype(T, /turf/simulated/wall))
		var/turf/simulated/wall/wall = T
		wall.paint_color = color
	else
		if(istype(T) && !istype(T, /turf/space))
			T.color = color

/datum/reagent/paint/touch_obj(var/obj/O)
	if(istype(O))
		O.color = color

/datum/reagent/paint/touch_mob(var/mob/M)
	if(istype(M) && !istype(M, /mob/observer)) //painting ghosts: not allowed
		M.color = color //maybe someday change this to paint only clothes and exposed body parts for human mobs.

/datum/reagent/paint/get_data()
	return color

/datum/reagent/paint/initialize_data(var/newdata)
	color = newdata
	return

/datum/reagent/paint/mix_data(var/newdata, var/newamount)
	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0

	var/hex1 = uppertext(color)
	var/hex2 = uppertext(newdata)
	if(length(hex1) == 7)
		hex1 += "FF"
	if(length(hex2) == 7)
		hex2 += "FF"
	if(length(hex1) != 9 || length(hex2) != 9)
		return
	colors[1] += hex2num(copytext(hex1, 2, 4)) * volume
	colors[2] += hex2num(copytext(hex1, 4, 6)) * volume
	colors[3] += hex2num(copytext(hex1, 6, 8)) * volume
	colors[4] += hex2num(copytext(hex1, 8, 10)) * volume
	tot_w += volume
	colors[1] += hex2num(copytext(hex2, 2, 4)) * newamount
	colors[2] += hex2num(copytext(hex2, 4, 6)) * newamount
	colors[3] += hex2num(copytext(hex2, 6, 8)) * newamount
	colors[4] += hex2num(copytext(hex2, 8, 10)) * newamount
	tot_w += newamount

	color = rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)
	return

/* Things that didn't fit anywhere else */

/datum/reagent/adminordrazine //An OP chemical for admins
	name = "Adminordrazine"
	id = "adminordrazine"
	description = "It's magic. We don't have to explain it."
	taste_description = "bwoink"
	reagent_state = LIQUID
	color = "#C8A5DC"
	affects_dead = 1 //This can even heal dead people.
	mrate_static = TRUE //Just in case

	glass_name = "liquid gold"
	glass_desc = "It's magic. We don't have to explain it."

/datum/reagent/adminordrazine/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed)

/datum/reagent/adminordrazine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.setCloneLoss(0)
	M.setOxyLoss(0)
	M.radiation = 0
	M.heal_organ_damage(5,5)
	M.adjustToxLoss(-5)
	M.hallucination = 0
	M.setBrainLoss(0)
	M.disabilities = 0
	M.sdisabilities = 0
	M.eye_blurry = 0
	M.SetBlinded(0)
	M.SetWeakened(0)
	M.SetStunned(0)
	M.SetParalysis(0)
	M.silent = 0
	M.dizziness = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.SetConfused(0)
	M.sleeping = 0
	M.jitteriness = 0

/datum/reagent/gold
	name = "Gold"
	id = "gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	taste_description = "metal"
	reagent_state = SOLID
	color = COLOR_GOLD
	price_tag = 3.2

/datum/reagent/silver
	name = "Silver"
	id = "silver"
	description = "A soft, white, lustrous transition metal, it has the highest electrical conductivity of any element and the highest thermal conductivity of any metal."
	taste_description = "metal"
	reagent_state = SOLID
	color = COLOR_SILVER
	price_tag = 2.2

/datum/reagent/uranium
	name ="Uranium"
	id = "uranium"
	description = "A silvery-white metallic chemical element in the actinide series, weakly radioactive."
	taste_description = "metal"
	reagent_state = SOLID
	color = COLOR_URANIUM
	price_tag = 3.2

/datum/reagent/platinum
	name = "Platinum"
	id = "platinum"
	description = "Platinum is a dense, malleable, ductile, highly unreactive, precious, gray-white transition metal.  It is very resistant to corrosion."
	taste_description = "metal"
	reagent_state = SOLID
	color = COLOR_PLATINUM
	price_tag = 3.9

/datum/reagent/uranium/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_ingest(M, alien, removed)

/datum/reagent/uranium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.apply_effect(5 * removed, IRRADIATE, 0)

/datum/reagent/uranium/touch_turf(var/turf/T)
	if(volume >= 3)
		if(!istype(T, /turf/space))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/adrenaline
	name = "Adrenaline"
	id = "adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#C8A5DC"
	mrate_static = TRUE

/datum/reagent/adrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.SetParalysis(0)
	M.SetWeakened(0)
	M.adjustToxLoss(rand(3))

/datum/reagent/water/holywater
	name = "Holy Water"
	id = "holywater"
	description = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."
	taste_description = "water"
	color = "#E0E8EF"
	mrate_static = TRUE
	hydration_factor = 10

	glass_name = "holy water"
	glass_desc = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."

/datum/reagent/water/holywater/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	if(ishuman(M)) // Any location
		if(M.mind && cult.is_antagonist(M.mind) && prob(10))
			cult.remove_antagonist(M.mind)

/datum/reagent/water/holywater/touch_turf(var/turf/T)
	if(volume >= 5)
		T.holy = 1
	return

/datum/reagent/ammonia
	name = "Ammonia"
	id = "ammonia"
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	taste_description = "mordant"
	taste_mult = 2
	reagent_state = GAS
	color = "#404030"

/datum/reagent/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	description = "A secondary amine, mildly corrosive."
	taste_description = "iron"
	reagent_state = LIQUID
	color = "#604030"

/datum/reagent/fluorosurfactant // Foam precursor
	name = "Fluorosurfactant"
	id = "fluorosurfactant"
	description = "A perfluoronated sulfonic acid that forms a foam when mixed with water."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#9E6B38"

/datum/reagent/foaming_agent // Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming agent"
	id = "foaming_agent"
	description = "A agent that yields metallic foam when mixed with light metal and a strong acid."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#664B63"

/datum/reagent/thermite
	name = "Thermite"
	id = "thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	taste_description = "sweet tasting metal"
	reagent_state = SOLID
	color = "#673910"
	touch_met = 50

/datum/reagent/thermite/touch_turf(var/turf/T)
	if(volume >= 5)
		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/W = T
			W.thermite = 1
			W.overlays += image('icons/effects/effects.dmi',icon_state = "#673910")
			remove_self(5)
	return

/datum/reagent/thermite/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 5)

/datum/reagent/thermite/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustFireLoss(3 * removed)

/datum/reagent/space_cleaner
	name = "Space cleaner"
	id = "cleaner"
	description = "A compound used to clean things. Now with 50% more sodium hypochlorite!"
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#A5F0EE"
	touch_met = 50
	price_tag = 0.2

/datum/reagent/space_cleaner/touch_obj(var/obj/O)
	O.clean_blood()

/datum/reagent/space_cleaner/touch_turf(var/turf/T)
	if(volume >= 1)
		if(istype(T, /turf/simulated))
			var/turf/simulated/S = T
			S.dirt = 0
		T.clean_blood()

		for(var/mob/living/simple_mob/slime/M in T)
			M.adjustToxLoss(rand(5, 10))

/datum/reagent/space_cleaner/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.r_hand)
		M.r_hand.clean_blood()
	if(M.l_hand)
		M.l_hand.clean_blood()
	if(M.wear_mask)
		if(M.wear_mask.clean_blood())
			M.update_inv_wear_mask(0)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(alien == IS_SLIME)
			M.adjustToxLoss(rand(5, 10))
		if(H.head)
			if(H.head.clean_blood())
				H.update_inv_head(0)
		if(H.wear_suit)
			if(H.wear_suit.clean_blood())
				H.update_inv_wear_suit(0)
		else if(H.w_uniform)
			if(H.w_uniform.clean_blood())
				H.update_inv_w_uniform(0)
		if(H.shoes)
			if(H.shoes.clean_blood())
				H.update_inv_shoes(0)
		else
			H.clean_blood(1)
			return
	M.clean_blood()

/datum/reagent/space_cleaner/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_SLIME)
		M.adjustToxLoss(6 * removed)
	else
		M.adjustToxLoss(3 * removed)
		if(prob(5))
			M.vomit()

/datum/reagent/lube // TODO: spraying on borgs speeds them up
	name = "Lube"
	id = "lube"
	description = "Lubricant is a substance introduced between two moving surfaces to reduce the friction and wear between them, giggity."
	taste_description = "slime"
	reagent_state = LIQUID
	color = "#009CA8"
	price_tag = 0.7

/datum/reagent/lube/touch_turf(var/turf/simulated/T)
	if(!istype(T))
		return
	if(volume >= 1)
		T.wet_floor(2)

/datum/reagent/silicate
	name = "Silicate"
	id = "silicate"
	description = "A compound that can be used to reinforce glass."
	taste_description = "plastic"
	reagent_state = LIQUID
	color = "#C7FFFF"
	price_tag = 0.5

/datum/reagent/silicate/touch_obj(var/obj/O)
	if(istype(O, /obj/structure/window))
		var/obj/structure/window/W = O
		W.apply_silicate(volume)
		remove_self(volume)
	return

/datum/reagent/glycerol
	name = "Glycerol"
	id = "glycerol"
	description = "Glycerol is a simple polyol compound. Glycerol is sweet-tasting and of low toxicity."
	taste_description = "sweetness"
	reagent_state = LIQUID
	color = "#808080"
	price_tag = 0.9

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	id = "nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	taste_description = "oil"
	reagent_state = LIQUID
	color = "#808080"
	price_tag = 0.7

/datum/reagent/coolant
	name = "Coolant"
	id = "coolant"
	description = "Industrial cooling substance."
	taste_description = "sourness"
	taste_mult = 1.1
	reagent_state = LIQUID
	color = "#C8A5DC"
	price_tag = 0.5

/datum/reagent/ultraglue
	name = "Ultra Glue"
	id = "glue"
	description = "An extremely powerful bonding agent."
	taste_description = "a special education class"
	color = "#FFFFCC"
	price_tag = 0.5

/datum/reagent/woodpulp
	name = "Wood Pulp"
	id = "woodpulp"
	description = "A mass of wood fibers."
	taste_description = "wood"
	reagent_state = LIQUID
	color = "#B97A57"
	price_tag = 0.9

/datum/reagent/luminol
	name = "Luminol"
	id = "luminol"
	description = "A compound that interacts with blood on the molecular level."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#F2F3F4"
	price_tag = 0.7

/datum/reagent/luminol/touch_obj(var/obj/O)
	O.reveal_blood()

/datum/reagent/luminol/touch_mob(var/mob/living/L)
	L.reveal_blood()

/datum/reagent/poppy
	name = "Poppy Resin"
	id = "poppyresin"
	description = "Extracted from poppies."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 0.8

	contraband_type = CONTRABAND_HEROIN
	tax_type = DRUG_TAX


/datum/reagent/coca
	name = "coca extract"
	id = "coca"
	description = "Extracted from the coca plant."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 0.9

	contraband_type = CONTRABAND_COCAINE
	tax_type = DRUG_TAX

/datum/reagent/menthol
	name = "Menthol"
	id = "menthol"
	description = "Tastes naturally minty, and imparts a very mild numbing sensation."
	taste_description = "mint"
	reagent_state = LIQUID
	color = "#80af9c"
	metabolism = REM * 0.002
	overdose = REAGENTS_OVERDOSE * 0.25
	scannable = 1
	price_tag = 0.3

/datum/reagent/caapi
	name = "caapi extract"
	id = "caapi_extract"
	description = "An extract from the caapi plant."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 1.8

	contraband_type = CONTRABAND_CAAPI
	tax_type = DRUG_TAX

/datum/reagent/chacruna
	name = "chacruna extract"
	id = "chacruna_extract"
	description = "An extract from the chacruna plant."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 1.8

	contraband_type = CONTRABAND_CHACRUNA
	tax_type = DRUG_TAX

/datum/reagent/wax
	name = "Wax"
	id = "wax"
	description = "An ester solid substance used for a variety of purposes."
	taste_description = "wax"
	reagent_state = LIQUID
	color = COLOR_PLATINUM

/datum/reagent/toiletwater
	name = "Toilet Water"
	id = "toiletwater"
	description = "Nasty water taken from a toilet."
	taste_description = "feces and urine"
	reagent_state = LIQUID
	color = "#757547"

/datum/reagent/nutriment/biomass
	name = "Biomass"
	id = "biomass"
	description = "A slurry of compounds that contains the basic requirements for life."
	taste_description = "salty meat"
	reagent_state = LIQUID
	color = "#DF9FBF"


/*************
	Nanites
*************/

// This exists to cut the number of chemicals a merc borg has to juggle on their hypo.
/datum/reagent/healing_nanites
	name = "Restorative Nanites"
	id = "healing_nanites"
	description = "Miniature medical robots that swiftly restore bodily damage."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#555555"
	metabolism = REM * 4 // Nanomachines gotta go fast.
	price_tag = 2

	get_tax()
		return MEDICAL_TAX


/datum/reagent/healing_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.heal_organ_damage(2 * removed, 2 * removed)
	M.adjustOxyLoss(-4 * removed)
	M.adjustToxLoss(-2 * removed)
	M.adjustCloneLoss(-2 * removed)


// The opposite to healing nanites, exists to make unidentified hypos implied to have nanites not be 100% safe.
/datum/reagent/defective_nanites
	name = "Defective Nanites"
	id = "defective_nanites"
	description = "Miniature medical robots that are malfunctioning and cause bodily harm. Fortunately, they cannot self-replicate."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 3 // Broken nanomachines go a bit slower.

/datum/reagent/defective_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(2 * removed, 2 * removed)
	M.adjustOxyLoss(4 * removed)
	M.adjustToxLoss(2 * removed)
	M.adjustCloneLoss(2 * removed)

//Unstable Mutagen but in nanite form.
/datum/reagent/mutating_nanites
	name = "Mutagenic Nanites"
	id = "mutagenic_nanites"
	description = "Miniature medical robots that modify a living organism's cells down to the genetic level."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 4

/datum/reagent/mutating_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.species.flags & NO_SCAN))
		return

	if(M.dna)
		if(prob(removed * 10))
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
		if(prob(removed * 40))
			randmuti(M)
			M << "<span class='warning'>You feel odd!</span>"
	M.apply_effect(10 * removed, IRRADIATE, 0)

//Unstable Mutagen but in nanite form.
/datum/reagent/mutagenic_nanites
	name = "Mutagenic Nanites"
	id = "mutagenic_nanites"
	description = "Miniature medical robots that modify a living organism's cells down to the genetic level."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 4

/datum/reagent/mutating_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.species.flags & NO_SCAN))
		return

	if(M.dna)
		if(prob(removed * 10))
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
		if(prob(removed * 40))
			randmuti(M)
			M << "<span class='warning'>You feel odd!</span>"
	M.apply_effect(10 * removed, IRRADIATE, 0)

//The nanobots found in loyalty implants.
/datum/reagent/control_nanites
	name = "Control Nanites"
	id = "control_nanites"
	description = "Miniature medical robots that modify a sapient organism's mental processes curing most forms of brainwashing and preventing further brainwashing."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 0.5 // Metabolizes at 0.1 units per tick. A suitable replacement for loyalty implants but will eventually require further injections.
	var/already_loyal = FALSE

/datum/reagent/control_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(!M.is_sentient())  // Cannot affect drones.
		return

	if(!already_loyal)
		var/mob/living/carbon/human/H = M
		var/datum/antagonist/antag_data = get_antag_data(H.mind.special_role)

		if(antag_data && (antag_data.flags & ANTAG_IMPLANT_IMMUNE))
			H.visible_message("[H] seems to resist the effects of the nanites!", "You feel the corporate tendrils of [using_map.company_name] try to invade your mind!")
			already_loyal = TRUE
		else
			clear_antag_roles(H.mind, 1)
			var/expiration_time = volume / metabolism
			H.add_modifier(/datum/modifier/loyalty, expiration_time)
			to_chat(H, "<span class='notice'>You feel a surge of loyalty towards [using_map.company_name].</span>")
			already_loyal = TRUE
	else
		return

// Turns people into nanite swarm blobs.
/datum/reagent/sentient_nanites
	name = "Emergent Intelligence Nanites"
	id = "sentient_nanites"
	description = "Extremely dangerous and illegal malfunctioning nanites. They are able to self-replicate and have developed a measure of intelligence."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 0.5 // 0.1 removed per tick.
	var/blob_timer = 0

/datum/reagent/sentient_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(2 * removed, 2 * removed)
	M.adjustOxyLoss(4 * removed)
	M.adjustToxLoss(2 * removed)
	M.adjustCloneLoss(2 * removed)
	blob_timer++

	if(blob_timer >= 1 MINUTE)
		var/mob/living/carbon/human/H = M
		burst_blob(H.mind, 0)

/datum/reagent/sentient_nanites/proc/burst_blob(var/datum/mind/blob, var/warned)
	var/client/blob_client = null
	var/turf/location = null

	if(iscarbon(blob.current))
		var/mob/living/carbon/C = blob.current
		if(GLOB.directory[ckey(blob.key)])
			blob_client = GLOB.directory[ckey(blob.key)]
			location = get_turf(C)
			if(istype(location, /turf/space) || istype(location.loc, /area/lots))
				if(!warned)
					to_chat(C, "<span class='warning'>You feel ready to burst, but this isn't an appropriate place!</span>")
					message_admins("[key_name_admin(C)] could not burst into a blob as they are either in space or in a player lot.")
					spawn(300)
						burst_blob(blob, 1)
				else
					log_admin("[key_name(C)] was in space or in a lot when attempting to burst as a blob.")
					message_admins("[key_name_admin(C)] was in space or in a lot when attempting to burst as a blob.")
					C.gib()
					new/mob/living/simple_mob/blob/spore/nanite(location)

			else if(blob_client && location)
				to_chat(blob_client, span("warning", "You feel the last vestiges of your consciousness being overwritten and slipping away..."))
				C.gib()
				new /obj/structure/blob/core/grey_goo(location, blob_client, 1, 0) //Come back to this and fix it. Mind not transferring properly.

// Liquid form of Astralite - Pure pieces of creation
/datum/reagent/astralite
	name = "Astralite"
	id = "astralite"
	description = "A stabilized form of astralite. It has many uses. Some good. Some bad."
	taste_description = "something indescribable"
	reagent_state = LIQUID
	color = "#c94000"
	metabolism = REM * 1.5 // 0.3 removed per tick.

/datum/reagent/astralite/affect_blood(var/mob/living/carbon/M, var/alien, var/removed) // May or may not be unbalanced but the only way to know is through testing.

	//Every tick - ONE of these effects will occur. If you're lucky, you'll survive. If you're unlucky you'll be very warm for the rest of your short life.
	var/luck_of_the_draw = rand(1,5)

	switch(luck_of_the_draw)
		if(1) // Fucking kills you in the most horrific way possible because fuck you.
			M.take_organ_damage(2 * removed, 2 * removed)
			M.adjustOxyLoss(4 * removed)
			M.adjustToxLoss(2 * removed)
			M.adjustCloneLoss(2 * removed)
			M.adjustFireLoss(3 * removed)
			if(M.fire_stacks <= 1.5)
				M.adjust_fire_stacks(0.15)
			if(prob(10))
				to_chat(M,"<span class='warning'>Your veins feel like they're on fire!</span>")
				M.adjust_fire_stacks(0.1)
			else if(prob(5))
				M.IgniteMob()
				to_chat(M,"<span class='critical'>Some of your veins rupture, the exposed blood igniting!</span>")
		if(2) // Acts as unstable mutagen. It's reality warping abilities allow genetic-type changes even for synthetics.
			var/mob/living/carbon/human/H = M
			if(istype(H) && (H.species.flags & NO_SCAN))
				return

			if(M.dna)
				if(prob(removed * 10))
					randmuti(M)
					if(prob(98))
						randmutb(M)
					else
						randmutg(M)
					domutcheck(M, null)
					M.UpdateAppearance()
				if(prob(removed * 40))
					randmuti(M)
					M << "<span class='warning'>You feel odd!</span>"
			M.apply_effect(10 * removed, IRRADIATE, 0)
		if(3) // Very potent healing. Bless RNGesus.
			M.heal_organ_damage(2 * removed, 2 * removed)
			M.adjustOxyLoss(-4 * removed)
			M.adjustToxLoss(-2 * removed)
			M.adjustCloneLoss(-2 * removed)
		if(4) // Insanity
			var/drug_strength = 120
			M.emote(pick("scream", "moan", "twitch", "groan", "twitch_s", "vomit", "shiver", "stare", "pale"))
			M.adjustBrainLoss(0.30)
			M.hallucination = max(M.hallucination, drug_strength)
			M.druggy = max(M.druggy, drug_strength)
			if(prob(10) && isturf(M.loc) && !istype(M.loc, /turf/space) && M.canmove && !M.restrained())
				step(M, pick(cardinal))
		if(5) // Gives some insight towards redspace related stuff. Come back to this later when Redspace is done.
			to_chat(M, span("warning", "Wooo! Spooky ghosts!"))