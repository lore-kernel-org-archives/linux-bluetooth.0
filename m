Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Fix not confirming notifications and indications
Date: Tue, 10 Feb 2015 11:04:31 +0100
Message-Id: <1423562671-24467-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In Lollipop, server app notifications needs to be confirmed just like
indications. We had those confirmations missing thus server apps
would stop indicating/notifying after first indication/notification
is send.
---
 android/gatt.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a36922c..4398194 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5532,6 +5532,18 @@ failed:
 				HAL_OP_GATT_SERVER_DELETE_SERVICE, status);
 }
 
+static void indication_confirmation_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct hal_ev_gatt_server_indication_sent ev;
+
+	ev.status = status;
+	ev.conn_id = PTR_TO_UINT(user_data);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_INDICATION_SENT, sizeof(ev), &ev);
+}
+
 static void handle_server_send_indication(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_send_indication *cmd = buf;
@@ -5554,11 +5566,10 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 	pdu = g_attrib_get_buffer(conn->device->attrib, &mtu);
 
 	if (cmd->confirm) {
-		/* TODO: Add data to track confirmation for this request */
 		length = enc_indication(cmd->attribute_handle,
 					(uint8_t *) cmd->value, cmd->len, pdu,
 					mtu);
-		confirmation_cb = ignore_confirmation_cb;
+		confirmation_cb = indication_confirmation_cb;
 	} else {
 		length = enc_notification(cmd->attribute_handle,
 						(uint8_t *) cmd->value,
@@ -5570,10 +5581,15 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 		status = HAL_STATUS_FAILED;
 	} else {
 		g_attrib_send(conn->device->attrib, 0, pdu, length,
-						confirmation_cb, NULL, NULL);
+				confirmation_cb, UINT_TO_PTR(conn->id), NULL);
 		status = HAL_STATUS_SUCCESS;
 	}
 
+	/* Here we confirm failed indications and all notifications */
+	if (status || !confirmation_cb)
+		indication_confirmation_cb(status, NULL, 0,
+							UINT_TO_PTR(conn->id));
+
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_SEND_INDICATION, status);
-- 
1.9.1

