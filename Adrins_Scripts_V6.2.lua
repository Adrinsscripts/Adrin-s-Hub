-- Adrin's Scripts V6.2

-- Movement + Teleport + Troll + Misc + Settings

-- RIGHT SHIFT = Open / Close Menu

-- G = Vehicle Fly



local function Main()

    local Players = game:GetService("Players")

    local UIS = game:GetService("UserInputService")

    local RunService = game:GetService("RunService")

    local TweenService = game:GetService("TweenService")

    local Lighting = game:GetService("Lighting")

    local TeleportService = game:GetService("TeleportService")

    local MarketplaceService = game:GetService("MarketplaceService")



    local player = Players.LocalPlayer

    local mouse = player:GetMouse()



    local function notify(msg)

        pcall(function()

            game:GetService("StarterGui"):SetCore("SendNotification", {

                Title = "Adrin's Scripts",

                Text = msg,

                Duration = 4

            })

        end)

    end



    notify("Loading V6.2...")



    local function getParent()

        local ok, hui = pcall(function()

            return gethui and gethui()

        end)

        if ok and hui then return hui end

        return game:GetService("CoreGui")

    end



    local parent = getParent()

    pcall(function()

        local old = parent:FindFirstChild("AdrinsScripts")

        if old then old:Destroy() end

    end)



    local Defaults = {

        bg = Color3.fromRGB(18,14,20),

        side = Color3.fromRGB(22,17,25),

        row = Color3.fromRGB(29,23,33),

        rowHover = Color3.fromRGB(39,30,44),

        text = Color3.fromRGB(236,237,245),

        sub = Color3.fromRGB(151,136,158),

        ACCENT = Color3.fromRGB(211,164,232),

        off = Color3.fromRGB(58,48,64),

        good = Color3.fromRGB(100,240,180),

        bad = Color3.fromRGB(240,80,100),

        stroke = Color3.fromRGB(49,39,55),

        chip = Color3.fromRGB(25,19,28)

    }



    local C = {}

    for k,v in pairs(Defaults) do C[k] = v end



    local function make(class, props, par)

        local obj = Instance.new(class)

        for k,v in pairs(props or {}) do

            obj[k] = v

        end

        if par then obj.Parent = par end

        return obj

    end



    local function corner(obj, radius)

        make("UICorner", {CornerRadius=UDim.new(0,radius)}, obj)

    end



    local function outline(obj)

        make("UIStroke", {Color=C.stroke, Thickness=1}, obj)

    end



    local function tween(obj, duration, props)

        TweenService:Create(

            obj,

            TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),

            props

        ):Play()

    end



    local gui = make("ScreenGui", {

        Name="AdrinsScripts",

        ResetOnSpawn=false,

        DisplayOrder=999,

        ZIndexBehavior=Enum.ZIndexBehavior.Sibling

    }, parent)



    local WIN_W, WIN_H = 820, 560

    local window = make("Frame", {

        Name="Window",

        Size=UDim2.fromOffset(WIN_W,WIN_H),

        Position=UDim2.new(0.5,-90,0.5,0),

        AnchorPoint=Vector2.new(0.5,0.5),

        BackgroundColor3=C.bg,

        BorderSizePixel=0

    },gui)

    corner(window,12)

    outline(window)



    local scale = make("UIScale",{Scale=1},window)

    local baseScale = 1

    pcall(function()

        local size = workspace.CurrentCamera.ViewportSize

        baseScale = math.clamp(math.min((size.X-280)/WIN_W,(size.Y-40)/WIN_H),0.5,1)

    end)

    scale.Scale = baseScale



    local header = make("Frame",{

        Size=UDim2.new(1,0,0,64),

        BackgroundTransparency=1

    },window)

    make("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.fromOffset(100,0),BackgroundColor3=C.stroke,BorderSizePixel=0},window)

    local searchFrame=make("Frame",{
        Name="SearchContainer",
        Size=UDim2.fromOffset(170,30),
        Position=UDim2.new(1,-258,0,17),
        BackgroundColor3=C.chip,
        BorderSizePixel=0
    },header)
    corner(searchFrame,8)
    outline(searchFrame)

    -- Draw a small magnifying glass with UI shapes instead of a font emoji.
    local searchLens=make("Frame",{
        Size=UDim2.fromOffset(9,9),
        Position=UDim2.fromOffset(10,8),
        BackgroundTransparency=1,
        BorderSizePixel=0
    },searchFrame)
    corner(searchLens,8)
    make("UIStroke",{Color=C.sub,Thickness=1.7},searchLens)
    make("Frame",{
        Size=UDim2.fromOffset(6,2),
        Position=UDim2.fromOffset(17,18),
        Rotation=45,
        BackgroundColor3=C.sub,
        BorderSizePixel=0
    },searchFrame)

    local searchBox=make("TextBox",{
        Name="Search",
        Size=UDim2.new(1,-34,1,0),
        Position=UDim2.fromOffset(29,0),
        BackgroundTransparency=1,
        Text="",
        PlaceholderText="Search features",
        PlaceholderColor3=C.sub,
        TextColor3=C.text,
        Font=Enum.Font.Gotham,
        TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left,
        ClearTextOnFocus=false,
        BorderSizePixel=0
    },searchFrame)

    local logo = make("Frame",{

        Size=UDim2.fromOffset(32,32),

        Position=UDim2.fromOffset(36,16),

        BackgroundColor3=C.ACCENT,

        BorderSizePixel=0

    },header)

    corner(logo,9)

    local logoGradient = make("UIGradient",{

        Color=ColorSequence.new(C.ACCENT,Color3.fromRGB(157,116,190)),

        Rotation=45

    },logo)



    -- Brand mark: use a standard Roblox font glyph, not emoji or special symbols.
    -- The offset shadow and slight tilt give the A a more distinctive badge style.
    make("TextLabel",{
        Name="LogoLetterShadow",
        Size=UDim2.fromScale(1,1),
        Position=UDim2.fromOffset(1,2),
        BackgroundTransparency=1,
        Text="A",
        Font=Enum.Font.GothamBlack,
        TextSize=23,
        TextColor3=Color3.fromRGB(89,52,112),
        TextXAlignment=Enum.TextXAlignment.Center,
        TextYAlignment=Enum.TextYAlignment.Center,
        Rotation=-8
    },logo)

    make("TextLabel",{
        Name="LogoLetter",
        Size=UDim2.fromScale(1,1),
        BackgroundTransparency=1,
        Text="A",
        Font=Enum.Font.GothamBlack,
        TextSize=23,
        TextColor3=Color3.fromRGB(255,250,255),
        TextStrokeColor3=Color3.fromRGB(142,92,170),
        TextStrokeTransparency=0.55,
        TextXAlignment=Enum.TextXAlignment.Center,
        TextYAlignment=Enum.TextYAlignment.Center,
        Rotation=-8
    },logo)



    make("TextLabel",{

        Size=UDim2.fromOffset(240,18),

        Position=UDim2.fromOffset(120,17),

        BackgroundTransparency=1,

        Text="Main",

        Font=Enum.Font.GothamBold,

        TextSize=15,

        TextColor3=C.text,

        TextXAlignment=Enum.TextXAlignment.Left

    },header)



    local gameTitleLabel=make("TextLabel",{
        Name="ExperienceName",
        Size=UDim2.fromOffset(240,14),
        Position=UDim2.fromOffset(120,36),
        BackgroundTransparency=1,
        Text=game.Name,
        Font=Enum.Font.Gotham,
        TextSize=11,
        TextColor3=C.sub,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd
    },header)




    local function headerButton(txt,x)

        local b=make("TextButton",{

            Size=UDim2.fromOffset(30,26),

            Position=UDim2.new(1,x,0,19),

            BackgroundColor3=C.row,

            Text=txt,

            TextColor3=C.text,

            Font=Enum.Font.GothamBold,

            TextSize=12,

            BorderSizePixel=0,

            AutoButtonColor=false

        },header)

        corner(b,7)

        outline(b)

        return b

    end



    local closeBtn=headerButton("X",-46)

    local minBtn=headerButton("-",-82)



    local dragging,dragStart,startPos

    header.InputBegan:Connect(function(input)

        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then

            dragging=true

            dragStart=input.Position

            startPos=window.Position

        end

    end)



    UIS.InputChanged:Connect(function(input)

        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then

            local delta=input.Position-dragStart

            window.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)

        end

    end)



    UIS.InputEnded:Connect(function(input)

        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then

            dragging=false

        end

    end)



    local sidebar=make("Frame",{

        Size=UDim2.new(0,100,1,0),

        Position=UDim2.fromOffset(0,0),

        BackgroundTransparency=1

    },window)



    local tabList=make("Frame",{

        Size=UDim2.new(1,-12,1,-132),

        Position=UDim2.fromOffset(6,78),

        BackgroundTransparency=1

    },sidebar)



    make("UIListLayout",{

        Padding=UDim.new(0,6),

        SortOrder=Enum.SortOrder.LayoutOrder

    },tabList)

    -- Airflow-style player profile: centered avatar, full name, username, and game.
    local profile=make("Frame",{
        Name="PlayerProfile",
        Size=UDim2.new(1,-12,0,106),
        Position=UDim2.new(0,6,1,-112),
        BackgroundColor3=C.row,
        BorderSizePixel=0
    },sidebar)
    corner(profile,10)
    outline(profile)

    local avatar=make("ImageLabel",{
        Name="Avatar",
        Size=UDim2.fromOffset(34,34),
        Position=UDim2.new(0.5,-17,0,6),
        BackgroundColor3=C.chip,
        Image="",
        ScaleType=Enum.ScaleType.Crop,
        BorderSizePixel=0
    },profile)
    corner(avatar,17)
    outline(avatar)

    make("TextLabel",{
        Name="PlayerDisplayName",
        Size=UDim2.new(1,-8,0,15),
        Position=UDim2.fromOffset(4,43),
        BackgroundTransparency=1,
        Text=player.DisplayName,
        Font=Enum.Font.GothamBold,
        TextSize=9,
        TextColor3=C.text,
        TextXAlignment=Enum.TextXAlignment.Center,
        TextTruncate=Enum.TextTruncate.AtEnd
    },profile)

    make("TextLabel",{
        Name="PlayerUsername",
        Size=UDim2.new(1,-8,0,13),
        Position=UDim2.fromOffset(4,58),
        BackgroundTransparency=1,
        Text="@"..player.Name,
        Font=Enum.Font.Gotham,
        TextSize=8,
        TextColor3=C.sub,
        TextXAlignment=Enum.TextXAlignment.Center,
        TextTruncate=Enum.TextTruncate.AtEnd
    },profile)

    local profileGameLabel=make("TextLabel",{
        Name="CurrentExperience",
        Size=UDim2.new(1,-8,0,15),
        Position=UDim2.fromOffset(4,77),
        BackgroundTransparency=1,
        Text=game.Name,
        Font=Enum.Font.Gotham,
        TextSize=7,
        TextColor3=C.sub,
        TextXAlignment=Enum.TextXAlignment.Center,
        TextTruncate=Enum.TextTruncate.AtEnd
    },profile)

    task.spawn(function()
        local ok,thumbnail=pcall(function()
            return Players:GetUserThumbnailAsync(
                player.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        if ok and avatar and avatar.Parent then
            avatar.Image=thumbnail
        end
    end)

    task.spawn(function()
        local ok,info=pcall(function()
            return MarketplaceService:GetProductInfo(game.PlaceId)
        end)
        if ok and info and info.Name then
            if profileGameLabel and profileGameLabel.Parent then
                profileGameLabel.Text=info.Name
            end
            if gameTitleLabel and gameTitleLabel.Parent then
                gameTitleLabel.Text=info.Name
            end
        end
    end)

    local content=make("Frame",{

        Size=UDim2.new(1,-126,1,-112),

        Position=UDim2.fromOffset(114,70),

        BackgroundTransparency=1

    },window)



    local status=make("TextLabel",{

        Size=UDim2.new(1,-126,0,24),

        Position=UDim2.new(0,114,1,-36),

        BackgroundTransparency=1,

        Text="READY",

        Font=Enum.Font.GothamBold,

        TextSize=11,

        TextColor3=C.good,

        TextXAlignment=Enum.TextXAlignment.Left

    },window)



    local function setStatus(txt,col)

        status.Text="● "..txt

        status.TextColor3=col or C.good

    end



    local pages,tabs={},{}

    -- Use plain ASCII monograms instead of Unicode symbols/emoji.
    -- Some Roblox executor fonts do not include those glyphs and render them as squares.
    local tabIcons={Movement="M",Teleport="TP",Troll="TR",Misc="MX",Settings="S"}

    local function showPage(name)

        for n,p in pairs(pages) do p.Visible=(n==name) end

        for n,t in pairs(tabs) do

            local active=n==name

            t.btn.BackgroundColor3=active and C.row or C.side

            t.btn.TextColor3=active and C.text or C.sub

            t.bar.Visible=active

        end

    end



    local function newTab(name,order)

        local b=make("TextButton",{

            Size=UDim2.new(1,-8,0,54),

            BackgroundColor3=C.side,

            Text=(tabIcons[name] or "•").."\n"..name,

            Font=Enum.Font.GothamBold,

            TextSize=11,

            TextColor3=C.sub,

            TextXAlignment=Enum.TextXAlignment.Center,

            AutoButtonColor=false,

            LayoutOrder=order,

            BorderSizePixel=0

        },tabList)

        corner(b,9)

        local bar=make("Frame",{

            Size=UDim2.fromOffset(3,20),

            Position=UDim2.new(0,2,0.5,-10),

            BackgroundColor3=C.ACCENT,

            BorderSizePixel=0,

            Visible=false

        },b)

        corner(bar,2)

        tabs[name]={btn=b,bar=bar}

        pages[name]=make("Frame",{

            Size=UDim2.fromScale(1,1),

            BackgroundTransparency=1,

            Visible=false

        },content)

        b.MouseButton1Click:Connect(function()

            showPage(name)

        end)

        return pages[name]

    end



    local function column(page,x,w,title)

        make("TextLabel",{

            Size=UDim2.new(w,-8,0,18),

            Position=UDim2.new(x,0,0,0),

            BackgroundTransparency=1,

            Text=title,

            Font=Enum.Font.GothamBold,

            TextSize=12,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Left

        },page)



        local col=make("ScrollingFrame",{

            Size=UDim2.new(w,-8,1,-26),

            Position=UDim2.new(x,0,0,26),

            BackgroundColor3=C.side,

            BackgroundTransparency=0,

            BorderSizePixel=0,

            ScrollBarThickness=3,

            ScrollBarImageColor3=C.off,

            AutomaticCanvasSize=Enum.AutomaticSize.Y,

            CanvasSize=UDim2.new()

        },page)



        corner(col,10)

        outline(col)

        make("UIPadding",{

            PaddingTop=UDim.new(0,8),

            PaddingLeft=UDim.new(0,8),

            PaddingLeft=UDim.new(0,8),

            PaddingRight=UDim.new(0,8),

            PaddingTop=UDim.new(0,8),

            PaddingBottom=UDim.new(0,8)

        },col)

        corner(col,9)
        outline(col)

        make("UIListLayout",{

            Padding=UDim.new(0,8),

            SortOrder=Enum.SortOrder.LayoutOrder

        },col)



        return col

    end



    local binds,allToggles={},{}

    local function toggleRow(col,order,title,desc,key,onChange)

        local row=make("Frame",{

            Size=UDim2.new(1,0,0,desc and 50 or 40),

            BackgroundColor3=C.row,

            BorderSizePixel=0,

            LayoutOrder=order

        },col)

        corner(row,9)



        make("TextLabel",{

            Size=UDim2.new(1,-120,0,16),

            Position=UDim2.fromOffset(14,desc and 9 or 12),

            BackgroundTransparency=1,

            Text=title,

            Font=Enum.Font.GothamBold,

            TextSize=12,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Left

        },row)



        if desc then

            make("TextLabel",{

                Size=UDim2.new(1,-120,0,14),

                Position=UDim2.fromOffset(14,26),

                BackgroundTransparency=1,

                Text=desc,

                Font=Enum.Font.Gotham,

                TextSize=10,

                TextColor3=C.sub,

                TextXAlignment=Enum.TextXAlignment.Left

            },row)

        end



        local pill=make("TextButton",{

            Size=UDim2.fromOffset(36,20),

            Position=UDim2.new(1,-50,0.5,-10),

            BackgroundColor3=C.off,

            Text="",

            BorderSizePixel=0,

            AutoButtonColor=false

        },row)

        corner(pill,10)



        local knob=make("Frame",{

            Size=UDim2.fromOffset(14,14),

            Position=UDim2.fromOffset(3,3),

            BackgroundColor3=Color3.new(1,1,1),

            BorderSizePixel=0

        },pill)

        corner(knob,7)



        if key then

            local chip=make("TextLabel",{

                Size=UDim2.fromOffset(28,20),

                Position=UDim2.new(1,-86,0.5,-10),

                BackgroundColor3=C.chip,

                Text=key.Name,

                Font=Enum.Font.GothamBold,

                TextSize=10,

                TextColor3=C.sub,

                BorderSizePixel=0

            },row)

            corner(chip,5)

        end



        local obj={state=false,indicators={}}



        function obj.Set(v,silent)

            obj.state=v

            tween(pill,0.15,{BackgroundColor3=v and C.ACCENT or C.off})

            tween(knob,0.15,{Position=v and UDim2.fromOffset(19,3) or UDim2.fromOffset(3,3)})



            for _,ind in ipairs(obj.indicators) do

                ind.bg.BackgroundColor3=v and C.ACCENT or C.off

                ind.knob.Position=v and UDim2.fromOffset(15,2) or UDim2.fromOffset(2,2)

            end



            if not silent then

                onChange(v)

            end

        end



        function obj.Toggle()

            obj.Set(not obj.state)

        end



        pill.MouseButton1Click:Connect(obj.Toggle)

        if key then binds[key]=obj end

        table.insert(allToggles,obj)

        return obj

    end



    local function sliderRow(col,order,title,min,max,default,suffix,callback)

        local row=make("Frame",{

            Size=UDim2.new(1,0,0,52),

            BackgroundColor3=C.row,

            BorderSizePixel=0,

            LayoutOrder=order

        },col)

        corner(row,9)



        make("TextLabel",{

            Size=UDim2.new(0.6,0,0,16),

            Position=UDim2.fromOffset(14,8),

            BackgroundTransparency=1,

            Text=title,

            Font=Enum.Font.GothamBold,

            TextSize=12,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Left

        },row)



        local valueLabel=make("TextLabel",{

            Size=UDim2.new(0.4,-14,0,16),

            Position=UDim2.new(0.6,0,0,8),

            BackgroundTransparency=1,

            Text="",

            Font=Enum.Font.GothamBold,

            TextSize=12,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Right

        },row)



        local track=make("Frame",{

            Size=UDim2.new(1,-28,0,4),

            Position=UDim2.fromOffset(14,38),

            BackgroundColor3=C.off,

            BorderSizePixel=0

        },row)

        corner(track,2)



        local fill=make("Frame",{

            Size=UDim2.fromScale(0,1),

            BackgroundColor3=C.ACCENT,

            BorderSizePixel=0

        },track)

        corner(fill,2)



        local hit=make("TextButton",{

            Size=UDim2.new(1,-28,0,24),

            Position=UDim2.fromOffset(14,28),

            BackgroundTransparency=1,

            Text=""

        },row)



        local function setValue(v,silent)

            v=math.clamp(math.floor(v+0.5),min,max)

            local a=(v-min)/(max-min)

            fill.Size=UDim2.fromScale(a,1)

            valueLabel.Text=tostring(v)..suffix

            if not silent then callback(v) end

        end



        local function fromX(x)

            setValue(min+(max-min)*math.clamp(

                (x-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1

            ))

        end



        local draggingSlider=false

        hit.InputBegan:Connect(function(input)

            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then

                draggingSlider=true

                fromX(input.Position.X)

            end

        end)



        UIS.InputChanged:Connect(function(input)

            if draggingSlider and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then

                fromX(input.Position.X)

            end

        end)



        UIS.InputEnded:Connect(function(input)

            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then

                draggingSlider=false

            end

        end)



        setValue(default,true)

    end



    local function buttonRow(col,order,text,color,callback)

        local b=make("TextButton",{

            Size=UDim2.new(1,0,0,38),

            BackgroundColor3=color or C.row,

            Text=text,

            Font=Enum.Font.GothamBold,

            TextSize=12,

            TextColor3=C.text,

            AutoButtonColor=false,

            BorderSizePixel=0,

            LayoutOrder=order

        },col)

        corner(b,9)

        b.MouseButton1Click:Connect(callback)

        return b

    end



    local function getChar()

        local char=player.Character

        return char,char and char:FindFirstChild("HumanoidRootPart"),char and char:FindFirstChildOfClass("Humanoid")

    end



    -- MOVEMENT*

    local moveTab=newTab("Movement",1)

    local left=column(moveTab,0,0.5,"Speed & Jump")

    local right=column(moveTab,0.5,0.5,"Fly & Float")



    local walkEnabled,walkValue=false,16

    local jumpEnabled,jumpValue=false,50

    local hipOn,hipValue,origHip=false,2,2

    local bhopOn,infJumpEnabled,noclipOn=false,false,false

    local flying,flySpeed=false,60

    local floatOn,floatSpeed,floatY,floatPart=false,40,0,nil

    local bv,bg,flyConn



    local walkToggle=toggleRow(left,1,"Enable WalkSpeed",nil,Enum.KeyCode.B,function(v)

        walkEnabled=v

        if not v then

            local _,_,hum=getChar()

            if hum then hum.WalkSpeed=16 end

        end

        setStatus(v and "WALKSPEED ON" or "WALKSPEED OFF")

    end)

    sliderRow(left,2,"WalkSpeed Value",0,500,16," studs",function(v) walkValue=v end)



    toggleRow(left,3,"Enable JumpPower",nil,Enum.KeyCode.N,function(v)

        jumpEnabled=v

        if not v then

            local _,_,hum=getChar()

            if hum then

                hum.UseJumpPower=true

                hum.JumpPower=50

            end

        end

        setStatus(v and "JUMPPOWER ON" or "JUMPPOWER OFF")

    end)

    sliderRow(left,4,"JumpPower Value",0,500,50,"",function(v) jumpValue=v end)



    local infJumpToggle=toggleRow(left,5,"Infinite Jump","Jump in mid-air",Enum.KeyCode.J,function(v)

        infJumpEnabled=v

        setStatus(v and "INFINITE JUMP ON" or "INFINITE JUMP OFF")

    end)



    toggleRow(left,6,"Bunny Hop","Hold Space to auto-jump",nil,function(v)

        bhopOn=v

    end)



    toggleRow(left,7,"Enable HipHeight",nil,nil,function(v)

        hipOn=v

        local _,_,hum=getChar()

        if hum then

            if v then origHip=hum.HipHeight else hum.HipHeight=origHip end

        end

    end)

    sliderRow(left,8,"HipHeight Value",0,50,2,"",function(v) hipValue=v end)



    UIS.JumpRequest:Connect(function()

        if infJumpEnabled then

            local _,_,hum=getChar()

            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end

        end

    end)



    local function stopFly()

        flying=false

        if flyConn then flyConn:Disconnect() flyConn=nil end

        if bv then bv:Destroy() bv=nil end

        if bg then bg:Destroy() bg=nil end

        local _,_,hum=getChar()

        if hum then hum.PlatformStand=false end

    end



    local function startFly()

        local _,root,hum=getChar()

        if not root or not hum or flying then return false end

        flying=true

        bv=make("BodyVelocity",{MaxForce=Vector3.new(1e6,1e6,1e6),P=15000,Velocity=Vector3.zero},root)

        bg=make("BodyGyro",{MaxTorque=Vector3.new(1e6,1e6,1e6),P=12000},root)

        hum.PlatformStand=true



        flyConn=RunService.RenderStepped:Connect(function()

            if not flying or not root.Parent then

                stopFly()

                return

            end



            local cam=workspace.CurrentCamera

            bg.CFrame=cam.CFrame

            local move=Vector3.zero



            if UIS:IsKeyDown(Enum.KeyCode.W) then move=move+cam.CFrame.LookVector end

            if UIS:IsKeyDown(Enum.KeyCode.S) then move=move-cam.CFrame.LookVector end

            if UIS:IsKeyDown(Enum.KeyCode.D) then move=move+cam.CFrame.RightVector end

            if UIS:IsKeyDown(Enum.KeyCode.A) then move=move-cam.CFrame.RightVector end

            if UIS:IsKeyDown(Enum.KeyCode.Space) then move=move+Vector3.new(0,1,0) end

            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move=move-Vector3.new(0,1,0) end



            if move.Magnitude>0 then move=move.Unit*flySpeed end

            bv.Velocity=move

        end)

        return true

    end



    local flyToggle=toggleRow(right,1,"Flight","WASD + Space / Ctrl",Enum.KeyCode.F,function(v)

        if v then

            if startFly() then

                setStatus("FLIGHT ACTIVE")

            else

                setStatus("NO CHARACTER",C.bad)

            end

        else

            stopFly()

            setStatus("FLIGHT OFF",C.sub)

        end

    end)

    sliderRow(right,2,"Fly Speed",1,500,60,"",function(v) flySpeed=v end)



    -- Vehicle Fly*

    local vehicleFlying=false

    local vehicleSpeed=100

    local vehicleVelocity,vehicleGyro,vehicleConnection

    local vehicleFlyToggle



    local function stopVehicleFly()

        vehicleFlying=false

        if vehicleConnection then vehicleConnection:Disconnect() vehicleConnection=nil end

        if vehicleVelocity then vehicleVelocity:Destroy() vehicleVelocity=nil end

        if vehicleGyro then vehicleGyro:Destroy() vehicleGyro=nil end

    end



    local function startVehicleFly()

        local _,_,hum=getChar()

        if not hum or not hum.SeatPart then return false end



        local seat=hum.SeatPart

        local root=seat.AssemblyRootPart or seat

        if not root or not root:IsA("BasePart") then return false end



        vehicleFlying=true

        vehicleVelocity=make("BodyVelocity",{

            MaxForce=Vector3.new(1e8,1e8,1e8),

            P=25000,

            Velocity=Vector3.zero

        },root)



        vehicleGyro=make("BodyGyro",{

            MaxTorque=Vector3.new(1e8,1e8,1e8),

            P=25000,

            D=1000,

            CFrame=root.CFrame

        },root)



        vehicleConnection=RunService.RenderStepped:Connect(function()

            if not vehicleFlying or not hum.Parent or hum.SeatPart~=seat or not root.Parent then

                stopVehicleFly()

                if vehicleFlyToggle then vehicleFlyToggle.Set(false,true) end

                return

            end



            local cam=workspace.CurrentCamera

            local direction=Vector3.zero

            if UIS:IsKeyDown(Enum.KeyCode.W) then direction=direction+cam.CFrame.LookVector end

            if UIS:IsKeyDown(Enum.KeyCode.S) then direction=direction-cam.CFrame.LookVector end

            if UIS:IsKeyDown(Enum.KeyCode.D) then direction=direction+cam.CFrame.RightVector end

            if UIS:IsKeyDown(Enum.KeyCode.A) then direction=direction-cam.CFrame.RightVector end

            if UIS:IsKeyDown(Enum.KeyCode.Space) then direction=direction+Vector3.new(0,1,0) end

            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then direction=direction-Vector3.new(0,1,0) end

            if direction.Magnitude>0 then direction=direction.Unit*vehicleSpeed end



            vehicleVelocity.Velocity=direction

            vehicleGyro.CFrame=cam.CFrame

        end)



        return true

    end



    vehicleFlyToggle=toggleRow(right,3,"Vehicle Fly","Sit in a vehicle | WASD + Space / Ctrl",Enum.KeyCode.G,function(v)

        if v then

            if startVehicleFly() then

                setStatus("VEHICLE FLY ACTIVE")

            else

                vehicleFlyToggle.Set(false,true)

                setStatus("SIT IN A VEHICLE FIRST",C.bad)

            end

        else

            stopVehicleFly()

            setStatus("VEHICLE FLY OFF",C.sub)

        end

    end)

    sliderRow(right,4,"Vehicle Fly Speed",10,500,100,"",function(v) vehicleSpeed=v end)



    local noclipToggle=toggleRow(right,5,"Noclip","Walk through walls",Enum.KeyCode.V,function(v)

        noclipOn=v

        setStatus(v and "NOCLIP ON" or "NOCLIP OFF")

    end)



    local clickTpOn=false

    local clickTpToggle=toggleRow(right,6,"Click Teleport","Hold Left Ctrl + click",Enum.KeyCode.T,function(v)

        clickTpOn=v

    end)



    local floatToggle

    floatToggle=toggleRow(right,7,"Air Float Platform","Q / E to move platform",nil,function(v)

        local _,root=getChar()

        if v then

            if not root then

                floatToggle.Set(false,true)

                return

            end

            floatOn=true

            floatY=root.Position.Y-3.5

            floatPart=make("Part",{

                Name="AirPlate",

                Size=Vector3.new(10,1,10),

                Anchored=true,

                Transparency=1,

                CanCollide=true,

                CFrame=CFrame.new(root.Position.X,floatY,root.Position.Z)

            },workspace)

        else

            floatOn=false

            if floatPart then floatPart:Destroy() floatPart=nil end

        end

    end)

    sliderRow(right,8,"Float Q/E Speed",1,150,40,"",function(v) floatSpeed=v end)



    RunService.Heartbeat:Connect(function(dt)

        local _,root,hum=getChar()

        if not hum then return end

        if walkEnabled then hum.WalkSpeed=walkValue end

        if jumpEnabled then

            hum.UseJumpPower=true

            hum.JumpPower=jumpValue

        end

        if hipOn then hum.HipHeight=hipValue end

        if bhopOn and not UIS:GetFocusedTextBox() and UIS:IsKeyDown(Enum.KeyCode.Space) and hum.FloorMaterial~=Enum.Material.Air then

            hum.Jump=true

        end

        if floatOn and floatPart and root and not UIS:GetFocusedTextBox() then

            if UIS:IsKeyDown(Enum.KeyCode.Q) then floatY=floatY-floatSpeed*dt end

            if UIS:IsKeyDown(Enum.KeyCode.E) then floatY=floatY+floatSpeed*dt end

            floatPart.CFrame=CFrame.new(root.Position.X,floatY,root.Position.Z)

        end

    end)



    RunService.Stepped:Connect(function()

        if not noclipOn then return end

        local char=player.Character

        if not char then return end

        for _,part in ipairs(char:GetDescendants()) do

            if part:IsA("BasePart") then part.CanCollide=false end

        end

    end)



    UIS.InputBegan:Connect(function(input,processed)

        if processed or not clickTpOn then return end

        if input.UserInputType==Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then

            local char,root=getChar()

            if root and mouse and mouse.Hit then

                mouse.TargetFilter=char

                root.CFrame=CFrame.new(mouse.Hit.Position+Vector3.new(0,3,0))

            end

        end

    end)



    -- TELEPORT*

    local tpTab=newTab("Teleport",2)

    local tpLeft=column(tpTab,0,0.5,"Select Player")

    local tpRight=column(tpTab,0.5,0.5,"Actions")

    local selectedPlayer

    local playerButtons={}



    local selectedLabel=make("TextLabel",{

        Size=UDim2.new(1,0,0,40),

        BackgroundColor3=C.row,

        Text="No player selected",

        Font=Enum.Font.GothamBold,

        TextSize=12,

        TextColor3=C.sub,

        BorderSizePixel=0,

        LayoutOrder=1

    },tpRight)

    corner(selectedLabel,9)



    local function selectPlayer(p)

        selectedPlayer=p

        selectedLabel.Text=p and ("Selected: "..p.Name) or "No player selected"

        selectedLabel.TextColor3=p and C.text or C.sub

        for pl,btn in pairs(playerButtons) do

            btn.BackgroundColor3=(pl==p) and C.ACCENT or C.row

        end

    end



    local function refreshPlayers()

        for _,btn in pairs(playerButtons) do btn:Destroy() end

        playerButtons={}

        local list={}

        for _,p in ipairs(Players:GetPlayers()) do

            if p~=player then table.insert(list,p) end

        end

        table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)



        for i,p in ipairs(list) do

            local b=make("TextButton",{

                Size=UDim2.new(1,0,0,34),

                BackgroundColor3=C.row,

                Text="   "..p.Name,

                Font=Enum.Font.GothamBold,

                TextSize=12,

                TextColor3=C.text,

                TextXAlignment=Enum.TextXAlignment.Left,

                AutoButtonColor=false,

                BorderSizePixel=0,

                LayoutOrder=i

            },tpLeft)

            corner(b,9)

            b.MouseButton1Click:Connect(function() selectPlayer(p) end)

            playerButtons[p]=b

        end



        if selectedPlayer and not playerButtons[selectedPlayer] then selectPlayer(nil) end

    end



    buttonRow(tpRight,2,"REFRESH PLAYER LIST",C.row,refreshPlayers)

    buttonRow(tpRight,3,"TELEPORT TO PLAYER",C.ACCENT,function()

        if not selectedPlayer then

            setStatus("SELECT A PLAYER FIRST",C.bad)

            return

        end

        local target=selectedPlayer.Character

        local targetRoot=target and target:FindFirstChild("HumanoidRootPart")

        local _,root=getChar()

        if targetRoot and root then

            root.CFrame=targetRoot.CFrame*CFrame.new(0,0,4)

            setStatus("TELEPORT ATTEMPTED")

        else

            setStatus("PLAYER NOT AVAILABLE",C.bad)

        end

    end)



    Players.PlayerAdded:Connect(refreshPlayers)

    Players.PlayerRemoving:Connect(function() task.defer(refreshPlayers) end)



    -- TROLL*

    local trollTab=newTab("Troll",3)

    local trollLeft=column(trollTab,0,0.5,"Self")

    local trollRight=column(trollTab,0.5,0.5,"Target Player")



    local spinOn,spinSpeed=false,20

    local shakeOn,shakeAmt=false,5

    local lowGravOn,gravValue=false,50

    local sitOn=false

    local origGravity=workspace.Gravity

    local orbitOn,orbitRadius,orbitSpeed,orbitAngle=false,10,5,0

    local headSitOn,followOn,spectateOn=false,false,false

    local followTimer=0



    toggleRow(trollLeft,1,"Spin","Spin your character",nil,function(v) spinOn=v end)

    sliderRow(trollLeft,2,"Spin Speed",1,100,20,"",function(v) spinSpeed=v end)

    toggleRow(trollLeft,3,"Shake","Vibrate your character",nil,function(v) shakeOn=v end)

    sliderRow(trollLeft,4,"Shake Intensity",1,20,5,"",function(v) shakeAmt=v end)

    toggleRow(trollLeft,5,"Low Gravity","Float like on the moon",nil,function(v)

        lowGravOn=v

        workspace.Gravity=v and gravValue or origGravity

    end)

    sliderRow(trollLeft,6,"Gravity Value",0,196,50,"",function(v)

        gravValue=v

        if lowGravOn then workspace.Gravity=v end

    end)

    toggleRow(trollLeft,7,"Force Sit","Stay seated",nil,function(v)

        sitOn=v

        if not v then

            local _,_,hum=getChar()

            if hum then hum.Sit=false end

        end

    end)



    local targetLabel=make("TextLabel",{

        Size=UDim2.new(1,0,0,40),

        BackgroundColor3=C.row,

        Text="No player selected (use Teleport tab)",

        Font=Enum.Font.GothamBold,

        TextSize=11,

        TextColor3=C.sub,

        BorderSizePixel=0,

        LayoutOrder=1

    },trollRight)

    corner(targetLabel,9)



    local function needTarget(toggle)

        if not selectedPlayer then

            toggle.Set(false,true)

            setStatus("SELECT A PLAYER FIRST",C.bad)

            return false

        end

        return true

    end



    local orbitToggle

    orbitToggle=toggleRow(trollRight,2,"Orbit Player","Circle around selected player",nil,function(v)

        if v and not needTarget(orbitToggle) then return end

        orbitOn=v

        if v then headSitOn=false end

    end)

    sliderRow(trollRight,3,"Orbit Radius",3,50,10," studs",function(v) orbitRadius=v end)

    sliderRow(trollRight,4,"Orbit Speed",1,20,5,"",function(v) orbitSpeed=v end)



    local headSitToggle

    headSitToggle=toggleRow(trollRight,5,"Head Sit","Sit on selected player's head",nil,function(v)

        if v and not needTarget(headSitToggle) then return end

        headSitOn=v

        if v then orbitToggle.Set(false) end

        if not v then

            local _,_,hum=getChar()

            if hum then hum.Sit=false end

        end

    end)



    local followToggle

    followToggle=toggleRow(trollRight,6,"Follow Player","Walk after selected player",nil,function(v)

        if v and not needTarget(followToggle) then return end

        followOn=v

    end)



    local spectateToggle

    spectateToggle=toggleRow(trollRight,7,"Spectate Player","View through their camera",nil,function(v)

        if v and not needTarget(spectateToggle) then return end

        spectateOn=v

        if not v then

            local _,_,hum=getChar()

            if hum then workspace.CurrentCamera.CameraSubject=hum end

        end

    end)



    RunService.Heartbeat:Connect(function(dt)

        targetLabel.Text=selectedPlayer and ("Target: "..selectedPlayer.Name) or "No player selected (use Teleport tab)"

        local _,root,hum=getChar()

        if not root or not hum then return end



        if spinOn then root.CFrame=root.CFrame*CFrame.Angles(0,math.rad(spinSpeed),0) end

        if shakeOn then

            local a=shakeAmt/10

            root.CFrame=root.CFrame*CFrame.new((math.random()-0.5)*a,(math.random()-0.5)*a*0.5,(math.random()-0.5)*a)

        end

        if sitOn then hum.Sit=true end



        local target=selectedPlayer and selectedPlayer.Character

        local targetRoot=target and target:FindFirstChild("HumanoidRootPart")

        local targetHum=target and target:FindFirstChildOfClass("Humanoid")



        if orbitOn and targetRoot then

            orbitAngle=orbitAngle+orbitSpeed*dt

            local center=targetRoot.Position

            local pos=center+Vector3.new(math.cos(orbitAngle)*orbitRadius,0,math.sin(orbitAngle)*orbitRadius)

            root.CFrame=CFrame.new(pos,center)

            root.AssemblyLinearVelocity=Vector3.zero

        elseif headSitOn then

            local head=target and target:FindFirstChild("Head")

            if head then

                hum.Sit=true

                root.CFrame=head.CFrame*CFrame.new(0,1.6,0)

                root.AssemblyLinearVelocity=Vector3.zero

            end

        end



        if followOn and targetRoot then

            followTimer=followTimer+dt

            if followTimer>0.2 then

                followTimer=0

                hum:MoveTo(targetRoot.Position)

            end

        end



        if spectateOn then

            if targetHum then

                workspace.CurrentCamera.CameraSubject=targetHum

            else

                spectateToggle.Set(false)

            end

        end

    end)



    -- MISC*

    local miscTab=newTab("Misc",4)

    local miscLeft=column(miscTab,0,0.5,"Utilities")

    local miscRight=column(miscTab,0.5,0.5,"Actions")



    local antiAfkOn,fullbrightOn=false,false

    local fovOn,fovValue=false,70

    local hlOn=false

    local highlights={}

    local lightingBackup={}



    toggleRow(miscLeft,1,"Anti-AFK","Prevent idle kick where supported",nil,function(v)

        antiAfkOn=v

    end)



    player.Idled:Connect(function()

        if antiAfkOn then

            pcall(function()

                local vu=game:GetService("VirtualUser")

                vu:CaptureController()

                vu:ClickButton2(Vector2.new())

            end)

        end

    end)



    toggleRow(miscLeft,2,"Fullbright","Light up dark areas",nil,function(v)

        fullbrightOn=v

        if v then

            lightingBackup={

                Brightness=Lighting.Brightness,

                ClockTime=Lighting.ClockTime,

                FogEnd=Lighting.FogEnd,

                GlobalShadows=Lighting.GlobalShadows,

                Ambient=Lighting.Ambient,

                OutdoorAmbient=Lighting.OutdoorAmbient

            }

        else

            for k,val in pairs(lightingBackup) do

                Lighting[k]=val

            end

        end

    end)



    toggleRow(miscLeft,3,"Custom FOV",nil,nil,function(v)

        fovOn=v

        if not v then workspace.CurrentCamera.FieldOfView=70 end

    end)

    sliderRow(miscLeft,4,"FOV Value",30,120,70,"",function(v) fovValue=v end)



    local function addHighlight(p)

        if p==player or not p.Character then return end

        if highlights[p] then highlights[p]:Destroy() end

        highlights[p]=make("Highlight",{

            FillColor=C.ACCENT,

            FillTransparency=0.6,

            OutlineColor=Color3.new(1,1,1),

            DepthMode=Enum.HighlightDepthMode.AlwaysOnTop

        },p.Character)

    end



    local function clearHighlights()

        for _,h in pairs(highlights) do h:Destroy() end

        highlights={}

    end



    toggleRow(miscLeft,5,"Player Highlights","Highlight other players",nil,function(v)

        hlOn=v

        if v then

            for _,p in ipairs(Players:GetPlayers()) do addHighlight(p) end

        else

            clearHighlights()

        end

    end)



    Players.PlayerAdded:Connect(function(p)

        p.CharacterAdded:Connect(function()

            if hlOn then task.wait(0.5) addHighlight(p) end

        end)

    end)



    buttonRow(miscRight,1,"COPY MY POSITION",C.row,function()

        local _,root=getChar()

        if not root then return end

        local p=root.Position

        local txt=string.format("Vector3.new(%.1f, %.1f, %.1f)",p.X,p.Y,p.Z)

        if setclipboard then

            pcall(setclipboard,txt)

            setStatus("POSITION COPIED")

        else

            print(txt)

            setStatus("POSITION PRINTED TO CONSOLE",C.sub)

        end

    end)



    buttonRow(miscRight,2,"RESET CHARACTER",C.row,function()

        local _,_,hum=getChar()

        if hum then

            hum.Health=0

            setStatus("CHARACTER RESET")

        end

    end)



    buttonRow(miscRight,3,"REJOIN SERVER",C.row,function()

        setStatus("REJOINING...",C.sub)

        pcall(function()

            TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,player)

        end)

    end)



    -- SETTINGS*

    local settingsTab=newTab("Settings",5)

    local settingsLeft=column(settingsTab,0,0.5,"CUSTOMIZE COLOURS")

    local settingsRight=column(settingsTab,0.5,0.5,"APPEARANCE")



    local function toHex(color)

        return string.format("#%02X%02X%02X",

            math.floor(color.R*255+0.5),

            math.floor(color.G*255+0.5),

            math.floor(color.B*255+0.5))

    end



    local function parseHex(value)

        value=value:gsub("#","")

        if #value~=6 or not value:match("^%x%x%x%x%x%x$") then return nil end

        local r=tonumber(value:sub(1,2),16)

        local g=tonumber(value:sub(3,4),16)

        local b=tonumber(value:sub(5,6),16)

        return Color3.fromRGB(r,g,b)

    end



    local function applyThemeColor(key,newColor)

        local oldColor=C[key]

        C[key]=newColor



        for _,obj in ipairs(gui:GetDescendants()) do

            pcall(function()

                if obj:IsA("GuiObject") and obj.BackgroundColor3==oldColor then

                    obj.BackgroundColor3=newColor

                end

                if (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) and obj.TextColor3==oldColor then

                    obj.TextColor3=newColor

                end

                if obj:IsA("UIStroke") and obj.Color==oldColor then

                    obj.Color=newColor

                end

                if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then

                    if obj.ImageColor3==oldColor then obj.ImageColor3=newColor end

                end

            end)

        end



        logo.BackgroundColor3=C.ACCENT

        logoGradient.Color=ColorSequence.new(C.ACCENT,Color3.fromRGB(157,116,190))

        setStatus("UPDATED "..key:upper().." COLOUR")

    end



    local colorNames={

        "bg","side","row","rowHover","text","sub",

        "ACCENT","off","good","bad","stroke","chip"

    }



    for i,key in ipairs(colorNames) do

        local row=make("Frame",{

            Size=UDim2.new(1,0,0,44),

            BackgroundColor3=C.row,

            BorderSizePixel=0,

            LayoutOrder=i

        },settingsLeft)

        corner(row,8)



        make("TextLabel",{

            Size=UDim2.new(0.42,0,1,0),

            Position=UDim2.fromOffset(10,0),

            BackgroundTransparency=1,

            Text=key,

            Font=Enum.Font.GothamBold,

            TextSize=11,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Left

        },row)



        local input=make("TextBox",{

            Size=UDim2.new(0.52,0,0,28),

            Position=UDim2.new(0.45,0,0.5,-14),

            BackgroundColor3=C.chip,

            Text=toHex(C[key]),

            Font=Enum.Font.GothamBold,

            TextSize=11,

            TextColor3=C.text,

            ClearTextOnFocus=false,

            BorderSizePixel=0

        },row)

        corner(input,6)



        input.FocusLost:Connect(function()

            local color=parseHex(input.Text)

            if color then

                applyThemeColor(key,color)

                input.Text=toHex(color)

            else

                input.Text=toHex(C[key])

                setStatus("INVALID HEX COLOUR",C.bad)

            end

        end)

    end



    buttonRow(settingsLeft,20,"RESET ALL COLOURS",C.ACCENT,function()

        for key,color in pairs(Defaults) do

            applyThemeColor(key,color)

        end

        for _,obj in ipairs(settingsLeft:GetDescendants()) do

            if obj:IsA("TextBox") then

                local key=obj.Parent:FindFirstChildWhichIsA("TextLabel")

                if key and C[key.Text] then obj.Text=toHex(C[key.Text]) end

            end

        end

        setStatus("DEFAULT COLOURS RESTORED")

    end)



    buttonRow(settingsLeft,21,"PINK THEME",C.row,function()

        local theme={

            ACCENT=Color3.fromRGB(255,85,160),

            bg=Color3.fromRGB(24,12,25),

            side=Color3.fromRGB(24,12,25),

            row=Color3.fromRGB(48,25,48),

            rowHover=Color3.fromRGB(65,32,62)

        }

        for k,v in pairs(theme) do applyThemeColor(k,v) end

    end)



    buttonRow(settingsLeft,22,"BLUE THEME",C.row,function()

        local theme={

            ACCENT=Color3.fromRGB(65,155,255),

            bg=Color3.fromRGB(10,18,30),

            side=Color3.fromRGB(10,18,30),

            row=Color3.fromRGB(20,35,55),

            rowHover=Color3.fromRGB(30,50,75)

        }

        for k,v in pairs(theme) do applyThemeColor(k,v) end

    end)



    buttonRow(settingsLeft,23,"PURPLE THEME",C.row,function()

        local theme={

            ACCENT=Color3.fromRGB(165,100,255),

            bg=Color3.fromRGB(18,13,29),

            side=Color3.fromRGB(18,13,29),

            row=Color3.fromRGB(34,25,52),

            rowHover=Color3.fromRGB(48,34,72)

        }

        for k,v in pairs(theme) do applyThemeColor(k,v) end

    end)



    local transparency=0

    sliderRow(settingsRight,1,"Window Transparency",0,50,0,"%",function(v)

        transparency=v/100

        window.BackgroundTransparency=transparency

    end)



    sliderRow(settingsRight,2,"UI Scale",50,125,100,"%",function(v)

        baseScale=v/100

        scale.Scale=baseScale

    end)



    buttonRow(settingsRight,3,"RESET APPEARANCE",C.row,function()

        window.BackgroundTransparency=0

        transparency=0

        baseScale=1

        scale.Scale=baseScale

        setStatus("APPEARANCE RESET")

    end)



    buttonRow(settingsRight,4,"HIDE KEYBINDS PANEL",C.row,function()

        local panel=gui:FindFirstChild("Keybinds")

        if panel then panel.Visible=not panel.Visible end

    end)



    buttonRow(settingsRight,5,"UNLOAD SCRIPT",C.ACCENT,function()

        for _,t in ipairs(allToggles) do

            if t.state then

                pcall(function() t.Set(false) end)

            end

        end

        stopFly()

        stopVehicleFly()

        workspace.Gravity=origGravity

        clearHighlights()

        gui:Destroy()

    end)



    -- ACTIVE KEYBINDS PANEL*

    local panelEntries={

        {"WalkSpeed","B",walkToggle},

        {"JumpPower","N",nil},

        {"Infinite Jump","J",infJumpToggle},

        {"Flight","F",flyToggle},

        {"Vehicle Fly","G",vehicleFlyToggle},

        {"Noclip","V",noclipToggle},

        {"Click Teleport","T",clickTpToggle}

    }



    local PANEL_H=44+(#panelEntries+1)*32+6

    local panel=make("Frame",{

        Name="Keybinds",

        Size=UDim2.fromOffset(220,PANEL_H),

        AnchorPoint=Vector2.new(1,0.5),

        Position=UDim2.new(1,-16,0.5,0),

        BackgroundColor3=C.bg,

        BorderSizePixel=0

    },gui)

    corner(panel,12)

    outline(panel)



    make("TextLabel",{

        Size=UDim2.new(1,-60,0,32),

        Position=UDim2.fromOffset(14,2),

        BackgroundTransparency=1,

        Text="Active Keybinds",

        Font=Enum.Font.GothamBold,

        TextSize=12,

        TextColor3=C.text,

        TextXAlignment=Enum.TextXAlignment.Left

    },panel)



    local function keyRow(index,name,keyName,toggleObj)

        local r=make("Frame",{

            Size=UDim2.new(1,-16,0,28),

            Position=UDim2.fromOffset(8,38+(index-1)*32),

            BackgroundColor3=C.row,

            BorderSizePixel=0

        },panel)

        corner(r,7)



        make("TextLabel",{

            Size=UDim2.new(1,-100,1,0),

            Position=UDim2.fromOffset(10,0),

            BackgroundTransparency=1,

            Text=name,

            Font=Enum.Font.Gotham,

            TextSize=11,

            TextColor3=C.text,

            TextXAlignment=Enum.TextXAlignment.Left

        },r)



        make("TextLabel",{

            Size=UDim2.fromOffset(28,18),

            Position=UDim2.new(1,-36,0.5,-9),

            BackgroundColor3=C.chip,

            Text=keyName,

            Font=Enum.Font.GothamBold,

            TextSize=9,

            TextColor3=C.sub,

            BorderSizePixel=0

        },r)

    end



    keyRow(1,"Toggle UI Key","RS",nil)

    for i,e in ipairs(panelEntries) do

        keyRow(i+1,e[1],e[2],e[3])

    end



    -- MENU CONTROLS*

    local isOpen=true

    local minimized=false

    local animToken=0



    local function setOpen(v)

        if isOpen==v then return end

        isOpen=v

        animToken=animToken+1

        local token=animToken



        if v then

            window.Visible=true

            panel.Visible=not minimized

            scale.Scale=baseScale*0.92

            TweenService:Create(scale,TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{

                Scale=baseScale

            }):Play()

        else

            tween(scale,0.15,{Scale=baseScale*0.92})

            panel.Visible=false

            task.delay(0.15,function()

                if animToken==token then window.Visible=false end

            end)

        end

    end



    local function setMinimized(v)

        minimized=v

        content.Visible=not v

        sidebar.Visible=not v

        status.Visible=not v

        panel.Visible=(not v) and isOpen

        tween(window,0.2,{

            Size=v and UDim2.fromOffset(WIN_W,64) or UDim2.fromOffset(WIN_W,WIN_H)

        })

    end



    minBtn.MouseButton1Click:Connect(function()

        setMinimized(not minimized)

    end)



    closeBtn.MouseButton1Click:Connect(function()

        setOpen(false)

    end)



    UIS.InputBegan:Connect(function(input,processed)

        if input.KeyCode==Enum.KeyCode.RightShift then

            setOpen(not isOpen)

            return

        end

        if processed then return end

        local obj=binds[input.KeyCode]

        if obj then obj.Toggle() end

    end)



    player.CharacterAdded:Connect(function()

        stopFly()

        stopVehicleFly()

        flyToggle.Set(false,true)

        vehicleFlyToggle.Set(false,true)

        if floatOn then floatToggle.Set(false) end

        if hipOn then

            task.wait(0.5)

            local _,_,hum=getChar()

            if hum then origHip=hum.HipHeight end

        end

    end)



    RunService.RenderStepped:Connect(function()

        if fullbrightOn then

            Lighting.Brightness=2

            Lighting.ClockTime=14

            Lighting.FogEnd=1000000

            Lighting.GlobalShadows=false

            Lighting.Ambient=Color3.fromRGB(190,190,190)

            Lighting.OutdoorAmbient=Color3.fromRGB(190,190,190)

        end

        if fovOn then

            workspace.CurrentCamera.FieldOfView=fovValue

        end

    end)



    showPage("Movement")

    refreshPlayers()

    setStatus("READY | RIGHT SHIFT: MENU")

    notify("V6.2 Loaded!")

    print("ADRIN'S SCRIPTS V6.2 LOADED")

    print("RIGHT SHIFT = MENU | B = SPEED | N = JUMP | J = INF JUMP | F = FLY | G = VEHICLE FLY")

end



local ok,err=pcall(Main)

if not ok then

    warn("[Adrin's Scripts] Failed to load: "..tostring(err))

    pcall(function()

        local player=game:GetService("Players").LocalPlayer

        local gui=Instance.new("ScreenGui")

        gui.Name="AdrinsScriptsError"

        gui.ResetOnSpawn=false

        gui.Parent=player:WaitForChild("PlayerGui")



        local box=Instance.new("TextButton")

        box.Size=UDim2.fromOffset(560,160)

        box.AnchorPoint=Vector2.new(0.5,0.5)

        box.Position=UDim2.fromScale(0.5,0.5)

        box.BackgroundColor3=Color3.fromRGB(34,12,18)

        box.TextColor3=Color3.new(1,1,1)

        box.TextWrapped=true

        box.TextSize=14

        box.Font=Enum.Font.Gotham

        box.Text="Adrin's Scripts failed to load:\n\n"..tostring(err).."\n\nClick to close"

        box.Parent=gui

        box.MouseButton1Click:Connect(function()

            gui:Destroy()

        end)

    end)

end
