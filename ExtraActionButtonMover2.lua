UIPARENT_MANAGED_FRAME_POSITIONS["PlayerPowerBarAlt"] = nil
--PlayerPowerBarAlt.ignoreFramePositionManager = true
PlayerPowerBarAlt:SetMovable(true)
PlayerPowerBarAlt:SetUserPlaced(true)

EABMoverDB2 = EABMoverDB2 or {}

local r, g, b, a = 0, 0, 0.8, 0.5 --mover color
local move = nil


function EAB_Anchors()
    --extra action button mover
    EABMover = CreateFrame("Frame", "EABMover", UIParent)
    EABMover:SetWidth(50)
    EABMover:SetHeight(50)
    EABMover:SetPoint(EABMoverDB2.moverPoint, EABMoverDB2.moverRelativeTo, EABMoverDB2.moverRelativePoint, EABMoverDB2.moverX, EABMoverDB2.moverY)

    EABMovertext = EABMover:CreateFontString("$parent_Text", "OVERLAY", "GameFontNormal")
    EABMovertext:SetTextColor(1, 1, 1)
    EABMovertext:SetPoint("TOP", EABMover, "BOTTOM", 0, -5)
    EABMovertext:SetText("Extra Action Button 1")

    EABMovericon = EABMover:CreateTexture("$parent_Icon")
    EABMovericon:SetColorTexture(r, g, b, a)
    EABMovericon:SetAllPoints()

    EABMover:EnableMouse(true)
    EABMover:SetMovable(true)
    EABMover:RegisterForDrag("LeftButton")
    EABMover:SetScript("OnDragStart", EABMover.StartMoving)
    EABMover:SetScript("OnDragStop", EABMover.StopMovingOrSizing)
    EABMover:SetToplevel()
    EABMover:SetFrameStrata("MEDIUM")
    EABMover:Hide()

    --power bar alt mover
    EABPower = CreateFrame("Frame", "EABPower", UIParent)
    EABPower:SetWidth(120)
    EABPower:SetHeight(40)
    EABPower:SetPoint(EABMoverDB2.powerPoint, EABMoverDB2.powerRelativeTo, EABMoverDB2.powerRelativePoint, EABMoverDB2.powerX, EABMoverDB2.powerY)

    EABPowertext = EABPower:CreateFontString("$parent_Text", "OVERLAY", "GameFontNormal")
    EABPowertext:SetTextColor(1, 1, 1)
    EABPowertext:SetPoint("TOP", EABPower, "BOTTOM", 0, -5)
    EABPowertext:SetText("Player Power Bar Alt")

    EABPowericon = EABPower:CreateTexture("$parent_Icon")
    EABPowericon:SetColorTexture(r, g, b, a)
    EABPowericon:SetAllPoints()

    EABPower:EnableMouse(true)
    EABPower:SetMovable(true)
    EABPower:RegisterForDrag("LeftButton")
    EABPower:SetScript("OnDragStart", EABPower.StartMoving)
    EABPower:SetScript("OnDragStop", EABPower.StopMovingOrSizing)
    EABPower:SetToplevel()
    EABPower:SetFrameStrata("HIGH")
    EABPower:Hide()
end

--frame
EABframe = CreateFrame("Frame", "EABframe", UIParent)
EABframe:RegisterEvent("ADDON_LOADED")
EABframe:RegisterEvent("PLAYER_REGEN_ENABLED")
EABframe:Show()

function EAB_OnEvent(self, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == "ExtraActionButtonMover2" then
        EABframe:UnregisterEvent("ADDON_LOADED")
        if next(EABMoverDB2) == nil then
            EAB_FillTable()
        end
        EAB_Anchors()
        move = false
        EAB_Hook()
        print("|cFF00DFFFExtra Action Button Mover Slash Commands:\n/eab - Shows the movable frames (type /eab again to hide them)\n/eab reset - Moves frames to their default position|r")
    elseif event == "PLAYER_REGEN_ENABLED" then
        EAB_Hook()
    end
end

function EAB_Timer()
    if PlayerPowerBarAlt:IsVisible() then
        PlayerPowerBarAlt:ClearAllPoints()
        PlayerPowerBarAlt:SetPoint("CENTER", EABPower, "CENTER")
    end
end

function EAB_Hook()
    if UnitAffectingCombat("player") ~= 1 then
        ExtraActionButton1:ClearAllPoints()
        ExtraActionButton1:SetPoint("CENTER", EABMover, "CENTER")
        PlayerPowerBarAlt:ClearAllPoints()
        PlayerPowerBarAlt:SetPoint("CENTER", EABPower, "CENTER")

        --point, relativeTo, relativePoint, xOfs, yOfs = MyRegion:GetPoint(n)
        --relativeTo:GetName()
        moverPoint, moverRelativeTo, moverRelativePoint, moverX, moverY = EABMover:GetPoint(1)
        EABMoverDB2.moverX = moverX
        EABMoverDB2.moverY = moverY
        EABMoverDB2.moverPoint = "CENTER"
        EABMoverDB2.moverRelativeTo = UIParent:GetName()
        EABMoverDB2.moverRelativePoint = "CENTER"
        powerPoint, powerRelativeTo, powerRelativePoint, powerX, powerY = EABPower:GetPoint(1)
        EABMoverDB2.powerX = powerX
        EABMoverDB2.powerY = powerY
        EABMoverDB2.powerPoint = "CENTER"
        EABMoverDB2.powerRelativeTo = UIParent:GetName()
        EABMoverDB2.powerRelativePoint = "CENTER"
    end
end

function EAB_ResetDefaultPosition()
    if UnitAffectingCombat("player") ~= 1 then
        EABMover:ClearAllPoints()
        EABMover:SetPoint("CENTER", ExtraActionBarFrame, "CENTER", 0, 0)
        ExtraActionButton1:ClearAllPoints()
        ExtraActionButton1:SetPoint("CENTER", EABMover, "CENTER")

        EABPower:ClearAllPoints()
        EABPower:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 195)
        PlayerPowerBarAlt:ClearAllPoints()
        PlayerPowerBarAlt:SetPoint("CENTER", EABPower, "CENTER")

        EAB_FillTable()
    end
end

function EAB_FillTable()
    --button
    EABMoverDB2.moverX = 0
    EABMoverDB2.moverY = 0
    EABMoverDB2.moverPoint = "CENTER"
    EABMoverDB2.moverRelativeTo = ExtraActionBarFrame:GetName()
    EABMoverDB2.moverRelativePoint = "CENTER"

    --power
    EABMoverDB2.powerX = 0
    EABMoverDB2.powerY = 195
    EABMoverDB2.powerPoint = "BOTTOM"
    EABMoverDB2.powerRelativeTo = UIParent:GetName()
    EABMoverDB2.powerRelativePoint = "BOTTOM"
end

SLASH_EAB1 = "/eab"
SlashCmdList["EAB"] = function(msg, editBox)
    if msg == "" then
        if move ~= nil then
            if move == false then
                EABMover:Show()
                EABPower:Show()
                print("|cFF00DFFFExtraActionButtonMover: Type /eab to hide frames|r")
                move = true
            elseif move == true then
                EAB_Hook()
                EABMover:Hide()
                EABPower:Hide()
                move = false
            end
        end
    elseif msg == "reset" then
        if move ~= nil then
            if move == true then
                EABMover:Hide()
                EABPower:Hide()
                move = false
            end
        end
        EAB_ResetDefaultPosition()
    end
end

EABframe:SetScript("OnEvent", EAB_OnEvent)
EABframe:SetScript("OnUpdate", EAB_Timer)