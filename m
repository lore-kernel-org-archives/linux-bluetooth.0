Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/7] android/gatt: Use common struct for client and server applications
Date: Mon, 28 Apr 2014 15:32:00 +0200
Message-Id: <1398691926-1777-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to handle client and server connection using the same
connection logic.
---
 android/gatt.c | 165 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 89 insertions(+), 76 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a7b8659..2e4bb8c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -70,15 +70,19 @@ static const char const *device_state_str[] = {
 	"CONNECTED",
 };
 
-struct gatt_client {
-	int32_t id;
-	uint8_t uuid[16];
-	struct queue *notifications;
-};
+typedef enum {
+	APP_CLIENT,
+	APP_SERVER,
+} gatt_app_type_t;
 
-struct gatt_server {
+struct gatt_app {
 	int32_t id;
 	uint8_t uuid[16];
+
+	gatt_app_type_t type;
+
+	/* Valid for client applications */
+	struct queue *notifications;
 };
 
 struct element_id {
@@ -138,7 +142,7 @@ struct gatt_device {
 
 struct connection {
 	struct gatt_device *device;
-	struct gatt_client *client;
+	struct gatt_app *app;
 	int32_t id;
 };
 
@@ -244,7 +248,7 @@ static void destroy_service(void *data)
 static bool match_client_by_uuid(const void *data, const void *user_data)
 {
 	const uint8_t *exp_uuid = user_data;
-	const struct gatt_client *client = data;
+	const struct gatt_app *client = data;
 
 	return !memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
@@ -252,7 +256,7 @@ static bool match_client_by_uuid(const void *data, const void *user_data)
 static bool match_server_by_uuid(const void *data, const void *user_data)
 {
 	const uint8_t *exp_uuid = user_data;
-	const struct gatt_server *server = data;
+	const struct gatt_app *server = data;
 
 	return !memcmp(exp_uuid, server->uuid, sizeof(server->uuid));
 }
@@ -260,7 +264,7 @@ static bool match_server_by_uuid(const void *data, const void *user_data)
 static bool match_client_by_id(const void *data, const void *user_data)
 {
 	int32_t exp_id = PTR_TO_INT(user_data);
-	const struct gatt_client *client = data;
+	const struct gatt_app *client = data;
 
 	return client->id == exp_id;
 }
@@ -268,17 +272,17 @@ static bool match_client_by_id(const void *data, const void *user_data)
 static bool match_server_by_id(const void *data, const void *user_data)
 {
 	int32_t exp_id = PTR_TO_INT(user_data);
-	const struct gatt_server *server = data;
+	const struct gatt_app *server = data;
 
 	return server->id == exp_id;
 }
 
-static struct gatt_client *find_client_by_id(int32_t id)
+static struct gatt_app *find_client_by_id(int32_t id)
 {
 	return queue_find(gatt_clients, match_client_by_id, INT_TO_PTR(id));
 }
 
-static struct gatt_server *find_server_by_id(int32_t id)
+static struct gatt_app *find_server_by_id(int32_t id)
 {
 	return queue_find(gatt_servers, match_server_by_id, INT_TO_PTR(id));
 }
@@ -325,13 +329,13 @@ static bool match_connection_by_id(const void *data, const void *user_data)
 	return conn->id == id;
 }
 
-static bool match_connection_by_device_and_client(const void *data,
+static bool match_connection_by_device_and_app(const void *data,
 							const void *user_data)
 {
 	const struct connection *conn = data;
 	const struct connection *match = user_data;
 
-	return conn->device == match->device && conn->client == match->client;
+	return conn->device == match->device && conn->app == match->app;
 }
 
 static struct connection *find_connection_by_id(int32_t conn_id)
@@ -348,12 +352,12 @@ static bool match_connection_by_device(const void *data, const void *user_data)
 	return conn->device == dev;
 }
 
-static bool match_connection_by_client(const void *data, const void *user_data)
+static bool match_connection_by_app(const void *data, const void *user_data)
 {
 	const struct connection *conn = data;
-	const struct gatt_client *client = user_data;
+	const struct gatt_app *app = user_data;
 
-	return conn->client == client;
+	return conn->app == app;
 }
 
 static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
@@ -455,14 +459,13 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
 static void destroy_notification(void *data)
 {
 	struct notification_data *notification = data;
-	struct gatt_client *client;
+	struct gatt_app *app;
 
 	if (--notification->ref)
 		return;
 
-	client = notification->conn->client;
-	queue_remove_if(client->notifications, match_notification,
-								notification);
+	app = notification->conn->app;
+	queue_remove_if(app->notifications, match_notification, notification);
 	free(notification);
 }
 
@@ -530,7 +533,7 @@ static void connection_cleanup(struct gatt_device *device)
 
 static void destroy_gatt_client(void *data)
 {
-	struct gatt_client *client = data;
+	struct gatt_app *client = data;
 
 	/* First we want to get all notifications and unregister them.
 	 * We don't pass unregister_notification to queue_destroy,
@@ -551,7 +554,7 @@ static void destroy_gatt_client(void *data)
 
 static void destroy_gatt_server(void *data)
 {
-	struct gatt_server *server = data;
+	struct gatt_app *server = data;
 
 	free(server);
 }
@@ -560,7 +563,7 @@ static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
 	struct hal_ev_gatt_client_register_client ev;
-	struct gatt_client *client;
+	struct gatt_app *client;
 	static int32_t client_cnt = 1;
 	uint8_t status;
 
@@ -574,7 +577,8 @@ static void handle_client_register(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	client = new0(struct gatt_client, 1);
+	client = new0(struct gatt_app, 1);
+	client->type = APP_CLIENT;
 	if (!client) {
 		error("gatt: cannot allocate memory for registering client");
 		status = HAL_STATUS_NOMEM;
@@ -625,7 +629,7 @@ static void send_client_disconnection_notify(struct connection *connection,
 {
 	struct hal_ev_gatt_client_disconnect ev;
 
-	ev.client_if = connection->client->id;
+	ev.client_if = connection->app->id;
 	ev.conn_id = connection->id;
 	ev.status = status;
 
@@ -640,7 +644,7 @@ static void send_client_connection_notify(struct connection *connection,
 {
 	struct hal_ev_gatt_client_connect ev;
 
-	ev.client_if = connection->client->id;
+	ev.client_if = connection->app->id;
 	ev.conn_id = connection->id;
 	ev.status = status;
 
@@ -650,16 +654,20 @@ static void send_client_connection_notify(struct connection *connection,
 							sizeof(ev), &ev);
 }
 
-static void send_client_disconnect_notify(struct connection *connection,
+static void send_app_disconnect_notify(struct connection *connection,
 								int32_t status)
 {
-	send_client_disconnection_notify(connection, status);
+	if (connection->app->type == APP_CLIENT)
+		send_client_disconnection_notify(connection, status);
+	/* TODO: handle APP_SERVER */
 }
 
-static void send_client_connect_notify(struct connection *connection,
+static void send_app_connect_notify(struct connection *connection,
 								int32_t status)
 {
-	send_client_connection_notify(connection, status);
+	if (connection->app->type == APP_CLIENT)
+		send_client_connection_notify(connection, status);
+	/* TODO: handle APP_SERVER */
 }
 
 static void disconnect_notify_by_device(void *data, void *user_data)
@@ -671,10 +679,10 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 		return;
 
 	if (dev->state == DEVICE_CONNECTED)
-		send_client_disconnect_notify(conn, GATT_SUCCESS);
+		send_app_disconnect_notify(conn, GATT_SUCCESS);
 	else if (dev->state == DEVICE_CONNECT_INIT ||
 					dev->state == DEVICE_CONNECT_READY)
-		send_client_connect_notify(conn, GATT_FAILURE);
+		send_app_connect_notify(conn, GATT_FAILURE);
 }
 
 static void destroy_device(void *data)
@@ -939,13 +947,13 @@ struct connect_data {
 	int32_t status;
 };
 
-static void send_client_connect_notifications(void *data, void *user_data)
+static void send_app_connect_notifications(void *data, void *user_data)
 {
 	struct connection *conn = data;
 	struct connect_data *con_data = user_data;
 
 	if (conn->device == con_data->dev)
-		send_client_connect_notify(conn, con_data->status);
+		send_app_connect_notify(conn, con_data->status);
 }
 
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
@@ -990,7 +998,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 reply:
 	data.dev = dev;
 	data.status = status;
-	queue_foreach(client_connections, send_client_connect_notifications,
+	queue_foreach(client_connections, send_app_connect_notifications,
 									&data);
 	device_unref(dev);
 
@@ -1138,7 +1146,7 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 }
 
 static struct connection *create_connection(struct gatt_device *device,
-						struct gatt_client *client)
+						struct gatt_app *app)
 {
 	struct connection *new_conn;
 	static int32_t last_conn_id = 1;
@@ -1149,9 +1157,9 @@ static struct connection *create_connection(struct gatt_device *device,
 		return NULL;
 
 	/* Make connection id unique to connection record
-	 * (client, device) pair.
+	 * (app, device) pair.
 	 */
-	new_conn->client = client;
+	new_conn->app = app;
 	new_conn->id = last_conn_id++;
 
 	if (!queue_push_head(client_connections, new_conn)) {
@@ -1171,23 +1179,23 @@ static void trigger_disconnection(struct connection *connection)
 {
 	/* Notify client */
 	if (queue_remove(client_connections, connection))
-			send_client_disconnect_notify(connection, GATT_SUCCESS);
+			send_app_disconnect_notify(connection, GATT_SUCCESS);
 
 	destroy_connection(connection);
 }
 
-static void client_disconnect_devices(struct gatt_client *client)
+static void app_disconnect_devices(struct gatt_app *client)
 {
 	struct connection *conn;
 
 	/* find every connection for client record and trigger disconnect */
-	conn = queue_remove_if(client_connections, match_connection_by_client,
+	conn = queue_remove_if(client_connections, match_connection_by_app,
 									client);
 	while (conn) {
 		trigger_disconnection(conn);
 
 		conn = queue_remove_if(client_connections,
-					match_connection_by_client, client);
+					match_connection_by_app, client);
 	}
 }
 
@@ -1198,7 +1206,7 @@ static bool trigger_connection(struct connection *connection)
 		device_set_state(connection->device, DEVICE_CONNECT_INIT);
 		break;
 	case DEVICE_CONNECTED:
-		send_client_connect_notify(connection, GATT_SUCCESS);
+		send_app_connect_notify(connection, GATT_SUCCESS);
 		break;
 	default:
 		break;
@@ -1220,7 +1228,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
 	uint8_t status;
-	struct gatt_client *cl;
+	struct gatt_app *cl;
 
 	DBG("");
 
@@ -1233,7 +1241,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		/* Check if there is any connect request or connected device
 		 * for this client. If so, remove this client from those lists.
 		 */
-		client_disconnect_devices(cl);
+		app_disconnect_devices(cl);
 		destroy_gatt_client(cl);
 		status = HAL_STATUS_SUCCESS;
 	}
@@ -1242,33 +1250,37 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static struct connection *find_connection_by_addr_and_client_id(bdaddr_t *addr,
-							int32_t client_id)
+static struct connection *find_conn(const bdaddr_t *addr, int32_t app_id,
+							int32_t app_type)
 {
 	struct connection conn_match;
 	struct gatt_device *dev = NULL;
-	struct gatt_client *client;
+	struct gatt_app *app;
 
-	/* Check if client is registered */
-	client = find_client_by_id(client_id);
-	if (!client) {
-		error("gatt: Client id %d not found", client_id);
+	/* Check if app is registered */
+	if (app_type == APP_CLIENT)
+		app = find_client_by_id(app_id);
+	else
+		app = find_server_by_id(app_id);
+
+	if (!app) {
+		error("gatt: Client id %d not found", app_id);
 		return NULL;
 	}
 
 	/* Check if device is known */
 	dev = find_device_by_addr(addr);
 	if (!dev) {
-		error("gatt: Client id %d not found", client_id);
+		error("gatt: Client id %d not found", app_id);
 		return NULL;
 	}
 
 	conn_match.device = dev;
-	conn_match.client = client;
+	conn_match.app = app;
 
 	return queue_find(client_connections,
-					match_connection_by_device_and_client,
-					&conn_match);
+				match_connection_by_device_and_app,
+				&conn_match);
 }
 
 static void handle_client_connect(const void *buf, uint16_t len)
@@ -1277,7 +1289,7 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	struct connection conn_match;
 	struct connection *conn;
 	struct gatt_device *device;
-	struct gatt_client *client;
+	struct gatt_app *client;
 	bdaddr_t addr;
 	uint8_t status;
 
@@ -1301,10 +1313,10 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	}
 
 	conn_match.device = device;
-	conn_match.client = client;
+	conn_match.app = client;
 
 	conn = queue_find(client_connections,
-					match_connection_by_device_and_client,
+					match_connection_by_device_and_app,
 					&conn_match);
 	if (!conn) {
 		conn = create_connection(device, client);
@@ -2876,7 +2888,7 @@ static void handle_client_register_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_connection_by_addr_and_client_id(&addr, cmd->client_if);
+	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2910,7 +2922,7 @@ static void handle_client_register_for_notification(const void *buf,
 						sizeof(notification->service));
 	notification->conn = conn;
 
-	if (queue_find(conn->client->notifications, match_notification,
+	if (queue_find(conn->app->notifications, match_notification,
 								notification)) {
 		free(notification);
 		status = HAL_STATUS_SUCCESS;
@@ -2949,7 +2961,7 @@ static void handle_client_register_for_notification(const void *buf,
 	 */
 	notification->ref = 2;
 
-	if (!queue_push_tail(conn->client->notifications, notification)) {
+	if (!queue_push_tail(conn->app->notifications, notification)) {
 		unregister_notification(notification);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2981,7 +2993,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	conn = find_connection_by_addr_and_client_id(&addr, cmd->client_if);
+	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
 	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2993,7 +3005,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 	memcpy(&notif.service, &cmd->srvc_id, sizeof(notif.service));
 	notif.conn = conn;
 
-	notification = queue_find(conn->client->notifications,
+	notification = queue_find(conn->app->notifications,
 						match_notification, &notif);
 	if (!notification) {
 		status = HAL_STATUS_FAILED;
@@ -3071,7 +3083,7 @@ static void handle_server_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_register *cmd = buf;
 	struct hal_ev_gatt_server_register ev;
-	struct gatt_server *server;
+	struct gatt_app *server;
 	static int32_t server_cnt = 1;
 	uint32_t status;
 
@@ -3085,7 +3097,8 @@ static void handle_server_register(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	server = new0(struct gatt_server, 1);
+	server = new0(struct gatt_app, 1);
+	server->type = APP_SERVER;
 	if (!server) {
 		error("gatt: Cannot allocate memory for registering server");
 		status = HAL_STATUS_NOMEM;
@@ -3125,7 +3138,7 @@ static void handle_server_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_unregister *cmd = buf;
 	uint8_t status;
-	struct gatt_server *server;
+	struct gatt_app *server;
 
 	DBG("");
 
@@ -3164,7 +3177,7 @@ static void handle_server_add_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_service *cmd = buf;
 	char uuidstr[MAX_LEN_UUID_STR];
-	struct gatt_server *server;
+	struct gatt_app *server;
 	struct element_id srvc_id;
 	uint8_t status;
 
@@ -3194,7 +3207,7 @@ failed:
 static void handle_server_add_included_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_inc_service *cmd = buf;
-	struct gatt_server *server;
+	struct gatt_app *server;
 	uint8_t status;
 
 	DBG("");
@@ -3221,7 +3234,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
 	char uuidstr[MAX_LEN_UUID_STR];
-	struct gatt_server *server;
+	struct gatt_app *server;
 	bt_uuid_t char_uuid;
 	uint8_t status;
 
@@ -3253,7 +3266,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_descriptor *cmd = buf;
 	char uuidstr[MAX_LEN_UUID_STR];
-	struct gatt_server *server;
+	struct gatt_app *server;
 	bt_uuid_t descr_uuid;
 	uint8_t status;
 
@@ -3283,7 +3296,7 @@ failed:
 static void handle_server_start_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_start_service *cmd = buf;
-	struct gatt_server *server;
+	struct gatt_app *server;
 	uint8_t status;
 
 	DBG("");
@@ -3310,7 +3323,7 @@ failed:
 static void handle_server_stop_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_stop_service *cmd = buf;
-	struct gatt_server *server;
+	struct gatt_app *server;
 	uint8_t status;
 
 	DBG("");
@@ -3336,7 +3349,7 @@ failed:
 static void handle_server_delete_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_delete_service *cmd = buf;
-	struct gatt_server *server;
+	struct gatt_app *server;
 	uint8_t status;
 
 	DBG("");
-- 
1.9.1

