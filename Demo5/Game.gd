extends Node2D

# export使变量能在属性窗口中显示和设置值
export(float) var speed = 1
onready var player = $Player
onready var sprite = $Player/Sprite
onready var animationPlayer = $Player/AnimationPlayer

# 在这里不使用_process(delta)方法处理物理引擎，
# 而应该使用_physics_process(delta)方法进行处理
func _physics_process(delta):
	var velocity = Vector2()
	var isMoving = false
	
	if Input.is_action_pressed('ui_left'):
		velocity.x += -1
		sprite.flip_h = true
		isMoving = true
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		sprite.flip_h = false
		isMoving = true
	if Input.is_action_pressed('ui_up'):
		velocity.y += -1
		isMoving = true
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		isMoving = true
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# 关键代码：移动并测试碰撞体，参数为玩家的移动速度
		player.move_and_collide(velocity)
	
	if isMoving and animationPlayer.current_animation != 'run':
		animationPlayer.current_animation = 'run'
	elif ! isMoving and animationPlayer.current_animation != 'idle':
		animationPlayer.current_animation = 'idle'
