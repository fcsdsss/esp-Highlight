-- 获取服务
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- 获取本地玩家
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- 创建 ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HighlightGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 创建 Frame（主面板）
local frame = Instance.new("Frame")
frame.Name = "MyFrame"
frame.Size = UDim2.new(0, 220, 0, 220)
frame.Position = UDim2.new(0.5, -110, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = screenGui

-- 添加圆角
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

-- 添加阴影效果
local frameShadow = Instance.new("UIStroke")
frameShadow.Thickness = 2
frameShadow.Color = Color3.fromRGB(0, 0, 0)
frameShadow.Transparency = 0.5
frameShadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
frameShadow.Parent = frame

-- 添加渐变效果
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 80))
}
gradient.Rotation = 45
gradient.Parent = frame

-- 创建标题标签
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Player Highlighter"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = frame

-- 创建 ToggleButton（高亮开关）
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 15, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = "Toggle Highlight (ON)"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.Gotham
toggleButton.Parent = frame

local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(0, 8)
toggleButtonCorner.Parent = toggleButton

-- 创建 ColorButton（颜色选择）
local colorButton = Instance.new("TextButton")
colorButton.Name = "ColorButton"
colorButton.Size = UDim2.new(0, 100, 0, 40)
colorButton.Position = UDim2.new(0, 115, 0, 50)
colorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
colorButton.Text = "Change Color"
colorButton.TextColor3 = Color3.fromRGB(200, 200, 200)
colorButton.TextSize = 14
colorButton.Font = Enum.Font.Gotham
colorButton.Parent = frame

local colorButtonCorner = Instance.new("UICorner")
colorButtonCorner.CornerRadius = UDim.new(0, 8)
colorButtonCorner.Parent = colorButton

-- 创建 ESPButton（ESP 标签开关）
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(0, 190, 0, 40)
espButton.Position = UDim2.new(0, 15, 0, 100)
espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espButton.Text = "Show ESP"
espButton.TextColor3 = Color3.fromRGB(200, 200, 200)
espButton.TextSize = 14
espButton.Font = Enum.Font.Gotham
espButton.Parent = frame

local espButtonCorner = Instance.new("UICorner")
espButtonCorner.CornerRadius = UDim.new(0, 8)
espButtonCorner.Parent = espButton

-- 创建 CloseButton（关闭脚本）
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 190, 0, 40)
closeButton.Position = UDim2.new(0, 15, 0, 150)
closeButton.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
closeButton.Text = "Close Script"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.Gotham
closeButton.Parent = frame

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 8)
closeButtonCorner.Parent = closeButton

-- 创建颜色选择滑动条（初始隐藏）
local sliderFrame = Instance.new("Frame")
sliderFrame.Name = "ColorSlider"
sliderFrame.Size = UDim2.new(0, 190, 0, 20)
sliderFrame.Position = UDim2.new(0, 15, 0, 160) -- 调整为与 CloseButton 间距 10 像素
sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sliderFrame.BorderSizePixel = 0
sliderFrame.Visible = false
sliderFrame.Parent = frame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local sliderGradient = Instance.new("UIGradient")
sliderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
}
sliderGradient.Parent = sliderFrame

local sliderKnob = Instance.new("Frame")
sliderKnob.Size = UDim2.new(0, 16, 0, 16)
sliderKnob.Position = UDim2.new(0, 0, 0, 2)
sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderKnob.BorderSizePixel = 0
sliderKnob.Parent = sliderFrame

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(0, 8)
knobCorner.Parent = sliderKnob

local knobStroke = Instance.new("UIStroke")
knobStroke.Thickness = 2
knobStroke.Color = Color3.fromRGB(0, 0, 0)
knobStroke.Transparency = 0.2
knobStroke.Parent = sliderKnob

-- 创建收缩按钮（初始隐藏）
local collapseButton = Instance.new("TextButton")
collapseButton.Name = "CollapseButton"
collapseButton.Size = UDim2.new(0, 40, 0, 40)
collapseButton.Position = UDim2.new(0.5, -20, 0.5, -20)
collapseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
collapseButton.Text = "+"
collapseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
collapseButton.TextSize = 20
collapseButton.Font = Enum.Font.GothamBold
collapseButton.Visible = false
collapseButton.Parent = screenGui

local collapseCorner = Instance.new("UICorner")
collapseCorner.CornerRadius = UDim.new(0, 20)
collapseCorner.Parent = collapseButton

local collapseStroke = Instance.new("UIStroke")
collapseStroke.Thickness = 2
collapseStroke.Color = Color3.fromRGB(0, 0, 0)
collapseStroke.Transparency = 0.5
collapseStroke.Parent = collapseButton

-- 高亮和 ESP 设置
local highlightEnabled = true
local espEnabled = false
local highlightColor = Color3.fromRGB(255, 0, 0)
local playerHighlights = {}
local connections = {}
local sliderVisible = false
local isCollapsed = false

-- 函数：将色调 (hue) 转换为 RGB
local function hueToRGB(hue)
    hue = hue % 1
    local r, g, b
    if hue < 1/6 then
        r = 1
        g = hue * 6
        b = 0
    elseif hue < 2/6 then
        r = 1 - (hue - 1/6) * 6
        g = 1
        b = 0
    elseif hue < 3/6 then
        r = 0
        g = 1
        b = (hue - 2/6) * 6
    elseif hue < 4/6 then
        r = 0
        g = 1 - (hue - 3/6) * 6
        b = 1
    elseif hue < 5/6 then
        r = (hue - 4/6) * 6
        g = 0
        b = 1
    else
        r = 1
        g = 0
        b = 1 - (hue - 5/6) * 6
    end
    return Color3.new(r, g, b)
end

-- 函数：计算距离
local function getDistance(player)
    if localPlayer.Character and player.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("HumanoidRootPart") then
        local localPos = localPlayer.Character.HumanoidRootPart.Position
        local targetPos = player.Character.HumanoidRootPart.Position
        return math.floor((localPos - targetPos).Magnitude * 10) / 10
    end
    return "N/A"
end

-- 函数：为玩家创建高亮和 ESP 标签
local function createHighlightForPlayer(player)
    if player == localPlayer or playerHighlights[player] then return end
    playerHighlights[player] = { highlight = nil, espGui = nil, connections = {} }

    local function onCharacterAdded(character)
        if playerHighlights[player].highlight then
            playerHighlights[player].highlight:Destroy()
            playerHighlights[player].highlight = nil
        end
        if playerHighlights[player].espGui then
            playerHighlights[player].espGui:Destroy()
            playerHighlights[player].espGui = nil
        end
        if not character then return end

        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = highlightColor
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0.5
        highlight.Parent = character
        highlight.Enabled = highlightEnabled
        playerHighlights[player].highlight = highlight

        local billboardGui = Instance.new("BillboardGui")
        billboardGui Huntington = Instance.new("BillboardGui")
        billboardGui.Name = "ESPGui"
        billboardGui.Adornee = character:FindFirstChild("Head")
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Enabled = espEnabled
        billboardGui.Parent = character

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 12
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Parent = billboardGui

        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = getDistance(player) .. " studs"
        distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distanceLabel.TextSize = 12
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distanceLabel.Parent = billboardGui

        playerHighlights[player].espGui = billboardGui
        print("高亮和 ESP 已为玩家创建:", player.Name)
    end

    local function onCharacterRemoving(character)
        if playerHighlights[player].highlight then
            playerHighlights[player].highlight:Destroy()
            playerHighlights[player].highlight = nil
        end
        if playerHighlights[player].espGui then
            playerHighlights[player].espGui:Destroy()
            playerHighlights[player].espGui = nil
        end
        print("高亮和 ESP 已为玩家移除:", player.Name)
    end

    local charAddedConn = player.CharacterAdded:Connect(onCharacterAdded)
    local charRemovingConn = player.CharacterRemoving:Connect(onCharacterRemoving)
    table.insert(playerHighlights[player].connections, charAddedConn)
    table.insert(playerHighlights[player].connections, charRemovingConn)
    table.insert(connections, charAddedConn)
    table.insert(connections, charRemovingConn)

    if player.Character then
        onCharacterAdded(player.Character)
    end
end

-- 为当前所有玩家创建高亮和 ESP（排除自己）
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createHighlightForPlayer(player)
    end
end

-- 处理新加入的玩家
local playerAddedConn = Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        createHighlightForPlayer(player)
    end
end)
table.insert(connections, playerAddedConn)

-- 处理离开的玩家
local playerRemovingConn = Players.PlayerRemoving:Connect(function(player)
    if playerHighlights[player] then
        if playerHighlights[player].highlight then
            playerHighlights[player].highlight:Destroy()
        end
        if playerHighlights[player].espGui then
            playerHighlights[player].espGui:Destroy()
        end
        for _, conn in ipairs(playerHighlights[player].connections) do
            conn:Disconnect()
        end
        playerHighlights[player] = nil
        print("玩家已离开，清理数据:", player.Name)
    end
end)
table.insert(connections, playerRemovingConn)

-- UI 控制：开关高亮
local toggleConn = toggleButton.MouseButton1Click:Connect(function()
    highlightEnabled = not highlightEnabled
    toggleButton.Text = highlightEnabled and "Toggle Highlight (ON)" or "Toggle Highlight (OFF)"
    for _, playerData in pairs(playerHighlights) do
        if playerData.highlight then
            playerData.highlight.Enabled = highlightEnabled
        end
    end
    print("高亮开关:", highlightEnabled and "开启" or "关闭")
end)
table.insert(connections, toggleConn)

-- UI 控制：显示/隐藏颜色滑动条
local colorConn = colorButton.MouseButton1Click:Connect(function()
    sliderVisible = not sliderVisible
    sliderFrame.Visible = sliderVisible
    colorButton.Text = sliderVisible and "Hide Color Slider" or "Change Color"
    print("颜色滑动条:", sliderVisible and "显示" or "隐藏")
end)
table.insert(connections, colorConn)

-- UI 控制：开关 ESP 标签
local espConn = espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "Hide ESP" or "Show ESP"
    for _, playerData in pairs(playerHighlights) do
        if playerData.espGui then
            playerData.espGui.Enabled = espEnabled
        end
    end
    print("ESP 标签:", espEnabled and "开启" or "关闭")
end)
table.insert(connections, espConn)

-- UI 控制：收缩/展开 UI
local collapseConn = collapseButton.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    frame.Visible = not isCollapsed
    collapseButton.Visible = isCollapsed
    collapseButton.Text = isCollapsed and "+" or "-"
    print("UI 状态:", isCollapsed and "收缩" or "展开")
end)
table.insert(connections, collapseConn)

-- 滑动条交互
local sliding = false
local function updateSlider(input)
    local sliderWidth = sliderFrame.AbsoluteSize.X
    local knobWidth = sliderKnob.AbsoluteSize.X
    local relativeX = input.Position.X - sliderFrame.AbsolutePosition.X
    local clampedX = math.clamp(relativeX, 0, sliderWidth - knobWidth)
    local t = clampedX / (sliderWidth - knobWidth)
    sliderKnob.Position = UDim2.new(0, clampedX, 0, 2)
    highlightColor = hueToRGB(t)
    for _, playerData in pairs(playerHighlights) do
        if playerData.highlight then
            playerData.highlight.FillColor = highlightColor
        end
    end
end

local sliderBeganConn = sliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = true
        updateSlider(input)
        print("开始滑动颜色")
    end
end)
table.insert(connections, sliderBeganConn)

local sliderChangedConn = UserInputService.InputChanged:Connect(function(input)
    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)
table.insert(connections, sliderChangedConn)

local sliderEndedConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = false
        print("结束滑动颜色")
    end
end)
table.insert(connections, sliderEndedConn)

-- UI 控制：关闭脚本
local closeConn = closeButton.MouseButton1Click:Connect(function()
    print("关闭脚本")
    for _, playerData in pairs(playerHighlights) do
        if playerData.highlight then
            playerData.highlight:Destroy()
        end
        if playerData.espGui then
            playerData.espGui:Destroy()
        end
        for _, conn in ipairs(playerData.connections) do
            conn:Disconnect()
        end
    end
    playerHighlights = {}
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
    connections = {}
    screenGui:Destroy()
end)
table.insert(connections, closeConn)

-- 使 Frame 和 CollapseButton 可拖拽
local dragging = false
local dragStart = nil
local startPos = nil
local dragTarget = nil

local inputBeganConn = UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if frame.Visible and frame:IsAncestorOf(input.UserInputState == Enum.UserInputState.Begin and input.Position) then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            dragTarget = frame
        elseif collapseButton.Visible and collapseButton:IsAncestorOf(input.UserInputState == Enum.UserInputState.Begin and input.Position) then
            dragging = true
            dragStart = input.Position
            startPos = collapseButton.Position
            dragTarget = collapseButton
        end
        if dragging then
            print("开始拖拽:", dragTarget.Name)
        end
    end
end)
table.insert(connections, inputBeganConn)

local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        dragTarget.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
table.insert(connections, inputChangedConn)

local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            print("结束拖拽:", dragTarget.Name)
        end
        dragging = false
        dragTarget = nil
    end
end)
table.insert(connections, inputEndedConn)

-- 每帧更新 ESP 距离
local heartbeatConn = Run30fps = RunService.Heartbeat:Connect(function()
    if espEnabled then
        for _, playerData in pairs(playerHighlights) do
            if playerData.espGui then
                local distanceLabel = playerData.espGui:FindFirstChild("DistanceLabel", true)
                if distanceLabel then
                    local player = Players:GetPlayerFromCharacter(playerData.espGui.Adornee.Parent)
                    if player then
                        distanceLabel.Text = getDistance(player) .. " studs"
                    end
                end
            end
        end
    end
end)
table.insert(connections, heartbeatConn)
