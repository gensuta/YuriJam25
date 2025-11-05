extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.current_animation = "idle"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.current_animation = "fly"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.current_animation = "walk"
		#$Sprite2D.flip_h = -direction;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.current_animation = "idle"

	move_and_slide()
