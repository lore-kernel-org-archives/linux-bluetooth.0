Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/10] android/gatt: Simplify app disconnection function call flow
Date: Wed, 11 Feb 2015 15:34:01 +0100
Message-Id: <1423665248-5121-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We do not keep app_connections in disconnected state and disconnecting
is equal to app_connection destruction. Thus we can use more generic
'queue_remove()' with proper destructor instead of custom functions like
device_disconnect_client and app_disconnect_devices. This destructor will
notify app about disconnection.
---
 android/gatt.c | 78 +++++++++++++++-------------------------------------------
 1 file changed, 20 insertions(+), 58 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f9cef4f..33eeba9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -879,15 +879,14 @@ static void notify_app_connect_status(struct app_connection *conn,
 		send_server_connection_state_notify(conn, !status);
 }
 
-static void notify_app_disconnect_status_by_device(void *data, void *user_data)
+static void destroy_connection(void *data)
 {
 	struct app_connection *conn = data;
-	struct gatt_device *dev = user_data;
 
-	if (dev != conn->device || !conn->app)
-		return;
+	if (conn->timeout_id > 0)
+		g_source_remove(conn->timeout_id);
 
-	switch (dev->state) {
+	switch (conn->device->state) {
 	case DEVICE_CONNECTED:
 		notify_app_disconnect_status(conn, GATT_SUCCESS);
 		break;
@@ -898,14 +897,6 @@ static void notify_app_disconnect_status_by_device(void *data, void *user_data)
 	case DEVICE_DISCONNECTED:
 		break;
 	}
-}
-
-static void destroy_connection(void *data)
-{
-	struct app_connection *conn = data;
-
-	if (conn->timeout_id > 0)
-		g_source_remove(conn->timeout_id);
 
 	if (!queue_find(app_connections, match_connection_by_device,
 							conn->device))
@@ -916,17 +907,6 @@ static void destroy_connection(void *data)
 	free(conn);
 }
 
-static void device_disconnect_clients(struct gatt_device *dev)
-{
-	/* Notify disconnection to all clients */
-	queue_foreach(app_connections, notify_app_disconnect_status_by_device,
-									dev);
-
-	/* Remove all clients by given device's */
-	queue_remove_all(app_connections, match_connection_by_device, dev,
-							destroy_connection);
-}
-
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -939,7 +919,8 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 	if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
 		DBG("%s (%d)", strerror(err), err);
 
-	device_disconnect_clients(dev);
+	queue_remove_all(app_connections, match_connection_by_device, dev,
+							destroy_connection);
 
 	return FALSE;
 }
@@ -1900,30 +1881,6 @@ reply:
 									status);
 }
 
-static void trigger_disconnection(struct app_connection *connection)
-{
-	/* Notify client */
-	if (queue_remove(app_connections, connection))
-			notify_app_disconnect_status(connection, GATT_SUCCESS);
-
-	destroy_connection(connection);
-}
-
-static void app_disconnect_devices(struct gatt_app *client)
-{
-	struct app_connection *conn;
-
-	/* find every connection for client record and trigger disconnect */
-	conn = queue_remove_if(app_connections, match_connection_by_app,
-									client);
-	while (conn) {
-		trigger_disconnection(conn);
-
-		conn = queue_remove_if(app_connections,
-					match_connection_by_app, client);
-	}
-}
-
 static int connect_bredr(struct gatt_device *dev)
 {
 	BtIOSecLevel sec_level;
@@ -2039,7 +1996,8 @@ static uint8_t unregister_app(int client_if)
 	}
 
 	/* Destroy app connections with proper notifications for this app. */
-	app_disconnect_devices(cl);
+	queue_remove_all(app_connections, match_connection_by_app, cl,
+							destroy_connection);
 	destroy_gatt_app(cl);
 
 	return HAL_STATUS_SUCCESS;
@@ -2207,9 +2165,10 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 	DBG("");
 
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
-	conn = find_connection_by_id(cmd->conn_id);
+	conn = queue_remove_if(app_connections, match_connection_by_id,
+						INT_TO_PTR(cmd->conn_id));
 	if (conn)
-		trigger_disconnection(conn);
+		destroy_connection(conn);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -4249,7 +4208,9 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		app = queue_find(gatt_apps, match_app_by_id,
 						INT_TO_PTR(test_client_if));
 		if (app)
-			app_disconnect_devices(app);
+			queue_remove_all(app_connections,
+						match_connection_by_app, app,
+						destroy_connection);
 
 		status = HAL_STATUS_SUCCESS;
 		break;
@@ -4342,9 +4303,10 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 	DBG("");
 
 	/* TODO: should we care to match also bdaddr when conn_id is unique? */
-	conn = find_connection_by_id(cmd->conn_id);
+	conn = queue_remove_if(app_connections, match_connection_by_id,
+						INT_TO_PTR(cmd->conn_id));
 	if (conn)
-		trigger_disconnection(conn);
+		destroy_connection(conn);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -7387,12 +7349,12 @@ bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr)
 	match.device = device;
 	match.app = app;
 
-	conn = queue_find(app_connections, match_connection_by_device_and_app,
-									&match);
+	conn = queue_remove_if(app_connections,
+				match_connection_by_device_and_app, &match);
 	if (!conn)
 		return false;
 
-	trigger_disconnection(conn);
+	destroy_connection(conn);
 
 	return true;
 }
-- 
1.9.1

