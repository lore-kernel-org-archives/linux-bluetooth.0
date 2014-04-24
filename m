Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/2] android/gatt: Refactor client connection handling
Date: Thu, 24 Apr 2014 15:01:58 +0200
Message-Id: <1398344519-8994-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398344519-8994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398344519-8994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple, connection specific device lists were replaced with one,
while devices store their connection state instead. Client list in each
device were replaced with single, global list, storing (connection_id,
client*, device*) tuples. This seams to be more natural and easier to
perform actions which are mostly triggered by specific clients on
specific device or connection.

Connection id previously assigned to device now properly identifies
client<->device and not the physical adapter<->device connection.
---
 android/gatt.c | 1000 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 520 insertions(+), 480 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8c7909a..76dca5c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,20 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+typedef enum {
+	DEVICE_DISCONNECTED = 0,
+	DEVICE_CONNECTION_PENDING,
+	DEVICE_CONNECTABLE,
+	DEVICE_CONNECTED,
+} gatt_device_state_t;
+
+static const char const *device_state_str[] = {
+	"DISCONNECTED",
+	"CONNECTION PENDING",
+	"CONNECTABLE",
+	"CONNECTED",
+};
+
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
@@ -98,8 +112,7 @@ struct service {
 struct notification_data {
 	struct hal_gatt_srvc_id service;
 	struct hal_gatt_gatt_id ch;
-	struct gatt_client *client;
-	struct gatt_device *dev;
+	struct connection *conn;
 	guint notif_id;
 	guint ind_id;
 	int ref;
@@ -109,16 +122,21 @@ struct gatt_device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 
-	struct queue *clients;
-
-	bool connect_ready;
-	int32_t conn_id;
+	gatt_device_state_t state;
 
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
 
 	guint watch_id;
+
+	uint32_t conn_ref;
+};
+
+struct connection {
+	struct gatt_device *device;
+	struct gatt_client *client;
+	int32_t id;
 };
 
 static struct ipc *hal_ipc = NULL;
@@ -127,9 +145,8 @@ static bool scanning = false;
 
 static struct queue *gatt_clients = NULL;
 static struct queue *gatt_servers = NULL;
-static struct queue *conn_list = NULL;		/* Connected devices */
-static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
-static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
+static struct queue *gatt_devices = NULL;
+static struct queue *client_connections = NULL;
 
 static struct queue *listen_clients = NULL;
 
@@ -268,7 +285,7 @@ static bool match_by_value(const void *data, const void *user_data)
 	return data == user_data;
 }
 
-static bool match_dev_by_bdaddr(const void *data, const void *user_data)
+static bool match_device_by_bdaddr(const void *data, const void *user_data)
 {
 	const struct gatt_device *dev = data;
 	const bdaddr_t *addr = user_data;
@@ -276,26 +293,87 @@ static bool match_dev_by_bdaddr(const void *data, const void *user_data)
 	return !bacmp(&dev->bdaddr, addr);
 }
 
-static bool match_dev_connect_ready(const void *data, const void *user_data)
+static bool match_device_by_state(const void *data, const void *user_data)
 {
 	const struct gatt_device *dev = data;
 
-	return dev->connect_ready;
+	if (dev->state != PTR_TO_UINT(user_data))
+		return false;
+
+	return true;
 }
 
-static bool match_dev_by_conn_id(const void *data, const void *user_data)
+static bool match_connectable_or_pending_device(const void *data,
+							const void *user_data)
 {
 	const struct gatt_device *dev = data;
-	const int32_t conn_id = PTR_TO_INT(user_data);
 
-	return dev->conn_id == conn_id;
+	if ((dev->state == DEVICE_CONNECTION_PENDING) ||
+					(dev->state == DEVICE_CONNECTABLE))
+		return true;
+
+	return false;
 }
 
-static bool match_dev_without_client(const void *data, const void *user_data)
+static bool match_connection_by_id(const void *data, const void *user_data)
 {
-	const struct gatt_device *dev = data;
+	const struct connection *conn = data;
+	const int32_t id = PTR_TO_INT(user_data);
+
+	return conn->id == id;
+}
+
+static bool match_connection_by_device_and_client(const void *data,
+							const void *user_data)
+{
+	const struct connection *conn = data;
+	const struct connection *match = user_data;
+
+	return conn->device == match->device && conn->client == match->client;
+}
+
+static struct connection *find_connection_by_id(int32_t conn_id)
+{
+	return queue_find(client_connections, match_connection_by_id,
+							INT_TO_PTR(conn_id));
+}
+
+static bool match_connection_by_device(const void *data, const void *user_data)
+{
+	const struct connection *conn = data;
+	const struct gatt_device *dev = user_data;
+
+	return conn->device == dev;
+}
+
+static bool match_connection_by_client(const void *data, const void *user_data)
+{
+	const struct connection *conn = data;
+	const struct gatt_client *client = user_data;
+
+	return conn->client == client;
+}
+
+static struct gatt_device *find_device(struct gatt_device *dev)
+{
+	return queue_find(gatt_devices, match_by_value, dev);
+}
+
+static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
+{
+	return queue_find(gatt_devices, match_device_by_bdaddr, (void *)addr);
+}
+
+static struct gatt_device *find_connectable_or_pending_device()
+{
+	return queue_find(gatt_devices, match_connectable_or_pending_device,
+									NULL);
+}
 
-	return queue_isempty(dev->clients);
+static struct gatt_device *find_device_by_state(uint32_t state)
+{
+	return queue_find(gatt_devices, match_device_by_state,
+							UINT_TO_PTR(state));
 }
 
 static bool match_srvc_by_element_id(const void *data, const void *user_data)
@@ -355,7 +433,7 @@ static bool match_notification(const void *a, const void *b)
 	const struct notification_data *a1 = a;
 	const struct notification_data *b1 = b;
 
-	if (bacmp(&a1->dev->bdaddr, &b1->dev->bdaddr))
+	if (a1->conn != b1->conn)
 		return false;
 
 	if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
@@ -381,11 +459,13 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
 static void destroy_notification(void *data)
 {
 	struct notification_data *notification = data;
+	struct gatt_client *client;
 
 	if (--notification->ref)
 		return;
 
-	queue_remove_if(notification->client->notifications, match_notification,
+	client = notification->conn->client;
+	queue_remove_if(client->notifications, match_notification,
 								notification);
 	free(notification);
 }
@@ -393,14 +473,31 @@ static void destroy_notification(void *data)
 static void unregister_notification(void *data)
 {
 	struct notification_data *notification = data;
+	struct gatt_device *dev = notification->conn->device;
 
-	if (notification->notif_id)
-		g_attrib_unregister(notification->dev->attrib,
-							notification->notif_id);
+	/* No device means it was already disconnected and client cleanup was
+	 * triggered afterwards, but once client unregisters, device stays if
+	 * used by others. Then just unregister single handle.
+	 */
+	if (!queue_find(gatt_devices, match_by_value, dev))
+		return;
+
+	if (notification->notif_id && dev)
+		g_attrib_unregister(dev->attrib, notification->notif_id);
 
-	if (notification->ind_id)
-		g_attrib_unregister(notification->dev->attrib,
-							notification->ind_id);
+	if (notification->ind_id && dev)
+		g_attrib_unregister(dev->attrib, notification->ind_id);
+}
+
+static void device_set_state(struct gatt_device *dev, uint32_t state)
+{
+	char bda[18];
+
+	ba2str(&dev->bdaddr, bda);
+	DBG("gatt: Device %s state changed %s -> %s", bda,
+			device_state_str[dev->state], device_state_str[state]);
+
+	dev->state = state;
 }
 
 static void connection_cleanup(struct gatt_device *device)
@@ -422,21 +519,17 @@ static void connection_cleanup(struct gatt_device *device)
 		g_attrib_cancel_all(attrib);
 		g_attrib_unref(attrib);
 	}
-}
-
-static void destroy_device(void *data)
-{
-	struct gatt_device *dev = data;
-
-	if (!dev)
-		return;
 
-	if (dev->conn_id)
-		connection_cleanup(dev);
+	/* If device was in connection_pending or connectable state we
+	 * search device list if we should stop the scan.
+	 */
+	if (!scanning && (device->state == DEVICE_CONNECTION_PENDING ||
+					device->state == DEVICE_CONNECTABLE)) {
+		if (!find_connectable_or_pending_device())
+			bt_le_discovery_stop(NULL);
+	}
 
-	queue_destroy(dev->clients, NULL);
-	queue_destroy(dev->services, destroy_service);
-	free(dev);
+	device_set_state(device, DEVICE_DISCONNECTED);
 }
 
 static void destroy_gatt_client(void *data)
@@ -531,123 +624,89 @@ failed:
 									status);
 }
 
-static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
-								int32_t status)
+static void send_client_connection_notify(struct connection *connection,
+							int32_t gatt_event,
+							int32_t status)
 {
 	struct hal_ev_gatt_client_disconnect ev;
 
-	ev.client_if = id;
-	ev.conn_id = dev->conn_id;
+	ev.client_if = connection->client->id;
+	ev.conn_id = connection->id;
 	ev.status = status;
-	bdaddr2android(&dev->bdaddr, &ev.bda);
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
-}
-
-static void send_client_connect_notify(int32_t id, struct gatt_device *dev,
-								int32_t status)
-{
-	struct hal_ev_gatt_client_connect ev;
+	bdaddr2android(&connection->device->bdaddr, &ev.bda);
 
-	ev.client_if = id;
-	ev.status = status;
-	bdaddr2android(&dev->bdaddr, &ev.bda);
-	ev.conn_id = status == GATT_SUCCESS ? dev->conn_id : 0;
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-				HAL_EV_GATT_CLIENT_CONNECT, sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, gatt_event, sizeof(ev),
+									&ev);
 }
 
-static void remove_client_from_device_list(void *data, void *user_data)
+static void send_client_disconnect_notify(struct connection *connection,
+								int32_t status)
 {
-	struct gatt_device *dev = data;
-
-	queue_remove_if(dev->clients, match_by_value, user_data);
+	send_client_connection_notify(connection, HAL_EV_GATT_CLIENT_DISCONNECT,
+									status);
 }
 
-static void put_device_on_disc_list(struct gatt_device *dev)
+static void send_client_connect_notify(struct connection *connection,
+								int32_t status)
 {
-	dev->conn_id = 0;
-	queue_remove_all(dev->clients, NULL, NULL, NULL);
-	queue_push_tail(disc_dev_list, dev);
+	send_client_connection_notify(connection, HAL_EV_GATT_CLIENT_CONNECT,
+									status);
 }
 
-static void cleanup_conn_list(int32_t id)
+static void disconnect_notify_by_device(void *data, void *user_data)
 {
-	struct gatt_device *dev;
+	struct connection *conn = data;
+	struct gatt_device *dev = user_data;
 
-	/* Find device without client */
-	dev = queue_remove_if(conn_list, match_dev_without_client, NULL);
-	while (dev) {
-		/* Device is connected, lets disconnect and notify client */
-		connection_cleanup(dev);
-		send_client_disconnect_notify(id, dev, GATT_SUCCESS);
+	if (dev != conn->device)
+		return;
 
-		/* Put device on disconnected device list */
-		put_device_on_disc_list(dev);
-		dev = queue_remove_if(conn_list, match_dev_without_client,
-									NULL);
-	};
+	if (dev->state == DEVICE_CONNECTED)
+		send_client_disconnect_notify(conn, GATT_SUCCESS);
+	else if (dev->state == DEVICE_CONNECTION_PENDING ||
+					dev->state == DEVICE_CONNECTABLE)
+		send_client_connect_notify(conn, GATT_FAILURE);
 }
 
-static void cleanup_conn_wait_queue(int32_t id)
+static void destroy_connection(void *data)
 {
-	struct gatt_device *dev;
+	struct connection *conn = data;
 
-	/* Find device without client */
-	dev = queue_remove_if(conn_wait_queue, match_dev_without_client, NULL);
-	while (dev) {
-		send_client_connect_notify(id, dev, GATT_FAILURE);
+	if (!queue_find(gatt_devices, match_by_value, conn->device))
+		goto cleanup;
 
-		/* Put device on disconnected device list */
-		put_device_on_disc_list(dev);
-		dev = queue_remove_if(conn_wait_queue,
-						match_dev_without_client, NULL);
-	};
+	conn->device->conn_ref--;
+	if (conn->device->conn_ref == 0)
+		connection_cleanup(conn->device);
 
-	/* Stop scan we had for connecting devices */
-	if (queue_isempty(conn_wait_queue) && !scanning)
-		bt_le_discovery_stop(NULL);
+cleanup:
+	free(conn);
 }
 
-static void remove_client_from_devices(int32_t id)
+static void device_disconnect_clients(struct gatt_device *dev)
 {
-	DBG("");
+	/* Notify disconnection to all clients */
+	queue_foreach(client_connections, disconnect_notify_by_device, dev);
 
-	queue_foreach(conn_list, remove_client_from_device_list,
-							INT_TO_PTR(id));
-	cleanup_conn_list(id);
-
-	queue_foreach(conn_wait_queue, remove_client_from_device_list,
-							INT_TO_PTR(id));
-	cleanup_conn_wait_queue(id);
+	/* Remove all clients by given device's */
+	queue_remove_all(client_connections, match_connection_by_device, dev,
+							destroy_connection);
 }
 
-static void handle_client_unregister(const void *buf, uint16_t len)
+static void destroy_device(void *data)
 {
-	const struct hal_cmd_gatt_client_unregister *cmd = buf;
-	uint8_t status;
-	struct gatt_client *cl;
+	struct gatt_device *dev = data;
 
-	DBG("");
+	if (!dev)
+		return;
 
-	cl = queue_remove_if(gatt_clients, match_client_by_id,
-						INT_TO_PTR(cmd->client_if));
-	if (!cl) {
-		error("gatt: client_if=%d not found", cmd->client_if);
-		status = HAL_STATUS_FAILED;
-	} else {
-		/* Check if there is any connect request or connected device for this
-		 * client. If so, remove this client from those lists.
-		 */
-		remove_client_from_devices(cl->id);
-		destroy_gatt_client(cl);
-		status = HAL_STATUS_SUCCESS;
-	}
+	if (dev->state != DEVICE_DISCONNECTED)
+		device_disconnect_clients(dev);
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_UNREGISTER, status);
+	queue_destroy(dev->services, destroy_service);
+
+	free(dev);
 }
 
 static void send_client_primary_notify(void *data, void *user_data)
@@ -670,17 +729,18 @@ static void send_client_primary_notify(void *data, void *user_data)
 					sizeof(ev), &ev);
 }
 
-static void send_client_all_primary(int32_t status, struct queue *services,
-							int32_t conn_id)
+static void send_client_all_primary(struct connection *connection,
+								int32_t status)
 {
 	struct hal_ev_gatt_client_search_complete ev;
 
 	if (!status)
-		queue_foreach(services, send_client_primary_notify,
-							INT_TO_PTR(conn_id));
+		queue_foreach(connection->device->services,
+						send_client_primary_notify,
+						INT_TO_PTR(connection->id));
 
 	ev.status = status;
-	ev.conn_id = conn_id;
+	ev.conn_id = connection->id;
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
 
@@ -735,7 +795,7 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
-	struct gatt_device *dev = user_data;
+	struct connection *conn = user_data;
 	GSList *l;
 	int32_t gatt_status;
 	uint8_t instance_id;
@@ -755,7 +815,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		goto done;
 	}
 
-	if (!queue_isempty(dev->services)) {
+	if (!queue_isempty(conn->device->services)) {
 		info("gatt: Services already cached");
 		gatt_status = GATT_SUCCESS;
 		goto done;
@@ -774,7 +834,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		if (!p)
 			continue;
 
-		if (!queue_push_tail(dev->services, p)) {
+		if (!queue_push_tail(conn->device->services, p)) {
 			error("gatt: Cannot push primary service to the list");
 			free(p);
 			continue;
@@ -787,36 +847,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	gatt_status = GATT_SUCCESS;
 
 done:
-	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
-}
-
-static void client_disconnect_notify(void *data, void *user_data)
-{
-	struct gatt_device *dev = user_data;
-	int32_t id = PTR_TO_INT(data);
-
-	send_client_disconnect_notify(id, dev, GATT_SUCCESS);
-}
-
-static bool is_device_wating_for_connect(const bdaddr_t *addr,
-							uint8_t addr_type)
-{
-	struct gatt_device *dev;
-
-	DBG("");
-
-	dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, (void *)addr);
-	if (!dev)
-		return false;
-
-	dev->bdaddr_type = addr_type;
-
-	/* Mark that this device is ready for connect.
-	 * Need it because will continue with connect after scan is stopped
-	 */
-	dev->connect_ready = true;
-
-	return true;
+	send_client_all_primary(conn, gatt_status);
 }
 
 static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
@@ -826,6 +857,7 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
+	struct gatt_device *dev;
 	char bda[18];
 
 	if (!scanning || !discoverable)
@@ -845,9 +877,13 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						sizeof(*ev) + ev->len, ev);
 
 connect:
-	if (!is_device_wating_for_connect(addr, addr_type))
+	dev = find_device_by_addr(addr);
+	if (!dev || (dev->state != DEVICE_CONNECTION_PENDING))
 		return;
 
+	device_set_state(dev, DEVICE_CONNECTABLE);
+	dev->bdaddr_type = addr_type;
+
 	/* We are ok to perform connect now. Stop discovery
 	 * and once it is stopped continue with creating ACL
 	 */
@@ -861,45 +897,36 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 	int sock, err = 0;
 	socklen_t len;
 
-	queue_remove(conn_list, dev);
-
 	sock = g_io_channel_unix_get_fd(io);
 	len = sizeof(err);
 	if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
 		DBG("%s (%d)", strerror(err), err);
 
-	connection_cleanup(dev);
-
-	queue_foreach(dev->clients, client_disconnect_notify, dev);
-
-	/* Reset conn_id and put on disconnected list. */
-	put_device_on_disc_list(dev);
+	device_disconnect_clients(dev);
 
 	return FALSE;
 }
 
-struct connect_data {
-	struct gatt_device *dev;
-	int32_t status;
-};
-
 static void send_client_connect_notifications(void *data, void *user_data)
 {
-	int32_t id = PTR_TO_INT(data);
-	struct connect_data *c = user_data;
+	struct connection *conn = data;
+	uint32_t status = PTR_TO_UINT(user_data);
 
-	send_client_connect_notify(id, c->dev, c->status);
+	send_client_connect_notify(conn, status);
 }
 
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
-	struct connect_data data;
+	uint32_t status;
 	GAttrib *attrib;
-	static uint32_t conn_id = 0;
 
-	/* Take device from conn waiting queue */
-	if (!queue_remove(conn_wait_queue, dev)) {
+	/* Look for device if connection request is valid.
+	 * TODO: Is this even possible when we have dev->att_io check
+	 * in connect_le()?
+	 */
+	dev = find_device(dev);
+	if (!dev || dev->state != DEVICE_CONNECTABLE) {
 		error("gatt: Device not on the connect wait queue!?");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
@@ -910,38 +937,31 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	if (gerr) {
 		error("gatt: connection failed %s", gerr->message);
-		data.status = GATT_FAILURE;
+		status = GATT_FAILURE;
 		goto reply;
 	}
 
 	attrib = g_attrib_new(io);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
-		data.status = GATT_FAILURE;
+		status = GATT_FAILURE;
 		goto reply;
 	}
 
 	dev->attrib = attrib;
 	dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 							disconnected_cb, dev);
-	dev->conn_id = ++conn_id;
 
-	/* Move gatt device from connect queue to conn_list */
-	if (!queue_push_tail(conn_list, dev)) {
-		error("gatt: Cannot push dev on conn_list");
-		connection_cleanup(dev);
-		data.status = GATT_FAILURE;
-		goto reply;
-	}
+	device_set_state(dev, DEVICE_CONNECTED);
 
-	data.status = GATT_SUCCESS;
+	status = GATT_SUCCESS;
 
 reply:
-	data.dev = dev;
-	queue_foreach(dev->clients, send_client_connect_notifications, &data);
+	queue_foreach(client_connections, send_client_connect_notifications,
+							UINT_TO_PTR(status));
 
 	/* If connection did not succeed, destroy device */
-	if (data.status)
+	if (status)
 		destroy_device(dev);
 
 	/* Check if we should restart scan */
@@ -1050,16 +1070,9 @@ static int connect_next_dev(void)
 
 	DBG("");
 
-	if (queue_isempty(conn_wait_queue))
-		return 0;
-
-	/* Discovery has been stopped because there is connection waiting */
-	dev = queue_find(conn_wait_queue, match_dev_connect_ready, NULL);
+	dev = find_device_by_state(DEVICE_CONNECTABLE);
 	if (!dev)
-		/* Lets try again. */
-		return -1;
-
-	dev->connect_ready = false;
+		return -ENODEV;
 
 	return connect_le(dev);
 }
@@ -1073,22 +1086,6 @@ static void bt_le_discovery_stop_cb(void)
 		bt_le_discovery_start(le_device_found_handler);
 }
 
-static struct gatt_device *find_device(bdaddr_t *addr)
-{
-	struct gatt_device *dev;
-
-	dev = queue_find(conn_list, match_dev_by_bdaddr, addr);
-	if (dev)
-		return dev;
-
-	return queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
-}
-
-static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
-{
-	return queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
-}
-
 static struct gatt_device *create_device(bdaddr_t *addr)
 {
 	struct gatt_device *dev;
@@ -1099,96 +1096,199 @@ static struct gatt_device *create_device(bdaddr_t *addr)
 
 	bacpy(&dev->bdaddr, addr);
 
-	dev->clients = queue_new();
 	dev->services = queue_new();
-
-	if (!dev->clients || !dev->services) {
+	if (!dev->services) {
 		error("gatt: Failed to allocate memory for client");
 		destroy_device(dev);
 		return NULL;
 	}
 
+	if (!queue_push_head(gatt_devices, dev)) {
+		error("gatt: Cannot push device to queue");
+		destroy_device(dev);
+		return NULL;
+	}
+
 	return dev;
 }
 
-static void handle_client_connect(const void *buf, uint16_t len)
+static struct connection *create_connection(struct gatt_device *device,
+						struct gatt_client *client)
 {
-	const struct hal_cmd_gatt_client_connect *cmd = buf;
-	struct gatt_device *dev = NULL;
-	void *l;
-	bdaddr_t addr;
+	struct connection *new_conn;
+	static int32_t last_conn_id = 1;
+
+	/* Check if already connected */
+	new_conn = new0(struct connection, 1);
+	if (!new_conn)
+		return NULL;
+
+	/* Make connection id unique to connection record
+	 * (client, device) pair.
+	 */
+	new_conn->client = client;
+	new_conn->device = device;
+	new_conn->id = last_conn_id++;
+
+	if (!queue_push_head(client_connections, new_conn)) {
+		error("gatt: Cannot push client on the client queue!?");
+
+		free(new_conn);
+		return NULL;
+	}
+
+	new_conn->device->conn_ref++;
+
+	return new_conn;
+}
+
+static void trigger_disconnection(struct connection *connection)
+{
+	/* Notify client */
+	if (queue_remove(client_connections, connection))
+			send_client_disconnect_notify(connection, GATT_SUCCESS);
+
+	destroy_connection(connection);
+}
+
+static void client_disconnect_devices(struct gatt_client *client)
+{
+	struct connection *conn;
+
+	/* find every connection for client record and trigger disconnect */
+	conn = queue_remove_if(client_connections, match_connection_by_client,
+									client);
+	while (conn) {
+		trigger_disconnection(conn);
+
+		conn = queue_remove_if(client_connections,
+					match_connection_by_client, client);
+	}
+}
+
+static bool trigger_connection(struct connection *connection)
+{
+	switch (connection->device->state) {
+	case DEVICE_DISCONNECTED:
+		device_set_state(connection->device, DEVICE_CONNECTION_PENDING);
+		break;
+	case DEVICE_CONNECTED:
+		send_client_connect_notify(connection, GATT_SUCCESS);
+		break;
+	default:
+		break;
+	}
+
+	/* after state change trigger discovering */
+	if (!scanning && (connection->device->state == DEVICE_CONNECTION_PENDING))
+		if (!bt_le_discovery_start(le_device_found_handler)) {
+			error("gatt: Could not start scan");
+
+			return false;
+		}
+
+	return true;
+}
+
+static void handle_client_unregister(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_unregister *cmd = buf;
 	uint8_t status;
-	bool send_notify = false;
+	struct gatt_client *cl;
 
 	DBG("");
 
-	/* Check if client is registered */
-	l = find_client_by_id(cmd->client_if);
-	if (!l) {
-		error("gatt: Client id %d not found", cmd->client_if);
+	cl = queue_remove_if(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!cl) {
+		error("gatt: client_if=%d not found", cmd->client_if);
 		status = HAL_STATUS_FAILED;
-		goto reply;
+	} else {
+		/* Check if there is any connect request or connected device
+		 * for this client. If so, remove this client from those lists.
+		 */
+		client_disconnect_devices(cl);
+		destroy_gatt_client(cl);
+		status = HAL_STATUS_SUCCESS;
 	}
 
-	android2bdaddr(&cmd->bdaddr, &addr);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_UNREGISTER, status);
+}
 
-	/* We do support many clients for one device connection so lets check
-	 * If device is connected or in connecting state just update list of
-	 * clients
-	 */
-	dev = find_device(&addr);
-	if (dev) {
-		/* Remeber to send dummy notification event  if we area
-		 * connected
-		 */
-		if (dev->conn_id)
-			send_notify = true;
+static struct connection *find_connection_by_addr_and_client_id(bdaddr_t *addr,
+							int32_t client_id)
+{
+	struct connection conn_match;
+	struct gatt_device *dev = NULL;
+	struct gatt_client *client;
 
-		if (queue_find(dev->clients, match_by_value,
-						INT_TO_PTR(cmd->client_if))) {
-			status = HAL_STATUS_SUCCESS;
-			goto reply;
-		}
+	/* Check if client is registered */
+	client = find_client_by_id(client_id);
+	if (!client) {
+		error("gatt: Client id %d not found", client_id);
+		return NULL;
+	}
 
-		/* Store another client */
-		if (!queue_push_tail(dev->clients,
-						INT_TO_PTR(cmd->client_if))) {
-			error("gatt: Cannot push client on gatt device list");
-			status = HAL_STATUS_FAILED;
-			goto reply;
-		}
+	/* Check if device is known */
+	dev = find_device_by_addr(addr);
+	if (!dev) {
+		error("gatt: Client id %d not found", client_id);
+		return NULL;
+	}
 
-		status = HAL_STATUS_SUCCESS;
+	conn_match.device = dev;
+	conn_match.client = client;
+
+	return queue_find(client_connections,
+					match_connection_by_device_and_client,
+					&conn_match);
+}
+
+static void handle_client_connect(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_connect *cmd = buf;
+	struct connection conn_match;
+	struct connection *conn;
+	struct gatt_device *device;
+	struct gatt_client *client;
+	bdaddr_t addr;
+	uint8_t status;
+
+	DBG("");
+
+	client = find_client_by_id(cmd->client_if);
+	if (!client) {
+		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	/* Let's check if we know device already */
-	dev = queue_remove_if(disc_dev_list, match_dev_by_bdaddr, &addr);
-	if (!dev) {
-		/* New device, create it. */
-		dev = create_device(&addr);
-		if (!dev) {
+	android2bdaddr(&cmd->bdaddr, &addr);
+
+	device = find_device_by_addr(&addr);
+	if (!device) {
+		device = create_device(&addr);
+		if (!device) {
 			status = HAL_STATUS_FAILED;
 			goto reply;
 		}
 	}
 
-	/* Update client list of device */
-	if (!queue_push_tail(dev->clients, INT_TO_PTR(cmd->client_if))) {
-		error("gatt: Cannot push client on the client queue!?");
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
+	conn_match.device = device;
+	conn_match.client = client;
 
-	/* Start le scan if not started */
-	if (!scanning && !bt_le_discovery_start(le_device_found_handler)) {
-		error("gatt: Could not start scan");
-		status = HAL_STATUS_FAILED;
-		goto reply;
+	conn = queue_find(client_connections,
+					match_connection_by_device_and_client,
+					&conn_match);
+	if (!conn) {
+		conn = create_connection(device, client);
+		if (!conn) {
+			status = HAL_STATUS_NOMEM;
+			goto reply;
+		}
 	}
 
-	if (!queue_push_tail(conn_wait_queue, dev)) {
-		error("gatt: Cannot push device on conn_wait_queue");
+	if (!trigger_connection(conn)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -1198,81 +1298,25 @@ static void handle_client_connect(const void *buf, uint16_t len)
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
 								status);
-
-	/* If there is an error here we should make sure dev is out. */
-	if ((status != HAL_STATUS_SUCCESS) && dev) {
-		destroy_device(dev);
-		return;
-	}
-
-	/* Send dummy notification since ACL is already up */
-	if (send_notify) {
-		struct hal_ev_gatt_client_connect ev;
-
-		ev.conn_id = dev->conn_id;
-		ev.status = GATT_SUCCESS;
-		ev.client_if = cmd->client_if;
-		bdaddr2android(&addr, &ev.bda);
-
-		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-						HAL_EV_GATT_CLIENT_CONNECT,
-						sizeof(ev), &ev);
-	}
 }
 
 static void handle_client_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_disconnect *cmd = buf;
-	struct gatt_device *dev;
-	bdaddr_t bdaddr;
+	struct connection *conn;
 	uint8_t status;
-	char addr[18];
 
 	DBG("");
 
-	android2bdaddr(cmd->bdaddr, &bdaddr);
-	ba2str(&bdaddr, addr);
-
-	dev = find_device_by_conn_id(cmd->conn_id);
-	if (!dev) {
-		error("gatt: dev %s with conn_id=%d not found",
-							addr, cmd->conn_id);
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
+	/* TODO: should we care to match also bdaddr when conn_id is unique? */
+	conn = find_connection_by_id(cmd->conn_id);
+	if (conn)
+		trigger_disconnection(conn);
 
-	/* Check if client owns this connection */
-	if (!queue_remove_if(dev->clients, match_by_value,
-						INT_TO_PTR(cmd->client_if))) {
-		error("gatt: cannot remove conn_id=%d", cmd->client_if);
-		status = HAL_STATUS_FAILED;
-	} else {
-		status = HAL_STATUS_SUCCESS;
-	}
+	status = HAL_STATUS_SUCCESS;
 
-reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_OP_GATT_CLIENT_DISCONNECT, status);
-
-	if (status == HAL_STATUS_FAILED)
-		return;
-
-	/* Just send disconnect event. If there is more clients on this
-	 * device then this is what we shall to do.
-	 * If this is last client, this is still OK to do because on connect
-	 * request we do le scan and wait until remote device start
-	 * advertisement
-	 */
-	send_client_disconnect_notify(cmd->client_if, dev, GATT_SUCCESS);
-
-	/* If there is more clients just return */
-	if (!queue_isempty(dev->clients))
-		return;
-
-	/* If this is last client do more cleaning */
-	connection_cleanup(dev);
-	queue_remove(conn_list, dev);
-	put_device_on_disc_list(dev);
 }
 
 static void send_client_listen_notify(int32_t id, int32_t status)
@@ -1420,7 +1464,7 @@ static void handle_client_refresh(const void *buf, uint16_t len)
 	DBG("");
 
 	android2bdaddr(&cmd->bdaddr, &bda);
-	dev = find_device(&bda);
+	dev = find_device_by_addr(&bda);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
@@ -1438,7 +1482,7 @@ done:
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
-	struct gatt_device *dev;
+	struct connection *conn;
 	uint8_t status;
 
 	DBG("");
@@ -1450,9 +1494,10 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		return;
 	}
 
-	dev = find_device_by_conn_id(cmd->conn_id);
-	if (!dev) {
+	conn = find_connection_by_id(cmd->conn_id);
+	if (!conn || !conn->device) {
 		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
+
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -1460,14 +1505,25 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 	/* TODO:  Handle filter uuid */
 
 	/* Use cache if possible */
-	if (!queue_isempty(dev->services)) {
+	if (!queue_isempty(conn->device->services)) {
+		send_client_all_primary(conn, GATT_SUCCESS);
+
 		status = HAL_STATUS_SUCCESS;
-		send_client_all_primary(GATT_SUCCESS, dev->services,
-								dev->conn_id);
 		goto reply;
 	}
 
-	if (!gatt_discover_primary(dev->attrib, NULL, primary_cb, dev)) {
+	if (conn->device->state != DEVICE_CONNECTED) {
+		char bda[18];
+
+		ba2str(&conn->device->bdaddr, bda);
+		error("gatt: device %s not connected", bda);
+
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	if (!gatt_discover_primary(conn->device->attrib, NULL, primary_cb,
+									conn)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -1503,7 +1559,7 @@ static void send_client_incl_service_notify(const struct service *prim,
 
 struct get_included_data {
 	struct service *prim;
-	struct gatt_device *device;
+	struct connection *conn;
 };
 
 static int get_inst_id_of_prim_services(const struct gatt_device *dev)
@@ -1519,7 +1575,7 @@ static int get_inst_id_of_prim_services(const struct gatt_device *dev)
 static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 {
 	struct get_included_data *data = user_data;
-	struct gatt_device *device = data->device;
+	struct connection *conn = data->conn;
 	struct service *service = data->prim;
 	struct service *incl;
 	int instance_id;
@@ -1541,7 +1597,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	 * id of primary service and start iterate included services from this
 	 * point.
 	 */
-	instance_id = get_inst_id_of_prim_services(device);
+	instance_id = get_inst_id_of_prim_services(conn->device);
 	if (instance_id < 0)
 		goto failed;
 
@@ -1559,7 +1615,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 		 * 2. on special queue inside primary service
 		 */
 		if (!queue_push_tail(service->included, incl) ||
-				!queue_push_tail(device->services, incl)) {
+			!queue_push_tail(conn->device->services, incl)) {
 			error("gatt: Cannot push incl service to the list");
 			destroy_service(incl);
 			continue;
@@ -1572,18 +1628,18 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	incl = queue_peek_head(service->included);
 
 	if (incl) {
-		send_client_incl_service_notify(service, incl, device->conn_id,
+		send_client_incl_service_notify(service, incl, conn->id,
 								GATT_SUCCESS);
 		return;
 	}
 
 failed:
-	send_client_incl_service_notify(service, NULL, device->conn_id,
+	send_client_incl_service_notify(service, NULL, conn->id,
 								GATT_FAILURE);
 }
 
-static bool search_included_services(struct gatt_device *dev,
-							struct service *prim)
+static bool search_included_services(struct connection *connection,
+							struct service *service)
 {
 	struct get_included_data *data;
 
@@ -1593,37 +1649,38 @@ static bool search_included_services(struct gatt_device *dev,
 		return false;
 	}
 
-	data->prim = prim;
-	data->device = dev;
+	data->prim = service;
+	data->conn = connection;
 
-	gatt_find_included(dev->attrib, prim->prim.range.start,
-							prim->prim.range.end,
-							get_included_cb, data);
+	gatt_find_included(connection->device->attrib,
+				service->prim.range.start,
+				service->prim.range.end, get_included_cb, data);
 	return true;
 }
 
 static bool find_service(int32_t conn_id, struct element_id *service_id,
-				struct gatt_device **dev, struct service **srvc)
+					struct connection **connection,
+					struct service **service)
 {
-	struct gatt_device *device;
-	struct service *service;
+	struct service *srvc;
+	struct connection *conn;
 
-	device = find_device_by_conn_id(conn_id);
-	if (!device) {
+	conn = find_connection_by_id(conn_id);
+	if (!conn || !conn->device) {
 		error("gatt: conn_id=%d not found", conn_id);
 		return false;
 	}
 
-	service = queue_find(device->services, match_srvc_by_element_id,
+	srvc = queue_find(conn->device->services, match_srvc_by_element_id,
 								service_id);
-	if (!service) {
+	if (!srvc) {
 		error("gatt: Service with inst_id: %d not found",
 							service_id->instance);
 		return false;
 	}
 
-	*dev = device;
-	*srvc = service;
+	*connection = conn;
+	*service = srvc;
 
 	return true;
 }
@@ -1631,7 +1688,7 @@ static bool find_service(int32_t conn_id, struct element_id *service_id,
 static void handle_client_get_included_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
-	struct gatt_device *device;
+	struct connection *conn;
 	struct service *prim_service;
 	struct service *incl_service;
 	struct element_id match_id;
@@ -1648,13 +1705,13 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	}
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
-	if (!find_service(cmd->conn_id, &match_id, &device, &prim_service)) {
+	if (!find_service(cmd->conn_id, &match_id, &conn, &prim_service)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
 	if (!prim_service->incl_search_done) {
-		if (search_included_services(device, prim_service))
+		if (search_included_services(conn, prim_service))
 			status = HAL_STATUS_SUCCESS;
 		else
 			status = HAL_STATUS_FAILED;
@@ -1677,10 +1734,10 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	 */
 	if (!incl_service)
 		send_client_incl_service_notify(prim_service, NULL,
-						device->conn_id, GATT_FAILURE);
+						conn->id, GATT_FAILURE);
 	else
 		send_client_incl_service_notify(prim_service, incl_service,
-						device->conn_id, GATT_SUCCESS);
+						conn->id, GATT_SUCCESS);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -1694,7 +1751,7 @@ reply:
 	 */
 	if (status)
 		send_client_incl_service_notify(prim_service, NULL,
-						device->conn_id, GATT_FAILURE);
+						conn->id, GATT_FAILURE);
 }
 
 static void send_client_char_notify(const struct characteristic *ch,
@@ -1792,7 +1849,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
 	struct characteristic *ch;
 	struct element_id match_id;
-	struct gatt_device *dev;
+	struct connection *conn;
 	struct service *srvc;
 	uint8_t status;
 
@@ -1806,7 +1863,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	}
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
-	if (!find_service(cmd->conn_id, &match_id, &dev, &srvc)) {
+	if (!find_service(cmd->conn_id, &match_id, &conn, &srvc)) {
 		status = HAL_STATUS_FAILED;
 		goto done;
 	}
@@ -1825,13 +1882,13 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		}
 
 		cb_data->service = srvc;
-		cb_data->conn_id = dev->conn_id;
+		cb_data->conn_id = conn->id;
 
 		range = srvc->primary ? srvc->prim.range : srvc->incl.range;
 
-		if (!gatt_discover_char(dev->attrib, range.start, range.end,
-							NULL, discover_char_cb,
-							cb_data)) {
+		if (!gatt_discover_char(conn->device->attrib, range.start,
+						range.end, NULL,
+						discover_char_cb, cb_data)) {
 			free(cb_data);
 
 			status = HAL_STATUS_FAILED;
@@ -1848,7 +1905,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	else
 		ch = queue_peek_head(srvc->chars);
 
-	send_client_char_notify(ch, dev->conn_id, srvc);
+	send_client_char_notify(ch, conn->id, srvc);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -1933,7 +1990,7 @@ static uint16_t parse_descrs(const uint8_t *pdu, guint16 len,
 }
 
 struct discover_desc_data {
-	struct gatt_device *dev;
+	struct connection *conn;
 	struct service *srvc;
 	struct characteristic *ch;
 
@@ -1944,7 +2001,7 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct discover_desc_data *data = user_data;
-	struct gatt_device *dev = data->dev;
+	struct connection *conn = data->conn;
 	struct service *srvc = data->srvc;
 	struct characteristic *ch = data->ch;
 	struct descriptor *descr;
@@ -1955,8 +2012,8 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		if (last_handle >= ch->end_handle)
 			goto reply;
 
-		if (!gatt_discover_char_desc(dev->attrib, last_handle + 1,
-						ch->end_handle,
+		if (!gatt_discover_char_desc(conn->device->attrib,
+						last_handle + 1, ch->end_handle,
 						gatt_discover_desc_cb, data))
 			goto reply;
 
@@ -1973,14 +2030,14 @@ reply:
 
 	descr = queue_peek_head(ch->descriptors);
 
-	send_client_descr_notify(status, dev->conn_id, srvc->primary, &srvc->id,
+	send_client_descr_notify(status, conn->id, srvc->primary, &srvc->id,
 						&ch->id,
 						descr ? &descr->id : NULL);
 
 	free(data);
 }
 
-static bool build_descr_cache(struct gatt_device *dev,
+static bool build_descr_cache(struct connection *connection,
 					struct service *srvc,
 					struct characteristic *ch)
 {
@@ -1999,7 +2056,7 @@ static bool build_descr_cache(struct gatt_device *dev,
 	if (!cb_data)
 		return false;
 
-	cb_data->dev = dev;
+	cb_data->conn = connection;
 	cb_data->srvc = srvc;
 	cb_data->ch = ch;
 	cb_data->result = queue_new();
@@ -2009,7 +2066,7 @@ static bool build_descr_cache(struct gatt_device *dev,
 		return false;
 	}
 
-	if (!gatt_discover_char_desc(dev->attrib, start, end,
+	if (!gatt_discover_char_desc(connection->device->attrib, start, end,
 					gatt_discover_desc_cb, cb_data)) {
 		queue_destroy(cb_data->result, NULL);
 		free(cb_data);
@@ -2027,7 +2084,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
-	struct gatt_device *dev;
+	struct connection *conn;
 	int32_t conn_id;
 	uint8_t primary;
 	uint8_t status;
@@ -2049,7 +2106,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
 	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 
-	if (!find_service(conn_id, &srvc_id, &dev, &srvc)) {
+	if (!find_service(conn_id, &srvc_id, &conn, &srvc)) {
 		error("gatt: Get descr. could not find service");
 
 		status = HAL_STATUS_FAILED;
@@ -2065,7 +2122,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	}
 
 	if (queue_isempty(ch->descriptors)) {
-		if (build_descr_cache(dev, srvc, ch)) {
+		if (build_descr_cache(conn, srvc, ch)) {
 			ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
 					HAL_STATUS_SUCCESS);
@@ -2168,7 +2225,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
 	struct char_op_data *cb_data;
 	struct characteristic *ch;
-	struct gatt_device *dev;
+	struct connection *conn;
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
@@ -2181,7 +2238,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
 	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 
-	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc)) {
+	if (!find_service(cmd->conn_id, &srvc_id, &conn, &srvc)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -2203,7 +2260,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!gatt_read_char(dev->attrib, ch->ch.value_handle,
+	if (!gatt_read_char(conn->device->attrib, ch->ch.value_handle,
 						read_char_cb, cb_data)) {
 		error("gatt: Cannot read characteristic with inst_id: %d",
 							cmd->char_id.inst_id);
@@ -2263,7 +2320,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
 	struct char_op_data *cb_data = NULL;
 	struct characteristic *ch;
-	struct gatt_device *dev;
+	struct connection *conn;
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
@@ -2281,7 +2338,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
 	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 
-	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc)) {
+	if (!find_service(cmd->conn_id, &srvc_id, &conn, &srvc)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -2307,17 +2364,18 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 
 	switch (cmd->write_type) {
 	case GATT_WRITE_TYPE_NO_RESPONSE:
-		res = gatt_write_cmd(dev->attrib, ch->ch.value_handle,
+		res = gatt_write_cmd(conn->device->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
 							NULL, NULL);
 		break;
 	case GATT_WRITE_TYPE_PREPARE:
-		res = gatt_reliable_write_char(dev->attrib, ch->ch.value_handle,
+		res = gatt_reliable_write_char(conn->device->attrib,
+							ch->ch.value_handle,
 							cmd->value, cmd->len,
 							write_char_cb, cb_data);
 		break;
 	case GATT_WRITE_TYPE_DEFAULT:
-		res = gatt_write_char(dev->attrib, ch->ch.value_handle,
+		res = gatt_write_char(conn->device->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
 							write_char_cb, cb_data);
 		break;
@@ -2448,7 +2506,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 	struct element_id char_id;
 	struct element_id descr_id;
 	struct element_id srvc_id;
-	struct gatt_device *dev;
+	struct connection *conn;
 	int32_t conn_id = 0;
 	uint8_t primary;
 	uint8_t status;
@@ -2462,7 +2520,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 	hal_gatt_id_to_element_id(&cmd->descr_id, &descr_id);
 
-	if (!find_service(conn_id, &srvc_id, &dev, &srvc)) {
+	if (!find_service(conn_id, &srvc_id, &conn, &srvc)) {
 		error("gatt: Read descr. could not find service");
 
 		status = HAL_STATUS_FAILED;
@@ -2495,7 +2553,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!gatt_read_char(dev->attrib, descr->handle, read_desc_cb,
+	if (!gatt_read_char(conn->device->attrib, descr->handle, read_desc_cb,
 								cb_data)) {
 		free(cb_data);
 
@@ -2563,7 +2621,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	struct element_id srvc_id;
 	struct element_id char_id;
 	struct element_id descr_id;
-	struct gatt_device *dev;
+	struct connection *conn;
 	int32_t conn_id;
 	uint8_t primary;
 	uint8_t status;
@@ -2585,7 +2643,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 	hal_gatt_id_to_element_id(&cmd->descr_id, &descr_id);
 
-	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc)) {
+	if (!find_service(cmd->conn_id, &srvc_id, &conn, &srvc)) {
 		error("gatt: Write descr. could not find service");
 
 		status = HAL_STATUS_FAILED;
@@ -2622,18 +2680,19 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 
 	switch (cmd->write_type) {
 	case GATT_WRITE_TYPE_NO_RESPONSE:
-		res = gatt_write_cmd(dev->attrib, descr->handle, cmd->value,
-					cmd->len, NULL , NULL);
+		res = gatt_write_cmd(conn->device->attrib, descr->handle,
+					cmd->value, cmd->len, NULL , NULL);
 		break;
 	case GATT_WRITE_TYPE_PREPARE:
-		res = gatt_reliable_write_char(dev->attrib, descr->handle,
-							cmd->value, cmd->len,
-							write_descr_cb,
-							cb_data);
+		res = gatt_reliable_write_char(conn->device->attrib,
+						descr->handle, cmd->value,
+						cmd->len, write_descr_cb,
+						cb_data);
 		break;
 	case GATT_WRITE_TYPE_DEFAULT:
-		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
-					cmd->len, write_descr_cb, cb_data);
+		res = gatt_write_char(conn->device->attrib, descr->handle,
+						cmd->value, cmd->len,
+						write_descr_cb, cb_data);
 		break;
 	default:
 		error("gatt: Write type %d unsupported", cmd->write_type);
@@ -2685,15 +2744,14 @@ static void write_execute_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_execute_write(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_execute_write *cmd = buf;
-	struct gatt_device *dev;
+	struct connection *conn;
 	uint8_t status;
 	uint8_t flags;
 
 	DBG("");
 
-	dev = queue_find(conn_list, match_dev_by_conn_id,
-						INT_TO_PTR(cmd->conn_id));
-	if (!dev) {
+	conn = find_connection_by_id(cmd->conn_id);
+	if (!conn->device) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
@@ -2701,7 +2759,7 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 	flags = cmd->execute ? ATT_WRITE_ALL_PREP_WRITES :
 						ATT_CANCEL_ALL_PREP_WRITES;
 
-	if (!gatt_execute_write(dev->attrib, flags, write_execute_cb,
+	if (!gatt_execute_write(conn->device->attrib, flags, write_execute_cb,
 						INT_TO_PTR(cmd->conn_id))) {
 		error("gatt: Could not send execute write");
 		status = HAL_STATUS_FAILED;
@@ -2731,8 +2789,8 @@ static void handle_notification(const uint8_t *pdu, uint16_t len,
 
 	memcpy(&ev->char_id, &notification->ch, sizeof(ev->char_id));
 	memcpy(&ev->srvc_id, &notification->service, sizeof(ev->srvc_id));
-	bdaddr2android(&notification->dev->bdaddr, &ev->bda);
-	ev->conn_id = notification->dev->conn_id;
+	bdaddr2android(&notification->conn->device->bdaddr, &ev->bda);
+	ev->conn_id = notification->conn->id;
 	ev->is_notify = pdu[0] == ATT_OP_HANDLE_NOTIFY;
 
 	/* We have to cut opcode and handle from data */
@@ -2744,11 +2802,13 @@ static void handle_notification(const uint8_t *pdu, uint16_t len,
 		uint16_t len;
 		size_t plen;
 
-		res = g_attrib_get_buffer(notification->dev->attrib, &plen);
+		res = g_attrib_get_buffer(
+				notification->conn->device->attrib,
+				&plen);
 		len = enc_confirmation(res, plen);
 		if (len > 0)
-			g_attrib_send(notification->dev->attrib, 0, res, len,
-							NULL, NULL, NULL);
+			g_attrib_send(notification->conn->device->attrib,
+						0, res, len, NULL, NULL, NULL);
 	}
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
@@ -2777,36 +2837,29 @@ static void handle_client_register_for_notification(const void *buf,
 {
 	const struct hal_cmd_gatt_client_register_for_notification *cmd = buf;
 	struct notification_data *notification;
-	struct gatt_client *client;
 	struct characteristic *c;
 	struct element_id match_id;
-	struct gatt_device *dev;
-	struct service *service;
+	struct connection *conn;
 	int32_t conn_id = 0;
+	struct service *service;
 	uint8_t status;
 	int32_t gatt_status;
 	bdaddr_t addr;
 
 	DBG("");
 
-	client = find_client_by_id(cmd->client_if);
-	if (!client) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
-	if (!dev) {
+	conn = find_connection_by_addr_and_client_id(&addr, cmd->client_if);
+	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	conn_id = dev->conn_id;
+	conn_id = conn->id;
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
-	service = queue_find(dev->services, match_srvc_by_element_id,
+	service = queue_find(conn->device->services, match_srvc_by_element_id,
 								&match_id);
 	if (!service) {
 		status = HAL_STATUS_FAILED;
@@ -2829,17 +2882,16 @@ static void handle_client_register_for_notification(const void *buf,
 	memcpy(&notification->ch, &cmd->char_id, sizeof(notification->ch));
 	memcpy(&notification->service, &cmd->srvc_id,
 						sizeof(notification->service));
-	notification->dev = dev;
-	notification->client = client;
+	notification->conn = conn;
 
-	if (queue_find(client->notifications, match_notification,
+	if (queue_find(conn->client->notifications, match_notification,
 								notification)) {
 		free(notification);
 		status = HAL_STATUS_SUCCESS;
 		goto failed;
 	}
 
-	notification->notif_id = g_attrib_register(dev->attrib,
+	notification->notif_id = g_attrib_register(conn->device->attrib,
 							ATT_OP_HANDLE_NOTIFY,
 							c->ch.value_handle,
 							handle_notification,
@@ -2851,13 +2903,15 @@ static void handle_client_register_for_notification(const void *buf,
 		goto failed;
 	}
 
-	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
+	notification->ind_id = g_attrib_register(conn->device->attrib,
+							ATT_OP_HANDLE_IND,
 							c->ch.value_handle,
 							handle_notification,
 							notification,
 							destroy_notification);
 	if (!notification->ind_id) {
-		g_attrib_unregister(dev->attrib, notification->notif_id);
+		g_attrib_unregister(conn->device->attrib,
+							notification->notif_id);
 		free(notification);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2869,7 +2923,7 @@ static void handle_client_register_for_notification(const void *buf,
 	 */
 	notification->ref = 2;
 
-	if (!queue_push_tail(client->notifications, notification)) {
+	if (!queue_push_tail(conn->client->notifications, notification)) {
 		unregister_notification(notification);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -2891,8 +2945,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 {
 	const struct hal_cmd_gatt_client_deregister_for_notification *cmd = buf;
 	struct notification_data *notification, notif;
-	struct gatt_client *client;
-	struct gatt_device *dev;
+	struct connection *conn;
 	int32_t conn_id = 0;
 	uint8_t status;
 	int32_t gatt_status;
@@ -2900,26 +2953,21 @@ static void handle_client_deregister_for_notification(const void *buf,
 
 	DBG("");
 
-	client = find_client_by_id(cmd->client_if);
-	if (!client) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	dev = find_device(&addr);
-	if (!dev) {
+	conn = find_connection_by_addr_and_client_id(&addr, cmd->client_if);
+	if (!conn) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	conn_id = dev->conn_id;
+	conn_id = conn->id;
+
 	memcpy(&notif.ch, &cmd->char_id, sizeof(notif.ch));
 	memcpy(&notif.service, &cmd->srvc_id, sizeof(notif.service));
-	notif.dev = dev;
+	notif.conn = conn;
 
-	notification = queue_find(client->notifications,
+	notification = queue_find(conn->client->notifications,
 						match_notification, &notif);
 	if (!notification) {
 		status = HAL_STATUS_FAILED;
@@ -2948,8 +2996,7 @@ static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!queue_find(gatt_clients, match_client_by_id,
-						INT_TO_PTR(cmd->client_if))) {
+	if (!find_client_by_id(cmd->client_if)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -3413,15 +3460,14 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
-	conn_list = queue_new();
-	conn_wait_queue = queue_new();
+	gatt_devices = queue_new();
 	gatt_clients = queue_new();
 	gatt_servers = queue_new();
-	disc_dev_list = queue_new();
+	client_connections = queue_new();
 	listen_clients = queue_new();
 
-	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers ||
-					!disc_dev_list || !listen_clients) {
+	if (!gatt_devices || !gatt_clients || !gatt_servers ||
+				!listen_clients || !client_connections) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_servers, NULL);
@@ -3430,14 +3476,11 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(gatt_clients, NULL);
 		gatt_clients = NULL;
 
-		queue_destroy(conn_list, NULL);
-		conn_list = NULL;
+		queue_destroy(gatt_devices, NULL);
+		gatt_devices = NULL;
 
-		queue_destroy(conn_wait_queue, NULL);
-		conn_wait_queue = NULL;
-
-		queue_destroy(disc_dev_list, NULL);
-		disc_dev_list = NULL;
+		queue_destroy(client_connections, NULL);
+		client_connections = NULL;
 
 		queue_destroy(listen_clients, NULL);
 		listen_clients = NULL;
@@ -3468,14 +3511,11 @@ void bt_gatt_unregister(void)
 	queue_destroy(gatt_clients, destroy_gatt_client);
 	gatt_clients = NULL;
 
-	queue_destroy(conn_list, destroy_device);
-	conn_list = NULL;
-
-	queue_destroy(conn_wait_queue, destroy_device);
-	conn_wait_queue = NULL;
+	queue_destroy(gatt_devices, destroy_device);
+	gatt_devices = NULL;
 
-	queue_destroy(disc_dev_list, destroy_device);
-	disc_dev_list = NULL;
+	queue_destroy(client_connections, destroy_connection);
+	client_connections = NULL;
 
 	queue_destroy(listen_clients, NULL);
 	listen_clients = NULL;
-- 
1.9.1

