/datum/advclassg
	var/name
	var/outfit
	var/tutorial = "Choose me!"
	var/list/allowed_sexes
	var/list/allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	var/list/allowed_patrons
	var/list/allowed_ages
	var/pickprob = 100
	var/maxchosen = -1
	var/amtchosen = 0
	var/plevel_req = 0
	var/special_req = FALSE //check the json for our ckey
	var/whitelist_req = FALSE
	var/isroyalg = FALSE
	var/isgarrisong = FALSE
	var/horse = FALSE
	var/vampcompat = TRUE
	var/list/traits_applied
	var/cmode_music

/datum/advclassg/proc/equipme(mob/living/carbon/human/H)
	if(!H)
		return FALSE

	if(outfit)
		H.equipOutfit(outfit)

	post_equip(H)

	H.advjobg = name
	H.advsetupg = 0
	H.invisibility = null
	H.cure_blind("advsetupg")
	H.SetStun(0)
	sleep(1)
	testing("[H] spawn troch")
	var/obj/item/flashlight/flare/torch/T = new()
	T.spark_act()
	H.put_in_hands(T)

	var/turf/TU = get_turf(H)
	if(TU)
		if(horse)
			new horse(TU)

	for(var/trait in traits_applied)
		ADD_TRAIT(H, trait, TRAIT_GENERIC)
	if(isgarrisong)
		for(var/mob/M in GLOB.garrisonspawns)
			to_chat(M, "<span class='info'>[H.real_name] is the [name].</span>")
		GLOB.billagerspawns -= H

/datum/advclassg/proc/post_equip(mob/living/carbon/human/H)
	addtimer(CALLBACK(H,TYPE_PROC_REF(/mob/living/carbon/human, add_credit)), 20)
	if(cmode_music)
		H.cmode_music = cmode_music
