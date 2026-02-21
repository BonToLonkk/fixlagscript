--// SERVICES
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// ===== DELETE MAP (SAFE VERSION) ===== --

local function makeInvisible(obj)
    if obj:IsA("BasePart") then
        obj.Transparency = 1
        obj.Material = Enum.Material.SmoothPlastic
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Transparency = 1
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    end
end

for _,v in pairs(workspace:GetDescendants()) do
    pcall(function()
        makeInvisible(v)
    end)
end

workspace.DescendantAdded:Connect(function(v)
    pcall(function()
        makeInvisible(v)
    end)
end)

--// ===== FPS GUI ===== --

local screenGui = Instance.new("ScreenGui")
local textLabel = Instance.new("TextLabel")

screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

textLabel.Parent = screenGui
textLabel.Size = UDim2.new(0, 250, 0, 40)
textLabel.Position = UDim2.new(0, 10, 0, 10)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextStrokeTransparency = 0

-- FPS Counter
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - lastTime >= 1 then
        textLabel.Text = LocalPlayer.Name.." | FPS: "..frames
        frames = 0
        lastTime = tick()
    end
end)

-- Rainbow Effect
task.spawn(function()
    local hue = 0
    while true do
        hue += 0.01
        if hue > 1 then hue = 0 end
        textLabel.TextColor3 = Color3.fromHSV(hue,1,1)
        RunService.RenderStepped:Wait()
    end
end)