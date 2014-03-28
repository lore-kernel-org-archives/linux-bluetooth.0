Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 4/7] android/gatt: Add initial implementation of register_for_notification
Date: Fri, 28 Mar 2014 11:49:19 +0100
Message-Id: <1396003762-9350-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will register notification and indication handler for given parameters.
Proper callback should be send with status of registration.
---
 android/gatt.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d6a0a2a..d7ea745 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -51,6 +51,7 @@
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
+	struct queue *notifications;
 };
 
 struct element_id {
@@ -70,6 +71,16 @@ struct service {
 	struct queue *chars;
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
 struct gatt_device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -204,6 +215,56 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
+static bool match_char_by_instance(const void *data, const void *user_data)
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
+
+	if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
+		return false;
+
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
+	if (notification->notif_id)
+		g_attrib_unregister(notification->dev->attrib,
+							notification->notif_id);
+
+	if (notification->ind_id)
+		g_attrib_unregister(notification->dev->attrib,
+							notification->ind_id);
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -216,6 +277,27 @@ static void destroy_device(void *data)
 	free(dev);
 }
 
+static void destroy_gatt_client(void *data)
+{
+	struct gatt_client *client = data;
+
+	/* First we want to get all notifications and unregister them.
+	 * We don't pass unregister_notification to queue_destroy,
+	 * because destroy notification performs operations on queue
+	 * too. So remove all elements and then destroy queue.
+	 */
+	while (queue_peek_head(client->notifications)) {
+		struct notification_data *notification;
+
+		notification = queue_pop_head(client->notifications);
+		unregister_notification(notification);
+	}
+
+	queue_destroy(client->notifications, free);
+
+	free(client);
+}
+
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
@@ -247,6 +329,14 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
+	client->notifications = queue_new();
+	if (!client->notifications) {
+		error("gatt: couldn't allocate notifications queue");
+		destroy_gatt_client(client);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	client->id = client_cnt++;
 
 	queue_push_head(gatt_clients, client);
@@ -281,7 +371,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	free(cl);
+	destroy_gatt_client(cl);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -1311,11 +1401,109 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
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
+	uint8_t status;
+	bdaddr_t addr;
+
 	DBG("");
 
+	client = find_client_by_id(cmd->client_if);
+	if (!client) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+
+	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
+	service = queue_find(dev->services, match_srvc_by_element_id,
+								&match_id);
+	bt_uuid_to_string(&match_id.uuid, uuid, MAX_LEN_UUID_STR);
+	if (!service) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	c = queue_find(service->chars, match_char_by_instance,
+					INT_TO_PTR(cmd->char_id.inst_id));
+	if (!c) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	notification = new0(struct notification_data, 1);
+	if (!notification) {
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
+								notification)) {
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
+	/* Because same data - notification - is shared by two handlers, we
+	 * introduce ref counter to be sure that data can be freed with no risk.
+	 * Counter is decremented in destroy_notification.
+	 */
+	notification->ref = 2;
+
+	if (!queue_push_tail(client->notifications, notification)) {
+		unregister_notification(notification);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	/* TODO: send callback with notification enabled/disabled */
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
-				HAL_STATUS_FAILED);
+				status);
 }
 
 static void handle_client_deregister_for_notification(const void *buf,
-- 
1.8.3.1

