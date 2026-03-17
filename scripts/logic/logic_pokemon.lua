function land_encounters()
    return AccessibilityLevel.Normal
end

function day_encounters()
    if day() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function night_encounters()
    if night() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function radar_encounters()
    if has("radar") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function firered_encounters()
    if has("fireredcartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function leafgreen_encounters()
    if has("leafgreencartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function ruby_encounters()
    if has("rubycartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function sapphire_encounters()
    if has("sapphirecartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function emerald_encounters()
    if has("emeraldcartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function swarm_encounters()
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("opt_start_with_swarms_on") and has("poffincase") and has("bag") then
        return AccessibilityLevel.Normal
    elseif has("poffincase") and has("bag") and has("national_dex") then
        return cynthia
    else
        return AccessibilityLevel.None
    end
end

function surf_encounters()
    return surf()
end

function roamer_encounters()
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("opt_can_reset_legendaries_in_ap_helper_on") and has("poketch") and has("markingmap") then
        return AccessibilityLevel.Normal
    elseif has("poketch") and has("markingmap") then
        return cynthia
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function feebas_fishing_encounters()
    if has("bag") and (has("oldrod") or has("goodrod") or has("superrod")) then
        if has("poketch") and has("dowsingmachine") and has("pokesonar") and surf() then
            return AccessibilityLevel.Normal
        else
            return AccessibilityLevel.SequenceBreak
        end
    else
        return AccessibilityLevel.None
    end
end

function soft_honey()
	if has("honey") or has("caught_415") then
	    return AccessibilityLevel.SequenceBreak
	else
        return AccessibilityLevel.None
    end
end

function regular_honey_tree_encounters()
    local meadow = Tracker:FindObjectForCode("@floaroma_meadow").AccessibilityLevel
    return math.max(meadow, soft_honey())
end

function munchlax_honey_tree_encounters()
    local meadow = Tracker:FindObjectForCode("@floaroma_meadow").AccessibilityLevel
    if has("treecamera") and has("poketch") and has("dowsingmachine") then
        return math.max(meadow, soft_honey())
    else
        return AccessibilityLevel.None
    end
end

function great_marsh_observatory_encounters()
    return AccessibilityLevel.Normal
end

function great_marsh_observatory_national_dex_encounters()
    if has("national_dex") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function oldrod_encounters()
    if has("oldrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function goodrod_encounters()
    if has("goodrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function superrod_encounters()
    if has("superrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function evo_item_shop()
    if has("opt_evo_items_shop_in_ap_helper_on") then
        return AccessibilityLevel.Normal
    else
        local veilstone = Tracker:FindObjectForCode("@veilstone_city").AccessibilityLevel
        return math.max(veilstone, AccessibilityLevel.SequenceBreak)
    end    
end

--== Evolution Logic ==--

function levelup()
    return AccessibilityLevel.Normal
    -- yep. any level is always in logic.
end


function evolve_item(value)
    if not has(value) or not has("bag") then return end
    
    if has("evomethod_item_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_trade_item(value)
    if not has(value) or not has("linkingcord") or not has("bag") then return end
    
    if has("evomethod_item_on") then
        return evo_item_shop()
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_area(area)
    local evo_area = Tracker:FindObjectForCode("@"..area).AccessibilityLevel
    if has("evomethod_area_on") then
        return evo_area
    else
        math.min(evo_area, AccessibilityLevel.SequenceBreak)
    end
end

function evolve_mildly(which)
    if has("evomethod_mildly_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_highly(which)
    if has("evomethod_highly_on") then
        local veilstone = Tracker:FindObjectForCode("@veilstone_city").AccessibilityLevel
        if which == tyrogue then
            return math.max(veilstone, AccessibilityLevel.SequenceBreak)
        elseif which == beauty then
            local hearthome = Tracker:FindObjectForCode("@hearthome_city").AccessibilityLevel
            return math.min(veilstone, hearthome, has_level("poffincase"))
        end
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_friendship()
    return AccessibilityLevel.Normal
end