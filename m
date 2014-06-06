Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 11/13] android/gatt: Create server connections on register
Date: Fri,  6 Jun 2014 15:46:24 +0200
Message-Id: <1402062386-4632-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need those to make server apps aware of current connections.
---
 android/gatt.c | 179 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 115 insertions(+), 64 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4bc4f35..9c2f3ba 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -173,6 +173,7 @@ struct app_connection {
 	int32_t id;
 
 	bool wait_execute_write;
+	bool owner;
 };
 
 static struct ipc *hal_ipc = NULL;
@@ -565,6 +566,9 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 	dev->state = state;
 }
 
+static void disconnect_notify_by_device(void *data, void *user_data);
+static void destroy_app_connection(void *data);
+
 static void connection_cleanup(struct gatt_device *device)
 {
 	if (device->watch_id) {
@@ -589,6 +593,16 @@ static void connection_cleanup(struct gatt_device *device)
 		g_attrib_unref(attrib);
 	}
 
+	if (queue_find(app_connections, match_connection_by_device, device)) {
+		/* Notify disconnection to all clients */
+		queue_foreach(app_connections, disconnect_notify_by_device,
+									device);
+
+		/* Remove all clients by given device's */
+		queue_remove_all(app_connections, match_connection_by_device,
+						device, destroy_app_connection);
+	}
+
 	/*
 	 * If device was in connection_pending or connectable state we
 	 * search device list if we should stop the scan.
@@ -771,7 +785,7 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 	struct app_connection *conn = data;
 	struct gatt_device *dev = user_data;
 
-	if (dev != conn->device)
+	if (dev != conn->device && conn->app->type == APP_CLIENT)
 		return;
 
 	if (dev->state == DEVICE_CONNECTED)
@@ -848,28 +862,19 @@ static void disconnect_device(struct gatt_device *dev)
 	dev->conn_cnt--;
 	if (dev->conn_cnt == 0)
 		connection_cleanup(dev);
-
-	device_unref(dev);
 }
 
 static void destroy_app_connection(void *data)
 {
 	struct app_connection *conn = data;
 
-	disconnect_device(conn->device);
+	if (conn->owner)
+		disconnect_device(conn->device);
 
 	queue_destroy(conn->transactions, free);
-	free(conn);
-}
 
-static void device_disconnect_clients(struct gatt_device *dev)
-{
-	/* Notify disconnection to all clients */
-	queue_foreach(app_connections, disconnect_notify_by_device, dev);
-
-	/* Remove all clients by given device's */
-	queue_remove_all(app_connections, match_connection_by_device, dev,
-							destroy_app_connection);
+	device_unref(conn->device);
+	free(conn);
 }
 
 static void send_client_primary_notify(void *data, void *user_data)
@@ -991,7 +996,19 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 	if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
 		DBG("%s (%d)", strerror(err), err);
 
-	device_disconnect_clients(dev);
+	if (queue_find(app_connections, match_connection_by_device, dev)) {
+		/* Notify disconnection to all clients */
+		queue_foreach(app_connections, disconnect_notify_by_device,
+									dev);
+
+		/* Remove all clients by given device's */
+		queue_remove_all(app_connections, match_connection_by_device,
+						dev, destroy_app_connection);
+	}
+
+	/* In case of incoming connection (no owner) we clean it up manually */
+	if (!queue_find(app_connections, match_connection_by_device, dev))
+		connection_cleanup(dev);
 
 	return FALSE;
 }
@@ -1006,7 +1023,9 @@ static void send_app_connect_notifications(void *data, void *user_data)
 	struct app_connection *conn = data;
 	struct connect_data *con_data = user_data;
 
-	if (conn->device == con_data->dev)
+
+	if ((conn->device == con_data->dev && conn->owner) ||
+						conn->app->type == APP_SERVER)
 		send_app_connect_notify(conn, con_data->status);
 }
 
@@ -1113,6 +1132,59 @@ static void notify_att_range_change(struct gatt_device *dev,
 		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 }
 
+static struct app_connection *create_app_connection(struct gatt_device *device,
+							struct gatt_app *app)
+{
+	struct app_connection *new_conn;
+	static int32_t last_conn_id = 1;
+
+	/* Check if already connected */
+	new_conn = new0(struct app_connection, 1);
+	if (!new_conn)
+		return NULL;
+
+	/* Make connection id unique to connection record (app, device) pair */
+	new_conn->app = app;
+	new_conn->id = last_conn_id++;
+
+	new_conn->transactions = queue_new();
+	if (!new_conn->transactions) {
+		free(new_conn);
+		return NULL;
+	}
+
+	if (!queue_push_head(app_connections, new_conn)) {
+		error("gatt: Cannot push client on the client queue!?");
+		queue_destroy(new_conn->transactions, free);
+		free(new_conn);
+		return NULL;
+	}
+
+	new_conn->device = device_ref(device);
+
+	if (device->state == DEVICE_CONNECTED)
+		send_app_connect_notify(new_conn, GATT_SUCCESS);
+
+	return new_conn;
+}
+
+static void create_server_app_connection(void *data, void *user_data)
+{
+	struct app_connection match;
+
+	match.app = data;
+	match.device = user_data;
+
+	if (match.app->type == APP_CLIENT)
+		return;
+
+	if (queue_find(app_connections, match_connection_by_device_and_app,
+									&match))
+		return;
+
+	create_app_connection(match.device, match.app);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1184,9 +1256,14 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 reply:
 	data.dev = dev;
 	data.status = status;
-	queue_foreach(app_connections, send_app_connect_notifications, &data);
 	device_unref(dev);
 
+	queue_foreach(app_connections, send_app_connect_notifications, &data);
+
+	/* Create connection for server apps without it */
+	if (!status)
+		queue_foreach(gatt_apps, create_server_app_connection, dev);
+
 	/* Check if we should restart scan */
 	if (scanning)
 		bt_le_discovery_start(le_device_found_handler);
@@ -1343,40 +1420,6 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 	return device_ref(dev);
 }
 
-static struct app_connection *create_app_connection(struct gatt_device *device,
-						struct gatt_app *app)
-{
-	struct app_connection *new_conn;
-	static int32_t last_conn_id = 1;
-
-	/* Check if already connected */
-	new_conn = new0(struct app_connection, 1);
-	if (!new_conn)
-		return NULL;
-
-	/* Make connection id unique to connection record (app, device) pair */
-	new_conn->app = app;
-	new_conn->id = last_conn_id++;
-
-	new_conn->transactions = queue_new();
-	if (!new_conn->transactions) {
-		free(new_conn);
-		return NULL;
-	}
-
-	if (!queue_push_head(app_connections, new_conn)) {
-		error("gatt: Cannot push client on the client queue!?");
-		queue_destroy(new_conn->transactions, free);
-		free(new_conn);
-		return NULL;
-	}
-
-	new_conn->device = device_ref(device);
-	new_conn->device->conn_cnt++;
-
-	return new_conn;
-}
-
 static void trigger_disconnection(struct app_connection *connection)
 {
 	/* Notify client */
@@ -1391,28 +1434,21 @@ static void app_disconnect_devices(struct gatt_app *client)
 	struct app_connection *conn;
 
 	/* find every connection for client record and trigger disconnect */
-	conn = queue_remove_if(app_connections, match_connection_by_app,
-									client);
+	conn = queue_find(app_connections, match_connection_by_app, client);
 	while (conn) {
 		trigger_disconnection(conn);
 
-		conn = queue_remove_if(app_connections,
-					match_connection_by_app, client);
+		conn = queue_find(app_connections, match_connection_by_app,
+									client);
 	}
 }
 
 static bool trigger_connection(struct app_connection *connection)
 {
-	switch (connection->device->state) {
-	case DEVICE_DISCONNECTED:
+	DBG("");
+
+	if (connection->device->state == DEVICE_DISCONNECTED)
 		device_set_state(connection->device, DEVICE_CONNECT_INIT);
-		break;
-	case DEVICE_CONNECTED:
-		send_app_connect_notify(connection, GATT_SUCCESS);
-		break;
-	default:
-		break;
-	}
 
 	/* after state change trigger discovering */
 	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT))
@@ -1422,6 +1458,9 @@ static bool trigger_connection(struct app_connection *connection)
 			return false;
 		}
 
+	connection->device->conn_cnt++;
+	connection->owner = true;
+
 	return true;
 }
 
@@ -3610,6 +3649,15 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 				HAL_OP_GATT_CLIENT_TEST_COMMAND, status);
 }
 
+static void create_server_connections(void *data, void *user_data)
+{
+	struct gatt_device *dev = data;
+	struct gatt_app *app = user_data;
+
+	if (dev->state == DEVICE_CONNECTED)
+		create_app_connection(dev, app);
+}
+
 static void handle_server_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_register *cmd = buf;
@@ -3633,6 +3681,9 @@ static void handle_server_register(const void *buf, uint16_t len)
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_REGISTER,
 							HAL_STATUS_SUCCESS);
+
+	queue_foreach(gatt_devices, create_server_connections,
+						find_app_by_id(ev.server_if));
 }
 
 static void handle_server_unregister(const void *buf, uint16_t len)
-- 
2.0.0

