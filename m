Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] android/gatt: Make application API public
Date: Thu, 12 Jun 2014 15:33:20 +0300
Message-Id: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This in future gonna be used by HoG to receive connection notifications.
---
 android/gatt.c | 142 +++++++++++++++++++++++++++++++++++++++++++++------------
 android/gatt.h |  15 ++++++
 2 files changed, 129 insertions(+), 28 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 741dc38..a2314e0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -87,11 +87,6 @@ static const char const *device_state_str[] = {
 	"CONNECTED",
 };
 
-typedef enum {
-	APP_CLIENT,
-	APP_SERVER,
-} gatt_app_type_t;
-
 struct pending_trans_data {
 	unsigned int id;
 	uint8_t opcode;
@@ -101,10 +96,12 @@ struct gatt_app {
 	int32_t id;
 	uint8_t uuid[16];
 
-	gatt_app_type_t type;
+	gatt_type_t type;
 
 	/* Valid for client applications */
 	struct queue *notifications;
+
+	gatt_conn_cb_t func;
 };
 
 struct element_id {
@@ -617,7 +614,7 @@ static void destroy_gatt_app(void *data)
 	 * too. So remove all elements and then destroy queue.
 	 */
 
-	if (app->type == APP_CLIENT)
+	if (app->type == GATT_CLIENT)
 		while (queue_peek_head(app->notifications)) {
 			struct notification_data *notification;
 
@@ -630,14 +627,14 @@ static void destroy_gatt_app(void *data)
 	free(app);
 }
 
-static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
+static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
 {
 	static int32_t application_id = 1;
 	struct gatt_app *app;
 
 	if (queue_find(gatt_apps, match_app_by_uuid, uuid)) {
 		error("gatt: app uuid is already on list");
-		return 0;
+		return NULL;
 	}
 
 	app = new0(struct gatt_app, 1);
@@ -646,14 +643,14 @@ static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 		return 0;
 	}
 
-	app->type = app_type;
+	app->type = type;
 
-	if (app->type == APP_CLIENT) {
+	if (app->type == GATT_CLIENT) {
 		app->notifications = queue_new();
 		if (!app->notifications) {
 			error("gatt: couldn't allocate notifications queue");
 			destroy_gatt_app(app);
-			return 0;
+			return NULL;
 		}
 	}
 
@@ -664,33 +661,35 @@ static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 	if (!queue_push_head(gatt_apps, app)) {
 		error("gatt: Cannot push app on the list");
 		destroy_gatt_app(app);
-		return 0;
+		return NULL;
 	}
 
-	if ((app->type == APP_SERVER) &&
+	if ((app->type == GATT_SERVER) &&
 			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
 		error("gatt: Cannot push server on the list");
 		destroy_gatt_app(app);
-		return 0;
+		return NULL;
 	}
 
-	return app->id;
+	return app;
 }
 
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
 	struct hal_ev_gatt_client_register_client ev;
+	struct gatt_app *app;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.client_if = register_app(cmd->uuid, APP_CLIENT);
+	app = register_app(cmd->uuid, GATT_CLIENT);
 
-	if (ev.client_if)
+	if (app) {
+		ev.client_if = app->id;
 		ev.status = GATT_SUCCESS;
-	else
+	} else
 		ev.status = GATT_FAILURE;
 
 	/* We should send notification with given in cmd UUID */
@@ -708,6 +707,12 @@ static void send_client_disconnection_notify(struct app_connection *connection,
 {
 	struct hal_ev_gatt_client_disconnect ev;
 
+	if (connection->app->func) {
+		connection->app->func(&connection->device->bdaddr, -ENOTCONN,
+						connection->device->attrib);
+		return;
+	}
+
 	ev.client_if = connection->app->id;
 	ev.conn_id = connection->id;
 	ev.status = status;
@@ -723,6 +728,13 @@ static void send_client_connection_notify(struct app_connection *connection,
 {
 	struct hal_ev_gatt_client_connect ev;
 
+	if (connection->app->func) {
+		connection->app->func(&connection->device->bdaddr,
+					status == GATT_SUCCESS ? 0 : -ENOTCONN,
+					connection->device->attrib);
+		return;
+	}
+
 	ev.client_if = connection->app->id;
 	ev.conn_id = connection->id;
 	ev.status = status;
@@ -738,6 +750,13 @@ static void send_server_connection_notify(struct app_connection *connection,
 {
 	struct hal_ev_gatt_server_connection ev;
 
+	if (connection->app->func) {
+		connection->app->func(&connection->device->bdaddr,
+					connected ? 0 : -ENOTCONN,
+					connection->device->attrib);
+		return;
+	}
+
 	ev.server_if = connection->app->id;
 	ev.conn_id = connection->id;
 	ev.connected = connected;
@@ -751,7 +770,7 @@ static void send_server_connection_notify(struct app_connection *connection,
 static void send_app_disconnect_notify(struct app_connection *connection,
 								int32_t status)
 {
-	if (connection->app->type == APP_CLIENT)
+	if (connection->app->type == GATT_CLIENT)
 		send_client_disconnection_notify(connection, status);
 	else
 		send_server_connection_notify(connection, !!status);
@@ -760,9 +779,9 @@ static void send_app_disconnect_notify(struct app_connection *connection,
 static void send_app_connect_notify(struct app_connection *connection,
 								int32_t status)
 {
-	if (connection->app->type == APP_CLIENT)
+	if (connection->app->type == GATT_CLIENT)
 		send_client_connection_notify(connection, status);
-	else
+	else if (connection->app->type == GATT_SERVER)
 		send_server_connection_notify(connection, !status);
 }
 
@@ -3566,9 +3585,11 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 	switch (cmd->command) {
 	case GATT_CLIENT_TEST_CMD_ENABLE:
 		if (cmd->u1) {
-			if (!test_client_if)
-				test_client_if = register_app(TEST_UUID,
-								APP_CLIENT);
+			if (!test_client_if) {
+				app = register_app(TEST_UUID, GATT_CLIENT);
+				if (app)
+					test_client_if = app->id;
+			}
 
 			if (test_client_if)
 				status = HAL_STATUS_SUCCESS;
@@ -3613,16 +3634,18 @@ static void handle_server_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_register *cmd = buf;
 	struct hal_ev_gatt_server_register ev;
+	struct gatt_app *app;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.server_if = register_app(cmd->uuid, APP_SERVER);
+	app = register_app(cmd->uuid, GATT_SERVER);
 
-	if (ev.server_if)
+	if (app) {
+		ev.server_if = app->id;
 		ev.status = GATT_SUCCESS;
-	else
+	} else
 		ev.status = GATT_FAILURE;
 
 	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
@@ -5963,3 +5986,66 @@ void bt_gatt_unregister(void)
 	bt_crypto_unref(crypto);
 	crypto = NULL;
 }
+
+
+unsigned int bt_gatt_register_app(const char *uuid, gatt_type_t type,
+							gatt_conn_cb_t func)
+{
+	struct gatt_app *app;
+	bt_uuid_t uuid128;
+
+	bt_string_to_uuid(&uuid128, uuid);
+	app = register_app((void *) &uuid128.value.u128, type);
+	if (!app)
+		return 0;
+
+	app->func = func;
+
+	return app->id;
+}
+
+bool bt_gatt_unregister_app(unsigned int id)
+{
+	uint8_t status;
+
+	status = unregister_app(id);
+
+	return status != HAL_STATUS_FAILED;
+}
+
+bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr)
+{
+	uint8_t status;
+
+	status = handle_connect(id, addr);
+
+	return status != HAL_STATUS_FAILED;
+}
+
+bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr)
+{
+	struct app_connection match;
+	struct app_connection *conn;
+	struct gatt_device *device;
+	struct gatt_app *app;
+
+	app = find_app_by_id(id);
+	if (!app)
+		return false;
+
+	device = find_device_by_addr(addr);
+	if (!device)
+		return false;
+
+	match.device = device;
+	match.app = app;
+
+	conn = queue_find(app_connections, match_connection_by_device_and_app,
+									&match);
+	if (!conn)
+		return false;
+
+	trigger_disconnection(conn);
+
+	return true;
+}
diff --git a/android/gatt.h b/android/gatt.h
index d4392d9..5ba9161 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -23,3 +23,18 @@
 
 bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_gatt_unregister(void);
+
+
+typedef enum {
+	GATT_CLIENT,
+	GATT_SERVER,
+} gatt_type_t;
+
+typedef void (*gatt_conn_cb_t)(const bdaddr_t *addr, int err, void *attrib);
+
+unsigned int bt_gatt_register_app(const char *uuid, gatt_type_t type,
+							gatt_conn_cb_t func);
+bool bt_gatt_unregister_app(unsigned int id);
+
+bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
+bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
-- 
1.9.3

