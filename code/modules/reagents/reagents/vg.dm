var/global/list/charcoal_doesnt_remove=list(
	CHARCOAL,
	BLOOD
)

/datum/reagent/proc/reagent_deleted()
	return

/datum/reagent/charcoal
	//data must contain virus type
	name = "Activated Charcoal"
	id = CHARCOAL
	reagent_state = LIQUID
	color = "#333333" // rgb: 51, 51, 51
	custom_metabolism = 0.06
	digestion_rate = 0.1 // Slow to move into the blood stream so stomach contents can actually be processed through.

/datum/reagent/charcoal/on_mob_life(var/mob/living/M, var/datum/organ/internal/stomach/S)
	if(S && prob(5))
		var/mob/living/carbon/human/H = M
		H.vomit()
		return
	M.adjustToxLoss(-2*REM)
	var/found_any = FALSE
	for(var/datum/reagent/reagent in holder.reagent_list)
		if(reagent.id in charcoal_doesnt_remove)
			continue
		holder.remove_reagent(reagent.id, 15*REM)
		found_any = TRUE

	if (!found_any)
		holder.remove_reagent(CHARCOAL, volume)
	..()
