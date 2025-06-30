local Rep = game:GetService("ReplicatedStorage")
local plr = game.Players.LocalPlayer
local skipDelay = 2
local running = false
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "SkipGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 170)
frame.Position = UDim2.new(0, 10, 0.6, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "By: Magic_Master"
title.TextColor3 = Color3.fromRGB(255, 255, 0)
title.TextScaled = true

local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 28)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Skip + Fix Lag - Return Toilet TD"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.SourceSansBold

local fixBtn = Instance.new("TextButton", frame)
fixBtn.Size = UDim2.new(1, -20, 0, 30)
fixBtn.Position = UDim2.new(0, 10, 0, 48)
fixBtn.Text = "Fix Lag"
fixBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
fixBtn.TextColor3 = Color3.new(1, 1, 1)
fixBtn.TextScaled = true
fixBtn.BorderSizePixel = 0

local toggleSkip = Instance.new("TextButton", frame)
toggleSkip.Size = UDim2.new(1, -20, 0, 40)
toggleSkip.Position = UDim2.new(0, 10, 0, 85)
toggleSkip.Text = "Skip: OFF"
toggleSkip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleSkip.TextColor3 = Color3.new(1,1,1)
toggleSkip.TextScaled = true
toggleSkip.BorderSizePixel = 0

local inputTime = Instance.new("TextBox", frame)
inputTime.Size = UDim2.new(1, -20, 0, 30)
inputTime.Position = UDim2.new(0, 10, 0, 130)
inputTime.PlaceholderText = "Delay (s)"
inputTime.Text = tostring(skipDelay)
inputTime.TextColor3 = Color3.new(1,1,1)
inputTime.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
inputTime.TextScaled = true
inputTime.ClearTextOnFocus = false

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 40, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -60)
toggleBtn.Text = "☰"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true
toggleBtn.BorderSizePixel = 0
toggleBtn.Active = true
toggleBtn.Draggable = true

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

toggleSkip.MouseButton1Click:Connect(function()
	running = not running
	toggleSkip.Text = "Skip: " .. (running and "ON" or "OFF")
end)

inputTime.FocusLost:Connect(function()
	local val = tonumber(inputTime.Text)
	if val and val >= 0.1 then
		skipDelay = val
	end
end)

task.spawn(function()
	while true do
		if running then
			pcall(function()
				Rep.Events.VoteSkip:FireServer()
			end)
		end
		wait(skipDelay)
	end
end)

local function optimize(instance)
	for _, obj in pairs(instance:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.CastShadow = false
			obj.Transparency = 1
		elseif obj:IsA("Decal") or obj:IsA("Texture") then
			obj:Destroy()
		elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
			obj.Enabled = false
		elseif obj:IsA("Sound") then
			obj.Volume = 0
		elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
			obj.Enabled = false
		end
	end
end

fixBtn.MouseButton1Click:Connect(function()
	local enemyFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("EnemyFolder") or workspace:FindFirstChild("Monsters")
	if enemyFolder then
		for _, enemy in pairs(enemyFolder:GetChildren()) do
			optimize(enemy)
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	local enemyFolder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("EnemyFolder") or workspace:FindFirstChild("Monsters")
	if enemyFolder then
		for _, enemy in pairs(enemyFolder:GetChildren()) do
			optimize(enemy)
		end
	end
end)
