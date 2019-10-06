timer++

fleshPercentage = (fleshCurrent/fleshRequired[flesh])*100 


if fleshPercentage > 100 {
	flesh++
	fleshCurrent = 0 
}

parentsTotal = (parent_percentage[flesh]/100)*max_units[flesh]

if timer > spawn_time and units < max_units[flesh] {
			var _whichCorner = irandom_range(0,3)
			var _5050 = irandom_range(0,1)
			var spawnX = 0
			var spawnY = 0
			
			//Choose which corner this squad will spawn in 
			switch(_whichCorner) 
			{
				case 0:											//	Bottom Right
					if _5050 == 0 {
						spawnX = room_width-64
						spawnY = irandom_range(y,room_height-64)
					} else {
						spawnX = irandom_range(x,room_width-64)	
						spawnY = room_height-64
					}
				break;
			  	case 1:											//	Top Right
					if _5050 == 0 {
						spawnX = room_width-64
						spawnY = irandom_range(y,0)
					} else {
						spawnX = irandom_range(x,room_width-64)
						spawnY = 64
					}	
				break;
			  	case 2:											//	Bottom Left
					if _5050 == 0 {
						spawnX = 64
						spawnY = irandom_range(y,room_height-64)
					} else {
						spawnX = irandom_range(0,x)
						spawnY = room_height-64
					}
				break;
			  	case 3:											//	Top Left
					if _5050 == 0 {
						spawnX = 64
						spawnY = irandom_range(0,y)
					} else {
						spawnX = irandom_range(0,x)
						spawnY = room_height-64
					}
				break;
			}
				
	timer = 0
	units++
	var kid_controller = instance_create_layer(spawnX,spawnY,"Instances",kidController)
	var kid0 = instance_create_layer(spawnX,spawnY,"Instances",kid)
	var kid1 = instance_create_layer(spawnX,spawnY,"Instances",kid)
	var kid2 = instance_create_layer(spawnX,spawnY,"Instances",kid)
	kid_controller.spawner = id
	kid0.controller = kid_controller
	kid0.line_pos = 0
	kid_controller.line_list[| 0] = kid0
	kid1.controller = kid_controller
	kid1.line_pos = 1
	kid_controller.line_list[| 1] = kid1
	kid2.controller = kid_controller
	kid2.line_pos = 2
	kid_controller.line_list[| 2] = kid2
	if parents < parentsTotal {
		kid_controller.parent_do_i_have_one = true
		var _parent = instance_create_layer(spawnX,spawnY,"Instances",parent)
		kid_controller.line_list[| ds_list_size(kid_controller.line_list)] = _parent
		_parent.controller = kid_controller
		_parent.line_pos = ds_list_size(kid_controller.line_list)-1
	}	
}	