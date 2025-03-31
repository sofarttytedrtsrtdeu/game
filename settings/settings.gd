extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	



func _on_check_box_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)


func _on_выход_pressed():
	get_tree().change_scene_to_file("res://меню.tscn")
