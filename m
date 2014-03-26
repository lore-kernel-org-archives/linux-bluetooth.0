Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/gatt: Add initial handling of register_for_notification
Date: Wed, 26 Mar 2014 15:37:17 +0100
Message-Id: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will register for both notifications and indications for given
characteristic and service. Notifications list will be stored in
client struct.
---
 android/gatt.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6354ac6..e98de48 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -51,6 +51,7 @@
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
+	struct queue *notifications;
 };
 
 struct element_id {
@@ -86,6 +87,16 @@ struct gatt_device {
 	guint watch_id;
 };
 
+struct notification_data {
+	struct hal_gatt_srvc_id service;
+	struct hal_gatt_gatt_id ch;
+	struct gatt_client *client;
+	struct gatt_device *dev;
+	guint notif_id;
+	guint ind_id;
+	int ref;
+};
+
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
@@ -171,6 +182,61 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
+static bool match_char_by_inst_id(const void *data, const void *user_data)
+{
+	const struct characteristic *ch = data;
+	uint8_t inst_id = PTR_TO_INT(user_data);
+
+	return inst_id == ch->id.instance;
+}
+
+static bool match_notification(const void *a, const void *b)
+{
+	const struct notification_data *a1 = a;
+	const struct notification_data *b1 = b;
+
+	if (bacmp(&a1->dev->bdaddr, &b1->dev->bdaddr))
+		return false;
+	if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
+		return false;
+	if (memcmp(&a1->service, &b1->service, sizeof(a1->service)))
+		return false;
+
+	return true;
+}
+
+static void destroy_notification(void *data)
+{
+	struct notification_data *notification = data;
+
+	if (--notification->ref)
+		return;
+
+	queue_remove_if(notification->client->notifications, match_notification,
+								notification);
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
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -208,6 +274,13 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	client->id = client_cnt++;
 
+	client->notifications = queue_new();
+	if (!client->notifications) {
+		error("gatt: couldn't allocate notifications queue");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	queue_push_head(gatt_clients, client);
 
 	status = HAL_STATUS_SUCCESS;
@@ -240,7 +313,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	free(cl);
+	free_gatt_client(cl);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -1146,14 +1219,124 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
 }
 
+static void client_register_for_notif_cb(int32_t conn_id, int32_t registered,
+					int32_t status,
+					const struct hal_gatt_srvc_id *srvc,
+					const struct hal_gatt_gatt_id *ch)
+{
+}
+
 static void handle_client_register_for_notification(const void *buf,
 								uint16_t len)
 {
+	const struct hal_cmd_gatt_client_register_for_notification *cmd = buf;
+	struct notification_data *notification;
+	char uuid[MAX_LEN_UUID_STR];
+	struct gatt_client *client;
+	struct characteristic *c;
+	struct element_id match_id;
+	struct gatt_device *dev;
+	struct service *service;
+	int32_t conn_id = 0;
+	char addr_str[18];
+	uint8_t status;
+	bdaddr_t addr;
+
 	DBG("");
 
+	client = queue_find(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!client) {
+		error("gatt: client %d not registered", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+	ba2str(&addr, addr_str);
+
+	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
+	if (!dev) {
+		error("gatt: device %s not found in connected devices list",
+								addr_str);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	conn_id = dev->conn_id;
+
+	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
+	service = queue_find(dev->services, match_srvc_by_gatt_id, &match_id);
+	bt_uuid_to_string(&match_id.uuid, uuid, MAX_LEN_UUID_STR);
+	if (!service) {
+		error("gatt: can't register notification, service not found");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	c = queue_find(service->chars, match_char_by_inst_id,
+					INT_TO_PTR(cmd->char_id.inst_id));
+	if (!c) {
+		error("gatt: can't register notification: no characteristic");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	notification = new0(struct notification_data, 1);
+	if (!notification) {
+		error("gatt: failed to allocate memory for notification");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	memcpy(&notification->ch, &cmd->char_id, sizeof(notification->ch));
+	memcpy(&notification->service, &cmd->srvc_id,
+						sizeof(notification->service));
+	notification->dev = dev;
+	notification->client = client;
+
+	if (queue_find(client->notifications, match_notification,
+			notification)) {
+		DBG("can't register for notification, already registered");
+		free(notification);
+		status = HAL_STATUS_SUCCESS;
+		goto failed;
+	}
+
+	notification->notif_id = g_attrib_register(dev->attrib,
+							ATT_OP_HANDLE_NOTIFY,
+							c->ch.value_handle,
+							NULL, notification,
+							destroy_notification);
+	if (!notification->notif_id) {
+		free(notification);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
+							c->ch.value_handle,
+							NULL, notification,
+							destroy_notification);
+	if (!notification->ind_id) {
+		g_attrib_unregister(dev->attrib, notification->notif_id);
+		free(notification);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	notification->ref = 2;
+
+	queue_push_tail(client->notifications, notification);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	client_register_for_notif_cb(conn_id, 1, status, &cmd->srvc_id,
+								&cmd->char_id);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
-				HAL_STATUS_FAILED);
+				status);
 }
 
 static void handle_client_deregister_for_notification(const void *buf,
-- 
1.8.3.1

