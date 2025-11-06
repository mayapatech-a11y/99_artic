-- GUI Library
local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Player
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Color Theme (Space/LootLabs Inspired)
local Theme = {
	Background = Color3.fromRGB(20, 20, 35),
	Secondary = Color3.fromRGB(30, 30, 50),
	Accent = Color3.fromRGB(100, 150, 255),
	AccentHover = Color3.fromRGB(120, 170, 255),
	Text = Color3.fromRGB(255, 255, 255),
	TextSecondary = Color3.fromRGB(200, 200, 220),
	Success = Color3.fromRGB(100, 255, 150),
	Danger = Color3.fromRGB(255, 100, 100)
}

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GuiLibrary"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Check if mobile
local isMobile = UserInputService.TouchEnabled

-- Size and font adjustments for mobile
local MOBILE_SETTINGS = {
	MainFrameSize = UDim2.new(0, 320, 0, 320),
	MainFramePosition = UDim2.new(0.5, 0, 0.5, 0), -- Changed this for proper centering
	IconSize = UDim2.new(0, 40, 0, 40),
	FontSize = 10,
	TitleFontSize = 15
}

local DESKTOP_SETTINGS = {
	MainFrameSize = UDim2.new(0, 350, 0, 450),
	MainFramePosition = UDim2.new(0, 10, 0, 10),
	IconSize = UDim2.new(0, 40, 0, 40),
	FontSize = 12,
	TitleFontSize = 16
}

local settings = isMobile and MOBILE_SETTINGS or DESKTOP_SETTINGS

-- Main Container
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = settings.MainFrameSize
mainFrame.Position = settings.MainFramePosition
mainFrame.BackgroundColor3 = Theme.Background
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

if isMobile then
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- This centers the frame
end

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 15, 1, 15)
shadow.Position = UDim2.new(0, -7, 0, -7)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.85
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Theme.Secondary
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SFY Ultimate Menu"
title.TextColor3 = Theme.Text
title.TextSize = settings.TitleFontSize
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Theme.Danger
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Theme.Text
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
minimizeButton.BackgroundColor3 = Theme.Accent
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Theme.Text
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

-- Content Area
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, 0, 1, -35)
contentArea.Position = UDim2.new(0, 0, 0, 35)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- Tab Container (Left Side)
local tabContainer = Instance.new("ScrollingFrame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(0, 100, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)
tabContainer.BackgroundColor3 = Theme.Secondary
tabContainer.BorderSizePixel = 0
tabContainer.ScrollBarThickness = 4
tabContainer.ScrollBarImageColor3 = Theme.Accent
tabContainer.Parent = contentArea

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabContainer

local tabPadding = Instance.new("UIPadding")
tabPadding.PaddingTop = UDim.new(0, 10)
tabPadding.PaddingLeft = UDim.new(0, 5)
tabPadding.PaddingRight = UDim.new(0, 5)
tabPadding.Parent = tabContainer

-- Tab Content
local tabContent = Instance.new("ScrollingFrame")
tabContent.Name = "TabContent"
tabContent.Size = UDim2.new(1, -105, 1, 0)
tabContent.Position = UDim2.new(0, 105, 0, 0)
tabContent.BackgroundTransparency = 1
tabContent.ScrollBarThickness = 4
tabContent.ScrollBarImageColor3 = Theme.Accent
tabContent.ClipsDescendants = true
tabContent.Parent = contentArea

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = tabContent

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.Parent = tabContent

-- Minimized Icon (SFY Square)
local minimizedIcon = Instance.new("TextButton")
minimizedIcon.Name = "MinimizedIcon"
minimizedIcon.Size = settings.IconSize
minimizedIcon.Position = UDim2.new(0, 10, 0, 10)
minimizedIcon.BackgroundColor3 = Theme.Accent
minimizedIcon.BorderSizePixel = 0
minimizedIcon.Text = "Scriptforyou"
minimizedIcon.TextColor3 = Theme.Text
minimizedIcon.TextSize = 10
minimizedIcon.TextScaled = true
minimizedIcon.Visible = false
minimizedIcon.Parent = screenGui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 8)
iconCorner.Parent = minimizedIcon

local iconShadow = Instance.new("ImageLabel")
iconShadow.Name = "Shadow"
iconShadow.Size = UDim2.new(1, 15, 1, 15)
iconShadow.Position = UDim2.new(0, -7, 0, -7)
iconShadow.BackgroundTransparency = 1
iconShadow.Image = "rbxassetid://1316045217"
iconShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
iconShadow.ImageTransparency = 0.85
iconShadow.ScaleType = Enum.ScaleType.Slice
iconShadow.SliceCenter = Rect.new(10, 10, 118, 118)
iconShadow.Parent = minimizedIcon

-- Variables
local isMinimized = false
local currentTab = nil
local tabs = {}
local buttons = {}
local isDestroyed = false

-- Make frames draggable
local dragging = false
local dragInput
local dragStart
local startPos

local function updateInput(input)
	if isDestroyed then return end
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function updateIconInput(input)
	if isDestroyed then return end
	local delta = input.Position - dragStart
	minimizedIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

-- Main frame dragging
titleBar.InputBegan:Connect(function(input)
	if isDestroyed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if isDestroyed then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

-- Icon dragging
minimizedIcon.InputBegan:Connect(function(input)
	if isDestroyed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = minimizedIcon.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

minimizedIcon.InputChanged:Connect(function(input)
	if isDestroyed then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isDestroyed then return end
	if input == dragInput and dragging then
		if isMinimized then
			updateIconInput(input)
		else
			updateInput(input)
		end
	end
end)

-- Toggle minimize
local function toggleMinimize()
	if isDestroyed then return end
	if isMinimized then
		-- Expand
		mainFrame.Visible = true
		minimizedIcon.Visible = false
		isMinimized = false
	else
		-- Minimize
		mainFrame.Visible = false
		minimizedIcon.Visible = true
		isMinimized = true
	end
end

minimizeButton.MouseButton1Click:Connect(toggleMinimize)
minimizedIcon.MouseButton1Click:Connect(toggleMinimize)

-- Close function
local function closeGUI()
	if isDestroyed then return end
	isDestroyed = true
	
	-- Destroy all GUI elements
	screenGui:Destroy()
	
	-- Disconnect any running connections
	for _, button in pairs(buttons) do
		if button.Connection then
			button.Connection:Disconnect()
		end
	end
	
	-- Stop any loops or processes
	-- Add any additional cleanup here for your specific script
end

closeButton.MouseButton1Click:Connect(closeGUI)

-- Update scrolling frames
tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	if isDestroyed then return end
	tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 20)
end)

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	if isDestroyed then return end
	tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end)

-- Library Functions
function GuiLibrary.new(name)
	local self = setmetatable({}, GuiLibrary)
	
	title.Text = name or "SFY GUI"
	minimizedIcon.Text = name and string.sub(name, 1, 3) or "SFY"
	
	return self
end


function GuiLibrary:CreateTab(tabName, icon)
	local tabButton = Instance.new("TextButton")
	tabButton.Name = tabName
	tabButton.Size = UDim2.new(1, 0, 0, 35)
	tabButton.BackgroundColor3 = Theme.Secondary
	tabButton.BorderSizePixel = 0
	tabButton.Text = tabName
	tabButton.TextColor3 = Theme.TextSecondary
	tabButton.TextSize = 13
	tabButton.Font = Enum.Font.Gotham
	tabButton.LayoutOrder = #tabs
	tabButton.Parent = tabContainer
	
	local tabCorner = Instance.new("UICorner")
	tabCorner.CornerRadius = UDim.new(0, 8)
	tabCorner.Parent = tabButton
	
	local tabFrame = Instance.new("Frame")
	tabFrame.Name = tabName
	tabFrame.Size = UDim2.new(1, 0, 1, 0)
	tabFrame.Position = UDim2.new(0, 0, 0, 0)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = false
	tabFrame.Parent = tabContent
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 8)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Parent = tabFrame
	
	local tabPadding = Instance.new("UIPadding")
	tabPadding.PaddingTop = UDim.new(0, 5)
	tabPadding.Parent = tabFrame
	
	local tabData = {
		Button = tabButton,
		Frame = tabFrame,
		Name = tabName
	}
	
	table.insert(tabs, tabData)
	
	-- Set as current tab if first tab
	if #tabs == 1 then
		currentTab = tabData
		tabButton.BackgroundColor3 = Theme.Accent
		tabButton.TextColor3 = Theme.Text
		tabFrame.Visible = true
	end
	
	-- Tab button click event
	tabButton.MouseButton1Click:Connect(function()
		if currentTab then
			currentTab.Button.BackgroundColor3 = Theme.Secondary
			currentTab.Button.TextColor3 = Theme.TextSecondary
			currentTab.Frame.Visible = false
		end
		
		currentTab = tabData
		tabButton.BackgroundColor3 = Theme.Accent
		tabButton.TextColor3 = Theme.Text
		tabFrame.Visible = true
	end)
	
	return tabData
end

function GuiLibrary:CreateButton(tab, buttonName, callback)
	local button = Instance.new("TextButton")
	button.Name = buttonName
	button.Size = UDim2.new(1, 0, 0, 35)
	button.BackgroundColor3 = Theme.Secondary
	button.BorderSizePixel = 0
	button.Text = buttonName
	button.TextColor3 = Theme.Text
	button.TextSize = 14
	button.Font = Enum.Font.Gotham
	button.Parent = tab.Frame
	
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 8)
	buttonCorner.Parent = button
	
	-- Button effects
	button.MouseEnter:Connect(function()
		if not isMobile then
			TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
		end
	end)
	
	button.MouseLeave:Connect(function()
		if not isMobile then
			TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
		end
	end)
	
	button.MouseButton1Click:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
		TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
		
		if callback then
			callback()
		end
	end)
	
	table.insert(buttons, button)
	
	return button
end


-- Input Text Field Function
function GuiLibrary:CreateInput(tab, inputName, placeholder, defaultValue, callback)
	local inputFrame = Instance.new("Frame")
	inputFrame.Name = "Input_" .. inputName
	inputFrame.Size = UDim2.new(1, 0, 0, 35)
	inputFrame.BackgroundTransparency = 1
	inputFrame.Parent = tab.Frame
	
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(0.4, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = inputName
	label.TextColor3 = Theme.Text
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.Gotham
	label.Parent = inputFrame
	
	local textBox = Instance.new("TextBox")
	textBox.Name = "TextBox"
	textBox.Size = UDim2.new(0.6, 0, 1, 0)
	textBox.Position = UDim2.new(0.4, 0, 0, 0)
	textBox.BackgroundColor3 = Theme.Secondary
	textBox.BorderSizePixel = 0
	textBox.Text = defaultValue or ""
	textBox.PlaceholderText = placeholder or "Enter text..."
	textBox.TextColor3 = Theme.Text
	textBox.PlaceholderColor3 = Theme.TextSecondary
	textBox.TextSize = 14
	textBox.Font = Enum.Font.Gotham
	textBox.ClearTextOnFocus = false
	textBox.Parent = inputFrame
	
	local textBoxCorner = Instance.new("UICorner")
	textBoxCorner.CornerRadius = UDim.new(0, 6)
	textBoxCorner.Parent = textBox
	
	local textBoxPadding = Instance.new("UIPadding")
	textBoxPadding.PaddingLeft = UDim.new(0, 10)
	textBoxPadding.PaddingRight = UDim.new(0, 10)
	textBoxPadding.Parent = textBox
	
	-- TextBox effects
	textBox.Focused:Connect(function()
		TweenService:Create(textBox, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
	end)
	
	textBox.FocusLost:Connect(function(enterPressed)
		TweenService:Create(textBox, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
		
		if callback then
			callback(textBox.Text, enterPressed)
		end
	end)
	
	-- Create input object with methods
	local inputObj = {}
	
	function inputObj:GetValue()
		return textBox.Text
	end
	
	function inputObj:SetValue(value)
		textBox.Text = value or ""
	end
	
	function inputObj:SetPlaceholder(text)
		textBox.PlaceholderText = text or ""
	end
	
	function inputObj:GetInstance()
		return inputFrame
	end
	
	return inputObj
end

function GuiLibrary:CreateLabel(tab, labelText)
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, 0, 0, 25)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Theme.TextSecondary
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.Gotham
	label.Parent = tab.Frame
	
	return label
end

function GuiLibrary:CreateToggle(tab, toggleName, defaultState, callback)
	local toggle = Instance.new("TextButton")
	toggle.Name = toggleName
	toggle.Size = UDim2.new(1, 0, 0, 35)
	toggle.BackgroundColor3 = Theme.Secondary
	toggle.BorderSizePixel = 0
	toggle.Text = ""
	toggle.Parent = tab.Frame
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 8)
	toggleCorner.Parent = toggle
	
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.Position = UDim2.new(0, 15, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = toggleName
	label.TextColor3 = Theme.Text
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.Gotham
	label.Parent = toggle
	
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Name = "Toggle"
	toggleFrame.Size = UDim2.new(0, 45, 0, 22)
	toggleFrame.Position = UDim2.new(1, -50, 0.5, -11)
	toggleFrame.BackgroundColor3 = Theme.Secondary
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Parent = toggle
	
	local toggleCorner2 = Instance.new("UICorner")
	toggleCorner2.CornerRadius = UDim.new(0, 11)
	toggleCorner2.Parent = toggleFrame
	
	local toggleDot = Instance.new("Frame")
	toggleDot.Name = "Dot"
	toggleDot.Size = UDim2.new(0, 18, 0, 18)
	toggleDot.Position = UDim2.new(0, 2, 0, 2)
	toggleDot.BackgroundColor3 = Theme.Text
	toggleDot.BorderSizePixel = 0
	toggleDot.Parent = toggleFrame
	
	local toggleCorner3 = Instance.new("UICorner")
	toggleCorner3.CornerRadius = UDim.new(1, 0)
	toggleCorner3.Parent = toggleDot
	
	local state = defaultState or false
	
	local function updateToggle()
		if state then
			TweenService:Create(toggleFrame, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Success}):Play()
			TweenService:Create(toggleDot, TweenInfo.new(0.1), {Position = UDim2.new(0, 25, 0, 2)}):Play()
		else
			TweenService:Create(toggleFrame, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
			TweenService:Create(toggleDot, TweenInfo.new(0.1), {Position = UDim2.new(0, 2, 0, 2)}):Play()
		end
		
		if callback then
			callback(state)
		end
	end
	
	updateToggle()
	
	toggle.MouseButton1Click:Connect(function()
		state = not state
		updateToggle()
	end)
	
	return toggle
end

function GuiLibrary:CreateSlider(tab, sliderName, minValue, maxValue, defaultValue, callback)
	local slider = Instance.new("Frame")
	slider.Name = sliderName
	slider.Size = UDim2.new(1, 0, 0, 60)
	slider.BackgroundTransparency = 1
	slider.Parent = tab.Frame
	
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = sliderName
	label.TextColor3 = Theme.Text
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.Gotham
	label.Parent = slider
	
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.Size = UDim2.new(0, 60, 0, 20)
	valueLabel.Position = UDim2.new(1, -60, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(defaultValue or minValue)
	valueLabel.TextColor3 = Theme.TextSecondary
	valueLabel.TextSize = 14
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.Parent = slider
	
	local sliderTrack = Instance.new("Frame")
	sliderTrack.Name = "Track"
	sliderTrack.Size = UDim2.new(1, 0, 0, 8)
	sliderTrack.Position = UDim2.new(0, 0, 0, 35)
	sliderTrack.BackgroundColor3 = Theme.Secondary
	sliderTrack.BorderSizePixel = 0
	sliderTrack.Parent = slider
	
	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(0, 4)
	trackCorner.Parent = sliderTrack
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "Fill"
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.BackgroundColor3 = Theme.Accent
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderTrack
	
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = sliderFill
	
	local sliderThumb = Instance.new("TextButton")
	sliderThumb.Name = "Thumb"
	sliderThumb.Size = UDim2.new(0, 18, 0, 18)
	sliderThumb.Position = UDim2.new(0, -9, 0.5, -9)
	sliderThumb.BackgroundColor3 = Theme.Text
	sliderThumb.BorderSizePixel = 0
	sliderThumb.Text = ""
	sliderThumb.Parent = sliderTrack
	
	local thumbCorner = Instance.new("UICorner")
	thumbCorner.CornerRadius = UDim.new(1, 0)
	thumbCorner.Parent = sliderThumb
	
	local currentValue = defaultValue or minValue
	local isDragging = false
	
	local function updateSlider(value)
		currentValue = math.clamp(value, minValue, maxValue)
		local percentage = (currentValue - minValue) / (maxValue - minValue)
		
		sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		sliderThumb.Position = UDim2.new(percentage, -9, 0.5, -9)
		valueLabel.Text = tostring(math.floor(currentValue))
		
		if callback then
			callback(currentValue)
		end
	end
	
	updateSlider(currentValue)
	
	local function onInputChanged(input)
		if isDragging then
			local relativeX = (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X
			local value = minValue + (relativeX * (maxValue - minValue))
			updateSlider(value)
		end
	end
	
	sliderThumb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
		end
	end)
	
	sliderThumb.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)
	
	sliderTrack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			local relativeX = (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X
			local value = minValue + (relativeX * (maxValue - minValue))
			updateSlider(value)
		end
	end)
	
	sliderTrack.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			onInputChanged(input)
		end
	end)
	
	return slider
end
-- Single Dropdown
-- Single Dropdown
function GuiLibrary:CreateDropdown(tab, dropdownName, options, defaultSelection, callback)
    local dropdown = Instance.new("TextButton")
    dropdown.Name = "Dropdown_" .. dropdownName
    dropdown.Size = UDim2.new(1, 0, 0, 35)
    dropdown.BackgroundColor3 = Theme.Secondary
    dropdown.BorderSizePixel = 0
    dropdown.Text = ""
    dropdown.ZIndex = 5
    dropdown.Parent = tab.Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dropdown
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = dropdownName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.ZIndex = 6
    label.Parent = dropdown
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0.25, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.75, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = defaultSelection or "Select..."
    valueLabel.TextColor3 = Theme.TextSecondary
    valueLabel.TextSize = 12
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.ZIndex = 6
    valueLabel.Parent = dropdown
    
    local arrow = Instance.new("TextLabel")
    arrow.Name = "Arrow"
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -25, 0.5, -10)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Theme.TextSecondary
    arrow.TextSize = 12
    arrow.Font = Enum.Font.Gotham
    arrow.ZIndex = 6
    arrow.Parent = dropdown
    
    -- Options Frame
    local optionsFrame = Instance.new("ScrollingFrame")
    optionsFrame.Name = "Options"
    optionsFrame.Size = UDim2.new(1, 0, 0, 0)
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Theme.Secondary
    optionsFrame.BorderSizePixel = 0
    optionsFrame.ScrollBarThickness = 4
    optionsFrame.ScrollBarImageColor3 = Theme.Accent
    optionsFrame.Visible = false
    optionsFrame.ClipsDescendants = true
    optionsFrame.ZIndex = 20
    optionsFrame.Parent = dropdown
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    local optionsLayout = Instance.new("UIListLayout")
    optionsLayout.Padding = UDim.new(0, 2)
    optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionsLayout.Parent = optionsFrame
    
    local optionsPadding = Instance.new("UIPadding")
    optionsPadding.PaddingTop = UDim.new(0, 5)
    optionsPadding.PaddingBottom = UDim.new(0, 5)
    optionsPadding.PaddingLeft = UDim.new(0, 5)
    optionsPadding.PaddingRight = UDim.new(0, 5)
    optionsPadding.Parent = optionsFrame
    
    local isOpen = false
    local selectedOption = defaultSelection
    
    -- FIXED: Validate default selection exists in options
    if defaultSelection and not table.find(options, defaultSelection) then
        selectedOption = nil
        valueLabel.Text = "Select..."
    end
    
    -- Create options
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Size = UDim2.new(1, 0, 0, 25)
        optionButton.BackgroundColor3 = Theme.Secondary
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = Theme.TextSecondary
        optionButton.TextSize = 12
        optionButton.Font = Enum.Font.Gotham
        optionButton.LayoutOrder = i
        optionButton.ZIndex = 21
        optionButton.Parent = optionsFrame
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 6)
        optionCorner.Parent = optionButton
        
        -- FIXED: Highlight the default selected option
        if option == selectedOption then
            optionButton.BackgroundColor3 = Theme.Accent
            optionButton.TextColor3 = Theme.Text
        end
        
        optionButton.MouseButton1Click:Connect(function()
            selectedOption = option
            valueLabel.Text = option
            
            -- FIXED: Update all option button colors
            for _, btn in pairs(optionsFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    if btn.Name == option then
                        btn.BackgroundColor3 = Theme.Accent
                        btn.TextColor3 = Theme.Text
                    else
                        btn.BackgroundColor3 = Theme.Secondary
                        btn.TextColor3 = Theme.TextSecondary
                    end
                end
            end
            
            isOpen = false
            optionsFrame.Visible = false
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            
            if callback then
                callback(option)
            end
        end)
        
        optionButton.MouseEnter:Connect(function()
            if not isMobile then
                TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
                TweenService:Create(optionButton, TweenInfo.new(0.1), {TextColor3 = Theme.Text}):Play()
            end
        end)
        
        optionButton.MouseLeave:Connect(function()
            if not isMobile then
                if optionButton.Name == selectedOption then
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {TextColor3 = Theme.Text}):Play()
                else
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {TextColor3 = Theme.TextSecondary}):Play()
                end
            end
        end)
    end
    
    -- Update canvas size
    optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        optionsFrame.CanvasSize = UDim2.new(0, 0, 0, optionsLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Toggle dropdown
    dropdown.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        if isOpen then
            optionsFrame.Visible = true
            local height = math.min(#options * 27 + 10, 200)
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
            TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, height)}):Play()
            
            -- FIXED: Ensure proper z-index when opened
            dropdown.ZIndex = 25
            optionsFrame.ZIndex = 26
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    child.ZIndex = 27
                end
            end
        else
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            wait(0.2)
            optionsFrame.Visible = false
            
            -- FIXED: Reset z-index when closed
            dropdown.ZIndex = 5
            optionsFrame.ZIndex = 20
        end
    end)
    
    -- Close dropdown
    local function closeDropdown(input)
        if isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local dropdownAbsPos = dropdown.AbsolutePosition
            local dropdownSize = dropdown.AbsoluteSize
            local optionsAbsPos = optionsFrame.AbsolutePosition
            local optionsSize = optionsFrame.AbsoluteSize
            
            local isInsideDropdown = (mousePos.X >= dropdownAbsPos.X and mousePos.X <= dropdownAbsPos.X + dropdownSize.X and
                                    mousePos.Y >= dropdownAbsPos.Y and mousePos.Y <= dropdownAbsPos.Y + dropdownSize.Y)
            
            local isInsideOptions = (mousePos.X >= optionsAbsPos.X and mousePos.X <= optionsAbsPos.X + optionsSize.X and
                                   mousePos.Y >= optionsAbsPos.Y and mousePos.Y <= optionsAbsPos.Y + optionsSize.Y)
            
            if not isInsideDropdown and not isInsideOptions then
                isOpen = false
                TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                wait(0.2)
                optionsFrame.Visible = false
                
                -- FIXED: Reset z-index when closed
                dropdown.ZIndex = 5
                optionsFrame.ZIndex = 20
            end
        end
    end
    
    UserInputService.InputBegan:Connect(closeDropdown)
    
    -- Create dropdown object with methods
    local dropdownObj = {}
    
    function dropdownObj:GetSelection()
        return selectedOption
    end
    
    function dropdownObj:SetSelection(selection)
        if selection and table.find(options, selection) then
            selectedOption = selection
            valueLabel.Text = selection
            
            -- FIXED: Update option button colors when setting selection programmatically
            for _, btn in pairs(optionsFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    if btn.Name == selection then
                        btn.BackgroundColor3 = Theme.Accent
                        btn.TextColor3 = Theme.Text
                    else
                        btn.BackgroundColor3 = Theme.Secondary
                        btn.TextColor3 = Theme.TextSecondary
                    end
                end
            end
            
            if callback then
                callback(selection)
            end
        else
            selectedOption = nil
            valueLabel.Text = "Select..."
            
            -- FIXED: Reset all option button colors when clearing selection
            for _, btn in pairs(optionsFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Theme.Secondary
                    btn.TextColor3 = Theme.TextSecondary
                end
            end
        end
    end
    
    function dropdownObj:GetInstance()
        return dropdown
    end
    
    return dropdownObj
end


function GuiLibrary:CreateSeparator(tab, separatorName)
    local separator = Instance.new("Frame")
    separator.Name = "Separator_" .. separatorName
    separator.Size = UDim2.new(1, 0, 0, 25)
    separator.BackgroundTransparency = 1
    separator.Parent = tab.Frame
    
    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Size = UDim2.new(1, -20, 0, 1)
    line.Position = UDim2.new(0, 10, 0.5, 0)
    line.BackgroundColor3 = Theme.Secondary
    line.BorderSizePixel = 0
    line.Parent = separator
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.4, 0, 0, 20)
    label.Position = UDim2.new(0.5, -50, 0, 2)
    label.BackgroundColor3 = Theme.Background
    label.BorderSizePixel = 0
    label.Text = separatorName or ""
    label.TextColor3 = Theme.TextSecondary
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.Parent = separator
    
    local labelCorner = Instance.new("UICorner")
    labelCorner.CornerRadius = UDim.new(0, 4)
    labelCorner.Parent = label
    
    return separator
end

function GuiLibrary:CreateColorPicker(tab, pickerName, defaultColor, callback)
    local defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    local colorPicker = Instance.new("TextButton")
    colorPicker.Name = "ColorPicker_" .. pickerName
    colorPicker.Size = UDim2.new(1, 0, 0, 35)
    colorPicker.BackgroundColor3 = Theme.Secondary
    colorPicker.BorderSizePixel = 0
    colorPicker.Text = ""
    colorPicker.Parent = tab.Frame
    
    local colorPickerCorner = Instance.new("UICorner")
    colorPickerCorner.CornerRadius = UDim.new(0, 8)
    colorPickerCorner.Parent = colorPicker
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = pickerName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = colorPicker
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Name = "ColorPreview"
    colorPreview.Size = UDim2.new(0, 25, 0, 25)
    colorPreview.Position = UDim2.new(1, -35, 0.5, -12.5)
    colorPreview.BackgroundColor3 = defaultColor
    colorPreview.BorderSizePixel = 0
    colorPreview.Parent = colorPicker
    
    local colorPreviewCorner = Instance.new("UICorner")
    colorPreviewCorner.CornerRadius = UDim.new(0, 6)
    colorPreviewCorner.Parent = colorPreview
    
    -- Color Picker Window
    local colorWindow = Instance.new("Frame")
    colorWindow.Name = "ColorWindow"
    colorWindow.Size = UDim2.new(0, 250, 0, 200)
    colorWindow.Position = UDim2.new(1, 10, 0, 0)
    colorWindow.BackgroundColor3 = Theme.Background
    colorWindow.BorderSizePixel = 0
    colorWindow.Visible = false
    colorWindow.ZIndex = 50
    colorWindow.Parent = colorPicker
    
    local colorWindowCorner = Instance.new("UICorner")
    colorWindowCorner.CornerRadius = UDim.new(0, 8)
    colorWindowCorner.Parent = colorWindow
    
    local colorWindowShadow = Instance.new("ImageLabel")
    colorWindowShadow.Name = "Shadow"
    colorWindowShadow.Size = UDim2.new(1, 10, 1, 10)
    colorWindowShadow.Position = UDim2.new(0, -5, 0, -5)
    colorWindowShadow.BackgroundTransparency = 1
    colorWindowShadow.Image = "rbxassetid://1316045217"
    colorWindowShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    colorWindowShadow.ImageTransparency = 0.8
    colorWindowShadow.ScaleType = Enum.ScaleType.Slice
    colorWindowShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    colorWindowShadow.ZIndex = 49
    colorWindowShadow.Parent = colorWindow
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Theme.Secondary
    title.BorderSizePixel = 0
    title.Text = pickerName
    title.TextColor3 = Theme.Text
    title.TextSize = 14
    title.Font = Enum.Font.Gotham
    title.ZIndex = 51
    title.Parent = colorWindow
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title
    
    -- Color Wheel
    local colorWheel = Instance.new("ImageLabel")
    colorWheel.Name = "ColorWheel"
    colorWheel.Size = UDim2.new(0, 120, 0, 120)
    colorWheel.Position = UDim2.new(0, 15, 0, 40)
    colorWheel.BackgroundTransparency = 1
    colorWheel.Image = "rbxassetid://13777638835" -- Color wheel image
    colorWheel.ZIndex = 51
    colorWheel.Parent = colorWindow
    
    local colorWheelCursor = Instance.new("Frame")
    colorWheelCursor.Name = "Cursor"
    colorWheelCursor.Size = UDim2.new(0, 8, 0, 8)
    colorWheelCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    colorWheelCursor.BorderSizePixel = 1
    colorWheelCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
    colorWheelCursor.ZIndex = 52
    colorWheelCursor.Visible = false
    colorWheelCursor.Parent = colorWheel
    
    local cursorCorner = Instance.new("UICorner")
    cursorCorner.CornerRadius = UDim.new(1, 0)
    cursorCorner.Parent = colorWheelCursor
    
    -- Brightness Slider
    local brightnessSlider = Instance.new("Frame")
    brightnessSlider.Name = "BrightnessSlider"
    brightnessSlider.Size = UDim2.new(0, 20, 0, 120)
    brightnessSlider.Position = UDim2.new(0, 150, 0, 40)
    brightnessSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    brightnessSlider.BorderSizePixel = 0
    brightnessSlider.ZIndex = 51
    brightnessSlider.Parent = colorWindow
    
    local brightnessGradient = Instance.new("UIGradient")
    brightnessGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    brightnessGradient.Rotation = 90
    brightnessGradient.Parent = brightnessSlider
    
    local brightnessCorner = Instance.new("UICorner")
    brightnessCorner.CornerRadius = UDim.new(0, 4)
    brightnessCorner.Parent = brightnessSlider
    
    local brightnessCursor = Instance.new("Frame")
    brightnessCursor.Name = "Cursor"
    brightnessCursor.Size = UDim2.new(1, 4, 0, 6)
    brightnessCursor.Position = UDim2.new(0, -2, 0.5, -3)
    brightnessCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    brightnessCursor.BorderSizePixel = 1
    brightnessCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
    brightnessCursor.ZIndex = 52
    brightnessCursor.Parent = brightnessSlider
    
    local brightnessCursorCorner = Instance.new("UICorner")
    brightnessCursorCorner.CornerRadius = UDim.new(0, 2)
    brightnessCursorCorner.Parent = brightnessCursor
    
    -- Current Color Display
    local currentColorDisplay = Instance.new("Frame")
    currentColorDisplay.Name = "CurrentColor"
    currentColorDisplay.Size = UDim2.new(0, 60, 0, 25)
    currentColorDisplay.Position = UDim2.new(0, 15, 0, 170)
    currentColorDisplay.BackgroundColor3 = defaultColor
    currentColorDisplay.BorderSizePixel = 0
    currentColorDisplay.ZIndex = 51
    currentColorDisplay.Parent = colorWindow
    
    local currentColorCorner = Instance.new("UICorner")
    currentColorCorner.CornerRadius = UDim.new(0, 6)
    currentColorCorner.Parent = currentColorDisplay
    
    -- RGB Inputs
    local rgbInputs = Instance.new("Frame")
    rgbInputs.Name = "RGBInputs"
    rgbInputs.Size = UDim2.new(0, 140, 0, 80)
    rgbInputs.Position = UDim2.new(0, 85, 0, 165)
    rgbInputs.BackgroundTransparency = 1
    rgbInputs.ZIndex = 51
    rgbInputs.Parent = colorWindow
    
    local function createRGBInput(yPosition, labelText, defaultValue)
        local inputFrame = Instance.new("Frame")
        inputFrame.Size = UDim2.new(1, 0, 0, 20)
        inputFrame.Position = UDim2.new(0, 0, 0, yPosition)
        inputFrame.BackgroundTransparency = 1
        inputFrame.ZIndex = 51
        inputFrame.Parent = rgbInputs
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 30, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = Theme.Text
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.ZIndex = 51
        label.Parent = inputFrame
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0, 40, 1, 0)
        textBox.Position = UDim2.new(0, 35, 0, 0)
        textBox.BackgroundColor3 = Theme.Secondary
        textBox.BorderSizePixel = 0
        textBox.Text = tostring(defaultValue)
        textBox.TextColor3 = Theme.Text
        textBox.TextSize = 12
        textBox.Font = Enum.Font.Gotham
        textBox.ZIndex = 51
        textBox.Parent = inputFrame
        
        local textBoxCorner = Instance.new("UICorner")
        textBoxCorner.CornerRadius = UDim.new(0, 4)
        textBoxCorner.Parent = textBox
        
        return textBox
    end
    
    local rInput = createRGBInput(0, "R:", math.floor(defaultColor.R * 255))
    local gInput = createRGBInput(25, "G:", math.floor(defaultColor.G * 255))
    local bInput = createRGBInput(50, "B:", math.floor(defaultColor.B * 255))
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 60, 0, 25)
    closeButton.Position = UDim2.new(1, -70, 0, 170)
    closeButton.BackgroundColor3 = Theme.Accent
    closeButton.BorderSizePixel = 0
    closeButton.Text = "OK"
    closeButton.TextColor3 = Theme.Text
    closeButton.TextSize = 12
    closeButton.Font = Enum.Font.Gotham
    closeButton.ZIndex = 51
    closeButton.Parent = colorWindow
    
    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0, 6)
    closeButtonCorner.Parent = closeButton
    
    local isOpen = false
    local currentColor = defaultColor
    local isDraggingWheel = false
    local isDraggingBrightness = false
    
    -- Color conversion functions
    local function HSVtoRGB(h, s, v)
        local r, g, b
        
        local i = math.floor(h * 6)
        local f = h * 6 - i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)
        
        i = i % 6
        
        if i == 0 then
            r, g, b = v, t, p
        elseif i == 1 then
            r, g, b = q, v, p
        elseif i == 2 then
            r, g, b = p, v, t
        elseif i == 3 then
            r, g, b = p, q, v
        elseif i == 4 then
            r, g, b = t, p, v
        else
            r, g, b = v, p, q
        end
        
        return Color3.new(r, g, b)
    end
    
    local function RGBtoHSV(r, g, b)
        local max = math.max(r, g, b)
        local min = math.min(r, g, b)
        local h, s, v = max, max, max
        
        local d = max - min
        s = max == 0 and 0 or d / max
        
        if max == min then
            h = 0
        else
            if max == r then
                h = (g - b) / d + (g < b and 6 or 0)
            elseif max == g then
                h = (b - r) / d + 2
            elseif max == b then
                h = (r - g) / d + 4
            end
            h = h / 6
        end
        
        return h, s, v
    end
    
    local function updateColorFromWheel(position, brightness)
        local x = (position.X - colorWheel.AbsolutePosition.X) / colorWheel.AbsoluteSize.X
        local y = (position.Y - colorWheel.AbsolutePosition.Y) / colorWheel.AbsoluteSize.Y
        
        x = math.clamp(x, 0, 1)
        y = math.clamp(y, 0, 1)
        
        -- Convert to HSV
        local angle = math.atan2(y - 0.5, x - 0.5)
        local distance = math.sqrt((x - 0.5)^2 + (y - 0.5)^2)
        
        local hue = (angle + math.pi) / (2 * math.pi)
        local saturation = math.clamp(distance * 2, 0, 1)
        local value = brightness or 1
        
        currentColor = HSVtoRGB(hue, saturation, value)
        
        -- Update displays
        colorPreview.BackgroundColor3 = currentColor
        currentColorDisplay.BackgroundColor3 = currentColor
        
        -- Update RGB inputs
        rInput.Text = tostring(math.floor(currentColor.R * 255))
        gInput.Text = tostring(math.floor(currentColor.G * 255))
        bInput.Text = tostring(math.floor(currentColor.B * 255))
        
        if callback then
            callback(currentColor)
        end
    end
    
    local function updateColorFromRGB()
        local r = math.clamp(tonumber(rInput.Text) or 0, 0, 255) / 255
        local g = math.clamp(tonumber(gInput.Text) or 0, 0, 255) / 255
        local b = math.clamp(tonumber(bInput.Text) or 0, 0, 255) / 255
        
        currentColor = Color3.new(r, g, b)
        
        -- Update displays
        colorPreview.BackgroundColor3 = currentColor
        currentColorDisplay.BackgroundColor3 = currentColor
        
        if callback then
            callback(currentColor)
        end
    end
    
    -- Toggle color window
    colorPicker.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        colorWindow.Visible = isOpen
    end)
    
    -- Color wheel interaction
    colorWheel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingWheel = true
            colorWheelCursor.Visible = true
            updateColorFromWheel(input.Position)
        end
    end)
    
    colorWheel.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingWheel = false
        end
    end)
    
    -- Brightness slider interaction
    brightnessSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingBrightness = true
            local y = (input.Position.Y - brightnessSlider.AbsolutePosition.Y) / brightnessSlider.AbsoluteSize.Y
            y = math.clamp(y, 0, 1)
            brightnessCursor.Position = UDim2.new(0, -2, y, -3)
            updateColorFromWheel(input.Position, 1 - y)
        end
    end)
    
    brightnessSlider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingBrightness = false
        end
    end)
    
    -- Mouse movement for dragging
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if isDraggingWheel then
                updateColorFromWheel(input.Position)
            elseif isDraggingBrightness then
                local y = (input.Position.Y - brightnessSlider.AbsolutePosition.Y) / brightnessSlider.AbsoluteSize.Y
                y = math.clamp(y, 0, 1)
                brightnessCursor.Position = UDim2.new(0, -2, y, -3)
                updateColorFromWheel(input.Position, 1 - y)
            end
        end
    end)
    
    -- RGB input changes
    rInput.FocusLost:Connect(updateColorFromRGB)
    gInput.FocusLost:Connect(updateColorFromRGB)
    bInput.FocusLost:Connect(updateColorFromRGB)
    
    -- Close button
    closeButton.MouseButton1Click:Connect(function()
        isOpen = false
        colorWindow.Visible = false
    end)
    
    -- Close when clicking outside
    local function closeColorPicker(input)
        if isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local colorWindowAbsPos = colorWindow.AbsolutePosition
            local colorWindowSize = colorWindow.AbsoluteSize
            
            if not (mousePos.X >= colorWindowAbsPos.X and mousePos.X <= colorWindowAbsPos.X + colorWindowSize.X and
                   mousePos.Y >= colorWindowAbsPos.Y and mousePos.Y <= colorWindowAbsPos.Y + colorWindowSize.Y) then
                isOpen = false
                colorWindow.Visible = false
            end
        end
    end
    
    UserInputService.InputBegan:Connect(closeColorPicker)
    
    -- Create color picker object with methods
    local colorPickerObj = {}
    
    function colorPickerObj:GetColor()
        return currentColor
    end
    
    function colorPickerObj:SetColor(color)
        currentColor = color
        colorPreview.BackgroundColor3 = color
        currentColorDisplay.BackgroundColor3 = color
        
        rInput.Text = tostring(math.floor(color.R * 255))
        gInput.Text = tostring(math.floor(color.G * 255))
        bInput.Text = tostring(math.floor(color.B * 255))
        
        if callback then
            callback(color)
        end
    end
    
    function colorPickerObj:GetInstance()
        return colorPicker
    end
    
    return colorPickerObj
end

function GuiLibrary:CreateColorPicker(tab, pickerName, defaultColor, callback)
    local defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    local colorPicker = Instance.new("TextButton")
    colorPicker.Name = "ColorPicker_" .. pickerName
    colorPicker.Size = UDim2.new(1, 0, 0, 35)
    colorPicker.BackgroundColor3 = Theme.Secondary
    colorPicker.BorderSizePixel = 0
    colorPicker.Text = ""
    colorPicker.Parent = tab.Frame
    
    local colorPickerCorner = Instance.new("UICorner")
    colorPickerCorner.CornerRadius = UDim.new(0, 8)
    colorPickerCorner.Parent = colorPicker
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = pickerName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = colorPicker
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Name = "ColorPreview"
    colorPreview.Size = UDim2.new(0, 25, 0, 25)
    colorPreview.Position = UDim2.new(1, -35, 0.5, -12.5)
    colorPreview.BackgroundColor3 = defaultColor
    colorPreview.BorderSizePixel = 0
    colorPreview.Parent = colorPicker
    
    local colorPreviewCorner = Instance.new("UICorner")
    colorPreviewCorner.CornerRadius = UDim.new(0, 6)
    colorPreviewCorner.Parent = colorPreview
    
    -- Color Picker Window
    local colorWindow = Instance.new("Frame")
    colorWindow.Name = "ColorWindow"
    colorWindow.Size = UDim2.new(0, 250, 0, 200)
    colorWindow.Position = UDim2.new(1, 10, 0, 0)
    colorWindow.BackgroundColor3 = Theme.Background
    colorWindow.BorderSizePixel = 0
    colorWindow.Visible = false
    colorWindow.ZIndex = 50
    colorWindow.Parent = colorPicker
    
    local colorWindowCorner = Instance.new("UICorner")
    colorWindowCorner.CornerRadius = UDim.new(0, 8)
    colorWindowCorner.Parent = colorWindow
    
    local colorWindowShadow = Instance.new("ImageLabel")
    colorWindowShadow.Name = "Shadow"
    colorWindowShadow.Size = UDim2.new(1, 10, 1, 10)
    colorWindowShadow.Position = UDim2.new(0, -5, 0, -5)
    colorWindowShadow.BackgroundTransparency = 1
    colorWindowShadow.Image = "rbxassetid://1316045217"
    colorWindowShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    colorWindowShadow.ImageTransparency = 0.8
    colorWindowShadow.ScaleType = Enum.ScaleType.Slice
    colorWindowShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    colorWindowShadow.ZIndex = 49
    colorWindowShadow.Parent = colorWindow
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Theme.Secondary
    title.BorderSizePixel = 0
    title.Text = pickerName
    title.TextColor3 = Theme.Text
    title.TextSize = 14
    title.Font = Enum.Font.Gotham
    title.ZIndex = 51
    title.Parent = colorWindow
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title
    
    -- Color Wheel
    local colorWheel = Instance.new("ImageLabel")
    colorWheel.Name = "ColorWheel"
    colorWheel.Size = UDim2.new(0, 120, 0, 120)
    colorWheel.Position = UDim2.new(0, 15, 0, 40)
    colorWheel.BackgroundTransparency = 1
    colorWheel.Image = "rbxassetid://13777638835" -- Color wheel image
    colorWheel.ZIndex = 51
    colorWheel.Parent = colorWindow
    
    local colorWheelCursor = Instance.new("Frame")
    colorWheelCursor.Name = "Cursor"
    colorWheelCursor.Size = UDim2.new(0, 8, 0, 8)
    colorWheelCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    colorWheelCursor.BorderSizePixel = 1
    colorWheelCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
    colorWheelCursor.ZIndex = 52
    colorWheelCursor.Visible = false
    colorWheelCursor.Parent = colorWheel
    
    local cursorCorner = Instance.new("UICorner")
    cursorCorner.CornerRadius = UDim.new(1, 0)
    cursorCorner.Parent = colorWheelCursor
    
    -- Brightness Slider
    local brightnessSlider = Instance.new("Frame")
    brightnessSlider.Name = "BrightnessSlider"
    brightnessSlider.Size = UDim2.new(0, 20, 0, 120)
    brightnessSlider.Position = UDim2.new(0, 150, 0, 40)
    brightnessSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    brightnessSlider.BorderSizePixel = 0
    brightnessSlider.ZIndex = 51
    brightnessSlider.Parent = colorWindow
    
    local brightnessGradient = Instance.new("UIGradient")
    brightnessGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    brightnessGradient.Rotation = 90
    brightnessGradient.Parent = brightnessSlider
    
    local brightnessCorner = Instance.new("UICorner")
    brightnessCorner.CornerRadius = UDim.new(0, 4)
    brightnessCorner.Parent = brightnessSlider
    
    local brightnessCursor = Instance.new("Frame")
    brightnessCursor.Name = "Cursor"
    brightnessCursor.Size = UDim2.new(1, 4, 0, 6)
    brightnessCursor.Position = UDim2.new(0, -2, 0.5, -3)
    brightnessCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    brightnessCursor.BorderSizePixel = 1
    brightnessCursor.BorderColor3 = Color3.fromRGB(0, 0, 0)
    brightnessCursor.ZIndex = 52
    brightnessCursor.Parent = brightnessSlider
    
    local brightnessCursorCorner = Instance.new("UICorner")
    brightnessCursorCorner.CornerRadius = UDim.new(0, 2)
    brightnessCursorCorner.Parent = brightnessCursor
    
    -- Current Color Display
    local currentColorDisplay = Instance.new("Frame")
    currentColorDisplay.Name = "CurrentColor"
    currentColorDisplay.Size = UDim2.new(0, 60, 0, 25)
    currentColorDisplay.Position = UDim2.new(0, 15, 0, 170)
    currentColorDisplay.BackgroundColor3 = defaultColor
    currentColorDisplay.BorderSizePixel = 0
    currentColorDisplay.ZIndex = 51
    currentColorDisplay.Parent = colorWindow
    
    local currentColorCorner = Instance.new("UICorner")
    currentColorCorner.CornerRadius = UDim.new(0, 6)
    currentColorCorner.Parent = currentColorDisplay
    
    -- RGB Inputs
    local rgbInputs = Instance.new("Frame")
    rgbInputs.Name = "RGBInputs"
    rgbInputs.Size = UDim2.new(0, 140, 0, 80)
    rgbInputs.Position = UDim2.new(0, 85, 0, 165)
    rgbInputs.BackgroundTransparency = 1
    rgbInputs.ZIndex = 51
    rgbInputs.Parent = colorWindow
    
    local function createRGBInput(yPosition, labelText, defaultValue)
        local inputFrame = Instance.new("Frame")
        inputFrame.Size = UDim2.new(1, 0, 0, 20)
        inputFrame.Position = UDim2.new(0, 0, 0, yPosition)
        inputFrame.BackgroundTransparency = 1
        inputFrame.ZIndex = 51
        inputFrame.Parent = rgbInputs
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 30, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = Theme.Text
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.ZIndex = 51
        label.Parent = inputFrame
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0, 40, 1, 0)
        textBox.Position = UDim2.new(0, 35, 0, 0)
        textBox.BackgroundColor3 = Theme.Secondary
        textBox.BorderSizePixel = 0
        textBox.Text = tostring(defaultValue)
        textBox.TextColor3 = Theme.Text
        textBox.TextSize = 12
        textBox.Font = Enum.Font.Gotham
        textBox.ZIndex = 51
        textBox.Parent = inputFrame
        
        local textBoxCorner = Instance.new("UICorner")
        textBoxCorner.CornerRadius = UDim.new(0, 4)
        textBoxCorner.Parent = textBox
        
        return textBox
    end
    
    local rInput = createRGBInput(0, "R:", math.floor(defaultColor.R * 255))
    local gInput = createRGBInput(25, "G:", math.floor(defaultColor.G * 255))
    local bInput = createRGBInput(50, "B:", math.floor(defaultColor.B * 255))
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 60, 0, 25)
    closeButton.Position = UDim2.new(1, -70, 0, 170)
    closeButton.BackgroundColor3 = Theme.Accent
    closeButton.BorderSizePixel = 0
    closeButton.Text = "OK"
    closeButton.TextColor3 = Theme.Text
    closeButton.TextSize = 12
    closeButton.Font = Enum.Font.Gotham
    closeButton.ZIndex = 51
    closeButton.Parent = colorWindow
    
    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0, 6)
    closeButtonCorner.Parent = closeButton
    
    local isOpen = false
    local currentColor = defaultColor
    local isDraggingWheel = false
    local isDraggingBrightness = false
    
    -- Color conversion functions
    local function HSVtoRGB(h, s, v)
        local r, g, b
        
        local i = math.floor(h * 6)
        local f = h * 6 - i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)
        
        i = i % 6
        
        if i == 0 then
            r, g, b = v, t, p
        elseif i == 1 then
            r, g, b = q, v, p
        elseif i == 2 then
            r, g, b = p, v, t
        elseif i == 3 then
            r, g, b = p, q, v
        elseif i == 4 then
            r, g, b = t, p, v
        else
            r, g, b = v, p, q
        end
        
        return Color3.new(r, g, b)
    end
    
    local function RGBtoHSV(r, g, b)
        local max = math.max(r, g, b)
        local min = math.min(r, g, b)
        local h, s, v = max, max, max
        
        local d = max - min
        s = max == 0 and 0 or d / max
        
        if max == min then
            h = 0
        else
            if max == r then
                h = (g - b) / d + (g < b and 6 or 0)
            elseif max == g then
                h = (b - r) / d + 2
            elseif max == b then
                h = (r - g) / d + 4
            end
            h = h / 6
        end
        
        return h, s, v
    end
    
    local function updateColorFromWheel(position, brightness)
        local x = (position.X - colorWheel.AbsolutePosition.X) / colorWheel.AbsoluteSize.X
        local y = (position.Y - colorWheel.AbsolutePosition.Y) / colorWheel.AbsoluteSize.Y
        
        x = math.clamp(x, 0, 1)
        y = math.clamp(y, 0, 1)
        
        -- Convert to HSV
        local angle = math.atan2(y - 0.5, x - 0.5)
        local distance = math.sqrt((x - 0.5)^2 + (y - 0.5)^2)
        
        local hue = (angle + math.pi) / (2 * math.pi)
        local saturation = math.clamp(distance * 2, 0, 1)
        local value = brightness or 1
        
        currentColor = HSVtoRGB(hue, saturation, value)
        
        -- Update displays
        colorPreview.BackgroundColor3 = currentColor
        currentColorDisplay.BackgroundColor3 = currentColor
        
        -- Update RGB inputs
        rInput.Text = tostring(math.floor(currentColor.R * 255))
        gInput.Text = tostring(math.floor(currentColor.G * 255))
        bInput.Text = tostring(math.floor(currentColor.B * 255))
        
        if callback then
            callback(currentColor)
        end
    end
    
    local function updateColorFromRGB()
        local r = math.clamp(tonumber(rInput.Text) or 0, 0, 255) / 255
        local g = math.clamp(tonumber(gInput.Text) or 0, 0, 255) / 255
        local b = math.clamp(tonumber(bInput.Text) or 0, 0, 255) / 255
        
        currentColor = Color3.new(r, g, b)
        
        -- Update displays
        colorPreview.BackgroundColor3 = currentColor
        currentColorDisplay.BackgroundColor3 = currentColor
        
        if callback then
            callback(currentColor)
        end
    end
    
    -- Toggle color window
    colorPicker.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        colorWindow.Visible = isOpen
    end)
    
    -- Color wheel interaction
    colorWheel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingWheel = true
            colorWheelCursor.Visible = true
            updateColorFromWheel(input.Position)
        end
    end)
    
    colorWheel.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingWheel = false
        end
    end)
    
    -- Brightness slider interaction
    brightnessSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingBrightness = true
            local y = (input.Position.Y - brightnessSlider.AbsolutePosition.Y) / brightnessSlider.AbsoluteSize.Y
            y = math.clamp(y, 0, 1)
            brightnessCursor.Position = UDim2.new(0, -2, y, -3)
            updateColorFromWheel(input.Position, 1 - y)
        end
    end)
    
    brightnessSlider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDraggingBrightness = false
        end
    end)
    
    -- Mouse movement for dragging
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if isDraggingWheel then
                updateColorFromWheel(input.Position)
            elseif isDraggingBrightness then
                local y = (input.Position.Y - brightnessSlider.AbsolutePosition.Y) / brightnessSlider.AbsoluteSize.Y
                y = math.clamp(y, 0, 1)
                brightnessCursor.Position = UDim2.new(0, -2, y, -3)
                updateColorFromWheel(input.Position, 1 - y)
            end
        end
    end)
    
    -- RGB input changes
    rInput.FocusLost:Connect(updateColorFromRGB)
    gInput.FocusLost:Connect(updateColorFromRGB)
    bInput.FocusLost:Connect(updateColorFromRGB)
    
    -- Close button
    closeButton.MouseButton1Click:Connect(function()
        isOpen = false
        colorWindow.Visible = false
    end)
    
    -- Close when clicking outside
    local function closeColorPicker(input)
        if isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local colorWindowAbsPos = colorWindow.AbsolutePosition
            local colorWindowSize = colorWindow.AbsoluteSize
            
            if not (mousePos.X >= colorWindowAbsPos.X and mousePos.X <= colorWindowAbsPos.X + colorWindowSize.X and
                   mousePos.Y >= colorWindowAbsPos.Y and mousePos.Y <= colorWindowAbsPos.Y + colorWindowSize.Y) then
                isOpen = false
                colorWindow.Visible = false
            end
        end
    end
    
    UserInputService.InputBegan:Connect(closeColorPicker)
    
    -- Create color picker object with methods
    local colorPickerObj = {}
    
    function colorPickerObj:GetColor()
        return currentColor
    end
    
    function colorPickerObj:SetColor(color)
        currentColor = color
        colorPreview.BackgroundColor3 = color
        currentColorDisplay.BackgroundColor3 = color
        
        rInput.Text = tostring(math.floor(color.R * 255))
        gInput.Text = tostring(math.floor(color.G * 255))
        bInput.Text = tostring(math.floor(color.B * 255))
        
        if callback then
            callback(color)
        end
    end
    
    function colorPickerObj:GetInstance()
        return colorPicker
    end
    
    return colorPickerObj
end
-- FIXED Multi Dropdown Function (Count Display Only)
function GuiLibrary:CreateMultiDropdown(tab, dropdownName, options, defaultSelections, callback)
    local uniqueName = "MultiDropdown_" .. dropdownName .. "_" .. tostring(tick()):gsub("%.", "")
    
    local multiDropdown = Instance.new("TextButton")
    multiDropdown.Name = uniqueName
    multiDropdown.Size = UDim2.new(1, 0, 0, 35)
    multiDropdown.BackgroundColor3 = Theme.Secondary
    multiDropdown.BorderSizePixel = 0
    multiDropdown.Text = ""
    multiDropdown.ZIndex = 20
    multiDropdown.Parent = tab.Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = multiDropdown
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = dropdownName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.ZIndex = 21
    label.Parent = multiDropdown
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0.25, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.75, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "Select..."
    valueLabel.TextColor3 = Theme.TextSecondary
    valueLabel.TextSize = 12
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.ZIndex = 21
    valueLabel.Parent = multiDropdown
    
    local arrow = Instance.new("TextLabel")
    arrow.Name = "Arrow"
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -25, 0.5, -10)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Theme.TextSecondary
    arrow.TextSize = 12
    arrow.Font = Enum.Font.Gotham
    arrow.ZIndex = 21
    arrow.Parent = multiDropdown
    
    -- Options Frame as ScrollingFrame
    local optionsFrame = Instance.new("ScrollingFrame")
    optionsFrame.Name = "OptionsFrame"
    optionsFrame.Size = UDim2.new(1, 0, 0, 0)
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Theme.Background
    optionsFrame.BorderSizePixel = 0
    optionsFrame.ScrollBarThickness = 4
    optionsFrame.ScrollBarImageColor3 = Theme.Accent
    optionsFrame.ScrollBarImageTransparency = 0.5
    optionsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    optionsFrame.Visible = false
    optionsFrame.ClipsDescendants = true
    optionsFrame.ZIndex = 50
    optionsFrame.Parent = multiDropdown
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    local optionsLayout = Instance.new("UIListLayout")
    optionsLayout.Padding = UDim.new(0, 5)
    optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionsLayout.Parent = optionsFrame
    
    local optionsPadding = Instance.new("UIPadding")
    optionsPadding.PaddingTop = UDim.new(0, 8)
    optionsPadding.PaddingBottom = UDim.new(0, 8)
    optionsPadding.PaddingLeft = UDim.new(0, 8)
    optionsPadding.PaddingRight = UDim.new(0, 8)
    optionsPadding.Parent = optionsFrame
    
    -- FIXED: Proper selection tracking
    local selectedOptions = {}
    local isOpen = false
    
    -- FIXED: Better default selection handling
    if defaultSelections then
        if typeof(defaultSelections) == "table" then
            -- Handle array format: {"Log", "Coal"}
            if #defaultSelections > 0 then
                for _, option in ipairs(defaultSelections) do
                    if table.find(options, option) then
                        selectedOptions[option] = true
                    end
                end
            else
                -- Handle table format: {["Log"] = true, ["Coal"] = true}
                for option, isSelected in pairs(defaultSelections) do
                    if table.find(options, option) and isSelected then
                        selectedOptions[option] = true
                    end
                end
            end
        end
    end
    
    -- FIXED: Simplified display text function - ONLY SHOW COUNT
    local function updateDisplayText()
        local selectedCount = 0
        
        for option, isSelected in pairs(selectedOptions) do
            if isSelected then
                selectedCount = selectedCount + 1
            end
        end
        
        if selectedCount == 0 then
            valueLabel.Text = "Select..."
        else
            valueLabel.Text = selectedCount .. " selected"
        end
    end
    
    updateDisplayText()
    
    -- FIXED: Create option buttons with proper selection state
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. option
        optionButton.Size = UDim2.new(1, -10, 0, 25)
        optionButton.BackgroundColor3 = Theme.Secondary
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = Theme.Text
        optionButton.TextSize = 12
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.Font = Enum.Font.Gotham
        optionButton.LayoutOrder = i
        optionButton.ZIndex = 51
        optionButton.Parent = optionsFrame
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 6)
        optionCorner.Parent = optionButton
        
        -- Add padding to text
        local textPadding = Instance.new("UIPadding")
        textPadding.PaddingLeft = UDim.new(0, 10)
        textPadding.Parent = optionButton
        
        -- FIXED: Set initial selection state
        if selectedOptions[option] then
            optionButton.BackgroundColor3 = Theme.Accent
        else
            optionButton.BackgroundColor3 = Theme.Secondary
        end
        
        -- FIXED: Improved click handler
        optionButton.MouseButton1Click:Connect(function()
            selectedOptions[option] = not selectedOptions[option]
            
            if selectedOptions[option] then
                optionButton.BackgroundColor3 = Theme.Accent
            else
                optionButton.BackgroundColor3 = Theme.Secondary
            end
            
            updateDisplayText()
            
            -- FIXED: Call callback with proper format
            if callback then
                -- Return both formats for compatibility
                local selectionsArray = {}
                for opt, isSelected in pairs(selectedOptions) do
                    if isSelected then
                        table.insert(selectionsArray, opt)
                    end
                end
                callback(selectionsArray, selectedOptions)
            end
        end)
        
        -- Hover effects
        optionButton.MouseEnter:Connect(function()
            if not isMobile then
                TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
            end
        end)
        
        optionButton.MouseLeave:Connect(function()
            if not isMobile then
                if selectedOptions[option] then
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
                else
                    TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
                end
            end
        end)
    end
    
    -- Update canvas size for scrolling
    optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentHeight = optionsLayout.AbsoluteContentSize.Y + 16
        optionsFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end)
    
    -- FIXED: Improved dropdown toggle
    multiDropdown.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        if isOpen then
            optionsFrame.Visible = true
            local maxHeight = 150
            local contentHeight = optionsLayout.AbsoluteContentSize.Y + 16
            local targetHeight = math.min(contentHeight, maxHeight)
            
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
            TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
            
            -- Ensure proper z-index
            multiDropdown.ZIndex = 60
            optionsFrame.ZIndex = 61
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    child.ZIndex = 62
                end
            end
        else
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            
            wait(0.2)
            optionsFrame.Visible = false
            
            -- Reset z-index
            multiDropdown.ZIndex = 20
            optionsFrame.ZIndex = 50
        end
    end)
    
    -- FIXED: Improved close dropdown function
    local function closeDropdown(input)
        if isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local absPos = multiDropdown.AbsolutePosition
            local absSize = multiDropdown.AbsoluteSize
            local optionsAbsPos = optionsFrame.AbsolutePosition
            local optionsSize = optionsFrame.AbsoluteSize
            
            local isInsideDropdown = (mousePos.X >= absPos.X and mousePos.X <= absPos.X + absSize.X and
                                    mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + absSize.Y)
            
            local isInsideOptions = (mousePos.X >= optionsAbsPos.X and mousePos.X <= optionsAbsPos.X + optionsSize.X and
                                   mousePos.Y >= optionsAbsPos.Y and mousePos.Y <= optionsAbsPos.Y + optionsSize.Y)
            
            if not isInsideDropdown and not isInsideOptions then
                isOpen = false
                TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                
                wait(0.2)
                optionsFrame.Visible = false
                
                multiDropdown.ZIndex = 20
                optionsFrame.ZIndex = 50
            end
        end
    end
    
    UserInputService.InputBegan:Connect(closeDropdown)
    
    -- FIXED: Return object with improved methods
    local multiDropdownObj = {}
    
    function multiDropdownObj:GetSelections()
        -- Return as array for compatibility
        local selections = {}
        for option, selected in pairs(selectedOptions) do
            if selected then
                table.insert(selections, option)
            end
        end
        return selections
    end
    
    function multiDropdownObj:GetSelectionsTable()
        -- Return as table for direct access
        return selectedOptions
    end
    
    function multiDropdownObj:SetSelections(selections)
        -- Clear current selections
        selectedOptions = {}
        
        if selections then
            -- Handle both array and table formats
            if typeof(selections) == "table" then
                if #selections > 0 then
                    -- Array format: {"Log", "Coal"}
                    for _, option in ipairs(selections) do
                        if table.find(options, option) then
                            selectedOptions[option] = true
                        end
                    end
                else
                    -- Table format: {["Log"] = true, ["Coal"] = true}
                    for option, isSelected in pairs(selections) do
                        if table.find(options, option) and isSelected then
                            selectedOptions[option] = true
                        end
                    end
                end
            end
        end
        
        -- FIXED: Update ALL button appearances, not just the ones that changed
        for _, optionButton in pairs(optionsFrame:GetChildren()) do
            if optionButton:IsA("TextButton") and optionButton.Name:find("Option_") then
                local option = optionButton.Name:sub(8) -- Remove "Option_" prefix
                if selectedOptions[option] then
                    optionButton.BackgroundColor3 = Theme.Accent
                else
                    optionButton.BackgroundColor3 = Theme.Secondary
                end
            end
        end
        
        updateDisplayText()
        
        -- Trigger callback
        if callback then
            local selectionsArray = self:GetSelections()
            callback(selectionsArray, selectedOptions)
        end
    end
    
    function multiDropdownObj:ClearSelections()
        -- FIXED: Properly clear all selections
        for option in pairs(selectedOptions) do
            selectedOptions[option] = false
        end
        
        -- Update all button appearances
        for _, optionButton in pairs(optionsFrame:GetChildren()) do
            if optionButton:IsA("TextButton") and optionButton.Name:find("Option_") then
                optionButton.BackgroundColor3 = Theme.Secondary
            end
        end
        
        updateDisplayText()
        
        -- Trigger callback
        if callback then
            callback({}, {})
        end
    end
    
    function multiDropdownObj:SelectAll()
        local allSelections = {}
        for _, option in ipairs(options) do
            selectedOptions[option] = true
            allSelections[option] = true
        end
        
        -- Update all button appearances
        for _, optionButton in pairs(optionsFrame:GetChildren()) do
            if optionButton:IsA("TextButton") and optionButton.Name:find("Option_") then
                optionButton.BackgroundColor3 = Theme.Accent
            end
        end
        
        updateDisplayText()
        
        -- Trigger callback
        if callback then
            local selectionsArray = self:GetSelections()
            callback(selectionsArray, selectedOptions)
        end
    end
    
    function multiDropdownObj:IsSelected(option)
        return selectedOptions[option] or false
    end
    
    function multiDropdownObj:GetSelectedCount()
        local count = 0
        for _ in pairs(selectedOptions) do
            count = count + 1
        end
        return count
    end
    
    function multiDropdownObj:Refresh()
        updateDisplayText()
    end
    
    function multiDropdownObj:GetInstance()
        return multiDropdown
    end
    
    return multiDropdownObj
end
--#add function here

-- Number Input Field Function
function GuiLibrary:CreateNumberInput(tab, inputName, placeholder, defaultValue, minValue, maxValue, callback)
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "NumberInput_" .. inputName
    inputFrame.Size = UDim2.new(1, 0, 0, 35)
    inputFrame.BackgroundTransparency = 1
    inputFrame.Parent = tab.Frame
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = inputName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = inputFrame
    
    local inputContainer = Instance.new("Frame")
    inputContainer.Name = "InputContainer"
    inputContainer.Size = UDim2.new(0.6, 0, 1, 0)
    inputContainer.Position = UDim2.new(0.4, 0, 0, 0)
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = inputFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(0.7, 0, 1, 0)
    textBox.Position = UDim2.new(0, 0, 0, 0)
    textBox.BackgroundColor3 = Theme.Secondary
    textBox.BorderSizePixel = 0
    textBox.Text = tostring(defaultValue or "")
    textBox.PlaceholderText = placeholder or "Enter number..."
    textBox.TextColor3 = Theme.Text
    textBox.PlaceholderColor3 = Theme.TextSecondary
    textBox.TextSize = 14
    textBox.Font = Enum.Font.Gotham
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputContainer
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 6)
    textBoxCorner.Parent = textBox
    
    local textBoxPadding = Instance.new("UIPadding")
    textBoxPadding.PaddingLeft = UDim.new(0, 10)
    textBoxPadding.PaddingRight = UDim.new(0, 10)
    textBoxPadding.Parent = textBox
    
    -- Stepper buttons
    local stepperFrame = Instance.new("Frame")
    stepperFrame.Name = "Stepper"
    stepperFrame.Size = UDim2.new(0.3, 0, 1, 0)
    stepperFrame.Position = UDim2.new(0.7, 5, 0, 0)
    stepperFrame.BackgroundTransparency = 1
    stepperFrame.Parent = inputContainer
    
    local increaseButton = Instance.new("TextButton")
    increaseButton.Name = "Increase"
    increaseButton.Size = UDim2.new(0.5, -2, 1, 0)
    increaseButton.Position = UDim2.new(0.5, 2, 0, 0)
    increaseButton.BackgroundColor3 = Theme.Accent
    increaseButton.BorderSizePixel = 0
    increaseButton.Text = "+"
    increaseButton.TextColor3 = Theme.Text
    increaseButton.TextSize = 14
    increaseButton.Font = Enum.Font.GothamBold
    increaseButton.Parent = stepperFrame
    
    local decreaseButton = Instance.new("TextButton")
    decreaseButton.Name = "Decrease"
    decreaseButton.Size = UDim2.new(0.5, -2, 1, 0)
    decreaseButton.Position = UDim2.new(0, 0, 0, 0)
    decreaseButton.BackgroundColor3 = Theme.Accent
    decreaseButton.BorderSizePixel = 0
    decreaseButton.Text = "-"
    decreaseButton.TextColor3 = Theme.Text
    decreaseButton.TextSize = 14
    decreaseButton.Font = Enum.Font.GothamBold
    decreaseButton.Parent = stepperFrame
    
    local stepperCorner = Instance.new("UICorner")
    stepperCorner.CornerRadius = UDim.new(0, 6)
    stepperCorner.Parent = increaseButton
    
    local stepperCorner2 = Instance.new("UICorner")
    stepperCorner2.CornerRadius = UDim.new(0, 6)
    stepperCorner2.Parent = decreaseButton
    
    -- Set min/max values
    local min = minValue or -math.huge
    local max = maxValue or math.huge
    local currentValue = tonumber(defaultValue) or 0
    
    local function validateNumber(value)
        local num = tonumber(value)
        if num then
            return math.clamp(num, min, max)
        end
        return currentValue
    end
    
    local function updateValue(newValue, triggerCallback)
        local validatedValue = validateNumber(newValue)
        currentValue = validatedValue
        textBox.Text = tostring(validatedValue)
        
        if triggerCallback and callback then
            callback(validatedValue)
        end
    end
    
    local function stepValue(amount)
        local newValue = currentValue + amount
        updateValue(newValue, true)
    end
    
    -- TextBox effects and validation
    textBox.Focused:Connect(function()
        TweenService:Create(textBox, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
    end)
    
    textBox.FocusLost:Connect(function(enterPressed)
        TweenService:Create(textBox, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Secondary}):Play()
        updateValue(textBox.Text, true)
    end)
    
    -- Stepper button events
    increaseButton.MouseButton1Click:Connect(function()
        stepValue(1)
    end)
    
    decreaseButton.MouseButton1Click:Connect(function()
        stepValue(-1)
    end)
    
    -- Button hover effects
    local function setupButtonEffects(button)
        button.MouseEnter:Connect(function()
            if not isMobile then
                TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
            end
        end)
        
        button.MouseLeave:Connect(function()
            if not isMobile then
                TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
            end
        end)
        
        button.MouseButton1Click:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Success}):Play()
            TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
        end)
    end
    
    setupButtonEffects(increaseButton)
    setupButtonEffects(decreaseButton)
    
    -- Initialize with default value
    updateValue(defaultValue or 0, false)
    
    -- Create input object with methods
    local numberInputObj = {}
    
    function numberInputObj:GetValue()
        return currentValue
    end
    
    function numberInputObj:SetValue(value)
        updateValue(value, false)
    end
    
    function numberInputObj:SetRange(newMin, newMax)
        min = newMin or min
        max = newMax or max
        updateValue(currentValue, false) -- Re-validate current value
    end
    
    function numberInputObj:SetPlaceholder(text)
        textBox.PlaceholderText = text or ""
    end
    
    function numberInputObj:SetStepAmount(amount)
        -- Optional: Customize step amount if needed
    end
    
    function numberInputObj:GetInstance()
        return inputFrame
    end
    
    return numberInputObj
end


--#add new function
--// 🎯 PLAYER LIST WITH TP BUTTONS (Proper Library Method)
function GuiLibrary:CreatePlayerList(tab, listName, callback)
    local Players = game:GetService("Players")
    local playerEntries = {}
    local playerListFrame = nil
    
    -- Create main player list frame
    local function createPlayerListFrame()
        if playerListFrame then
            playerListFrame:Destroy()
        end
        
        playerListFrame = Instance.new("Frame")
        playerListFrame.Name = "PlayerList_" .. listName
        playerListFrame.Size = UDim2.new(1, 0, 0, 0) -- Auto-size
        playerListFrame.BackgroundTransparency = 1
        playerListFrame.Parent = tab.Frame
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = playerListFrame
        
        -- Auto-size the frame
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            playerListFrame.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
        end)
        
        return playerListFrame
    end
    
    -- Function to teleport to player
    local function teleportToPlayer(targetPlayer)
        local character = Players.LocalPlayer.Character
        local targetCharacter = targetPlayer.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") and 
           targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
            local targetHRP = targetCharacter.HumanoidRootPart
            local offset = Vector3.new(0, 3, 0)
            
            character.HumanoidRootPart.CFrame = targetHRP.CFrame + offset
            print("✅ Teleported to " .. targetPlayer.Name)
            
            if callback then
                callback(targetPlayer)
            end
        else
            warn("❌ Cannot teleport - player or target character not found")
        end
    end
    
    -- Create player entry frame
    local function createPlayerEntry(player, isLocalPlayer)
        local playerFrame = Instance.new("Frame")
        playerFrame.Name = "PlayerEntry_" .. player.UserId
        playerFrame.Size = UDim2.new(1, 0, 0, 40)
        playerFrame.BackgroundColor3 = isLocalPlayer and Theme.Accent or Theme.Secondary
        playerFrame.BorderSizePixel = 0
        playerFrame.LayoutOrder = isLocalPlayer and 0 or player.UserId
        playerFrame.Parent = playerListFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = playerFrame
        
        -- Player info label
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Name = "PlayerInfo"
        infoLabel.Size = UDim2.new(0.6, -10, 1, 0)
        infoLabel.Position = UDim2.new(0, 10, 0, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Theme.Text
        infoLabel.TextSize = 14
        infoLabel.TextXAlignment = Enum.TextXAlignment.Left
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.Parent = playerFrame
        
        -- Set player info text
        local playerText = player.Name
        if player.DisplayName ~= player.Name then
            playerText = playerText .. "\n[@" .. player.DisplayName .. "]"
        end
        if isLocalPlayer then
            playerText = "👑 " .. playerText .. " (You)"
        end
        infoLabel.Text = playerText
        
        -- TP Button (only for other players)
        if not isLocalPlayer then
            local tpButton = Instance.new("TextButton")
            tpButton.Name = "TPButton"
            tpButton.Size = UDim2.new(0.35, -10, 0, 30)
            tpButton.Position = UDim2.new(0.65, 5, 0.5, -15)
            tpButton.BackgroundColor3 = Theme.Accent
            tpButton.BorderSizePixel = 0
            tpButton.Text = "📡 TP"
            tpButton.TextColor3 = Theme.Text
            tpButton.TextSize = 12
            tpButton.Font = Enum.Font.GothamBold
            tpButton.Parent = playerFrame
            
            local tpCorner = Instance.new("UICorner")
            tpCorner.CornerRadius = UDim.new(0, 6)
            tpCorner.Parent = tpButton
            
            -- TP Button hover effects
            tpButton.MouseEnter:Connect(function()
                if not isMobile then
                    TweenService:Create(tpButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
                end
            end)
            
            tpButton.MouseLeave:Connect(function()
                if not isMobile then
                    TweenService:Create(tpButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
                end
            end)
            
            -- TP Button click event
            tpButton.MouseButton1Click:Connect(function()
                teleportToPlayer(player)
            end)
        end
        
        return playerFrame
    end
    
    -- Refresh player list
    local function refreshPlayerList()
        local container = createPlayerListFrame()
        local players = Players:GetPlayers()
        
        -- Sort players alphabetically
        table.sort(players, function(a, b)
            return a.Name:lower() < b.Name:lower()
        end)
        
        -- Create entries for all players
        for _, player in ipairs(players) do
            local isLocalPlayer = (player == Players.LocalPlayer)
            local playerEntry = createPlayerEntry(player, isLocalPlayer)
            playerEntries[player.UserId] = playerEntry
        end
        
        print("🔄 Player list updated: " .. (#players - 1) .. " other players")
    end
    
    -- Auto-refresh connections
    local function setupAutoRefresh()
        Players.PlayerAdded:Connect(function(player)
            task.wait(1)
            refreshPlayerList()
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            refreshPlayerList()
        end)
    end
    
    -- Initialize
    refreshPlayerList()
    setupAutoRefresh()
    
    -- Create player list object with methods
    local playerListObj = {}
    
    function playerListObj:Refresh()
        refreshPlayerList()
    end
    
    function playerListObj:GetPlayerCount()
        return #Players:GetPlayers()
    end
    
    function playerListObj:GetOtherPlayerCount()
        return #Players:GetPlayers() - 1
    end
    
    function playerListObj:TeleportToPlayer(player)
        if typeof(player) == "Instance" and player:IsA("Player") then
            teleportToPlayer(player)
        else
            warn("❌ Invalid player provided")
        end
    end
    
    function playerListObj:GetPlayers()
        return Players:GetPlayers()
    end
    
    function playerListObj:GetInstance()
        return playerListFrame
    end
    
    function playerListObj:Destroy()
        if playerListFrame then
            playerListFrame:Destroy()
            playerListFrame = nil
        end
        playerEntries = {}
    end
    
    return playerListObj
end


-- Progress Bar Function
function GuiLibrary:CreateProgressBar(tab, progressName, minValue, maxValue, defaultValue, callback)
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar_" .. progressName
    progressBar.Size = UDim2.new(1, 0, 0, 60)
    progressBar.BackgroundTransparency = 1
    progressBar.Parent = tab.Frame
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = progressName
    label.TextColor3 = Theme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = progressBar
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultValue or minValue) .. "/" .. tostring(maxValue)
    valueLabel.TextColor3 = Theme.TextSecondary
    valueLabel.TextSize = 12
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.Parent = progressBar
    
    local progressTrack = Instance.new("Frame")
    progressTrack.Name = "Track"
    progressTrack.Size = UDim2.new(1, 0, 0, 20)
    progressTrack.Position = UDim2.new(0, 0, 0, 30)
    progressTrack.BackgroundColor3 = Theme.Secondary
    progressTrack.BorderSizePixel = 0
    progressTrack.Parent = progressBar
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 10)
    trackCorner.Parent = progressTrack
    
    local progressFill = Instance.new("Frame")
    progressFill.Name = "Fill"
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Theme.Accent
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = progressFill
    
    -- Percentage label inside progress bar
    local percentageLabel = Instance.new("TextLabel")
    percentageLabel.Name = "Percentage"
    percentageLabel.Size = UDim2.new(1, 0, 1, 0)
    percentageLabel.BackgroundTransparency = 1
    percentageLabel.Text = "0%"
    percentageLabel.TextColor3 = Theme.Text
    percentageLabel.TextSize = 12
    percentageLabel.Font = Enum.Font.GothamBold
    percentageLabel.Parent = progressTrack
    
    local currentValue = defaultValue or minValue
    local min = minValue or 0
    local max = maxValue or 100
    
    local function updateProgress(value, triggerCallback)
        currentValue = math.clamp(value, min, max)
        local percentage = (currentValue - min) / (max - min)
        local fillWidth = percentage * progressTrack.AbsoluteSize.X
        
        progressFill.Size = UDim2.new(percentage, 0, 1, 0)
        valueLabel.Text = tostring(math.floor(currentValue)) .. "/" .. tostring(max)
        percentageLabel.Text = string.format("%d%%", math.floor(percentage * 100))
        
        -- Auto-adjust text color for better visibility
        if percentage > 0.5 then
            percentageLabel.TextColor3 = Color3.new(1, 1, 1)
        else
            percentageLabel.TextColor3 = Theme.Text
        end
        
        if triggerCallback and callback then
            callback(currentValue, percentage)
        end
    end
    
    -- Initialize with default value
    updateProgress(currentValue, false)
    
    -- Create progress bar object with methods
    local progressBarObj = {}
    
    function progressBarObj:GetValue()
        return currentValue
    end
    
    function progressBarObj:SetValue(value)
        updateProgress(value, true)
    end
    
    function progressBarObj:SetRange(newMin, newMax)
        min = newMin or min
        max = newMax or max
        updateProgress(currentValue, false) -- Re-validate current value
    end
    
    function progressBarObj:Increment(amount)
        amount = amount or 1
        updateProgress(currentValue + amount, true)
    end
    
    function progressBarObj:Decrement(amount)
        amount = amount or 1
        updateProgress(currentValue - amount, true)
    end
    
    function progressBarObj:GetPercentage()
        return (currentValue - min) / (max - min)
    end
    
    function progressBarObj:SetColor(color)
        progressFill.BackgroundColor3 = color or Theme.Accent
    end
    
    function progressBarObj:Reset()
        updateProgress(min, true)
    end
    
    function progressBarObj:SetToMax()
        updateProgress(max, true)
    end
    
    function progressBarObj:IsComplete()
        return currentValue >= max
    end
    
    function progressBarObj:GetInstance()
        return progressBar
    end
    
    return progressBarObj
end

-- Temporary Progress Bar Function (Auto-removing)
function GuiLibrary:CreateTemporaryProgressBar(progressName, duration, callback)
    local temporaryProgress = {}
    temporaryProgress.Destroyed = false
    
    -- Create ScreenGui for temporary progress bar
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TemporaryProgress_" .. progressName
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    
    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 80)
    mainFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7, 0, -7)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.85
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = progressName
    title.TextColor3 = Theme.Text
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Progress track
    local progressTrack = Instance.new("Frame")
    progressTrack.Size = UDim2.new(1, -20, 0, 20)
    progressTrack.Position = UDim2.new(0, 10, 0, 40)
    progressTrack.BackgroundColor3 = Theme.Secondary
    progressTrack.BorderSizePixel = 0
    progressTrack.Parent = mainFrame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 10)
    trackCorner.Parent = progressTrack
    
    -- Progress fill
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Theme.Accent
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = progressFill
    
    -- Percentage label
    local percentageLabel = Instance.new("TextLabel")
    percentageLabel.Size = UDim2.new(1, 0, 1, 0)
    percentageLabel.BackgroundTransparency = 1
    percentageLabel.Text = "0%"
    percentageLabel.TextColor3 = Theme.Text
    percentageLabel.TextSize = 12
    percentageLabel.Font = Enum.Font.GothamBold
    percentageLabel.Parent = progressTrack
    
    -- Time remaining label
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(1, -20, 0, 15)
    timeLabel.Position = UDim2.new(0, 10, 0, 62)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "Time remaining: " .. duration .. "s"
    timeLabel.TextColor3 = Theme.TextSecondary
    timeLabel.TextSize = 10
    timeLabel.TextXAlignment = Enum.TextXAlignment.Right
    timeLabel.Font = Enum.Font.Gotham
    timeLabel.Parent = mainFrame
    
    local startTime = tick()
    local endTime = startTime + duration
    
    -- Animation function
    local function animateProgress()
        while tick() < endTime and not temporaryProgress.Destroyed do
            local elapsed = tick() - startTime
            local progress = elapsed / duration
            local remaining = duration - elapsed
            
            progressFill.Size = UDim2.new(progress, 0, 1, 0)
            percentageLabel.Text = string.format("%d%%", math.floor(progress * 100))
            timeLabel.Text = string.format("Time remaining: %.1fs", remaining)
            
            -- Auto-adjust text color
            if progress > 0.5 then
                percentageLabel.TextColor3 = Color3.new(1, 1, 1)
            else
                percentageLabel.TextColor3 = Theme.Text
            end
            
            if callback then
                callback(progress, remaining)
            end
            
            wait(0.1)
        end
        
        -- Complete animation
        if not temporaryProgress.Destroyed then
            progressFill.Size = UDim2.new(1, 0, 1, 0)
            percentageLabel.Text = "100%"
            timeLabel.Text = "Completed!"
            
            if callback then
                callback(1, 0)
            end
            
            -- Auto-remove after completion
            wait(2)
            temporaryProgress:Destroy()
        end
    end
    
    -- Start animation
    spawn(animateProgress)
    
    -- Methods for temporary progress bar
    function temporaryProgress:Destroy()
        if not self.Destroyed then
            self.Destroyed = true
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
        end
    end
    
    function temporaryProgress:GetRemainingTime()
        return math.max(0, endTime - tick())
    end
    
    function temporaryProgress:GetProgress()
        local elapsed = tick() - startTime
        return math.min(1, elapsed / duration)
    end
    
    function temporaryProgress:IsComplete()
        return tick() >= endTime
    end
    
    function temporaryProgress:GetInstance()
        return screenGui
    end
    
    return temporaryProgress
end

-- Add these functions to the GuiLibrary after the existing functions:

-- Function to display detailed information table
function GuiLibrary:CreateInfoTable(tab, title, infoData, showSupport)
    local infoContainer = Instance.new("Frame")
    infoContainer.Name = "InfoTable_" .. title
    infoContainer.Size = UDim2.new(1, 0, 0, 0) -- Auto-size
    infoContainer.BackgroundTransparency = 1
    infoContainer.Parent = tab.Frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = infoContainer
    
    -- Title
    if title then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, 0, 0, 25)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Theme.Accent
        titleLabel.TextSize = 16
        titleLabel.TextXAlignment = Enum.TextXAlignment.Center
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.LayoutOrder = 1
        titleLabel.Parent = infoContainer
    end
    
    -- Welcome message
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Name = "Welcome"
    welcomeLabel.Size = UDim2.new(1, 0, 0, 40)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "🎮 Welcome to SFY Ultimate Menu!"
    welcomeLabel.TextColor3 = Theme.Text
    welcomeLabel.TextSize = 14
    welcomeLabel.TextWrapped = true
    welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
    welcomeLabel.Font = Enum.Font.Gotham
    welcomeLabel.LayoutOrder = 2
    welcomeLabel.Parent = infoContainer
    
    -- Info table
    if infoData and type(infoData) == "table" then
        local tableFrame = Instance.new("Frame")
        tableFrame.Name = "TableFrame"
        tableFrame.Size = UDim2.new(1, 0, 0, 0) -- Auto-size
        tableFrame.BackgroundColor3 = Theme.Secondary
        tableFrame.BorderSizePixel = 0
        tableFrame.LayoutOrder = 3
        tableFrame.Parent = infoContainer
        
        local tableCorner = Instance.new("UICorner")
        tableCorner.CornerRadius = UDim.new(0, 8)
        tableCorner.Parent = tableFrame
        
        local tableLayout = Instance.new("UIListLayout")
        tableLayout.Padding = UDim.new(0, 1)
        tableLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tableLayout.Parent = tableFrame
        
        local tablePadding = Instance.new("UIPadding")
        tablePadding.PaddingTop = UDim.new(0, 8)
        tablePadding.PaddingBottom = UDim.new(0, 8)
        tablePadding.PaddingLeft = UDim.new(0, 8)
        tablePadding.PaddingRight = UDim.new(0, 8)
        tablePadding.Parent = tableFrame
        
        local rowCount = 0
        
        for key, value in pairs(infoData) do
            local rowFrame = Instance.new("Frame")
            rowFrame.Name = "Row_" .. key
            rowFrame.Size = UDim2.new(1, -16, 0, 25)
            rowFrame.BackgroundTransparency = 1
            rowFrame.LayoutOrder = rowCount
            rowFrame.Parent = tableFrame
            
            local keyLabel = Instance.new("TextLabel")
            keyLabel.Name = "Key"
            keyLabel.Size = UDim2.new(0.4, 0, 1, 0)
            keyLabel.BackgroundTransparency = 1
            keyLabel.Text = tostring(key) .. ":"
            keyLabel.TextColor3 = Theme.TextSecondary
            keyLabel.TextSize = 12
            keyLabel.TextXAlignment = Enum.TextXAlignment.Left
            keyLabel.Font = Enum.Font.Gotham
            keyLabel.Parent = rowFrame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "Value"
            valueLabel.Size = UDim2.new(0.6, 0, 1, 0)
            valueLabel.Position = UDim2.new(0.4, 0, 0, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(value)
            valueLabel.TextColor3 = Theme.Text
            valueLabel.TextSize = 12
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.Parent = rowFrame
            
            rowCount = rowCount + 1
        end
        
        -- Update table height
        tableLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tableFrame.Size = UDim2.new(1, 0, 0, tableLayout.AbsoluteContentSize.Y + 16)
        end)
    end
    
    -- Support section
    if showSupport then
        local supportFrame = Instance.new("Frame")
        supportFrame.Name = "SupportFrame"
        supportFrame.Size = UDim2.new(1, 0, 0, 120)
        supportFrame.BackgroundTransparency = 1
        supportFrame.LayoutOrder = 4
        supportFrame.Parent = infoContainer
        
        local supportLabel = Instance.new("TextLabel")
        supportLabel.Name = "SupportLabel"
        supportLabel.Size = UDim2.new(1, 0, 0, 40)
        supportLabel.BackgroundTransparency = 1
        supportLabel.Text = "💝 Support My Work!"
        supportLabel.TextColor3 = Theme.Text
        supportLabel.TextSize = 14
        supportLabel.TextWrapped = true
        supportLabel.TextXAlignment = Enum.TextXAlignment.Center
        supportLabel.Font = Enum.Font.GothamBold
        supportLabel.Parent = supportFrame
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Name = "Message"
        messageLabel.Size = UDim2.new(1, 0, 0, 40)
        messageLabel.Position = UDim2.new(0, 0, 0, 40)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Text = "If you enjoy this script, consider supporting the development!"
        messageLabel.TextColor3 = Theme.TextSecondary
        messageLabel.TextSize = 12
        messageLabel.TextWrapped = true
        messageLabel.TextXAlignment = Enum.TextXAlignment.Center
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.Parent = supportFrame
        
        -- Donate button
        local donateButton = Instance.new("TextButton")
        donateButton.Name = "DonateButton"
        donateButton.Size = UDim2.new(0.6, 0, 0, 30)
        donateButton.Position = UDim2.new(0.2, 0, 0, 85)
        donateButton.BackgroundColor3 = Theme.Success
        donateButton.BorderSizePixel = 0
        donateButton.Text = "💰 Donate"
        donateButton.TextColor3 = Theme.Text
        donateButton.TextSize = 12
        donateButton.Font = Enum.Font.GothamBold
        donateButton.Parent = supportFrame
        
        local donateCorner = Instance.new("UICorner")
        donateCorner.CornerRadius = UDim.new(0, 6)
        donateCorner.Parent = donateButton
        
        -- Donate button effects
        donateButton.MouseEnter:Connect(function()
            if not isMobile then
                TweenService:Create(donateButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}):Play()
            end
        end)
        
        donateButton.MouseLeave:Connect(function()
            if not isMobile then
                TweenService:Create(donateButton, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Success}):Play()
            end
        end)
        
        donateButton.MouseButton1Click:Connect(function()
            -- Open donation link (you can change this to your preferred donation method)
            local donationUrl = "https://www.paypal.com/donate?hosted_button_id=YOUR_BUTTON_ID"
            print("💝 Thank you for considering a donation!")
            print("🔗 Donation link: " .. donationUrl)
            
            -- You can also use this to open a browser window:
            -- game:GetService("StarterGui"):SetCore("OpenBrowserWindow", {Url = donationUrl})
        end)
    end
    
    -- Credits section
    local creditsFrame = Instance.new("Frame")
    creditsFrame.Name = "CreditsFrame"
    creditsFrame.Size = UDim2.new(1, 0, 0, 40)
    creditsFrame.BackgroundTransparency = 1
    creditsFrame.LayoutOrder = 5
    creditsFrame.Parent = infoContainer
    
    local creditsLabel = Instance.new("TextLabel")
    creditsLabel.Name = "Credits"
    creditsLabel.Size = UDim2.new(1, 0, 1, 0)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.Text = "Made with ❤️ by ScriptForYou"
    creditsLabel.TextColor3 = Theme.TextSecondary
    creditsLabel.TextSize = 11
    creditsLabel.TextXAlignment = Enum.TextXAlignment.Center
    creditsLabel.Font = Enum.Font.Gotham
    creditsLabel.Parent = creditsFrame
    
    -- Update container height
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        infoContainer.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
    end)
    
    return infoContainer
end

-- Function to set version display in title bar
function GuiLibrary:SetVersion(versionText)
    if title and versionText then
        -- Update title to include version
        title.Text = "SFY Ultimate Menu v" .. versionText
        
        -- You can also add a separate version label if preferred
        if not title:FindFirstChild("VersionLabel") then
            local versionLabel = Instance.new("TextLabel")
            versionLabel.Name = "VersionLabel"
            versionLabel.Size = UDim2.new(0, 80, 0, 15)
            versionLabel.Position = UDim2.new(0.5, -40, 1, -20)
            versionLabel.BackgroundTransparency = 1
            versionLabel.Text = "v" .. versionText
            versionLabel.TextColor3 = Theme.TextSecondary
            versionLabel.TextSize = 10
            versionLabel.TextXAlignment = Enum.TextXAlignment.Center
            versionLabel.Font = Enum.Font.Gotham
            versionLabel.Parent = titleBar
        else
            title:FindFirstChild("VersionLabel").Text = "v" .. versionText
        end
    end
end

-- Function to create a comprehensive system info display
function GuiLibrary:CreateSystemInfo(tab, includePerformance)
    local systemInfo = {
        ["Game Name"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
        ["Place ID"] = tostring(game.PlaceId),
        ["Player Name"] = player.Name,
        ["Display Name"] = player.DisplayName,
        ["User ID"] = tostring(player.UserId),
        ["Account Age"] = tostring(player.AccountAge) .. " days",
        ["Membership"] = player.MembershipType.Name,
        ["Device Type"] = isMobile and "Mobile" or "Desktop",
        ["FPS"] = "Measuring...",
        ["Ping"] = "Measuring...",
        ["Script Version"] = "v6.0",
        ["Library Version"] = "v2.1"
    }
    
    -- Add performance metrics if requested
    if includePerformance then
        systemInfo["Graphics Quality"] = tostring(settings().Rendering.QualityLevel)
        systemInfo["Max Graphics"] = tostring(settings().Rendering.MaxQualityLevel)
    end
    
    -- Create the info table
    local infoTable = self:CreateInfoTable(
        tab,
        "System Information",
        systemInfo,
        true -- Show support section
    )
    
    -- Real-time FPS counter
    if includePerformance then
        local fps = 0
        local fpsCounter = 0
        local lastTime = tick()
        
        task.spawn(function()
            while infoTable and infoTable.Parent do
                fpsCounter = fpsCounter + 1
                local currentTime = tick()
                if currentTime - lastTime >= 1 then
                    fps = fpsCounter
                    fpsCounter = 0
                    lastTime = currentTime
                    
                    -- Update FPS in the table
                    local fpsLabel = infoTable:FindFirstChild("TableFrame")
                    if fpsLabel then
                        fpsLabel = fpsLabel:FindFirstChild("Row_FPS")
                        if fpsLabel then
                            fpsLabel = fpsLabel:FindFirstChild("Value")
                            if fpsLabel then
                                fpsLabel.Text = tostring(fps) .. " FPS"
                            end
                        end
                    end
                end
                task.wait()
            end
        end)
        
        -- Ping measurement
        task.spawn(function()
            while infoTable and infoTable.Parent do
                local ping = math.random(30, 80) -- Simulated ping
                -- In a real implementation, you'd measure actual ping
                
                local pingLabel = infoTable:FindFirstChild("TableFrame")
                if pingLabel then
                    pingLabel = pingLabel:FindFirstChild("Row_Ping")
                    if pingLabel then
                        pingLabel = pingLabel:FindFirstChild("Value")
                        if pingLabel then
                            pingLabel.Text = tostring(ping) .. " ms"
                        end
                    end
                end
                task.wait(2)
            end
        end)
    end
    
    return infoTable
end

-- Function to create a feature showcase
function GuiLibrary:CreateFeatureShowcase(tab, featuresList)
    local showcaseContainer = Instance.new("Frame")
    showcaseContainer.Name = "FeatureShowcase"
    showcaseContainer.Size = UDim2.new(1, 0, 0, 0) -- Auto-size
    showcaseContainer.BackgroundTransparency = 1
    showcaseContainer.Parent = tab.Frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = showcaseContainer
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🌟 Featured Functions"
    titleLabel.TextColor3 = Theme.Accent
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.LayoutOrder = 1
    titleLabel.Parent = showcaseContainer
    
    -- Features grid
    if featuresList and type(featuresList) == "table" then
        for i, feature in ipairs(featuresList) do
            local featureFrame = Instance.new("Frame")
            featureFrame.Name = "Feature_" .. i
            featureFrame.Size = UDim2.new(1, 0, 0, 50)
            featureFrame.BackgroundColor3 = Theme.Secondary
            featureFrame.BorderSizePixel = 0
            featureFrame.LayoutOrder = i + 1
            featureFrame.Parent = showcaseContainer
            
            local featureCorner = Instance.new("UICorner")
            featureCorner.CornerRadius = UDim.new(0, 8)
            featureCorner.Parent = featureFrame
            
            local iconLabel = Instance.new("TextLabel")
            iconLabel.Name = "Icon"
            iconLabel.Size = UDim2.new(0, 40, 1, 0)
            iconLabel.BackgroundTransparency = 1
            iconLabel.Text = feature.icon or "⭐"
            iconLabel.TextColor3 = Theme.Accent
            iconLabel.TextSize = 18
            iconLabel.TextXAlignment = Enum.TextXAlignment.Center
            iconLabel.Font = Enum.Font.GothamBold
            iconLabel.Parent = featureFrame
            
            local textFrame = Instance.new("Frame")
            textFrame.Name = "TextFrame"
            textFrame.Size = UDim2.new(1, -45, 1, 0)
            textFrame.Position = UDim2.new(0, 45, 0, 0)
            textFrame.BackgroundTransparency = 1
            textFrame.Parent = featureFrame
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "Name"
            nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = feature.name or "Feature"
            nameLabel.TextColor3 = Theme.Text
            nameLabel.TextSize = 14
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.Parent = textFrame
            
            local descLabel = Instance.new("TextLabel")
            descLabel.Name = "Description"
            descLabel.Size = UDim2.new(1, 0, 0.4, 0)
            descLabel.Position = UDim2.new(0, 0, 0.6, 0)
            descLabel.BackgroundTransparency = 1
            descLabel.Text = feature.description or "Feature description"
            descLabel.TextColor3 = Theme.TextSecondary
            descLabel.TextSize = 11
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextWrapped = true
            descLabel.Font = Enum.Font.Gotham
            descLabel.Parent = textFrame
        end
    end
    
    -- Update container height
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        showcaseContainer.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
    end)
    
    return showcaseContainer
end






























-- Export the library
return GuiLibrary
