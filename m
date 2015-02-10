Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/6] android/gatt: Minor function renames
Date: Tue, 10 Feb 2015 13:48:12 +0100
Message-Id: <1423572494-32037-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

App connection notification functions names were not very descriptive
and it wasn't clear why for server and client notification sending
'status' function parameter was modified. With this patch, 'state' valid
for server and 'connection/disconnection status' valid for client are
distinguished.

Some functions also had 'send' prefix despite not calling 'ipc_send_'
directly like others do.

Declared type in 'struct app_connection *connection' function parameter
tells enough, thus parameter name was shortened to 'conn' in favor of
consistency and more descriptive function naming.
---
 android/gatt.c | 114 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0a6e6e9..7b924af 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -795,97 +795,97 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 	return device_ref(dev);
 }
 
-static void send_client_connection_notify(struct app_connection *connection,
+static void send_client_connect_status_notify(struct app_connection *conn,
 								int32_t status)
 {
 	struct hal_ev_gatt_client_connect ev;
 
-	if (connection->app->func) {
-		connection->app->func(&connection->device->bdaddr,
+	if (conn->app->func) {
+		conn->app->func(&conn->device->bdaddr,
 					status == GATT_SUCCESS ? 0 : -ENOTCONN,
-					connection->device->attrib);
+					conn->device->attrib);
 		return;
 	}
 
-	ev.client_if = connection->app->id;
-	ev.conn_id = connection->id;
+	ev.client_if = conn->app->id;
+	ev.conn_id = conn->id;
 	ev.status = status;
 
-	bdaddr2android(&connection->device->bdaddr, &ev.bda);
+	bdaddr2android(&conn->device->bdaddr, &ev.bda);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_CONNECT,
 							sizeof(ev), &ev);
 }
 
-static void send_server_connection_notify(struct app_connection *connection,
+static void send_server_connection_state_notify(struct app_connection *conn,
 								bool connected)
 {
 	struct hal_ev_gatt_server_connection ev;
 
-	if (connection->app->func) {
-		connection->app->func(&connection->device->bdaddr,
+	if (conn->app->func) {
+		conn->app->func(&conn->device->bdaddr,
 					connected ? 0 : -ENOTCONN,
-					connection->device->attrib);
+					conn->device->attrib);
 		return;
 	}
 
-	ev.server_if = connection->app->id;
-	ev.conn_id = connection->id;
+	ev.server_if = conn->app->id;
+	ev.conn_id = conn->id;
 	ev.connected = connected;
 
-	bdaddr2android(&connection->device->bdaddr, &ev.bdaddr);
+	bdaddr2android(&conn->device->bdaddr, &ev.bdaddr);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_EV_GATT_SERVER_CONNECTION, sizeof(ev), &ev);
 }
 
-static void send_client_disconnection_notify(struct app_connection *connection,
+static void send_client_disconnect_status_notify(struct app_connection *conn,
 								int32_t status)
 {
 	struct hal_ev_gatt_client_disconnect ev;
 
-	if (connection->app->func) {
-		connection->app->func(&connection->device->bdaddr, -ENOTCONN,
-						connection->device->attrib);
+	if (conn->app->func) {
+		conn->app->func(&conn->device->bdaddr, -ENOTCONN,
+						conn->device->attrib);
 		return;
 	}
 
-	ev.client_if = connection->app->id;
-	ev.conn_id = connection->id;
+	ev.client_if = conn->app->id;
+	ev.conn_id = conn->id;
 	ev.status = status;
 
-	bdaddr2android(&connection->device->bdaddr, &ev.bda);
+	bdaddr2android(&conn->device->bdaddr, &ev.bda);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
 
 }
 
-static void send_app_disconnect_notify(struct app_connection *connection,
+static void notify_app_disconnect_status(struct app_connection *conn,
 								int32_t status)
 {
-	if (!connection->app)
+	if (!conn->app)
 		return;
 
-	if (connection->app->type == GATT_CLIENT)
-		send_client_disconnection_notify(connection, status);
+	if (conn->app->type == GATT_CLIENT)
+		send_client_disconnect_status_notify(conn, status);
 	else
-		send_server_connection_notify(connection, !!status);
+		send_server_connection_state_notify(conn, !!status);
 }
 
-static void send_app_connect_notify(struct app_connection *connection,
+static void notify_app_connect_status(struct app_connection *conn,
 								int32_t status)
 {
-	if (!connection->app)
+	if (!conn->app)
 		return;
 
-	if (connection->app->type == GATT_CLIENT)
-		send_client_connection_notify(connection, status);
-	else if (connection->app->type == GATT_SERVER)
-		send_server_connection_notify(connection, !status);
+	if (conn->app->type == GATT_CLIENT)
+		send_client_connect_status_notify(conn, status);
+	else if (conn->app->type == GATT_SERVER)
+		send_server_connection_state_notify(conn, !status);
 }
 
-static void disconnect_notify_by_device(void *data, void *user_data)
+static void notify_app_disconnect_status_by_device(void *data, void *user_data)
 {
 	struct app_connection *conn = data;
 	struct gatt_device *dev = user_data;
@@ -895,11 +895,11 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 
 	switch (dev->state) {
 	case DEVICE_CONNECTED:
-		send_app_disconnect_notify(conn, GATT_SUCCESS);
+		notify_app_disconnect_status(conn, GATT_SUCCESS);
 		break;
 	case DEVICE_CONNECT_INIT:
 	case DEVICE_CONNECT_READY:
-		send_app_connect_notify(conn, GATT_FAILURE);
+		notify_app_connect_status(conn, GATT_FAILURE);
 		break;
 	case DEVICE_DISCONNECTED:
 		break;
@@ -925,7 +925,8 @@ static void destroy_connection(void *data)
 static void device_disconnect_clients(struct gatt_device *dev)
 {
 	/* Notify disconnection to all clients */
-	queue_foreach(app_connections, disconnect_notify_by_device, dev);
+	queue_foreach(app_connections, notify_app_disconnect_status_by_device,
+									dev);
 
 	/* Remove all clients by given device's */
 	queue_remove_all(app_connections, match_connection_by_device, dev,
@@ -1416,13 +1417,13 @@ struct connect_data {
 	int32_t status;
 };
 
-static void send_app_connect_notifications(void *data, void *user_data)
+static void notify_app_connect_status_by_device(void *data, void *user_data)
 {
 	struct app_connection *conn = data;
 	struct connect_data *con_data = user_data;
 
 	if (conn->device == con_data->dev)
-		send_app_connect_notify(conn, con_data->status);
+		notify_app_connect_status(conn, con_data->status);
 }
 
 static struct app_connection *find_conn_without_app(struct gatt_device *dev)
@@ -1634,7 +1635,8 @@ reply:
 
 	data.dev = dev;
 	data.status = status;
-	queue_foreach(app_connections, send_app_connect_notifications, &data);
+	queue_foreach(app_connections, notify_app_connect_status_by_device,
+									&data);
 	device_unref(dev);
 
 	/* Check if we should restart scan */
@@ -1909,7 +1911,7 @@ static void trigger_disconnection(struct app_connection *connection)
 {
 	/* Notify client */
 	if (queue_remove(app_connections, connection))
-			send_app_disconnect_notify(connection, GATT_SUCCESS);
+			notify_app_disconnect_status(connection, GATT_SUCCESS);
 
 	destroy_connection(connection);
 }
@@ -1972,28 +1974,27 @@ static int connect_bredr(struct gatt_device *dev)
 	return 0;
 }
 
-static bool trigger_connection(struct app_connection *connection)
+static bool trigger_connection(struct app_connection *conn)
 {
 	bool ret;
 
-	switch (connection->device->state) {
+	switch (conn->device->state) {
 	case DEVICE_DISCONNECTED:
 		/*
 		 *  If device was last seen over BR/EDR connect over it.
 		 *  Note: Connection state is handled in connect_bredr() func
 		 */
-		if (bt_device_last_seen_bearer(&connection->device->bdaddr) ==
+		if (bt_device_last_seen_bearer(&conn->device->bdaddr) ==
 								BDADDR_BREDR)
-			return connect_bredr(connection->device) == 0;
+			return connect_bredr(conn->device) == 0;
 
 		/* For LE use auto connect feature */
-		ret = auto_connect_le(connection->device);
+		ret = auto_connect_le(conn->device);
 		if (ret)
-			device_set_state(connection->device,
-							DEVICE_CONNECT_INIT);
+			device_set_state(conn->device, DEVICE_CONNECT_INIT);
 		break;
 	case DEVICE_CONNECTED:
-		send_app_connect_notify(connection, GATT_SUCCESS);
+		notify_app_connect_status(conn, GATT_SUCCESS);
 		ret = true;
 		break;
 	case DEVICE_CONNECT_READY:
@@ -2544,7 +2545,7 @@ failed:
 	send_client_incl_service_notify(&service->id, incl, conn->id);
 }
 
-static bool search_included_services(struct app_connection *connection,
+static bool search_included_services(struct app_connection *conn,
 							struct service *service)
 {
 	struct get_included_data *data;
@@ -2557,7 +2558,7 @@ static bool search_included_services(struct app_connection *connection,
 	}
 
 	data->prim = service;
-	data->conn = connection;
+	data->conn = conn;
 
 	if (service->primary) {
 		start = service->prim.range.start;
@@ -2567,8 +2568,8 @@ static bool search_included_services(struct app_connection *connection,
 		end = service->incl.range.end;
 	}
 
-	gatt_find_included(connection->device->attrib, start, end,
-							get_included_cb, data);
+	gatt_find_included(conn->device->attrib, start, end, get_included_cb,
+									data);
 
 	return true;
 }
@@ -2925,9 +2926,8 @@ reply:
 	free(data);
 }
 
-static bool build_descr_cache(struct app_connection *connection,
-					struct service *srvc,
-					struct characteristic *ch)
+static bool build_descr_cache(struct app_connection *conn, struct service *srvc,
+						struct characteristic *ch)
 {
 	struct discover_desc_data *cb_data;
 	uint16_t start, end;
@@ -2944,11 +2944,11 @@ static bool build_descr_cache(struct app_connection *connection,
 	if (!cb_data)
 		return false;
 
-	cb_data->conn = connection;
+	cb_data->conn = conn;
 	cb_data->srvc = srvc;
 	cb_data->ch = ch;
 
-	if (!gatt_discover_desc(connection->device->attrib, start, end, NULL,
+	if (!gatt_discover_desc(conn->device->attrib, start, end, NULL,
 					gatt_discover_desc_cb, cb_data)) {
 		free(cb_data);
 		return false;
-- 
1.9.1

