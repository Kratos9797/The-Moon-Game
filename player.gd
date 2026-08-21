extends CharacterBody3D
#ONREADY VARIABLES
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
#TESTING VARIABLES
var gravity :=9.8
#PLAYER STATS
var SPEED :=6.7
var STAMINA : float
var JUMP :=6
#MOVEMENT VARIABLES
var SENSITIVITY :=0.005
var input_dir
var direction
#NOTE:Delta is taken instead of time
#CAPTURING MOUSE
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
'''WHen an input which the game does not respond to is given ,we check if its mouse
If its mouse then by how much ever the mouse moves the head and under it the camera moves'''
func _unhandled_input(event):
	if event is InputEventMouse:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y*SENSITIVITY)
		camera.rotation.x= clamp(camera.rotation.x,deg_to_rad(-50),deg_to_rad(60))
		
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		#Using Galileo's equation v=u+at
		velocity.y -=gravity*delta
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y =JUMP - gravity*delta
	input_dir = Input.get_vector("Left ","Right","Forward","Backward")
	direction = (head.transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x*SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x=0
		velocity.z = 0
	move_and_slide()
		
