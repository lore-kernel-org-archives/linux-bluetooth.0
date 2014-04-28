Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/7] android/gatt: Store client and server apps on a single list
Date: Mon, 28 Apr 2014 15:32:01 +0200
Message-Id: <1398691926-1777-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will simplify and reduce code amount for handling client and server
app as it will use common code.
---
 android/gatt.c | 134 +++++++++++++++++++++------------------------------------
 1 file changed, 48 insertions(+), 86 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2e4bb8c..4f50cc0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -150,11 +150,12 @@ static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
 
-static struct queue *gatt_clients = NULL;
-static struct queue *gatt_servers = NULL;
+static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
 static struct queue *client_connections = NULL;
 
+static int32_t app_id = 1;
+
 static struct queue *listen_clients = NULL;
 
 static void bt_le_discovery_stop_cb(void);
@@ -245,7 +246,7 @@ static void destroy_service(void *data)
 	free(srvc);
 }
 
-static bool match_client_by_uuid(const void *data, const void *user_data)
+static bool match_app_by_uuid(const void *data, const void *user_data)
 {
 	const uint8_t *exp_uuid = user_data;
 	const struct gatt_app *client = data;
@@ -253,15 +254,7 @@ static bool match_client_by_uuid(const void *data, const void *user_data)
 	return !memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
 
-static bool match_server_by_uuid(const void *data, const void *user_data)
-{
-	const uint8_t *exp_uuid = user_data;
-	const struct gatt_app *server = data;
-
-	return !memcmp(exp_uuid, server->uuid, sizeof(server->uuid));
-}
-
-static bool match_client_by_id(const void *data, const void *user_data)
+static bool match_app_by_id(const void *data, const void *user_data)
 {
 	int32_t exp_id = PTR_TO_INT(user_data);
 	const struct gatt_app *client = data;
@@ -269,22 +262,9 @@ static bool match_client_by_id(const void *data, const void *user_data)
 	return client->id == exp_id;
 }
 
-static bool match_server_by_id(const void *data, const void *user_data)
-{
-	int32_t exp_id = PTR_TO_INT(user_data);
-	const struct gatt_app *server = data;
-
-	return server->id == exp_id;
-}
-
-static struct gatt_app *find_client_by_id(int32_t id)
-{
-	return queue_find(gatt_clients, match_client_by_id, INT_TO_PTR(id));
-}
-
-static struct gatt_app *find_server_by_id(int32_t id)
+static struct gatt_app *find_app_by_id(int32_t id)
 {
-	return queue_find(gatt_servers, match_server_by_id, INT_TO_PTR(id));
+	return queue_find(gatt_apps, match_app_by_id, INT_TO_PTR(id));
 }
 
 static bool match_by_value(const void *data, const void *user_data)
@@ -531,32 +511,27 @@ static void connection_cleanup(struct gatt_device *device)
 	device_set_state(device, DEVICE_DISCONNECTED);
 }
 
-static void destroy_gatt_client(void *data)
+static void destroy_gatt_app(void *data)
 {
-	struct gatt_app *client = data;
+	struct gatt_app *app = data;
 
 	/* First we want to get all notifications and unregister them.
 	 * We don't pass unregister_notification to queue_destroy,
 	 * because destroy notification performs operations on queue
 	 * too. So remove all elements and then destroy queue.
 	 */
-	while (queue_peek_head(client->notifications)) {
-		struct notification_data *notification;
-
-		notification = queue_pop_head(client->notifications);
-		unregister_notification(notification);
-	}
 
-	queue_destroy(client->notifications, free);
+	if (app->type == APP_CLIENT)
+		while (queue_peek_head(app->notifications)) {
+			struct notification_data *notification;
 
-	free(client);
-}
+			notification = queue_pop_head(app->notifications);
+			unregister_notification(notification);
+		}
 
-static void destroy_gatt_server(void *data)
-{
-	struct gatt_app *server = data;
+	queue_destroy(app->notifications, free);
 
-	free(server);
+	free(app);
 }
 
 static void handle_client_register(const void *buf, uint16_t len)
@@ -564,14 +539,13 @@ static void handle_client_register(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_register *cmd = buf;
 	struct hal_ev_gatt_client_register_client ev;
 	struct gatt_app *client;
-	static int32_t client_cnt = 1;
 	uint8_t status;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
+	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
 		error("gatt: client uuid is already on list");
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -588,18 +562,18 @@ static void handle_client_register(const void *buf, uint16_t len)
 	client->notifications = queue_new();
 	if (!client->notifications) {
 		error("gatt: couldn't allocate notifications queue");
-		destroy_gatt_client(client);
+		destroy_gatt_app(client);
 		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
 
 	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
-	client->id = client_cnt++;
+	client->id = app_id++;
 
-	if (!queue_push_head(gatt_clients, client)) {
+	if (!queue_push_head(gatt_apps, client)) {
 		error("gatt: Cannot push client on the list");
-		destroy_gatt_client(client);
+		destroy_gatt_app(client);
 		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
@@ -1063,7 +1037,7 @@ static void handle_client_scan(const void *buf, uint16_t len)
 
 	DBG("new state %d", cmd->start);
 
-	registered = find_client_by_id(cmd->client_if);
+	registered = find_app_by_id(cmd->client_if);
 	if (!registered) {
 		error("gatt: Client not registered");
 		status = HAL_STATUS_FAILED;
@@ -1232,7 +1206,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	cl = queue_remove_if(gatt_clients, match_client_by_id,
+	cl = queue_remove_if(gatt_apps, match_app_by_id,
 						INT_TO_PTR(cmd->client_if));
 	if (!cl) {
 		error("gatt: client_if=%d not found", cmd->client_if);
@@ -1242,7 +1216,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		 * for this client. If so, remove this client from those lists.
 		 */
 		app_disconnect_devices(cl);
-		destroy_gatt_client(cl);
+		destroy_gatt_app(cl);
 		status = HAL_STATUS_SUCCESS;
 	}
 
@@ -1258,11 +1232,7 @@ static struct connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 	struct gatt_app *app;
 
 	/* Check if app is registered */
-	if (app_type == APP_CLIENT)
-		app = find_client_by_id(app_id);
-	else
-		app = find_server_by_id(app_id);
-
+	app = find_app_by_id(app_id);
 	if (!app) {
 		error("gatt: Client id %d not found", app_id);
 		return NULL;
@@ -1295,7 +1265,7 @@ static void handle_client_connect(const void *buf, uint16_t len)
 
 	DBG("");
 
-	client = find_client_by_id(cmd->client_if);
+	client = find_app_by_id(cmd->client_if);
 	if (!client) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
@@ -1401,7 +1371,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!find_client_by_id(cmd->client_if)) {
+	if (!find_app_by_id(cmd->client_if)) {
 		error("gatt: Client not registered");
 		status = HAL_STATUS_FAILED;
 		goto reply;
@@ -3034,7 +3004,7 @@ static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!find_client_by_id(cmd->client_if)) {
+	if (!find_app_by_id(cmd->client_if)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -3084,14 +3054,13 @@ static void handle_server_register(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_server_register *cmd = buf;
 	struct hal_ev_gatt_server_register ev;
 	struct gatt_app *server;
-	static int32_t server_cnt = 1;
 	uint32_t status;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (queue_find(gatt_servers, match_server_by_uuid, &cmd->uuid)) {
+	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
 		error("gatt: Server uuid is already on list");
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -3107,9 +3076,9 @@ static void handle_server_register(const void *buf, uint16_t len)
 
 	memcpy(server->uuid, cmd->uuid, sizeof(server->uuid));
 
-	server->id = server_cnt++;
+	server->id = app_id++;
 
-	if (!queue_push_head(gatt_servers, server)) {
+	if (!queue_push_head(gatt_apps, server)) {
 		error("gatt: Cannot push server on the list");
 		free(server);
 		status = HAL_STATUS_FAILED;
@@ -3142,14 +3111,14 @@ static void handle_server_unregister(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	destroy_gatt_server(server);
+	destroy_gatt_app(server);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -3183,7 +3152,7 @@ static void handle_server_add_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3212,7 +3181,7 @@ static void handle_server_add_included_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3240,7 +3209,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3272,7 +3241,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3301,7 +3270,7 @@ static void handle_server_start_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3328,7 +3297,7 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3354,7 +3323,7 @@ static void handle_server_delete_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	server = find_server_by_id(cmd->server_if);
+	server = find_app_by_id(cmd->server_if);
 	if (!server) {
 		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
@@ -3501,20 +3470,16 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	DBG("");
 
 	gatt_devices = queue_new();
-	gatt_clients = queue_new();
-	gatt_servers = queue_new();
+	gatt_apps = queue_new();
 	client_connections = queue_new();
 	listen_clients = queue_new();
 
-	if (!gatt_devices || !gatt_clients || !gatt_servers ||
-				!listen_clients || !client_connections) {
+	if (!gatt_devices || !gatt_apps || !listen_clients ||
+							!client_connections) {
 		error("gatt: Failed to allocate memory for queues");
 
-		queue_destroy(gatt_servers, NULL);
-		gatt_servers = NULL;
-
-		queue_destroy(gatt_clients, NULL);
-		gatt_clients = NULL;
+		queue_destroy(gatt_apps, NULL);
+		gatt_apps = NULL;
 
 		queue_destroy(gatt_devices, NULL);
 		gatt_devices = NULL;
@@ -3545,11 +3510,8 @@ void bt_gatt_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
 	hal_ipc = NULL;
 
-	queue_destroy(gatt_servers, destroy_gatt_server);
-	gatt_servers = NULL;
-
-	queue_destroy(gatt_clients, destroy_gatt_client);
-	gatt_clients = NULL;
+	queue_destroy(gatt_apps, destroy_gatt_app);
+	gatt_apps = NULL;
 
 	queue_destroy(client_connections, destroy_connection);
 	client_connections = NULL;
-- 
1.9.1

