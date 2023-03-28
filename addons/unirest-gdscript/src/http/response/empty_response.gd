class_name EmptyResponse extends RefCounted

var props: Dictionary

var headers: Dictionary
var status: HTTPClient.ResponseCode
var error: UnirestError = null

func _init(headers: PackedStringArray, status: int, code: int, raw_body: PackedByteArray, props: Dictionary = {}) -> void:
	self.props = props
	if code > 0:
		error = UnirestError.new(
			{type = "HttpClient error", code = code}, 
			"HttpClient error is %s" % code
		)
	else:
		self.headers = UniOperations.dictionary_to_headers(headers)
		self.status = status
		if (status in [300, 500]):
			error = UnirestError.new(
				{status = status}, 
				"HTTP Status Code is %s" % status, raw_body.get_string_from_utf8()
			)

func get_headers() -> Dictionary:
	return headers

func get_status() -> HTTPClient.ResponseCode:
	return status

func _to_string() -> String:
	return get_meta("log_format", "").format({
		host = UniOperations.resolve_host(get_meta("host")),
		date = Time.get_datetime_string_from_system(),
		headers = self.headers,
		status = self.status,
		ttr = get_meta("ttr", "?")
	})
