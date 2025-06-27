<meta name='viewport' content='width=device-width, initial-scale=1'/>local playerPlot
for _, plot in ipairs(workspace.Plots:GetChildren()) do
    if plot:FindFirstChild("YourBase", true).Enabled then
        playerPlot = plot.Name
        break
    end
end

local RaritySettings = {
    ["Brainrot God"] = {
        Color = Color3.new(0.5, 0, 0.5),
        Size = UDim2.new(0, 180, 0, 60)
    },
    ["Secret"] = {
        Color = Color3.new(0, 0, 0),
        Size = UDim2.new(0, 200, 0, 70)
    }
}

local espToggles = {
    ["Brainrot God"] = false,
    ["Secret"] = false
}

local function updateESP()
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot.Name ~= playerPlot then
            for _, child in pairs(plot:GetDescendants()) do
                if child.Name == "Rarity" and child:IsA("TextLabel") and RaritySettings[child.Text] then
                    local model = child.Parent.Parent
                    local rarity = child.Text
                    local tag = rarity .. "_ESP"

                    if espToggles[rarity] then
                        if not model:FindFirstChild(tag) then
                            local esp = Instance.new("BillboardGui")
                            esp.Name = tag
                            esp.Size = RaritySettings[rarity].Size
                            esp.StudsOffset = Vector3.new(0, 3, 0)
                            esp.AlwaysOnTop = true
                            local label = Instance.new("TextLabel")
                            label.Text = child.Parent.DisplayName.Text
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 1
                            label.TextScaled = true
                            label.TextColor3 = RaritySettings[rarity].Color
                            label.TextStrokeColor3 = Color3.new(0, 0, 0)
                            label.TextStrokeTransparency = 0
                            label.Font = Enum.Font.SourceSansBold
                            label.Parent = esp
                            esp.Parent = model
                        end
                    else
                        if model:FindFirstChild(tag) then
                            model[tag]:Destroy()
                        end
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        updateESP()
        task.wait(1)
    end
end)

-- GUI
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local function createToggleButton(rarity, pos)
    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.Position = pos
    btn.Text = rarity .. " ESP: OFF"
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold

    btn.MouseButton1Click:Connect(function()
        espToggles[rarity] = not espToggles[rarity]
        btn.Text = rarity .. " ESP: " .. (espToggles[rarity] and "ON" or "OFF")
    end)
end

createToggleButton("Brainrot God", UDim2.new(0, 20, 0, 100))
createToggleButton("Secret", UDim2.new(0, 20, 0, 150))