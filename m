Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 3/5] android/gatt: Create device and connect bonded devices
Date: Mon,  9 Jun 2014 11:15:49 +0300
Message-Id: <1402301751-26353-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402301751-26353-1-git-send-email-luiz.dentz@gmail.com>
References: <1402301751-26353-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Devices bonded should be connected so later their services can be
discovered.
---
 android/gatt.c | 618 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 313 insertions(+), 305 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8a8419c..013337c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -627,151 +627,99 @@ static void destroy_gatt_app(void *data)
 	free(app);
 }
 
-static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
-						int rssi, uint16_t eir_len,
-						const void *eir,
-						bool discoverable, bool bonded)
-{
-	uint8_t buf[IPC_MTU];
-	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
-	struct gatt_device *dev;
-	char bda[18];
-
-	if (!scanning || (!discoverable && !bonded))
-		goto connect;
-
-	ba2str(addr, bda);
-	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
-
-	bdaddr2android(addr, ev->bda);
-	ev->rssi = rssi;
-	ev->len = eir_len;
-
-	memcpy(ev->adv_data, eir, ev->len);
+enum pend_req_state {
+	REQUEST_INIT,
+	REQUEST_PENDING,
+	REQUEST_DONE,
+};
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-						HAL_EV_GATT_CLIENT_SCAN_RESULT,
-						sizeof(*ev) + ev->len, ev);
+struct pending_request {
+	uint16_t handle;
+	int length;
+	uint8_t *value;
+	uint16_t offset;
 
-connect:
-	dev = find_device_by_addr(addr);
-	if (!dev || (dev->state != DEVICE_CONNECT_INIT))
-		return;
+	uint8_t *filter_value;
+	uint16_t filter_vlen;
 
-	device_set_state(dev, DEVICE_CONNECT_READY);
-	dev->bdaddr_type = addr_type;
+	enum pend_req_state state;
+	uint8_t error;
+};
 
-	if (!scanning) {
-		connect_next_dev();
-		return;
-	}
+static void destroy_pending_request(void *data)
+{
+	struct pending_request *entry = data;
 
-	/*
-	 * We are ok to perform connect now. Stop discovery
-	 * and once it is stopped continue with creating ACL
-	 */
-	bt_le_discovery_stop(bt_le_discovery_stop_cb);
+	free(entry->value);
+	free(entry->filter_value);
+	free(entry);
 }
 
-static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
+static void destroy_device(void *data)
 {
-	static int32_t application_id = 1;
-	struct gatt_app *app;
-
-	if (queue_find(gatt_apps, match_app_by_uuid, uuid)) {
-		error("gatt: app uuid is already on list");
-		return NULL;
-	}
-
-	/* Register LE once the first app register */
-	if (queue_isempty(gatt_apps))
-		bt_le_register(le_device_found_handler);
-
-	app = new0(struct gatt_app, 1);
-	if (!app) {
-		error("gatt: Cannot allocate memory for registering app");
-		return 0;
-	}
-
-	app->type = type;
+	struct gatt_device *dev = data;
 
-	if (app->type == GATT_CLIENT) {
-		app->notifications = queue_new();
-		if (!app->notifications) {
-			error("gatt: couldn't allocate notifications queue");
-			destroy_gatt_app(app);
-			return NULL;
-		}
-	}
+	if (!dev)
+		return;
 
-	memcpy(app->uuid, uuid, sizeof(app->uuid));
+	queue_destroy(dev->services, destroy_service);
+	queue_destroy(dev->pending_requests, destroy_pending_request);
 
-	app->id = application_id++;
+	free(dev);
+}
 
-	if (!queue_push_head(gatt_apps, app)) {
-		error("gatt: Cannot push app on the list");
-		destroy_gatt_app(app);
+static struct gatt_device *device_ref(struct gatt_device *device)
+{
+	if (!device)
 		return NULL;
-	}
 
-	if ((app->type == GATT_SERVER) &&
-			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
-		error("gatt: Cannot push server on the list");
-		destroy_gatt_app(app);
-		return NULL;
-	}
+	device->ref++;
 
-	return app;
+	return device;
 }
 
-static void handle_client_register(const void *buf, uint16_t len)
+static void device_unref(struct gatt_device *device)
 {
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
+	if (!device)
+		return;
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
+	if (--device->ref)
+		return;
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-							HAL_STATUS_SUCCESS);
+	destroy_device(device);
 }
 
-static void send_client_disconnection_notify(struct app_connection *connection,
-								int32_t status)
+static struct gatt_device *create_device(const bdaddr_t *addr)
 {
-	struct hal_ev_gatt_client_disconnect ev;
+	struct gatt_device *dev;
 
-	if (connection->app->func) {
-		connection->app->func(&connection->device->bdaddr, -ENOTCONN,
-						connection->device->attrib);
-		return;
-	}
+	dev = new0(struct gatt_device, 1);
+	if (!dev)
+		return NULL;
 
-	ev.client_if = connection->app->id;
-	ev.conn_id = connection->id;
-	ev.status = status;
+	bacpy(&dev->bdaddr, addr);
 
-	bdaddr2android(&connection->device->bdaddr, &ev.bda);
+	dev->services = queue_new();
+	if (!dev->services) {
+		error("gatt: Failed to allocate memory for client");
+		destroy_device(dev);
+		return NULL;
+	}
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-				HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
+	dev->pending_requests = queue_new();
+	if (!dev->pending_requests) {
+		error("gatt: Failed to allocate memory for client");
+		destroy_device(dev);
+		return NULL;
+	}
 
+	if (!queue_push_head(gatt_devices, dev)) {
+		error("gatt: Cannot push device to queue");
+		destroy_device(dev);
+		return NULL;
+	}
+
+	return device_ref(dev);
 }
 
 static void send_client_connection_notify(struct app_connection *connection,
@@ -818,6 +766,28 @@ static void send_server_connection_notify(struct app_connection *connection,
 				HAL_EV_GATT_SERVER_CONNECTION, sizeof(ev), &ev);
 }
 
+static void send_client_disconnection_notify(struct app_connection *connection,
+								int32_t status)
+{
+	struct hal_ev_gatt_client_disconnect ev;
+
+	if (connection->app->func) {
+		connection->app->func(&connection->device->bdaddr, -ENOTCONN,
+						connection->device->attrib);
+		return;
+	}
+
+	ev.client_if = connection->app->id;
+	ev.conn_id = connection->id;
+	ev.status = status;
+
+	bdaddr2android(&connection->device->bdaddr, &ev.bda);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
+
+}
+
 static void send_app_disconnect_notify(struct app_connection *connection,
 								int32_t status)
 {
@@ -851,68 +821,6 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 		send_app_connect_notify(conn, GATT_FAILURE);
 }
 
-enum pend_req_state {
-	REQUEST_INIT,
-	REQUEST_PENDING,
-	REQUEST_DONE,
-};
-
-struct pending_request {
-	uint16_t handle;
-	int length;
-	uint8_t *value;
-	uint16_t offset;
-
-	uint8_t *filter_value;
-	uint16_t filter_vlen;
-
-	enum pend_req_state state;
-	uint8_t error;
-};
-
-static void destroy_pending_request(void *data)
-{
-	struct pending_request *entry = data;
-
-	free(entry->value);
-	free(entry->filter_value);
-	free(entry);
-}
-
-static void destroy_device(void *data)
-{
-	struct gatt_device *dev = data;
-
-	if (!dev)
-		return;
-
-	queue_destroy(dev->services, destroy_service);
-	queue_destroy(dev->pending_requests, destroy_pending_request);
-
-	free(dev);
-}
-
-static struct gatt_device *device_ref(struct gatt_device *device)
-{
-	if (!device)
-		return NULL;
-
-	device->ref++;
-
-	return device;
-}
-
-static void device_unref(struct gatt_device *device)
-{
-	if (!device)
-		return;
-
-	if (--device->ref)
-		return;
-
-	destroy_device(device);
-}
-
 static void destroy_connection(void *data)
 {
 	struct app_connection *conn = data;
@@ -940,72 +848,6 @@ static void device_disconnect_clients(struct gatt_device *dev)
 							destroy_connection);
 }
 
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
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
-}
-
-static struct service *create_service(uint8_t id, bool primary, char *uuid,
-								void *data)
-{
-	struct service *s;
-
-	s = new0(struct service, 1);
-	if (!s) {
-		error("gatt: Cannot allocate memory for gatt_primary");
-		return NULL;
-	}
-
-	s->chars = queue_new();
-	if (!s->chars) {
-		error("gatt: Cannot allocate memory for char cache");
-		free(s);
-		return NULL;
-	}
-
-	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
-		error("gatt: Cannot convert string to uuid");
-		queue_destroy(s->chars, NULL);
-		free(s);
-		return NULL;
-	}
-
-	s->id.instance = id;
-
-	/* Put primary service to our local list */
-	s->primary = primary;
-	if (s->primary) {
-		memcpy(&s->prim, data, sizeof(s->prim));
-	} else {
-		memcpy(&s->incl, data, sizeof(s->incl));
-		return s;
-	}
-
-	/* For primary service allocate queue for included services */
-	s->included = queue_new();
-	if (!s->included) {
-		queue_destroy(s->chars, NULL);
-		free(s);
-		return NULL;
-	}
-
-	return s;
-}
-
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1023,20 +865,6 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-struct connect_data {
-	struct gatt_device *dev;
-	int32_t status;
-};
-
-static void send_app_connect_notifications(void *data, void *user_data)
-{
-	struct app_connection *conn = data;
-	struct connect_data *con_data = user_data;
-
-	if (conn->device == con_data->dev)
-		send_app_connect_notify(conn, con_data->status);
-}
-
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
 static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -1140,6 +968,20 @@ static void notify_att_range_change(struct gatt_device *dev,
 		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 }
 
+struct connect_data {
+	struct gatt_device *dev;
+	int32_t status;
+};
+
+static void send_app_connect_notifications(void *data, void *user_data)
+{
+	struct app_connection *conn = data;
+	struct connect_data *con_data = user_data;
+
+	if (conn->device == con_data->dev)
+		send_app_connect_notify(conn, con_data->status);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1267,6 +1109,218 @@ static int connect_le(struct gatt_device *dev)
 	return 0;
 }
 
+static int connect_next_dev(void)
+{
+	struct gatt_device *dev;
+
+	DBG("");
+
+	dev = find_device_by_state(DEVICE_CONNECT_READY);
+	if (!dev)
+		return -ENODEV;
+
+	return connect_le(dev);
+}
+
+static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
+						int rssi, uint16_t eir_len,
+						const void *eir,
+						bool discoverable, bool bonded)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
+	struct gatt_device *dev;
+	char bda[18];
+
+	if (!scanning || (!discoverable && !bonded))
+		goto connect;
+
+	ba2str(addr, bda);
+	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
+
+	bdaddr2android(addr, ev->bda);
+	ev->rssi = rssi;
+	ev->len = eir_len;
+
+	memcpy(ev->adv_data, eir, ev->len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+						HAL_EV_GATT_CLIENT_SCAN_RESULT,
+						sizeof(*ev) + ev->len, ev);
+
+connect:
+	dev = find_device_by_addr(addr);
+	if (!dev) {
+		if (!bonded)
+			return;
+
+		dev = create_device(addr);
+		if (!dev)
+			return;
+		connect_le(dev);
+		return;
+	}
+
+	device_set_state(dev, DEVICE_CONNECT_READY);
+	dev->bdaddr_type = addr_type;
+
+	if (!scanning) {
+		connect_next_dev();
+		return;
+	}
+
+	/*
+	 * We are ok to perform connect now. Stop discovery
+	 * and once it is stopped continue with creating ACL
+	 */
+	bt_le_discovery_stop(bt_le_discovery_stop_cb);
+}
+
+static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
+{
+	static int32_t application_id = 1;
+	struct gatt_app *app;
+
+	if (queue_find(gatt_apps, match_app_by_uuid, uuid)) {
+		error("gatt: app uuid is already on list");
+		return NULL;
+	}
+
+	/* Register LE once the first app register */
+	if (queue_isempty(gatt_apps))
+		bt_le_register(le_device_found_handler);
+
+	app = new0(struct gatt_app, 1);
+	if (!app) {
+		error("gatt: Cannot allocate memory for registering app");
+		return 0;
+	}
+
+	app->type = type;
+
+	if (app->type == GATT_CLIENT) {
+		app->notifications = queue_new();
+		if (!app->notifications) {
+			error("gatt: couldn't allocate notifications queue");
+			destroy_gatt_app(app);
+			return NULL;
+		}
+	}
+
+	memcpy(app->uuid, uuid, sizeof(app->uuid));
+
+	app->id = application_id++;
+
+	if (!queue_push_head(gatt_apps, app)) {
+		error("gatt: Cannot push app on the list");
+		destroy_gatt_app(app);
+		return NULL;
+	}
+
+	if ((app->type == GATT_SERVER) &&
+			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
+		error("gatt: Cannot push server on the list");
+		destroy_gatt_app(app);
+		return NULL;
+	}
+
+	return app;
+}
+
+static void handle_client_register(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_register *cmd = buf;
+	struct hal_ev_gatt_client_register_client ev;
+	struct gatt_app *app;
+
+	DBG("");
+
+	memset(&ev, 0, sizeof(ev));
+
+	app = register_app(cmd->uuid, GATT_CLIENT);
+
+	if (app) {
+		ev.client_if = app->id;
+		ev.status = GATT_SUCCESS;
+	} else
+		ev.status = GATT_FAILURE;
+
+	/* We should send notification with given in cmd UUID */
+	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
+							HAL_STATUS_SUCCESS);
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
 static void handle_client_scan(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_scan *cmd = buf;
@@ -1315,19 +1369,6 @@ reply:
 									status);
 }
 
-static int connect_next_dev(void)
-{
-	struct gatt_device *dev;
-
-	DBG("");
-
-	dev = find_device_by_state(DEVICE_CONNECT_READY);
-	if (!dev)
-		return -ENODEV;
-
-	return connect_le(dev);
-}
-
 static void bt_le_discovery_stop_cb(void)
 {
 	DBG("");
@@ -1337,39 +1378,6 @@ static void bt_le_discovery_stop_cb(void)
 		bt_le_discovery_start();
 }
 
-static struct gatt_device *create_device(const bdaddr_t *addr)
-{
-	struct gatt_device *dev;
-
-	dev = new0(struct gatt_device, 1);
-	if (!dev)
-		return NULL;
-
-	bacpy(&dev->bdaddr, addr);
-
-	dev->services = queue_new();
-	if (!dev->services) {
-		error("gatt: Failed to allocate memory for client");
-		destroy_device(dev);
-		return NULL;
-	}
-
-	dev->pending_requests = queue_new();
-	if (!dev->pending_requests) {
-		error("gatt: Failed to allocate memory for client");
-		destroy_device(dev);
-		return NULL;
-	}
-
-	if (!queue_push_head(gatt_devices, dev)) {
-		error("gatt: Cannot push device to queue");
-		destroy_device(dev);
-		return NULL;
-	}
-
-	return device_ref(dev);
-}
-
 static struct app_connection *create_connection(struct gatt_device *device,
 						struct gatt_app *app)
 {
-- 
1.9.3

