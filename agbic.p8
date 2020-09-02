pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
 vx=0
 vy=0
 x=60
 y=60
 fric=.005
 steer_angle=.25
 angle=.25
 max_speed=1.5
end

function _update60()
 turn_car()
 move_car()
end


function _draw()
 cls(5)
 draw_bricks()
 camera(x-64,y-64)
 circfill(x,y,2,8)
 line(x,y,x+10*cos(angle),y+10*sin(angle))
 print(x.." "..y,x-62,y-62)
end

function turn_car()
 mag=sqrt(vx^2+vy^2)
 if abs(vx)>0 or abs(vy)>0 then
  if btn(0) then
   angle+=.01*(-(.5/max_speed)*mag+1)
  end
  if btn(1) then
   angle-=.01*(-(.5/max_speed)*mag+1)
  end
 end
 angle=angle%1
 vy=mag*sin(angle)
 vx=mag*cos(angle)
end

function move_car()
 if btn(5) and mag<max_speed then
  vx+=.02*cos(angle)
  vy+=.02*sin(angle)
 end
 if btn(4) and mag>0 then
  vx-=.005*cos(angle)
  vy-=.005*sin(angle)
 end
 vx=vx*(1-fric)
 vy=vy*(1-fric)
 x+=vx
 y+=vy
end


function draw_bricks()
 for i=0,12 do
  for j=0,12 do
   spr(j%2+1,8*i,8*j)
  end
 end
end
__gfx__
00000000440440440440440400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700044044044044044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000404404404404404400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000440440440440440400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
