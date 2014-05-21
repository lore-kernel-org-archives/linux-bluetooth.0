Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix handling write request
Date: Wed, 21 May 2014 14:32:19 +0200
Message-Id: <1400675539-12592-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds write request to Android framework and uses buffor on
the stack for the request event.
---
 android/gatt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..42bf2ec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3891,7 +3891,8 @@ static void write_cb(uint16_t handle, uint16_t offset,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	struct hal_ev_gatt_server_request_write ev;
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_server_request_write *ev = (void *) buf;
 	struct gatt_app *app;
 	int32_t id = PTR_TO_INT(user_data);
 	static int32_t trans_id = 1;
@@ -3916,21 +3917,24 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	if (att_opcode == ATT_OP_EXEC_WRITE_REQ)
 		goto failed;
 
-	memset(&ev, 0, sizeof(ev));
+	memset(ev, 0, sizeof(*ev));
 
-	bdaddr2android(bdaddr, ev.bdaddr);
-	ev.attr_handle = handle;
-	ev.offset = offset;
+	bdaddr2android(bdaddr, &ev->bdaddr);
+	ev->attr_handle = handle;
+	ev->offset = offset;
 
-	ev.conn_id = conn->id;
-	ev.trans_id = app->trans_id.id;
+	ev->conn_id = conn->id;
+	ev->trans_id = app->trans_id.id;
 
-	ev.is_prep = att_opcode == ATT_OP_PREP_WRITE_REQ;
-	ev.need_rsp = att_opcode == ATT_OP_WRITE_REQ;
+	ev->is_prep = att_opcode == ATT_OP_PREP_WRITE_REQ;
+	ev->need_rsp = att_opcode == ATT_OP_WRITE_REQ;
 
-	ev.length = len;
-	memcpy(&ev.value, value, len);
+	ev->length = len;
+	memcpy(ev->value, value, len);
 
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_REQUEST_WRITE,
+						sizeof(*ev) + ev->length , ev);
 	return;
 
 failed:
-- 
1.8.4

