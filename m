Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/7] android/gatt: Rename connection list
Date: Mon, 28 Apr 2014 15:32:02 +0200
Message-Id: <1398691926-1777-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This list will be used for both, client and server apps connections.
---
 android/gatt.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4f50cc0..2d860ff 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -152,7 +152,7 @@ static bool scanning = false;
 
 static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
-static struct queue *client_connections = NULL;
+static struct queue *app_connections = NULL;
 
 static int32_t app_id = 1;
 
@@ -320,7 +320,7 @@ static bool match_connection_by_device_and_app(const void *data,
 
 static struct connection *find_connection_by_id(int32_t conn_id)
 {
-	return queue_find(client_connections, match_connection_by_id,
+	return queue_find(app_connections, match_connection_by_id,
 							INT_TO_PTR(conn_id));
 }
 
@@ -711,10 +711,10 @@ cleanup:
 static void device_disconnect_clients(struct gatt_device *dev)
 {
 	/* Notify disconnection to all clients */
-	queue_foreach(client_connections, disconnect_notify_by_device, dev);
+	queue_foreach(app_connections, disconnect_notify_by_device, dev);
 
 	/* Remove all clients by given device's */
-	queue_remove_all(client_connections, match_connection_by_device, dev,
+	queue_remove_all(app_connections, match_connection_by_device, dev,
 							destroy_connection);
 }
 
@@ -972,7 +972,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 reply:
 	data.dev = dev;
 	data.status = status;
-	queue_foreach(client_connections, send_app_connect_notifications,
+	queue_foreach(app_connections, send_app_connect_notifications,
 									&data);
 	device_unref(dev);
 
@@ -1136,7 +1136,7 @@ static struct connection *create_connection(struct gatt_device *device,
 	new_conn->app = app;
 	new_conn->id = last_conn_id++;
 
-	if (!queue_push_head(client_connections, new_conn)) {
+	if (!queue_push_head(app_connections, new_conn)) {
 		error("gatt: Cannot push client on the client queue!?");
 
 		free(new_conn);
@@ -1152,7 +1152,7 @@ static struct connection *create_connection(struct gatt_device *device,
 static void trigger_disconnection(struct connection *connection)
 {
 	/* Notify client */
-	if (queue_remove(client_connections, connection))
+	if (queue_remove(app_connections, connection))
 			send_app_disconnect_notify(connection, GATT_SUCCESS);
 
 	destroy_connection(connection);
@@ -1163,12 +1163,12 @@ static void app_disconnect_devices(struct gatt_app *client)
 	struct connection *conn;
 
 	/* find every connection for client record and trigger disconnect */
-	conn = queue_remove_if(client_connections, match_connection_by_app,
+	conn = queue_remove_if(app_connections, match_connection_by_app,
 									client);
 	while (conn) {
 		trigger_disconnection(conn);
 
-		conn = queue_remove_if(client_connections,
+		conn = queue_remove_if(app_connections,
 					match_connection_by_app, client);
 	}
 }
@@ -1248,7 +1248,7 @@ static struct connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 	conn_match.device = dev;
 	conn_match.app = app;
 
-	return queue_find(client_connections,
+	return queue_find(app_connections,
 				match_connection_by_device_and_app,
 				&conn_match);
 }
@@ -1285,7 +1285,7 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	conn_match.device = device;
 	conn_match.app = client;
 
-	conn = queue_find(client_connections,
+	conn = queue_find(app_connections,
 					match_connection_by_device_and_app,
 					&conn_match);
 	if (!conn) {
@@ -3471,11 +3471,11 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 
 	gatt_devices = queue_new();
 	gatt_apps = queue_new();
-	client_connections = queue_new();
+	app_connections = queue_new();
 	listen_clients = queue_new();
 
 	if (!gatt_devices || !gatt_apps || !listen_clients ||
-							!client_connections) {
+							!app_connections) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_apps, NULL);
@@ -3484,8 +3484,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(gatt_devices, NULL);
 		gatt_devices = NULL;
 
-		queue_destroy(client_connections, NULL);
-		client_connections = NULL;
+		queue_destroy(app_connections, NULL);
+		app_connections = NULL;
 
 		queue_destroy(listen_clients, NULL);
 		listen_clients = NULL;
@@ -3513,8 +3513,8 @@ void bt_gatt_unregister(void)
 	queue_destroy(gatt_apps, destroy_gatt_app);
 	gatt_apps = NULL;
 
-	queue_destroy(client_connections, destroy_connection);
-	client_connections = NULL;
+	queue_destroy(app_connections, destroy_connection);
+	app_connections = NULL;
 
 	queue_destroy(gatt_devices, destroy_device);
 	gatt_devices = NULL;
-- 
1.9.1

