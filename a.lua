local DataStoreService = game:GetService("DataStoreService")
local PlayerStats = DataStoreService:GetDataStore("PlayerStats")

game.Players.PlayerAdded:Connect(function(plr)
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = plr
	leaderstats.Name = "leaderstats"

	local Clicks = Instance.new("IntValue")
	Clicks.Parent = leaderstats
	Clicks.Name = "Clicks"
	local playerid = plr.UserId

	local Rebirths = Instance.new("IntValue")
	Rebirths.Parent = leaderstats
	Rebirths.Name = "Rebirths"

	local Data = {
		ClicksVal = plr:WaitForChild("leaderstats"):WaitForChild("Clicks").Value,
		RebirthsVal = plr:WaitForChild("leaderstats"):WaitForChild("Rebirths").Value,
		MultiVal = plr:WaitForChild("Multi").Value,
	}

	local playerKey = "PLAYER_" .. plr.UserId

	local success, fail = pcall(function()
		Data = PlayerStats:GetAsync(playerKey, Data)
	end)

	if success and Data then
		print("Data Get Successfully")
		Clicks.Value = Data.ClicksVal
		Rebirths.Value = Data.RebirthsVal
		plr:WaitForChild("Multi").Value = Data.MultiVal
	end
	if fail then
		print(fail)
	end
end)

game:BindToClose(function()
	for i, v in ipairs(game:GetService("Players"):GetPlayers()) do
		local Data = {
			ClicksVal = v:WaitForChild("leaderstats"):WaitForChild("Clicks").Value,
			RebirthsVal = v:WaitForChild("leaderstats"):WaitForChild("Rebirths").Value,
			MultiVal = v:WaitForChild("Multi").Value,
		}
		local playerKey = "PLAYER_" .. v.UserId

		local success, fail = pcall(function()
			Data = PlayerStats:SetAsync(playerKey, Data)
		end)

		if success and Data then
			print("Data Save Successfully")
			v:WaitForChild("leaderstats"):WaitForChild("Clicks").Value = Data.ClicksVal
			v:WaitForChild("leaderstats"):WaitForChild("Rebirths").Value = Data.RebirthsVal
			v:WaitForChild("Multi").Value = Data.MultiVal
		end
		if fail then
			print(fail)
		end
	end
end)

--[[
game.Players.PlayerRemoving:Connect(function(plr)
	local playerid = plr.UserId
	local data = {
		["Clicks"] = plr.leaderstats:WaitForChild("Clicks").Value,
		["Rebirths"] = plr.leaderstats:WaitForChild("Rebirths").Value,
	}

	local success, errorMessage = pcall(function()
		PlayerStats:SetAsync("PLAYER_"..playerid, data)

		print("Saving Data")
	end)
	print("Player Left")
	local currpoints
	
	local playerid = plr.UserId
	
	if success then
		print("it worked!!")
		for i, v in pairs(data) do
			print(v)
		end
	else
		print("Their is a error" .. errorMessage)
	end
end)

]]
--
