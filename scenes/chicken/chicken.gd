extends CharacterBody2D

##################################################
enum STATE {
	IDLE,
	RUN,
}

##################################################
const MOVING_SPEED: float = 50.0

var state: STATE = STATE.IDLE
var is_left: bool = false
var anim_node: AnimatedSprite2D

##################################################
func _ready() -> void:
	anim_node = $AnimatedSprite2D
	
	add_to_group("Chicken")
	# 그룹에 추가 ("Chicken" 그룹에 속함)

##################################################
func _physics_process(delta: float) -> void:
	var direction_x: float = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * MOVING_SPEED
		if direction_x > 0:
			is_left = false
		else:
			is_left = true
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)
	
	var direction_y: float = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * MOVING_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, MOVING_SPEED)
	
	if velocity.x or velocity.y:
		state = STATE.RUN
	else:
		state = STATE.IDLE
	
	set_state(state)
	move_and_slide()

##################################################
func _process(delta: float) -> void:
	z_index = global_position.y
	# 치킨의 z_index를 y 위치로 설정 (깊이 조정)

##################################################
func set_state(state_value: STATE) -> void:
	match state_value:
		STATE.IDLE:
			anim_node.play("idle")
		STATE.RUN:
			anim_node.play("run")
	
	anim_node.flip_h = not is_left
