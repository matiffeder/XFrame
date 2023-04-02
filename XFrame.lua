_G.XFVERSION = "1.0";
local frames={"XP", "PF", "PET", "TF", "TT", "BF", "DB", "CB", "TCB", "PT", "HF", "GHF", "FPS"};
local add={
	gui={{
		name = "XFrame",
		version = XFVERSION,
		window = "XFrameGUI",
	}},
	popup={{
		GetText = function() return "XFrame"; end,
		GetTooltip = function() return "/xf, /xframe"; end,
		OnClick = function(this, key) XAddon_ShowPage("XFrameGUI"); end,
}}};
local def={
	["Enable"] = true,
	["Anchor"] = false,
	["HideMenu"] = true,
	["HideExp"] = false,
	["PF_X"] = 0, ["PF_Y"] = 0,
	["PET_X"] = 142, ["PET_Y"] = 60,
	["TF_X"] = -64, ["TF_Y"] = 2,
	["TT_X"] = -45, ["TT_Y"] = -37,
	["BF_X"] = -200, ["BF_Y"] = 10,
	["DB_X"] = 0, ["DB_Y"] = 18,
	["CB_X"] = 0, ["CB_Y"] = -120,
	["TCB_X"] = 0, ["TCB_Y"] = 0,
	["XP_X"] = 0, ["XP_Y"] = 0, ["XP_W"] = 832,
	["PT_X"] = 2, ["PT_Y"] = 118,
	["HF_X"] = 0, ["HF_Y"] = 0,
	["GHF_X"] = 0, ["GHF_Y"] = 0,
	["FPS_X"] = -260, ["FPS_Y"] = -98,
};
XFrameSet = {};

SlashCmdList["XFRAME"] = function(editbox, msg)
	if XBARVERSION and XBARVERSION>=1.51 then
		XAddon_ShowPage("XFrameGUI");
	else
		ToggleUIFrame(XFrameGUI);
	end
end
SLASH_XFRAME1 = "/xf";
SLASH_XFRAME2 = "/xframe";

function XFrame_UpF(str)
	return str:sub(1, 1):upper()..str:sub(2)
end

function XFrame_Var()
	if XFrameSet["Enable"]==true then
		if XFrameSet["Anchor"]==true then
			for i, v in pairs(frames) do
				getglobal("XFrame"..v):Show();
			end
			XFrameFPS:Hide();
		else
			for i, v in pairs(frames) do
				getglobal("XFrame"..v):Hide();
			end
		end
		ExperienceFrame:ClearAllAnchors();
		ExperienceFrame:SetAnchor("BOTTOM", "BOTTOM", "UIParent", XFrameSet["XP_X"], XFrameSet["XP_Y"]);
		ExperienceFrame:SetWidth(XFrameSet["XP_W"]);
		MainMenuFrame:ClearAllAnchors();
		MainMenuFrame:SetAnchor("BOTTOM", "BOTTOM", "ExperienceFrame", 0, 0);
		PlayerFrame:ClearAllAnchors();
		PlayerFrame:SetAnchor("TOPLEFT", "TOPLEFT", "UIParent", XFrameSet["PF_X"], XFrameSet["PF_Y"]);
		PetHeadFrame:ClearAllAnchors();
		PetHeadFrame:SetAnchor("TOPLEFT", "TOPLEFT", "PlayerFrame", XFrameSet["PET_X"], XFrameSet["PET_Y"]);
		TargetFrame:ClearAllAnchors();
		TargetFrame:SetAnchor("TOP", "TOP", "UIParent", XFrameSet["TF_X"], XFrameSet["TF_Y"]);
		TargetTargetFrame:ClearAllAnchors();
		TargetTargetFrame:SetAnchor("TOPLEFT", "BOTTOMRIGHT", "TargetFrame", (XFrameSet["TT_X"]), (XFrameSet["TT_Y"]));
		PlayerBuffButton1:ClearAllAnchors();
		PlayerBuffButton1:SetAnchor("TOPRIGHT", "TOPRIGHT", "UIParent", XFrameSet["BF_X"], XFrameSet["BF_Y"]);
		PlayerDebuffButton1:ClearAllAnchors();
		PlayerDebuffButton1:SetAnchor("TOPRIGHT", "BOTTOMRIGHT", "PlayerBuffButton17", XFrameSet["DB_X"], XFrameSet["DB_Y"]);
		CastingBarFrame:ClearAllAnchors();
		CastingBarFrame:SetAnchor("BOTTOM", "BOTTOM", "UIParent", XFrameSet["CB_X"], XFrameSet["CB_Y"]);
		TargetCastingBar:ClearAllAnchors();
		TargetCastingBar:SetAnchor("TOPLEFT", "BOTTOMLEFT", "TargetFrame", XFrameSet["TCB_X"], XFrameSet["TCB_Y"]);
		UnitFrame_party1:ClearAllAnchors();
		UnitFrame_party1:SetAnchor("TOPLEFT", "TOPLEFT", "UIParent", XFrameSet["PT_X"], XFrameSet["PT_Y"]);
		HouseFrame:ClearAllAnchors();
		HouseFrame:SetAnchor("TOPLEFT", "TOPLEFT", "UIParent", XFrameSet["HF_X"], XFrameSet["HF_Y"]);
		GuildHouseFrame:ClearAllAnchors();
		GuildHouseFrame:SetAnchor("TOPLEFT", "TOPLEFT", "UIParent", XFrameSet["GHF_X"], XFrameSet["GHF_Y"]);
		XFrameFPSTexture:SetTexture("Interface/WorldMap/WorldMap-TitlebarSwitch-Normal");
		XFrameFPSTexture:SetColor(1, 1, 1);
		XFrameFPS:ClearAllAnchors();
		XFrameFPS:SetAnchor("BOTTOM", "BOTTOM", "UIParent", XFrameSet["FPS_X"], XFrameSet["FPS_Y"]);
		FramerateText:SetScale(0.8);
		FramerateText:ClearAllAnchors();
		FramerateText:SetAnchor("LEFT", "LEFT", "XFrameFPS", 10, 8);
		if XFrameSet["HideMenu"]==true then
			MainMenuFrame:Hide();
		else
			MainMenuFrame:Show();
		end
		if XFrameSet["HideExp"]==true then
			ExperienceFrame:Hide();
		else
			ExperienceFrame:Show();
		end
	else
		for i, v in pairs(frames) do
			getglobal("XFrame"..v):Hide();
		end
		MainMenuFrame:Show();
		ExperienceFrame:Show();
	end
end

function XFrame_OnLoad(this)
	this:RegisterEvent("VARIABLES_LOADED");
	SaveVariables("XFrameSet");
	local lang = GetLanguage():upper();
	local _, err = loadfile("Interface/Addons/XFrame/Locales/"..lang..".lua");
	if err then
		XFrame_Print("|cff993333XFrame can't find translation, ENUS.lua loaded.|r");
		dofile("Interface/Addons/XFrame/Locales/ENUS.lua");
	else
		dofile("Interface/Addons/XFrame/Locales/"..lang..".lua");
	end
end

function XFrame_OnEvent(event)
	if event=="VARIABLES_LOADED" then
		for k, v in pairs(def) do
			if XFrameSet[k]==nil then
				XFrameSet[k] = v;
			end
		end
		if XBARVERSION and XBARVERSION>=1.51 then
			XAddon_Register(add);
		end
		XFrame_Var();
		XFrame_Print("|cffBBF3E5XFrame %s|r %s |cffBBF3E5/xf|r %s", XFVERSION, XFrameLang["Load"], XFrameLang["ToConfig"]);
	end
end

function XFrame_OnShow()
	XFrameGUI_CB:SetChecked(XFrameSet["Enable"]);
	XFrameGUI_XA:SetChecked(XFrameSet["Anchor"]);
	XFrameGUI_HM:SetChecked(XFrameSet["HideMenu"]);
	XFrameGUI_HE:SetChecked(XFrameSet["HideExp"]);
	for i, v in pairs(frames) do
		getglobal("XFrameGUI_"..v.."_X"):SetText(math.floor(XFrameSet[v.."_X"]));
		getglobal("XFrameGUI_"..v.."_Y"):SetText(math.floor(XFrameSet[v.."_Y"]));
	end
	XFrameGUI_XP_W:SetText(math.floor(XFrameSet["XP_W"]));
	XFrameGUI_Version:SetText("XFrame "..XFVERSION)
	XFrameGUI_XA_Text:SetText(XFrameLang["Anchor"]);
	XFrameGUI_HM_Text:SetText(XFrameLang["HideMenu"]);
	XFrameGUI_HE_Text:SetText(XFrameLang["HideExp"]);
	XFrameGUI_HM:SetScale(0.7);
	XFrameGUI_HE:SetScale(0.7);
	XFrameGUI_BF_Dummy:SetText(XFrameLang["Dummy"]);
	XFrameGUI_DB_Dummy:SetText(XFrameLang["Dummy"]);
	XFrameGUI_CB_Dummy:SetText(XFrameLang["Dummy"]);
	XFrameGUI_TCB_Dummy:SetText(XFrameLang["Dummy"]);
	XFrameGUI_PT_Dummy:SetText(XFrameLang["Dummy"]);
	XFrameGUI_FPS_Dummy:SetText(XFrameLang["Anchor"]);
	XFrameGUI_XP_X_Desc:SetText(TUTORIAL_TITLE16);
	XFrameGUI_XP_W_Text:SetText(GCF_TEXT_WIDTH.." :");
	XFrameGUI_XP_G:SetText(XFrameLang["Screen"]);
	XFrameGUI_PF_X_Desc:SetText(CHARACTER_FRAME_TITLE);
	XFrameGUI_PET_X_Desc:SetText(SKILLBOOK_TAB_PET);
	XFrameGUI_TF_X_Desc:SetText(TUTORIAL_TITLE13);
	XFrameGUI_TT_X_Desc:SetText(XFrameLang["TargetTarget"]);
	XFrameGUI_BF_X_Desc:SetText(XFrame_UpF(_glossary_00827));
	XFrameGUI_DB_X_Desc:SetText(XFrameLang["Debuff"]);
	XFrameGUI_CB_X_Desc:SetText(XFrameLang["CastingBar"]);
	XFrameGUI_TCB_X_Desc:SetText(XFrameLang["TCastingBar"]);
	XFrameGUI_PT_X_Desc:SetText(PARTY);
	XFrameGUI_HF_X_Desc:SetText(XFrame_UpF(_glossary_00073));
	XFrameGUI_GHF_X_Desc:SetText(GUILDBOARD_HOUSE);
	XFrameGUI_FPS_X_Desc:SetText("FPS");
end

function XFrame_Default()
	for i, v in pairs(def) do
		XFrameSet[i] = v;
	end
	XFrame_OnShow();
	XFrame_Save();
end

function XFrame_Save()
	XFrameSet["Enable"] = XFrameGUI_CB:IsChecked();
	XFrameSet["Anchor"] = XFrameGUI_XA:IsChecked();
	XFrameSet["HideMenu"] = XFrameGUI_HM:IsChecked();
	XFrameSet["HideExp"] = XFrameGUI_HE:IsChecked();
	for i, v in pairs(frames) do
		XFrameSet[v.."_X"] = tonumber(getglobal("XFrameGUI_"..v.."_X"):GetText());
		XFrameSet[v.."_Y"] = tonumber(getglobal("XFrameGUI_"..v.."_Y"):GetText());
	end
	XFrameSet["XP_W"] = tonumber(XFrameGUI_XP_W:GetText())
	XFrame_Print("|cffBBF3E5XFrame|r %s", XFrameLang["Saved"]);
	XFrame_Var();
end

function XFrame_Close(this)
	if XBARVERSION and XBARVERSION>=1.51 then
		XAddonMngr:Hide();
	end
	this:GetParent():Hide();
end

function XFrame_MoveStart(key, this, dummy)
	if dummy then
		this:StartMoving();
	elseif key=="RBUTTON" and IsShiftKeyDown() then
		this:GetParent():StartMoving();
	end
end

function XFrame_MoveEnd(this, dummy, frame)
	this:StopMovingOrSizing(); this:GetParent():StopMovingOrSizing();
	if dummy then
		local anc, relp, relt, posX, posY = this:GetAnchor();
		getglobal(frame):ClearAllAnchors();
		getglobal(frame):SetAnchor(anc, relp, relt, posX, posY);
		this:Hide();
	end
	_, _, _, XFrameSet["PF_X"], XFrameSet["PF_Y"] = PlayerFrame:GetAnchor();
	_, _, _, XFrameSet["PET_X"], XFrameSet["PET_Y"] = PetHeadFrame:GetAnchor();
	_, _, _, XFrameSet["TF_X"], XFrameSet["TF_Y"] = TargetFrame:GetAnchor();
	_, _, _, XFrameSet["TT_X"], XFrameSet["TT_Y"] = TargetTargetFrame:GetAnchor();
	_, _, _, XFrameSet["BF_X"], XFrameSet["BF_Y"] = PlayerBuffButton1:GetAnchor();
	_, _, _, XFrameSet["DB_X"], XFrameSet["DB_Y"] = PlayerDebuffButton1:GetAnchor();
	_, _, _, XFrameSet["CB_X"], XFrameSet["CB_Y"] = CastingBarFrame:GetAnchor();
	_, _, _, XFrameSet["TCB_X"], XFrameSet["TCB_Y"] = TargetCastingBar:GetAnchor();
	_, _, _, XFrameSet["XP_X"], XFrameSet["XP_Y"] = ExperienceFrame:GetAnchor();
	_, _, _, XFrameSet["PT_X"], XFrameSet["PT_Y"] = UnitFrame_party1:GetAnchor();
	_, _, _, XFrameSet["HF_X"], XFrameSet["HF_Y"] = HouseFrame:GetAnchor();
	_, _, _, XFrameSet["GHF_X"], XFrameSet["GHF_Y"] = GuildHouseFrame:GetAnchor();
	XFrame_OnShow();
end

function XFrame_ShowDummy(frame, target)
	if frame then
		local anc, relp, relt, posX, posY = getglobal(target):GetAnchor();
		getglobal(frame):ClearAllAnchors();
		getglobal(frame):SetAnchor(anc, relp, relt, posX, posY);
		if getglobal(frame):IsVisible() then
			getglobal(frame):Hide();
		else
			getglobal(frame):SetWidth(getglobal(target):GetWidth());
			getglobal(frame):SetHeight(getglobal(target):GetHeight());
			getglobal(frame):Show();
		end
	end
end

function XFrame_Tooltip(this)
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 0, 0);
	GameTooltip:SetText("XFrame");
	GameTooltip:AddLine(UIPANELANCHORFRAME_TOOLTIP, 0, .7, .9);
end

function XFrame_Print(str, ...)
	DEFAULT_CHAT_FRAME:AddMessage(str:format(...), 1, 1, 1);
end