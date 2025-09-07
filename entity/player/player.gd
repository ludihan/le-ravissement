extends CharacterBody3D

const CAMERA_SPEED := 0.005
const WALK_SPEED := 100

@onready var camera_3d: Camera3D = $Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_movement: Vector2 = event.relative
		rotation.y -= mouse_movement.x * CAMERA_SPEED
		camera_3d.rotation.x = clamp(
			camera_3d.rotation.x - mouse_movement.y * CAMERA_SPEED,
			deg_to_rad(-30.0), deg_to_rad(30.0)
		)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		
	var input = Input.get_vector("left", "right", "forward", "backward")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * WALK_SPEED * delta
	velocity.z = movement_dir.z * WALK_SPEED * delta
	move_and_slide()
