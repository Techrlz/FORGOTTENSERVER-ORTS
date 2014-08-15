local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local travelNode = keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you want to get to Edron?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=33176, y=31764, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Maybe later.'})

local travelNode = keywordHandler:addKeyword({'eremo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Oh, you know the good old sage Eremo. I can bring you to his little island. Do you want me to do that?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=33314, y=31883, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Maybe later.'})
	
	keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I\'m a fisherman and I take along people to Edron. You can also buy some fresh fish.'})
	keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I\'m a fisherman and I take along people to Edron. You can also buy some fresh fish.'})
	keywordHandler:addKeyword({'fish'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My fish is of the finest quality you could find. Ask me for a trade to check for yourself.'})
	keywordHandler:addKeyword({'cormaya'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'It\'s a lovely and peaceful isle. Did you already visit the nice sandy beach?'})
	keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My name is Pemaret, the fisherman.'})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "marlin") then
		if player:getItemCount(7963) > 0 then
			npcHandler:say("WOW! You have a marlin!! I could make a nice decoration for your wall from it. May I have it?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		if player:getItemCount(7963) > 0 then
			npcHandler:say("Yeah! Now let's see... <fumble fumble> There you go, I hope you like it!", cid)
			player:addItem(7964, 1)
			player:removeItem(7963, 1)
		else
			npcHandler:say("You don't have the fish.", cid)
		end
		npcHandler.topic[cid] = 0
	end
	if msgcontains(msg, "no") then
		npcHandler:say("Then no.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
