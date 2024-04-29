--[[

-  While in-game, just pre-pend any of the commands below with "!" or "."  For example, ".bank" or "!mail".
-  While in-game, you can type "#commands" or "$commands" to display the list of available commands.

--]]

-- Table to store list of possible commands
local commands = {
    bank = { "bank", "openbank" },  -- Chat variations for opening the bank
    mail = { "mail", "mailbox" },  -- Chat variations for opening the mailbox
    auction = { "auctions", "ah", "auctionhouse" },  -- Chat variations for opening the auction house
}

local function ChatCommandList(event, unit, msg, Type, lang)
	if(msg == "#commands") or (msg == "$commands") then
	unit:SendAreaTriggerMessage("|cFF00B0E8.bank  -  opens the Global Bank|r")
	unit:SendAreaTriggerMessage("|cFF00B0E8.mail  -  opens the Global Mailbox|r")
	unit:SendAreaTriggerMessage("|cFF00B0E8.auctions  -  opens the Global AuctionHouse|r") 
	end
	return false
end

local function OnEvents(event, player, message, type, language)
    -- Convert message to lowercase for case-insensitive comparison
    local normalizedMessage = string.lower(message)

    for action, commandList in pairs(commands) do
        for _, command in ipairs(commandList) do
            if normalizedMessage == command then
                if action == "bank" then
                    player:SendBroadcastMessage("|cff00cc00Welcome to your bank, |cff00ffff["..player:GetName().."]|r")
                    player:SendShowBank(player)
                elseif action == "mail" then
                    player:SendBroadcastMessage("|cff00cc00Opening mailbox for |cff00ffff["..player:GetName().."]|r")
                    player:SendShowMail(player)
                elseif action == "auction" then
                    player:SendBroadcastMessage("|cff00cc00Opening auction house for |cff00ffff["..player:GetName().."]|r")
                    player:SendAuctionMenu(player)
                end
                -- Return false to prevent further processing
                return false
            end
        end
    end
end


RegisterPlayerEvent(18, ChatCommandList)
RegisterPlayerEvent(42, OnEvents)