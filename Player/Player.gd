extends KinematicBody

export(float) var look_sensitivity = 0.5
var vertical_look_limit = 90

export(int) var speed = 10
var horizontal_velocity = Vector3.ZERO
export(int) var acceleration = 3

var gravity = -9.81
var vertical_velocity = Vector3.ZERO
export(int) var jump_strength = 10

onready var head = $Head


func _input(event):
	if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x)*look_sensitivity)
		head.rotate_x(deg2rad(-event.relative.y)*look_sensitivity)
		head.rotation_degrees.x = clamp(
			head.rotation_degrees.x,
			-vertical_look_limit,
			vertical_look_limit
		)


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)
		
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"): direction -= global_transform.basis.z
	if Input.is_action_pressed("move_backward"): direction += global_transform.basis.z
	if Input.is_action_pressed("move_left"): direction -= global_transform.basis.x
	if Input.is_action_pressed("move_right"): direction += global_transform.basis.x
	horizontal_velocity = horizontal_velocity.linear_interpolate(speed*direction.normalized(),delta*acceleration)
	
	if is_on_floor(): vertical_velocity.y = jump_strength if Input.is_action_just_pressed("jump") else 0
	else: vertical_velocity.y += gravity * delta
	
	var velocity = horizontal_velocity + vertical_velocity
	move_and_slide(velocity,Vector3.UP)
