Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 7/8] android/gatt: Add handler for ATT_OP_HANDLE_NOTIFY and ATT_OP_HANDLE_IND
Date: Fri, 28 Mar 2014 10:45:58 +0100
Message-Id: <1395999959-2396-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invoke callback notify_cb with received data. We set flag is_notify
properly to inform Android what type of notification has been received.
---
 android/gatt.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e6a1711..a5d40fc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1395,6 +1395,35 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
 }
 
+static void handle_notification(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_notify *ev = (void *) buf;
+	struct notification_data *notification = user_data;
+	uint8_t is_notify;
+	uint8_t offset;
+
+	if (len < 3)
+		return;
+
+	is_notify = pdu[0] == ATT_OP_HANDLE_NOTIFY ? true : false;
+
+	memcpy(&ev->char_id, &notification->ch, sizeof(ev->char_id));
+	memcpy(&ev->srvc_id, &notification->service, sizeof(ev->srvc_id));
+	bdaddr2android(&notification->dev->bdaddr, &ev->bda);
+	ev->conn_id = notification->dev->conn_id;
+	ev->is_notify = is_notify;
+
+	/* We have to cut opcode and handle from data */
+	offset = sizeof(is_notify) + sizeof(uint16_t);
+	ev->len = len - offset;
+	memcpy(ev->value, pdu + offset, len - offset);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
+						sizeof(*ev) + ev->len, ev);
+}
+
 static void send_register_for_notification_ev(int32_t id, int32_t registered,
 					int32_t status,
 					const struct hal_gatt_srvc_id *srvc,
@@ -1483,7 +1512,8 @@ static void handle_client_register_for_notification(const void *buf,
 	notification->notif_id = g_attrib_register(dev->attrib,
 							ATT_OP_HANDLE_NOTIFY,
 							c->ch.value_handle,
-							NULL, notification,
+							handle_notification,
+							notification,
 							destroy_notification);
 	if (!notification->notif_id) {
 		free(notification);
@@ -1493,7 +1523,8 @@ static void handle_client_register_for_notification(const void *buf,
 
 	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
 							c->ch.value_handle,
-							NULL, notification,
+							handle_notification,
+							notification,
 							destroy_notification);
 	if (!notification->ind_id) {
 		g_attrib_unregister(dev->attrib, notification->notif_id);
-- 
1.8.3.1

