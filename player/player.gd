extends CharacterBody2D

enum {
	Атака,
	Атака2,
	бег,
	кувырок,
	прыжок,
	стоит
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var health = 100
var gold = 0
var state = стоит
var combo = false


func _physics_process(delta):
	match state: 
		бег:
			pass
		Атака:
			attack_state()
		Атака2:
			attack2_state()
		кувырок:
			somersault_state()
		прыжок:
			pass
		стоит:
			move_state()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Прыжок") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("падает с высоты")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	if velocity.y > 0:
		anim.play("падает с высоты")
		
	if health <= 0: 
		health = 0
		anim.play("умер")
		await anim.animation_finished
		queue_free()
		get_tree().change_scene_to_file("res://меню.tscn")
	move_and_slide()

func move_state():
	var direction = Input.get_axis("Влево", "Вправо")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("бег")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Стоит")
			
		
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	elif direction: 
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_just_pressed("Атака"):
		state = Атака
		
	if Input.is_action_just_pressed("Атака 2"):
		state = Атака2
		
	if Input.is_action_just_pressed("Кувырок"):
		state = кувырок
		
func somersault_state():
	anim.play("кувырок")
	await anim.animation_finished
	state = стоит
	
func attack_state():
	if Input.is_action_just_pressed("Атака") and combo == true:
		state = Атака2
	velocity.x = 0
	anim.play("Атака")
	
func attack2_state():
	velocity.x = 0
	anim.play("Атака 2")
	
func combo1():
	combo = true
	await anim.animation_finished
	combo = false

	func _on_animated_sprite_2d_animation_finished() -> void:
		if anim.animation == "Атака":
			state = стоит
		if anim.animation == "Атака2":
			state = стоит
