local Players = game:GetService("Players")
local Rep = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

local skipRunning = false
local skipDelay = 1

local gui = Instance.new("ScreenGui")
gui.Name = "SkipOnlyGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = plr:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 40, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextScaled = true
toggleBtn.Text = "☰"
toggleBtn.Parent = gui
toggleBtn.Active = true
toggleBtn.Draggable = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 150)
frame.Position = UDim2.new(0, 60, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local titleTop = Instance.new("TextLabel")
titleTop.Size = UDim2.new(1, 0, 0, 25)
titleTop.Position = UDim2.new(0, 0, 0, 0)
titleTop.BackgroundTransparency = 1
titleTop.Text = "By: Magic_Master"
titleTop.TextColor3 = Color3.fromRGB(255, 255, 0)
titleTop.TextScaled = true
titleTop.Font = Enum.Font.SourceSansBold
titleTop.Parent = frame

local titleBottom = Instance.new("TextLabel")
titleBottom.Size = UDim2.new(1, 0, 0, 20)
titleBottom.Position = UDim2.new(0, 0, 0, 25)
titleBottom.BackgroundTransparency = 1
titleBottom.Text = "Script: Fast Skip"
titleBottom.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBottom.TextScaled = true
titleBottom.Font = Enum.Font.SourceSans
titleBottom.Parent = frame

local skipBtn = Instance.new("TextButton")
skipBtn.Size = UDim2.new(1, -20, 0, 35)
skipBtn.Position = UDim2.new(0, 10, 0, 50)
skipBtn.Text = "Skip: OFF"
skipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
skipBtn.TextColor3 = Color3.new(1,1,1)
skipBtn.TextScaled = true
skipBtn.BorderSizePixel = 0
skipBtn.Parent = frame

local delayBox = Instance.new("TextBox")
delayBox.Size = UDim2.new(1, -20, 0, 30)
delayBox.Position = UDim2.new(0, 10, 0, 95)
delayBox.PlaceholderText = "Delay (s)"
delayBox.Text = tostring(skipDelay)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
delayBox.TextScaled = true
delayBox.ClearTextOnFocus = false
delayBox.Parent = frame

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

skipBtn.MouseButton1Click:Connect(function()
	skipRunning = not skipRunning
	skipBtn.Text = "Skip: " .. (skipRunning and "ON" or "OFF")
end)

delayBox.FocusLost:Connect(function()
	local val = tonumber(delayBox.Text)
	if val and val >= 0.1 then
		skipDelay = val
	end
end)

task.spawn(function()
	while true do
		if skipRunning then
			pcall(function()
				Rep:FindFirstChild("Events")?.VoteSkip:FireServer()
			end)
		end
		task.wait(skipDelay)
	end
end)
