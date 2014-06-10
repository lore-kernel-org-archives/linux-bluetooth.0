Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] android/gatt: Automatically discover primary services for bonded devices
Date: Tue, 10 Jun 2014 18:54:02 +0300
Message-Id: <1402415643-32300-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
References: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/gatt.c | 637 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 353 insertions(+), 284 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8f65827..2fad341 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -791,6 +791,9 @@ static void send_client_disconnection_notify(struct app_connection *connection,
 static void send_app_disconnect_notify(struct app_connection *connection,
 								int32_t status)
 {
+	if (!connection->app)
+		return;
+
 	if (connection->app->type == GATT_CLIENT)
 		send_client_disconnection_notify(connection, status);
 	else
@@ -800,6 +803,9 @@ static void send_app_disconnect_notify(struct app_connection *connection,
 static void send_app_connect_notify(struct app_connection *connection,
 								int32_t status)
 {
+	if (!connection->app)
+		return;
+
 	if (connection->app->type == GATT_CLIENT)
 		send_client_connection_notify(connection, status);
 	else if (connection->app->type == GATT_SERVER)
@@ -811,7 +817,7 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 	struct app_connection *conn = data;
 	struct gatt_device *dev = user_data;
 
-	if (dev != conn->device)
+	if (dev != conn->device || !conn->app)
 		return;
 
 	if (dev->state == DEVICE_CONNECTED)
@@ -968,6 +974,317 @@ static void notify_att_range_change(struct gatt_device *dev,
 		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 }
 
+static struct app_connection *create_connection(struct gatt_device *device,
+						struct gatt_app *app)
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
+	new_conn->device->conn_cnt++;
+
+	return new_conn;
+}
+
+static struct service *create_service(uint8_t id, bool primary, char *uuid,
+								void *data)
+{
+	struct service *s;
+
+	s = new0(struct service, 1);
+	if (!s) {
+		error("gatt: Cannot allocate memory for gatt_primary");
+		return NULL;
+	}
+
+	s->chars = queue_new();
+	if (!s->chars) {
+		error("gatt: Cannot allocate memory for char cache");
+		free(s);
+		return NULL;
+	}
+
+	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
+		error("gatt: Cannot convert string to uuid");
+		queue_destroy(s->chars, NULL);
+		free(s);
+		return NULL;
+	}
+
+	s->id.instance = id;
+
+	/* Put primary service to our local list */
+	s->primary = primary;
+	if (s->primary) {
+		memcpy(&s->prim, data, sizeof(s->prim));
+	} else {
+		memcpy(&s->incl, data, sizeof(s->incl));
+		return s;
+	}
+
+	/* For primary service allocate queue for included services */
+	s->included = queue_new();
+	if (!s->included) {
+		queue_destroy(s->chars, NULL);
+		free(s);
+		return NULL;
+	}
+
+	return s;
+}
+
+static void send_client_primary_notify(void *data, void *user_data)
+{
+	struct hal_ev_gatt_client_search_result ev;
+	struct service *p = data;
+	int32_t conn_id = PTR_TO_INT(user_data);
+
+	/* In service queue we will have also included services */
+	if (!p->primary)
+		return;
+
+	ev.conn_id  = conn_id;
+	element_id_to_hal_srvc_id(&p->id, 1, &ev.srvc_id);
+
+	uuid2android(&p->id.uuid, ev.srvc_id.uuid);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
+}
+
+static void send_client_search_complete_notify(int32_t status, int32_t conn_id)
+{
+	struct hal_ev_gatt_client_search_complete ev;
+
+	ev.status = status;
+	ev.conn_id = conn_id;
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
+}
+
+struct discover_srvc_data {
+	bt_uuid_t uuid;
+	struct app_connection *conn;
+};
+
+static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct gatt_primary prim;
+	struct service *s;
+	int32_t gatt_status;
+	struct gatt_device *dev = cb_data->conn->device;
+	uint8_t instance_id = queue_length(dev->services);
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover pri srvc filtered by uuid failed: %s",
+							att_ecode2str(status));
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!ranges) {
+		info("gatt: No primary services searched by uuid found");
+		gatt_status = GATT_SUCCESS;
+		goto reply;
+	}
+
+	bt_uuid_to_string(&cb_data->uuid, prim.uuid, sizeof(prim.uuid));
+	/*
+	 * If multiple instances of the same service (as identified by UUID)
+	 * exist, the first instance of the service is returned.
+	 */
+	memcpy(&prim.range, ranges->data, sizeof(prim.range));
+
+	s = create_service(instance_id++, true, prim.uuid, &prim);
+	if (!s) {
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!queue_push_tail(dev->services, s)) {
+		error("gatt: Cannot push primary service to the list");
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
+
+	DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+		prim.range.start, prim.range.end, prim.uuid);
+
+	/* Partial search service scanning was performed */
+	dev->partial_srvc_search = true;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
+	free(cb_data);
+}
+
+static void discover_srvc_all_cb(uint8_t status, GSList *services,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct gatt_device *dev = cb_data->conn->device;
+	int32_t gatt_status;
+	GSList *l;
+	/*
+	 * There might be multiply services with same uuid. Therefore make sure
+	 * each primary service one has unique instance_id
+	 */
+	uint8_t instance_id = queue_length(dev->services);
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover all primary services failed: %s",
+							att_ecode2str(status));
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!services) {
+		info("gatt: No primary services found");
+		gatt_status = GATT_SUCCESS;
+		goto reply;
+	}
+
+	for (l = services; l; l = l->next) {
+		struct gatt_primary *prim = l->data;
+		struct service *p;
+
+		if (queue_find(dev->services, match_srvc_by_range,
+								&prim->range))
+			continue;
+
+		p = create_service(instance_id++, true, prim->uuid, prim);
+		if (!p)
+			continue;
+
+		if (!queue_push_tail(dev->services, p)) {
+			error("gatt: Cannot push primary service to the list");
+			free(p);
+			continue;
+		}
+
+		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+			prim->range.start, prim->range.end, prim->uuid);
+	}
+
+	/*
+	 * Send all found services notifications - first cache,
+	 * then send notifies
+	 */
+	queue_foreach(dev->services, send_client_primary_notify,
+						INT_TO_PTR(cb_data->conn->id));
+
+	/* Full search service scanning was performed */
+	dev->partial_srvc_search = false;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
+	free(cb_data);
+}
+
+static void discover_primary_cb(uint8_t status, GSList *services,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct app_connection *conn = cb_data->conn;
+	struct gatt_device *dev = conn->device;
+	GSList *l, *uuids = NULL;
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover all primary services failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!services) {
+		info("gatt: No primary services found");
+		return;
+	}
+
+	for (l = services; l; l = l->next) {
+		struct gatt_primary *prim = l->data;
+		uint8_t *new_uuid;
+		bt_uuid_t uuid;
+
+		DBG("uuid: %s", prim->uuid);
+
+		if (bt_string_to_uuid(&uuid, prim->uuid) < 0) {
+			error("gatt: Cannot convert string to uuid");
+			continue;
+		}
+
+		new_uuid = g_memdup(&uuid.value.u128, sizeof(uuid.value.u128));
+
+		uuids = g_slist_prepend(uuids, new_uuid);
+	}
+
+	bt_device_set_uuids(&dev->bdaddr, uuids);
+
+	free(cb_data);
+	queue_remove(app_connections, conn);
+	destroy_connection(conn);
+}
+
+static guint search_dev_for_srvc(struct app_connection *conn, bt_uuid_t *uuid)
+{
+	struct discover_srvc_data *cb_data =
+					new0(struct discover_srvc_data, 1);
+
+	if (!cb_data) {
+		error("gatt: Cannot allocate cb data");
+		return 0;
+	}
+
+	cb_data->conn = conn;
+
+	if (uuid) {
+		memcpy(&cb_data->uuid, uuid, sizeof(cb_data->uuid));
+		return gatt_discover_primary(conn->device->attrib, uuid,
+					discover_srvc_by_uuid_cb, cb_data);
+	}
+
+
+	if (conn->app)
+		return gatt_discover_primary(conn->device->attrib, NULL,
+						discover_srvc_all_cb, cb_data);
+
+	return gatt_discover_primary(conn->device->attrib, NULL,
+						discover_primary_cb, cb_data);
+}
+
 struct connect_data {
 	struct gatt_device *dev;
 	int32_t status;
@@ -1051,6 +1368,19 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	status = GATT_SUCCESS;
 
 reply:
+	if (!dev->conn_cnt) {
+		struct app_connection *conn;
+
+		if (!dev->attrib)
+			return;
+
+		conn = create_connection(dev, NULL);
+		if (!conn)
+			return;
+
+		search_dev_for_srvc(conn, NULL);
+	}
+
 	data.dev = dev;
 	data.status = status;
 	queue_foreach(app_connections, send_app_connect_notifications, &data);
@@ -1215,105 +1545,39 @@ static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
 	if ((app->type == GATT_SERVER) &&
 			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
 		error("gatt: Cannot push server on the list");
-		destroy_gatt_app(app);
-		return NULL;
-	}
-
-	return app;
-}
-
-static void handle_client_register(const void *buf, uint16_t len)
-{
-	const struct hal_cmd_gatt_client_register *cmd = buf;
-	struct hal_ev_gatt_client_register_client ev;
-	struct gatt_app *app;
-
-	DBG("");
-
-	memset(&ev, 0, sizeof(ev));
-
-	app = register_app(cmd->uuid, GATT_CLIENT);
-
-	if (app) {
-		ev.client_if = app->id;
-		ev.status = GATT_SUCCESS;
-	} else
-		ev.status = GATT_FAILURE;
-
-	/* We should send notification with given in cmd UUID */
-	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
-
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-							HAL_STATUS_SUCCESS);
-}
-
-static void send_client_primary_notify(void *data, void *user_data)
-{
-	struct hal_ev_gatt_client_search_result ev;
-	struct service *p = data;
-	int32_t conn_id = PTR_TO_INT(user_data);
-
-	/* In service queue we will have also included services */
-	if (!p->primary)
-		return;
-
-	ev.conn_id  = conn_id;
-	element_id_to_hal_srvc_id(&p->id, 1, &ev.srvc_id);
-
-	uuid2android(&p->id.uuid, ev.srvc_id.uuid);
+		destroy_gatt_app(app);
+		return NULL;
+	}
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
+	return app;
 }
 
-static struct service *create_service(uint8_t id, bool primary, char *uuid,
-								void *data)
+static void handle_client_register(const void *buf, uint16_t len)
 {
-	struct service *s;
+	const struct hal_cmd_gatt_client_register *cmd = buf;
+	struct hal_ev_gatt_client_register_client ev;
+	struct gatt_app *app;
 
-	s = new0(struct service, 1);
-	if (!s) {
-		error("gatt: Cannot allocate memory for gatt_primary");
-		return NULL;
-	}
+	DBG("");
 
-	s->chars = queue_new();
-	if (!s->chars) {
-		error("gatt: Cannot allocate memory for char cache");
-		free(s);
-		return NULL;
-	}
+	memset(&ev, 0, sizeof(ev));
 
-	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
-		error("gatt: Cannot convert string to uuid");
-		queue_destroy(s->chars, NULL);
-		free(s);
-		return NULL;
-	}
+	app = register_app(cmd->uuid, GATT_CLIENT);
 
-	s->id.instance = id;
+	if (app) {
+		ev.client_if = app->id;
+		ev.status = GATT_SUCCESS;
+	} else
+		ev.status = GATT_FAILURE;
 
-	/* Put primary service to our local list */
-	s->primary = primary;
-	if (s->primary) {
-		memcpy(&s->prim, data, sizeof(s->prim));
-	} else {
-		memcpy(&s->incl, data, sizeof(s->incl));
-		return s;
-	}
+	/* We should send notification with given in cmd UUID */
+	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));
 
-	/* For primary service allocate queue for included services */
-	s->included = queue_new();
-	if (!s->included) {
-		queue_destroy(s->chars, NULL);
-		free(s);
-		return NULL;
-	}
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
 
-	return s;
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
+							HAL_STATUS_SUCCESS);
 }
 
 static void handle_client_scan(const void *buf, uint16_t len)
@@ -1373,40 +1637,6 @@ static void bt_le_discovery_stop_cb(void)
 		bt_le_discovery_start();
 }
 
-static struct app_connection *create_connection(struct gatt_device *device,
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
@@ -1757,167 +1987,6 @@ done:
 									status);
 }
 
-struct discover_srvc_data {
-	bt_uuid_t uuid;
-	struct app_connection *conn;
-};
-
-static void send_client_search_complete_notify(int32_t status, int32_t conn_id)
-{
-	struct hal_ev_gatt_client_search_complete ev;
-
-	ev.status = status;
-	ev.conn_id = conn_id;
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
-}
-
-static void discover_srvc_all_cb(uint8_t status, GSList *services,
-								void *user_data)
-{
-	struct discover_srvc_data *cb_data = user_data;
-	struct gatt_device *dev = cb_data->conn->device;
-	int32_t gatt_status;
-	GSList *l;
-	/*
-	 * There might be multiply services with same uuid. Therefore make sure
-	 * each primary service one has unique instance_id
-	 */
-	uint8_t instance_id = queue_length(dev->services);
-
-	DBG("Status %d", status);
-
-	if (status) {
-		error("gatt: Discover all primary services failed: %s",
-							att_ecode2str(status));
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
-
-	if (!services) {
-		info("gatt: No primary services found");
-		gatt_status = GATT_SUCCESS;
-		goto reply;
-	}
-
-	for (l = services; l; l = l->next) {
-		struct gatt_primary *prim = l->data;
-		struct service *p;
-
-		if (queue_find(dev->services, match_srvc_by_range,
-								&prim->range))
-			continue;
-
-		p = create_service(instance_id++, true, prim->uuid, prim);
-		if (!p)
-			continue;
-
-		if (!queue_push_tail(dev->services, p)) {
-			error("gatt: Cannot push primary service to the list");
-			free(p);
-			continue;
-		}
-
-		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
-			prim->range.start, prim->range.end, prim->uuid);
-	}
-
-	/*
-	 * Send all found services notifications - first cache,
-	 * then send notifies
-	 */
-	queue_foreach(dev->services, send_client_primary_notify,
-						INT_TO_PTR(cb_data->conn->id));
-
-	/* Full search service scanning was performed */
-	dev->partial_srvc_search = false;
-	gatt_status = GATT_SUCCESS;
-
-reply:
-	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
-	free(cb_data);
-}
-
-static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
-								void *user_data)
-{
-	struct discover_srvc_data *cb_data = user_data;
-	struct gatt_primary prim;
-	struct service *s;
-	int32_t gatt_status;
-	struct gatt_device *dev = cb_data->conn->device;
-	uint8_t instance_id = queue_length(dev->services);
-
-	DBG("Status %d", status);
-
-	if (status) {
-		error("gatt: Discover pri srvc filtered by uuid failed: %s",
-							att_ecode2str(status));
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
-
-	if (!ranges) {
-		info("gatt: No primary services searched by uuid found");
-		gatt_status = GATT_SUCCESS;
-		goto reply;
-	}
-
-	bt_uuid_to_string(&cb_data->uuid, prim.uuid, sizeof(prim.uuid));
-	/*
-	 * If multiple instances of the same service (as identified by UUID)
-	 * exist, the first instance of the service is returned.
-	 */
-	memcpy(&prim.range, ranges->data, sizeof(prim.range));
-
-	s = create_service(instance_id++, true, prim.uuid, &prim);
-	if (!s) {
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
-
-	if (!queue_push_tail(dev->services, s)) {
-		error("gatt: Cannot push primary service to the list");
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
-
-	send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
-
-	DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
-		prim.range.start, prim.range.end, prim.uuid);
-
-	/* Partial search service scanning was performed */
-	dev->partial_srvc_search = true;
-	gatt_status = GATT_SUCCESS;
-
-reply:
-	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
-	free(cb_data);
-}
-
-static guint search_dev_for_srvc(struct app_connection *conn, bt_uuid_t *uuid)
-{
-	struct discover_srvc_data *cb_data =
-					new0(struct discover_srvc_data, 1);
-
-	if (!cb_data) {
-		error("gatt: Cannot allocate cb data");
-		return 0;
-	}
-
-	cb_data->conn = conn;
-
-	if (uuid) {
-		memcpy(&cb_data->uuid, uuid, sizeof(cb_data->uuid));
-		return gatt_discover_primary(conn->device->attrib, uuid,
-					discover_srvc_by_uuid_cb, cb_data);
-	}
-
-	return gatt_discover_primary(conn->device->attrib, NULL,
-						discover_srvc_all_cb, cb_data);
-}
-
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
-- 
1.9.3

