extends StaticBody2D

##################################################
var sprite_node: Sprite2D
var area_node: Area2D
# 충돌 영역으로 사용
var is_in: bool = false
# 닭이 나무 영역에 들어왔는지 여부를 판단하는 플래그
var alpha_value: float = 1.0
# 나무 투명도 조절 값


##################################################
func _ready() -> void:
	sprite_node = $Sprite2D
	area_node = $Area2D
	# 각 노드 가져오기
	
	area_node.connect("body_entered", Callable(self, "_on_body_entered"))
	area_node.connect("body_exited", Callable(self, "_on_body_exited"))
	# Area2D의 신호(body_entered, body_exited)를 연결

	z_index = global_position.y
	# 나무 오브젝트의 z_index를 y 위치로 설정 (깊이 조정)

##################################################
func _process(delta: float) -> void:	
	if is_in:
		alpha_value = clampf(alpha_value - delta, 0.5, 1.0)
	else:
		alpha_value = clampf(alpha_value + delta, 0.5, 1.0)
	# 플레이어가 나무에 가까이 있으면 나무를 반투명하게 처리
	
	sprite_node.modulate.a = alpha_value
	# 투명도 값 적용

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Chicken"):
		is_in = true
	# 나무 영역에 들어온 객체가 "Chicken" 그룹에 속하면 플래그 설정

##################################################
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Chicken"):
		is_in = false
	# 나무 영역을 나간 객체가 "Chicken" 그룹에 속하면 플래그 해제
