Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/7] android/gatt: Rename connection struct
Date: Mon, 28 Apr 2014 15:32:03 +0200
Message-Id: <1398691926-1777-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This represents client or server application connection and not the io
connection thus should be named properly.
---
 android/gatt.c | 94 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2d860ff..706d009 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -118,7 +118,7 @@ struct service {
 struct notification_data {
 	struct hal_gatt_srvc_id service;
 	struct hal_gatt_gatt_id ch;
-	struct connection *conn;
+	struct app_connection *conn;
 	guint notif_id;
 	guint ind_id;
 	int ref;
@@ -140,7 +140,7 @@ struct gatt_device {
 	int conn_cnt;
 };
 
-struct connection {
+struct app_connection {
 	struct gatt_device *device;
 	struct gatt_app *app;
 	int32_t id;
@@ -303,7 +303,7 @@ static bool match_pending_device(const void *data, const void *user_data)
 
 static bool match_connection_by_id(const void *data, const void *user_data)
 {
-	const struct connection *conn = data;
+	const struct app_connection *conn = data;
 	const int32_t id = PTR_TO_INT(user_data);
 
 	return conn->id == id;
@@ -312,13 +312,13 @@ static bool match_connection_by_id(const void *data, const void *user_data)
 static bool match_connection_by_device_and_app(const void *data,
 							const void *user_data)
 {
-	const struct connection *conn = data;
-	const struct connection *match = user_data;
+	const struct app_connection *conn = data;
+	const struct app_connection *match = user_data;
 
 	return conn->device == match->device && conn->app == match->app;
 }
 
-static struct connection *find_connection_by_id(int32_t conn_id)
+static struct app_connection *find_connection_by_id(int32_t conn_id)
 {
 	return queue_find(app_connections, match_connection_by_id,
 							INT_TO_PTR(conn_id));
@@ -326,7 +326,7 @@ static struct connection *find_connection_by_id(int32_t conn_id)
 
 static bool match_connection_by_device(const void *data, const void *user_data)
 {
-	const struct connection *conn = data;
+	const struct app_connection *conn = data;
 	const struct gatt_device *dev = user_data;
 
 	return conn->device == dev;
@@ -334,7 +334,7 @@ static bool match_connection_by_device(const void *data, const void *user_data)
 
 static bool match_connection_by_app(const void *data, const void *user_data)
 {
-	const struct connection *conn = data;
+	const struct app_connection *conn = data;
 	const struct gatt_app *app = user_data;
 
 	return conn->app == app;
@@ -598,7 +598,7 @@ failed:
 									status);
 }
 
-static void send_client_disconnection_notify(struct connection *connection,
+static void send_client_disconnection_notify(struct app_connection *connection,
 								int32_t status)
 {
 	struct hal_ev_gatt_client_disconnect ev;
@@ -613,7 +613,7 @@ static void send_client_disconnection_notify(struct connection *connection,
 				HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
 }
 
-static void send_client_connection_notify(struct connection *connection,
+static void send_client_connection_notify(struct app_connection *connection,
 								int32_t status)
 {
 	struct hal_ev_gatt_client_connect ev;
@@ -628,7 +628,7 @@ static void send_client_connection_notify(struct connection *connection,
 							sizeof(ev), &ev);
 }
 
-static void send_app_disconnect_notify(struct connection *connection,
+static void send_app_disconnect_notify(struct app_connection *connection,
 								int32_t status)
 {
 	if (connection->app->type == APP_CLIENT)
@@ -636,7 +636,7 @@ static void send_app_disconnect_notify(struct connection *connection,
 	/* TODO: handle APP_SERVER */
 }
 
-static void send_app_connect_notify(struct connection *connection,
+static void send_app_connect_notify(struct app_connection *connection,
 								int32_t status)
 {
 	if (connection->app->type == APP_CLIENT)
@@ -646,7 +646,7 @@ static void send_app_connect_notify(struct connection *connection,
 
 static void disconnect_notify_by_device(void *data, void *user_data)
 {
-	struct connection *conn = data;
+	struct app_connection *conn = data;
 	struct gatt_device *dev = user_data;
 
 	if (dev != conn->device)
@@ -694,7 +694,7 @@ static void device_unref(struct gatt_device *device)
 
 static void destroy_connection(void *data)
 {
-	struct connection *conn = data;
+	struct app_connection *conn = data;
 
 	if (!queue_find(gatt_devices, match_by_value, conn->device))
 		goto cleanup;
@@ -738,7 +738,7 @@ static void send_client_primary_notify(void *data, void *user_data)
 					sizeof(ev), &ev);
 }
 
-static void send_client_all_primary(struct connection *connection,
+static void send_client_all_primary(struct app_connection *connection,
 								int32_t status)
 {
 	struct hal_ev_gatt_client_search_complete ev;
@@ -804,7 +804,7 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
-	struct connection *conn = user_data;
+	struct app_connection *conn = user_data;
 	GSList *l;
 	int32_t gatt_status;
 	uint8_t instance_id;
@@ -923,7 +923,7 @@ struct connect_data {
 
 static void send_app_connect_notifications(void *data, void *user_data)
 {
-	struct connection *conn = data;
+	struct app_connection *conn = data;
 	struct connect_data *con_data = user_data;
 
 	if (conn->device == con_data->dev)
@@ -1119,14 +1119,14 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 	return device_ref(dev);
 }
 
-static struct connection *create_connection(struct gatt_device *device,
+static struct app_connection *create_connection(struct gatt_device *device,
 						struct gatt_app *app)
 {
-	struct connection *new_conn;
+	struct app_connection *new_conn;
 	static int32_t last_conn_id = 1;
 
 	/* Check if already connected */
-	new_conn = new0(struct connection, 1);
+	new_conn = new0(struct app_connection, 1);
 	if (!new_conn)
 		return NULL;
 
@@ -1149,7 +1149,7 @@ static struct connection *create_connection(struct gatt_device *device,
 	return new_conn;
 }
 
-static void trigger_disconnection(struct connection *connection)
+static void trigger_disconnection(struct app_connection *connection)
 {
 	/* Notify client */
 	if (queue_remove(app_connections, connection))
@@ -1160,7 +1160,7 @@ static void trigger_disconnection(struct connection *connection)
 
 static void app_disconnect_devices(struct gatt_app *client)
 {
-	struct connection *conn;
+	struct app_connection *conn;
 
 	/* find every connection for client record and trigger disconnect */
 	conn = queue_remove_if(app_connections, match_connection_by_app,
@@ -1173,7 +1173,7 @@ static void app_disconnect_devices(struct gatt_app *client)
 	}
 }
 
-static bool trigger_connection(struct connection *connection)
+static bool trigger_connection(struct app_connection *connection)
 {
 	switch (connection->device->state) {
 	case DEVICE_DISCONNECTED:
@@ -1224,10 +1224,10 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static struct connection *find_conn(const bdaddr_t *addr, int32_t app_id,
+static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 							int32_t app_type)
 {
-	struct connection conn_match;
+	struct app_connection conn_match;
 	struct gatt_device *dev = NULL;
 	struct gatt_app *app;
 
@@ -1256,8 +1256,8 @@ static struct connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 static void handle_client_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_connect *cmd = buf;
-	struct connection conn_match;
-	struct connection *conn;
+	struct app_connection conn_match;
+	struct app_connection *conn;
 	struct gatt_device *device;
 	struct gatt_app *client;
 	bdaddr_t addr;
@@ -1311,7 +1311,7 @@ reply:
 static void handle_client_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_disconnect *cmd = buf;
-	struct connection *conn;
+	struct app_connection *conn;
 	uint8_t status;
 
 	DBG("");
@@ -1490,7 +1490,7 @@ done:
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
-	struct connection *conn;
+	struct app_connection *conn;
 	uint8_t status;
 
 	DBG("");
@@ -1567,7 +1567,7 @@ static void send_client_incl_service_notify(const struct service *prim,
 
 struct get_included_data {
 	struct service *prim;
-	struct connection *conn;
+	struct app_connection *conn;
 };
 
 static int get_inst_id_of_prim_services(const struct gatt_device *dev)
@@ -1583,7 +1583,7 @@ static int get_inst_id_of_prim_services(const struct gatt_device *dev)
 static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 {
 	struct get_included_data *data = user_data;
-	struct connection *conn = data->conn;
+	struct app_connection *conn = data->conn;
 	struct service *service = data->prim;
 	struct service *incl;
 	int instance_id;
@@ -1646,7 +1646,7 @@ failed:
 								GATT_FAILURE);
 }
 
-static bool search_included_services(struct connection *connection,
+static bool search_included_services(struct app_connection *connection,
 							struct service *service)
 {
 	struct get_included_data *data;
@@ -1667,11 +1667,11 @@ static bool search_included_services(struct connection *connection,
 }
 
 static bool find_service(int32_t conn_id, struct element_id *service_id,
-					struct connection **connection,
+					struct app_connection **connection,
 					struct service **service)
 {
 	struct service *srvc;
-	struct connection *conn;
+	struct app_connection *conn;
 
 	conn = find_connection_by_id(conn_id);
 	if (!conn) {
@@ -1696,7 +1696,7 @@ static bool find_service(int32_t conn_id, struct element_id *service_id,
 static void handle_client_get_included_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
-	struct connection *conn;
+	struct app_connection *conn;
 	struct service *prim_service;
 	struct service *incl_service;
 	struct element_id match_id;
@@ -1857,7 +1857,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
 	struct characteristic *ch;
 	struct element_id match_id;
-	struct connection *conn;
+	struct app_connection *conn;
 	struct service *srvc;
 	uint8_t status;
 
@@ -1998,7 +1998,7 @@ static uint16_t parse_descrs(const uint8_t *pdu, guint16 len,
 }
 
 struct discover_desc_data {
-	struct connection *conn;
+	struct app_connection *conn;
 	struct service *srvc;
 	struct characteristic *ch;
 
@@ -2009,7 +2009,7 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct discover_desc_data *data = user_data;
-	struct connection *conn = data->conn;
+	struct app_connection *conn = data->conn;
 	struct service *srvc = data->srvc;
 	struct characteristic *ch = data->ch;
 	struct descriptor *descr;
@@ -2045,7 +2045,7 @@ reply:
 	free(data);
 }
 
-static bool build_descr_cache(struct connection *connection,
+static bool build_descr_cache(struct app_connection *connection,
 					struct service *srvc,
 					struct characteristic *ch)
 {
@@ -2092,7 +2092,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
-	struct connection *conn;
+	struct app_connection *conn;
 	int32_t conn_id;
 	uint8_t primary;
 	uint8_t status;
@@ -2233,7 +2233,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
 	struct char_op_data *cb_data;
 	struct characteristic *ch;
-	struct connection *conn;
+	struct app_connection *conn;
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
@@ -2328,7 +2328,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
 	struct char_op_data *cb_data = NULL;
 	struct characteristic *ch;
-	struct connection *conn;
+	struct app_connection *conn;
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
@@ -2514,7 +2514,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 	struct element_id char_id;
 	struct element_id descr_id;
 	struct element_id srvc_id;
-	struct connection *conn;
+	struct app_connection *conn;
 	int32_t conn_id = 0;
 	uint8_t primary;
 	uint8_t status;
@@ -2629,7 +2629,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	struct element_id srvc_id;
 	struct element_id char_id;
 	struct element_id descr_id;
-	struct connection *conn;
+	struct app_connection *conn;
 	int32_t conn_id;
 	uint8_t primary;
 	uint8_t status;
@@ -2752,7 +2752,7 @@ static void write_execute_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_execute_write(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_execute_write *cmd = buf;
-	struct connection *conn;
+	struct app_connection *conn;
 	uint8_t status;
 	uint8_t flags;
 
@@ -2847,7 +2847,7 @@ static void handle_client_register_for_notification(const void *buf,
 	struct notification_data *notification;
 	struct characteristic *c;
 	struct element_id match_id;
-	struct connection *conn;
+	struct app_connection *conn;
 	int32_t conn_id = 0;
 	struct service *service;
 	uint8_t status;
@@ -2953,7 +2953,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 {
 	const struct hal_cmd_gatt_client_deregister_for_notification *cmd = buf;
 	struct notification_data *notification, notif;
-	struct connection *conn;
+	struct app_connection *conn;
 	int32_t conn_id = 0;
 	uint8_t status;
 	int32_t gatt_status;
-- 
1.9.1

