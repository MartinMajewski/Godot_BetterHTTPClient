class_name HttpProxy extends Resource

@export var host: String = ""
@export var port: int = -1
@export var username: String = ""
@export var password: String = ""

func _init(
	host: String = "",
	port: int = -1,
	username: String = "",
	password: String = ""
) -> void:
	self.host = host
	self.port = port
	self.username = username
	self.password = password
