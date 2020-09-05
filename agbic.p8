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
 lap=1
 boost=2
 angels={}
 for i=1,1 do
  _angel_x=flr(rnd(127))
  _angel_y=flr(rnd(127))
  add(angels, {_angel_x,_angel_y})
 end
end

function _update60()
 turn_car()
 move_car()
 move_angels()
end


function _draw()
 cls(5)
// draw_bricks()
 map(0,0,0,0,17,9)
// draw_angels()
 camera(x-64,y-64)
 circfill(x,y,2,8)
 line(x,y,x+10*cos(angle),y+10*sin(angle))
 print(x.." "..y,x-62,y-62)
 print(fget(mget(x/8,y/8)),x-62,y-50)
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


function solid(_x,_y,_sflag)
 val=mget(_x/8,_y/8)
 return fget(val, _sflag) 
end


function solid_area(_x,_y,_w,_h,_sflag)
 return 
  solid(_x-_w,_y-_h,_sflag) or
  solid(_x+_w,_y-_h,_sflag) or
  solid(_x-_w,_y+_h,_sflag) or
  solid(_x+_w,_y+_h,_sflag)
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
 if solid_area(x+vx,y+vy,2,2,0) then
  vx*=boost
  vy*=boost
 end
 if not solid_area(x+vx,y,2,2,3) then
  x+=vx
 else
  vx*=-.001
 end
 if not solid_area(x,y+vy,2,2,3) then
 	y+=vy
 else 
  vy*=-.001
 end
 //angle=atan2(vx,vy)
 
end


function draw_bricks()
 for i=0,12 do
  for j=0,12 do
   spr(j%2+1,8*i,8*j)
  end
 end
end



function draw_angels()
 for angel in all(angels) do
  if angel[1]>x then
   spr(17,angel[1],angel[2])
  else
   spr(18,angel[1],angel[2])
  end
  spr(21,angel[1],angel[2],1,2)
 end
end

function move_angels()
 for angel in all(angels) do
  if angel[1]>x then
  	angel[1]-=1
  else
   angel[1]+=1
  end
  if angel[2]>y then
   angel[2]-=1
  else
   angel[2]+=1
  end
 end
end
  
  
__gfx__
00000000440440440440440477887788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000077887788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700044044044044044088778877000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000088778877000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000404404404404404477887788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000077887788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000440440440440440488778877000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000088778877000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aa0000aaaa0000aaaa0000aaaa0000aa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000776666777766667777666677776666770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077da770077ad770077aa770077aa7701000000100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077aa700077aa700077da700077ad7000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007667000076670000766700007667000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077667700776677007766770077667700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000776666777766667777666677776666770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000766006677660066776600667766006670001100000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000001110011100000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0008080100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000030000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000030000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000101010101010101010101000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000101010101010101010101000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000101010101010101010101000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
