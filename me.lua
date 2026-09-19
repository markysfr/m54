-- m6rcxdeee_ GOLD GUI - 2025 | Toggle Z + Transparente + Teclas sincronizadas
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "m6rcxdeeeGold"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local UserInputService = game:GetService("UserInputService")

local guiAbierto = true

-- === COLORES ===
local COLOR_NORMAL    = Color3.fromRGB(40, 40, 40)
local COLOR_ACTIVO    = Color3.fromRGB(255, 215, 0)
local COLOR_TEXTO_OFF = Color3.fromRGB(255, 215, 0)
local COLOR_TEXTO_ON  = Color3.fromRGB(0, 0, 0)

-- === MAIN FRAME ===
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 300)  -- 🔥 más bajo, porque hay menos botones
main.Position = UDim2.new(0.5, -140, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.5
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 3
stroke.Transparency = 0.3

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "m6rcxdeee_"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.Font = Enum.Font.GothamBlack
title.TextSize = 32
title.Parent = main

-- === DATOS DE BOTONES (solo los 5 reales) ===
local botones = {
    {nombre = "CTRL + TP",  url = "https://raw.githubusercontent.com/markysfr/ctrl-tp/refs/heads/main/ctrltp.lua"},
    {nombre = "NOCLIP",     url = "https://raw.githubusercontent.com/markysfr/noclip/refs/heads/main/noclip.lua"},
    {nombre = "FULLBRIGHT", url = "https://raw.githubusercontent.com/markysfr/fullbright/refs/heads/main/fullbright.lua"},
    {nombre = "ESP",        url = "https://raw.githubusercontent.com/markysfr/espfull/refs/heads/main/espnpc.lua"},
    {nombre = "X-RAY",      url = "https://raw.githubusercontent.com/markysfr/x-ray/refs/heads/main/xray.lua"}
}

local botonesRef = {}

-- === FUNCIÓN TOGGLE ===
local function toggleBoton(i)
    local ref = botonesRef[i]
    if not ref then return end

    ref.activo = not ref.activo

    if ref.activo then
        ref.boton.BackgroundColor3 = COLOR_ACTIVO
        ref.boton.TextColor3 = COLOR_TEXTO_ON
    else
        ref.boton.BackgroundColor3 = COLOR_NORMAL
        ref.boton.TextColor3 = COLOR_TEXTO_OFF
    end

    if botones[i].url ~= "" then
        loadstring(game:HttpGet(botones[i].url))()
    end
end

-- === CREAR BOTONES ===
for i = 1, #botones do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-30,0,38)
    btn.Position = UDim2.new(0,15,0,45 + (i-1)*42)
    btn.BackgroundColor3 = COLOR_NORMAL
    btn.BackgroundTransparency = 0.3
    btn.Text = botones[i].nombre
    btn.TextColor3 = COLOR_TEXTO_OFF
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = main

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 10)

    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(255, 215, 0)
    s.Thickness = 1.5
    s.Transparency = 0.7

    botonesRef[i] = {
        boton = btn,
        activo = false,
        stroke = s
    }

    btn.MouseButton1Click:Connect(function()
        toggleBoton(i)
    end)

    btn.MouseEnter:Connect(function()
        if not botonesRef[i].activo then
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 0)
        end
    end)
    btn.MouseLeave:Connect(function()
        if not botonesRef[i].activo then
            btn.BackgroundColor3 = COLOR_NORMAL
        end
    end)
end

-- === 🔥 MAPEO DE TECLAS EN ORDEN ===
-- 1 -> CTRL + TP
-- 2 -> NOCLIP
-- 3 -> FULLBRIGHT
-- 4 -> ESP
-- 5 -> X-RAY
local teclasNumericas = {
    [Enum.KeyCode.One]   = 1,
    [Enum.KeyCode.Two]   = 2,
    [Enum.KeyCode.Three] = 3,
    [Enum.KeyCode.Four]  = 4,
    [Enum.KeyCode.Five]  = 5,
    -- Numpad
    [Enum.KeyCode.KeypadOne]   = 1,
    [Enum.KeyCode.KeypadTwo]   = 2,
    [Enum.KeyCode.KeypadThree] = 3,
    [Enum.KeyCode.KeypadFour]  = 4,
    [Enum.KeyCode.KeypadFive]  = 5
}

-- === TOGGLE CON Z ===
local toggleKey = Enum.KeyCode.Z

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == toggleKey then
        guiAbierto = not guiAbierto
        gui.Enabled = guiAbierto
        if guiAbierto then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
        end
        return
    end

    if not guiAbierto then return end

    local idx = teclasNumericas[input.KeyCode]
    if idx then
        toggleBoton(idx)
    end
end)

-- === LIBERAR CURSOR AL INICIO ===
UserInputService.MouseBehavior = Enum.MouseBehavior.Default
UserInputService.MouseIconEnabled = true
