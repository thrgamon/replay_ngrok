require 'json'

NGROK_ENDPOINT = 'localhost:4040'
LAST_NGROK_REQUEST = "-s http://#{NGROK_SERVER_LOCATION}/api/requests/http?limit=1"
REPLAY_REQUEST = "-s -H 'Content-Type: application/json' -d '{\"id\": \"%<request_id>s\"}' http://#{NGROK_SERVER_LOCATION}/api/requests/http"

last_request = `curl #{LAST_NGROK_REQUEST}`

request_id = JSON.parse(last_request)["requests"][0]["id"]

request_url = format(REPLAY_REQUEST, request_id: request_id)

system("curl #{request_url}")
