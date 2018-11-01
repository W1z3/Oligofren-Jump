uses graphABC;
type
  point = record
    x, y: integer;
  end;

var
  oligofren, background, platform: picture;
  Left, Right, x, y, i, h: integer;
  vx, vy: real;
  platforms: array [1..20] of point;
  game, active, settings: boolean;

procedure KeyDown(Key: integer);
begin
  if Key = vk_a then Left := 1;
  if Key = vk_d then Right := 1;
  if key = vk_Escape then game := false;
  if key = vk_Escape then settings := false;
end;

procedure KeyUp(Key: integer);
begin
  if Key = vk_a then Left := 0;
  if Key = vk_d then Right := 0;
end;

procedure MouseUp(x, y, mb: integer);
begin
  if (mb = 1) and (x > 150) and (x < 380) and (y > 133) and (y < 200) then game := true;
  if (mb = 1) and (x > 150) and (x < 380) and (y > 230) and (y < 290) then settings := true;
  if (mb = 1) and (x > 150) and (x < 380) and (y > 300) and (y < 340) then active := false;
  
end;

begin
  window.Caption := 'Oligofren Jump v1.1';
  SetWindowSize(532, 850);
  window.IsFixedSize := true;
  LockDrawing;
  OnKeyDown := KeyDown;
  OnKeyUp := KeyUp;
  OnMouseUp := MouseUp;
  oligofren := picture.Create('data\oligofren.png');
  background := picture.Create('data\background.png');
  platform := picture.Create('data\platform.png');
  active := true;
  game := false;
  while active do
  begin
    ClearWindow;
    x := 266;y := 400;h := 425;
    for i := 1 to 20 do
    begin
      platforms[i].x := random(532);
      platforms[i].y := random(850);
    end;
    SetPenColor(clBlack);
    SetFontColor(clBlue);
    SetBrushColor(clTransparent);
    TextOut(175, 10, 'Oligofren Jump');
    Line(10, 50, 520, 50);
    SetPenColor(clRed);
    SetBrushColor(clYellowGreen);
    setfontsize(20);
    Rectangle(150, 133, 380, 200);
    TextOut(220, 150, 'Играть');
    
    Rectangle(150, 230, 380, 290);
    TextOut(194, 245, 'Настройки');
    
    Rectangle(150, 300, 380, 340);
    TextOut(222, 304, 'Выход');
    
    SetBrushColor(clTransparent);
    TextOut(1, 820, '© Wize');
    Redraw;
    
    while settings do
    begin
      ClearWindow;
      SetPenColor(clBlack);
      SetFontColor(clBlue);
      SetBrushColor(clTransparent);
      TextOut(150, 10, 'Oligofren Jump v1.1');
      Line(10, 50, 520, 50);
      SetBrushColor(clTransparent);
      TextOut(120, 815, 'Neeviebizm GameWorks');
      SetFontColor(clBlue);TextOut(10, 60, 'Ваше имя: ');SetFontColor(clBlack);TextOut(150, 60, 'Bitch Ass Nigga');
      SetFontColor(clBlue);TextOut(10, 120, 'Ваш олигофрен: ');SetFontColor(clBlack);TextOut(220, 120, 'Обыкновенный');picture.create('data/oligofren.png');oligofren.draw(440, 75);
      SetFontColor(clBlue);TextOut(10, 180, 'Разрешение: ');SetFontColor(clBlack);TextOut(178, 180, '8K 120FPS');
      SetFontColor(clBlue);TextOut(10, 240, 'Звуки: ');SetFontColor(clBlack);TextOut(95, 240, 'Выкл.');
      SetFontColor(clBlue);TextOut(10, 300, 'Вы просрали времени: ');SetFontColor(clBlack);TextOut(305, 300, (Milliseconds / 1000));
      SetFontColor(clBlue);TextOut(10, 360, 'Счетчик FPS:');SetFontColor(clBlack);TextOut(185, 360, 'Вкл.');
      Redraw;
      
    end;
    
    while game do
    begin
      background.Draw(0, 0);
      for i := 1 to 20 do platform.Draw(platforms[i].x, platforms[i].y);
      oligofren.Draw(x, y);
      if Left = 1 then x := x - 3;
      if Right = 1 then x := x + 3;
      vy := vy + 0.1;
      y := y + round(vy);
      for i := 1 to 20 do
        if (x + 51 > platforms[i].x) and
        (x + 5 < platforms[i].x + 56) and
        (y + 56 > platforms[i].y) and
        (y + 56 < platforms[i].y + 14) and (vy > 0) then 
          vy := -7;
      if y < h then
      begin
        for i := 1 to 20 do
        begin
          y := h; 
          platforms[i].y := platforms[i].y - round(vy);
          if (platforms[i].y > 850) then
          begin
            platforms[i].y := 0;
            platforms[i].x := random(532);
          end;
        end;
        
        
      end;
      Redraw;
    end;
  end;
  Halt;
end.