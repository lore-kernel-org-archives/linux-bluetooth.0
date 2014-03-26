Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Add initial implementation of indication/notification handling
Date: Wed, 26 Mar 2014 11:56:56 +0100
Message-Id: <1395831416-26217-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add notifications and indications handling. It register
or unregister notification using g_attrib_register() and g_attrib_unregister().
Notifications list is cached in gatt_client struct. notification_data
struct is used when calling notify_cb. When device is disconnected,
notification_data elements will be automatically removed from gatt_client's queue.
---
 android/gatt.c | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d2eda9e..c016377 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -51,6 +51,7 @@
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
+	struct queue *notifications;
 };
 
 struct gatt_id {
@@ -75,6 +76,15 @@ struct generic_call_data {
 	struct gatt_srvc *gatt_srvc;
 };
 
+struct notification_data {
+	struct gatt_client *client;
+	struct hal_gatt_srvc_id srvc;
+	struct hal_gatt_gatt_id ch;
+	struct gatt_device *dev;
+	guint notif_id;
+	guint ind_id;
+};
+
 struct gatt_device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -102,6 +112,51 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 
 static void bt_le_discovery_stop_cb(void);
 
+static bool match_notification(const void *a, const void *b)
+{
+	const struct notification_data *a1 = a;
+	const struct notification_data *b1 = b;
+
+	if (bacmp(&a1->dev->bdaddr, &b1->dev->bdaddr))
+		return false;
+	if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
+		return false;
+	if (memcmp(&a1->srvc, &b1->srvc, sizeof(a1->srvc)))
+		return false;
+
+	return true;
+}
+
+static void destroy_notification(void *data)
+{
+	struct notification_data *notification = data;
+
+	queue_remove_if(notification->client->notifications, match_notification,
+								notification);
+
+	free(notification);
+}
+
+static void unregister_notification(void *data)
+{
+	struct notification_data *notification = data;
+
+	g_attrib_unregister(notification->dev->attrib, notification->notif_id);
+	g_attrib_unregister(notification->dev->attrib, notification->ind_id);
+}
+
+static void free_gatt_client(void *data)
+{
+	struct gatt_client *client = data;
+
+	while (queue_peek_head(client->notifications))
+		unregister_notification(queue_pop_head(client->notifications));
+
+	queue_destroy(client->notifications, free);
+
+	free(client);
+}
+
 static void free_gatt_service(void *data)
 {
 	struct gatt_srvc *srvc = data;
@@ -177,6 +232,14 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < chars->id.inst_id;
 }
 
+static bool match_char_by_inst_id(const void *data, const void *user_data)
+{
+	const struct gatt_srvc_char *chars = data;
+	uint8_t inst_id = PTR_TO_INT(user_data);
+
+	return inst_id == chars->id.inst_id;
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -214,6 +277,8 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	client->id = client_cnt++;
 
+	client->notifications = queue_new();
+
 	queue_push_head(gatt_clients, client);
 
 	status = HAL_STATUS_SUCCESS;
@@ -246,7 +311,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	free(cl);
+	free_gatt_client(cl);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -1145,24 +1210,219 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
 }
 
+static void client_notify_cb(struct notification_data *notification,
+					const uint8_t *pdu, uint16_t len,
+					bool is_notify)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_notify *ev = (void *) buf;
+
+	memcpy(&ev->char_id, &notification->ch, sizeof(ev->char_id));
+	memcpy(&ev->srvc_id, &notification->srvc, sizeof(ev->srvc_id));
+	bdaddr2android(&notification->dev->bdaddr, &ev->bda);
+	ev->conn_id = notification->dev->conn_id;
+	ev->is_notify = is_notify;
+	ev->len = len;
+	memcpy(ev->value, pdu, len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
+						sizeof(*ev) + ev->len, ev);
+}
+
+static void handle_notification(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct notification_data *notification = user_data;
+
+	client_notify_cb(notification, pdu, len, true);
+}
+
+static void handle_indication(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct notification_data *notification = user_data;
+
+	client_notify_cb(notification, pdu, len, false);
+}
+
+static void client_register_for_notif_cb(int32_t conn_id, int32_t registered,
+					int32_t status,
+					const struct hal_gatt_srvc_id *srvc,
+					const struct hal_gatt_gatt_id *ch)
+{
+	struct hal_ev_gatt_client_reg_for_notif ev;
+
+	ev.conn_id = conn_id;
+	ev.status = status;
+	ev.registered = registered;
+	memcpy(&ev.srvc_id, srvc, sizeof(ev.srvc_id));
+	memcpy(&ev.char_id, ch, sizeof(ev.char_id));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_FOR_NOTIF, sizeof(ev), &ev);
+}
+
 static void handle_client_register_for_notification(const void *buf,
 								uint16_t len)
 {
+	const struct hal_cmd_gatt_client_register_for_notification *cmd = buf;
+	struct notification_data *notification;
+	struct gatt_client *client;
+	struct gatt_srvc_char *c;
+	struct gatt_id match_id;
+	struct gatt_device *dev;
+	struct gatt_srvc *srvc;
+	int32_t conn_id = 0;
+	uint8_t status;
+	bdaddr_t addr;
+	char addr_str[18];
+	char uuid[MAX_LEN_UUID_STR];
+
 	DBG("");
 
+	client = queue_find(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!client) {
+		error("client %d not registered", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+	ba2str(&addr, addr_str);
+
+	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
+	if (!dev) {
+		error("device %s not found in connected devices list",
+								addr_str);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	conn_id = dev->conn_id;
+
+	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
+	srvc = queue_find(dev->services, match_srvc_by_gatt_id, &match_id);
+	bt_uuid_to_string(&match_id.uuid, uuid, MAX_LEN_UUID_STR);
+	if (!srvc) {
+		error("service %s with instance id %d not found in device %s",
+					uuid, match_id.inst_id, addr_str);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	c = queue_find(srvc->chars, match_char_by_inst_id,
+					INT_TO_PTR(cmd->char_id.inst_id));
+	if (!c) {
+		error("char inst_id %d in service %s not found in device %s",
+							cmd->char_id.inst_id,
+							uuid, addr_str);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	notification = new0(struct notification_data, 1);
+	if (!notification) {
+		error("failed to create notification");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	memcpy(&notification->ch, &cmd->char_id, sizeof(notification->ch));
+	memcpy(&notification->srvc, &cmd->srvc_id, sizeof(notification->srvc));
+	notification->dev = dev;
+	notification->client = client;
+
+	if (queue_find(client->notifications, match_notification,
+			notification)) {
+		DBG("notification already registered");
+		free(notification);
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	queue_push_tail(client->notifications, notification);
+
+	notification->notif_id = g_attrib_register(dev->attrib,
+							ATT_OP_HANDLE_NOTIFY,
+							c->ch.value_handle,
+							handle_notification,
+							notification, NULL);
+
+	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
+							c->ch.value_handle,
+							handle_indication,
+							notification,
+							destroy_notification);
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
+	client_register_for_notif_cb(conn_id, 1, status, &cmd->srvc_id,
+								&cmd->char_id);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
-				HAL_STATUS_FAILED);
+				status);
 }
 
 static void handle_client_deregister_for_notification(const void *buf,
 								uint16_t len)
 {
+	const struct hal_cmd_gatt_client_deregister_for_notification *cmd = buf;
+	struct notification_data *notification, notif;
+	struct gatt_client *client;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t status;
+	bdaddr_t addr;
+	char addr_str[18];
+
 	DBG("");
 
+	client = queue_find(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!client) {
+		error("client %d not registered", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+	ba2str(&addr, addr_str);
+
+	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
+	if (!dev) {
+		error("device %s not found in connected devices list",
+								addr_str);
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	memcpy(&notif.ch, &cmd->char_id, sizeof(notif.ch));
+	memcpy(&notif.srvc, &cmd->srvc_id, sizeof(notif.srvc));
+	notif.dev = dev;
+
+	notification = queue_find(client->notifications,
+						match_notification, &notif);
+
+	if (!notification) {
+		error("notification not registered");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	unregister_notification(notification);
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
+	client_register_for_notif_cb(conn_id, 0, status, &cmd->srvc_id,
+								&cmd->char_id);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
-				HAL_STATUS_FAILED);
+				status);
 }
 
 static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
@@ -1446,7 +1706,7 @@ void bt_gatt_unregister(void)
 {
 	DBG("");
 
-	queue_destroy(gatt_clients, free);
+	queue_destroy(gatt_clients, free_gatt_client);
 
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
 	hal_ipc = NULL;
-- 
1.8.3.1

