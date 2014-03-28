Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 6/7] android/gatt: Add handler for ATT_OP_HANDLE_NOTIFY and ATT_OP_HANDLE_IND
Date: Fri, 28 Mar 2014 11:49:21 +0100
Message-Id: <1396003762-9350-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invoke callback notify_cb with received data. We set flag is_notify
properly to inform Android what type of notification has been received.
---
 android/gatt.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e87237a..75c555c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1398,6 +1398,31 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
 }
 
+static void handle_notification(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_notify *ev = (void *) buf;
+	struct notification_data *notification = user_data;
+	uint8_t data_offset = sizeof(uint8_t) + sizeof(uint16_t);
+
+	if (len < data_offset)
+		return;
+
+	memcpy(&ev->char_id, &notification->ch, sizeof(ev->char_id));
+	memcpy(&ev->srvc_id, &notification->service, sizeof(ev->srvc_id));
+	bdaddr2android(&notification->dev->bdaddr, &ev->bda);
+	ev->conn_id = notification->dev->conn_id;
+	ev->is_notify = pdu[0] == ATT_OP_HANDLE_NOTIFY;
+
+	/* We have to cut opcode and handle from data */
+	ev->len = len - data_offset;
+	memcpy(ev->value, pdu + data_offset, len - data_offset);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
+						sizeof(*ev) + ev->len, ev);
+}
+
 static void send_register_for_notification_ev(int32_t id, int32_t registered,
 					int32_t status,
 					const struct hal_gatt_srvc_id *srvc,
@@ -1486,7 +1511,8 @@ static void handle_client_register_for_notification(const void *buf,
 	notification->notif_id = g_attrib_register(dev->attrib,
 							ATT_OP_HANDLE_NOTIFY,
 							c->ch.value_handle,
-							NULL, notification,
+							handle_notification,
+							notification,
 							destroy_notification);
 	if (!notification->notif_id) {
 		free(notification);
@@ -1496,7 +1522,8 @@ static void handle_client_register_for_notification(const void *buf,
 
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

