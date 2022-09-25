local maxrangecvar = CreateConVar( "proxchat_maxrange", 1000, FCVAR_ARCHIVE, "Maximum distance for listener to still be able to hear the talker." )
local enabledcvar = CreateConVar( "proxchat_enabled", 1, FCVAR_ARCHIVE, "Enables/disables proximity chat." )

local maxrange = maxrangecvar:GetInt() ^ 2
cvars.AddChangeCallback( "proxchat_maxrange", function( _, _, val )
    maxrange = tonumber( val ) ^ 2
end )

local enabled = enabledcvar:GetInt() ^ 2
cvars.AddChangeCallback( "proxchat_enabled", function( _, _, val )
    enabled = tobool( val )
end )

hook.Add( "PlayerCanHearPlayersVoice", "proxchat_canhear", function( listener, talker )
    if not enabled then return end

    if listener:GetPos():DistToSqr( talker:GetPos() ) > maxrange then
        return false, true
    end

    return true, true
end )
