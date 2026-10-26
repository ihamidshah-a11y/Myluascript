--[[
    SAMMY V1 - RAINBOW EDITION
    "SAMMY 🤝 SAI 🤑"
]]

-- Ensure game is loaded
repeat task.wait() until game:IsLoaded()

local lp = game:GetService("Players").LocalPlayer
local tcs = game:GetService("TextChatService")
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local cg = game:GetService("CoreGui")
local ts = game:GetService("TweenService")
local run = game:GetService("RunService")

local looping = false
local safeMode = false
local cyclePatterns = true
local pIdx = 1
local patternIdx = 1

-- ALL PATTERNS
local customPatterns = {
    "_____", "$_$", "&_&", "=====", "~~~~~", "#####", "___", "-_-"
}

-- 1. UTILS
local function sendGlobal(txt)
    pcall(function()
        if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = tcs:FindFirstChild("RBXGeneral", true)
            if channel then channel:SendAsync(txt) end
        else
            rs.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(txt, "All")
        end
    end)
end

local function makeDraggable(gui, dragPart)
    local dragging, dragInput, dragStart, startPos
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    uis.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    run.Heartbeat:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

-- 2. GUI CONSTRUCTION
if cg:FindFirstChild("SAMMY_V1_FINAL") then cg:FindFirstChild("SAMMY_V1_FINAL"):Destroy() end
local sg = Instance.new("ScreenGui", cg); sg.Name = "HAMID_V1_FINAL"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 420); main.Position = UDim2.new(0.5, -130, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main.Visible = false; main.ClipsDescendants = true
local mainStroke = Instance.new("UIStroke", main); mainStroke.Thickness = 2
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
makeDraggable(main, main)

-- RAINBOW CONTROLLER
run.RenderStepped:Connect(function()
    local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    mainStroke.Color = color
end)

-- Tab Navigation
local tabF = Instance.new("Frame", main); tabF.Size = UDim2.new(1,0,0,35); tabF.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
local btnSpam = Instance.new("TextButton", tabF); btnSpam.Size = UDim2.new(0.5,0,1,0); btnSpam.Text = "SPAM"; btnSpam.TextColor3 = Color3.new(1,1,1); btnSpam.BackgroundTransparency = 1; btnSpam.Font = "GothamBold"
local btnCred = Instance.new("TextButton", tabF); btnCred.Size = UDim2.new(0.5,0,1,0); btnCred.Position = UDim2.new(0.5,0,0,0); btnCred.Text = "CREDITS"; btnCred.TextColor3 = Color3.new(1,1,1); btnCred.BackgroundTransparency = 1; btnCred.Font = "GothamBold"

local spamP = Instance.new("Frame", main); spamP.Size = UDim2.new(1,0,0.9,0); spamP.Position = UDim2.new(0,0,0.1,0); spamP.BackgroundTransparency = 1
local credP = Instance.new("ScrollingFrame", main); credP.Visible = false; credP.Size = spamP.Size; credP.Position = spamP.Position; credP.BackgroundTransparency = 1; credP.ScrollBarThickness = 2; credP.CanvasSize = UDim2.new(0,0,1,0)

btnSpam.MouseButton1Click:Connect(function() spamP.Visible = true; credP.Visible = false end)
btnCred.MouseButton1Click:Connect(function() spamP.Visible = false; credP.Visible = true end)

-- CREDITS SECTION
local crText = Instance.new("TextLabel", credP)
crText.Size = UDim2.new(0.9, 0, 0, 200); crText.Position = UDim2.new(0.05, 0, 0.05, 0); crText.BackgroundTransparency = 1; crText.TextColor3 = Color3.new(1, 1, 1); crText.TextWrapped = true; crText.Font = "GothamBold"; crText.TextSize = 18; crText.TextYAlignment = 0; crText.TextXAlignment = 1
crText.Text = "MADE BY HAMID 🤫"

-- SPAM ELEMENTS
local nIn = Instance.new("TextBox", spamP); nIn.Size = UDim2.new(0.9,0,0,30); nIn.Position = UDim2.new(0.05,0,0.03,0); nIn.Text = "TARGET"; nIn.BackgroundColor3 = Color3.fromRGB(30,30,35); nIn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", nIn)
local dIn = Instance.new("TextBox", spamP); dIn.Size = UDim2.new(0.9,0,0,30); dIn.Position = UDim2.new(0.05,0,0.12,0); dIn.Text = "1.5"; dIn.BackgroundColor3 = Color3.fromRGB(30,30,35); dIn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", dIn)

local patBtn = Instance.new("TextButton", spamP); patBtn.Size = UDim2.new(0.9,0,0,30); patBtn.Position = UDim2.new(0.05,0,0.21,0); patBtn.Text = "Pattern: CYCLE ALL"; patBtn.BackgroundColor3 = Color3.fromRGB(40,40,60); patBtn.TextColor3 = Color3.new(0, 0.8, 1); Instance.new("UICorner", patBtn)
local cycleBtn = Instance.new("TextButton", spamP); cycleBtn.Size = UDim2.new(0.9,0,0,30); cycleBtn.Position = UDim2.new(0.05,0,0.30,0); cycleBtn.Text = "Mode: AUTO CYCLE"; cycleBtn.BackgroundColor3 = Color3.fromRGB(40,40,45); cycleBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", cycleBtn)

local safeBtn = Instance.new("TextButton", spamP); safeBtn.Size = UDim2.new(0.9,0,0,30); safeBtn.Position = UDim2.new(0.05,0,0.39,0); safeBtn.Text = "Safe Mode: OFF"; safeBtn.BackgroundColor3 = Color3.fromRGB(40,40,45); safeBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", safeBtn)
local startB = Instance.new("TextButton", spamP); startB.Size = UDim2.new(0.9,0,0,35); startB.Position = UDim2.new(0.05,0,0.52,0); startB.Text = "START SPAM"; startB.BackgroundColor3 = Color3.fromRGB(0, 150, 70); startB.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", startB)
local stopB = Instance.new("TextButton", spamP); stopB.Size = UDim2.new(0.9,0,0,35); stopB.Position = UDim2.new(0.05,0,0.64,0); stopB.Text = "STOP SPAM"; stopB.BackgroundColor3 = Color3.fromRGB(180, 0, 0); stopB.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", stopB)

-- Logic
patBtn.MouseButton1Click:Connect(function()
    patternIdx = (patternIdx >= #customPatterns) and 1 or (patternIdx + 1)
    patBtn.Text = "Pattern: " .. customPatterns[patternIdx]
end)

cycleBtn.MouseButton1Click:Connect(function()
    cyclePatterns = not cyclePatterns
    cycleBtn.Text = cyclePatterns and "Mode: AUTO CYCLE" or "Mode: STATIC"
    cycleBtn.TextColor3 = cyclePatterns and Color3.new(1,1,1) or Color3.new(1,0.5,0)
end)

-- 3. S-BUTTON (Rainbow Border)
local sHold = Instance.new("Frame", sg); sHold.Size = UDim2.new(0, 65, 0, 65); sHold.Position = UDim2.new(0, 30, 0.5, -30); sHold.BackgroundTransparency = 1
local sBtn = Instance.new("TextButton", sHold); sBtn.Size = UDim2.new(0.7,0,0.7,0); sBtn.Position = UDim2.new(0.15,0,0.15,0); sBtn.BackgroundColor3 = Color3.new(0,0,0); sBtn.Text = "S"; sBtn.TextColor3 = Color3.new(1,1,1); sBtn.Font = "FredokaOne"; sBtn.TextSize = 24; Instance.new("UICorner", sBtn).CornerRadius = UDim.new(1,0)
local sStroke = Instance.new("UIStroke", sBtn); sStroke.Thickness = 2

run.RenderStepped:Connect(function()
    sStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
end)
makeDraggable(sHold, sBtn)

-- 4. PHRASES
local phrases = {
    "TMKX ME OIL", "TMKX ME LUFFY", "TMKX ME CAR", -- NEW PHRASES ADDED HERE
    "TMKX ME GEMINI ✌️", "TMKX ME GALAXIES😏", "TMKX ME GLACIER♠️", "TMKX ME FLASH⚡", "TMKX ME MOUNTAINS👌", 
    "TMKX ME PAPERWORKS♠️", "TMKX ME HARD DRIVE🌚", "PAPA HAMID RUNS YOU🗿", "TMKX ME KARELA🤢", "SURRENDER KRDE🏳️", 
    "TMKX ME QATAR AIRWAYS👌", "TMKX ME AVENGERS🤑", "TMKX ME GALACTUS💀", "PAPA KO H8 WHY😏", "TMKX ME GOAT🥰"
}

safeBtn.MouseButton1Click:Connect(function()
    safeMode = not safeMode
    safeBtn.Text = safeMode and "Safe Mode: ON" or "Safe Mode: OFF"
    safeBtn.TextColor3 = safeMode and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

startB.MouseButton1Click:Connect(function() looping = true end)
stopB.MouseButton1Click:Connect(function() looping = false end)

task.spawn(function()
    while true do
        if looping then
            local target = nIn.Text; local phrase = phrases[pIdx]; local pat = customPatterns[patternIdx]
            local maxLen = 195 
            local available = maxLen - (#target + #phrase + 2)
            local finalPattern = string.sub(string.rep(pat, 40), 1, math.max(available, 5))
            sendGlobal(finalPattern .. " " .. target .. " " .. phrase)
            pIdx = (pIdx >= #phrases) and 1 or (pIdx + 1)
            if cyclePatterns then
                patternIdx = (patternIdx >= #customPatterns) and 1 or (patternIdx + 1)
                patBtn.Text = "Pattern: " .. customPatterns[patternIdx]
            end
            local waitTime = tonumber(dIn.Text) or 1.5
            if safeMode then waitTime = waitTime + (math.random(-2, 2)/10) end
            task.wait(math.max(waitTime, 0.1))
        else task.wait(0.5) end
    end
end)

-- 5. INTRO WITH RAINBOW LOADING BAR
task.spawn(function()
    local iS = Instance.new("ScreenGui", cg)
    local box = Instance.new("Frame", iS); box.Size = UDim2.new(0, 400, 0, 150); box.Position = UDim2.new(0.5, -200, 0.45, -75); box.BackgroundColor3 = Color3.new(0,0,0); box.BackgroundTransparency = 0.2
    local bStroke = Instance.new("UIStroke", box); bStroke.Thickness = 2
    
    -- Loading Bar Container
    local barBG = Instance.new("Frame", box); barBG.Size = UDim2.new(0.8, 0, 0, 10); barBG.Position = UDim2.new(0.1, 0, 0.8, 0); barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    local barFill = Instance.new("Frame", barBG); barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.new(1,1,1)
    local uic = Instance.new("UICorner", barBG); local uic2 = Instance.new("UICorner", barFill)
    
    run.RenderStepped:Connect(function()
        local c = Color3.fromHSV(tick() % 2 / 2, 1, 1)
        bStroke.Color = c
        barFill.BackgroundColor3 = c
    end)

    local l = Instance.new("TextLabel", box); l.Size = UDim2.new(1,0,0.7,0); l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1); l.Font = "Code"; l.TextSize = 22; l.Text = ""
    
    ts:Create(barFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    
    local function typeW(str)
        l.Text = ""
        for i = 1, #str do l.Text = str:sub(1,i); task.wait(0.04) end
        task.wait(0.5)
    end
    
    typeW("HAMID V1"); typeW("HAMID 🤝 SAI 🤑")
    
    local startupPattern = string.rep("_____", 30)
    sendGlobal(startupPattern .. " HAMID PAPA V1 LOADED 😏✌️")
    iS:Destroy(); main.Visible = true
end)

sBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
