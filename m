Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/11] android/gatt: Add handler for ATT_OP_HANDLE_NOTIFY and ATT_OP_HANDLE_IND
Date: Thu, 27 Mar 2014 22:13:08 +0100
Message-Id: <1395954789-32459-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invoke callback notify_cb with received data. We set flag is_notify
properly to inform Android what type of notification has been received.
---
 android/gatt.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 61c35c3..d004e35 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1403,6 +1403,41 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
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
+	memcpy(&ev->srvc_id, &notification->service, sizeof(ev->srvc_id));
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
 static void client_register_for_notif_cb(int32_t conn_id, int32_t registered,
 					int32_t status,
 					const struct hal_gatt_srvc_id *srvc,
@@ -1500,7 +1535,8 @@ static void handle_client_register_for_notification(const void *buf,
 	notification->notif_id = g_attrib_register(dev->attrib,
 							ATT_OP_HANDLE_NOTIFY,
 							c->ch.value_handle,
-							NULL, notification,
+							handle_notification,
+							notification,
 							destroy_notification);
 	if (!notification->notif_id) {
 		free(notification);
@@ -1510,7 +1546,8 @@ static void handle_client_register_for_notification(const void *buf,
 
 	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
 							c->ch.value_handle,
-							NULL, notification,
+							handle_indication,
+							notification,
 							destroy_notification);
 	if (!notification->ind_id) {
 		g_attrib_unregister(dev->attrib, notification->notif_id);
-- 
1.8.3.1

