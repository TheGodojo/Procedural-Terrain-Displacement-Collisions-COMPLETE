extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var terrain = get_parent().get_node("Terrain")

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(terrain.global_transform.origin,Vector3.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
