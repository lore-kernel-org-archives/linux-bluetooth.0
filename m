Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 06/11] shared/att: Handle incoming confirmation PDU.
Date: Fri,  7 Nov 2014 12:41:54 -0800
Message-Id: <1415392919-17572-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of incoming confirmation PDUs to shared/att.
The code makes sure that there is a pending indication and notifies
the associated callback.

Also included is a fix that automatically disconnects the io if a
response is received while no request is pending.
---
 src/shared/att.c | 119 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index aa80cef..f043523 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -514,6 +514,46 @@ static void wakeup_writer(struct bt_att *att)
 	att->writer_active = true;
 }
 
+static void disconn_handler(void *data, void *user_data)
+{
+	struct att_disconn *disconn = data;
+
+	if (disconn->removed)
+		return;
+
+	if (disconn->callback)
+		disconn->callback(disconn->user_data);
+}
+
+static bool disconnect_cb(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	io_destroy(att->io);
+	att->io = NULL;
+
+	util_debug(att->debug_callback, att->debug_data,
+						"Physical link disconnected");
+
+	bt_att_ref(att);
+	att->in_disconn = true;
+	queue_foreach(att->disconn_list, disconn_handler, NULL);
+	att->in_disconn = false;
+
+	if (att->need_disconn_cleanup) {
+		queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
+							destroy_att_disconn);
+		att->need_disconn_cleanup = false;
+	}
+
+	bt_att_cancel_all(att);
+	bt_att_unregister_all(att);
+
+	bt_att_unref(att);
+
+	return false;
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -523,13 +563,19 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	uint8_t *rsp_pdu = NULL;
 	uint16_t rsp_pdu_len = 0;
 
-	/* If no request is pending, then the response is unexpected. */
+	/*
+	 * If no request is pending, then the response is unexpected. Disconnect
+	 * the bearer.
+	 */
 	if (!op) {
-		wakeup_writer(att);
+		util_debug(att->debug_callback, att->debug_data,
+					"Received unexpected ATT response");
+		disconnect_cb(att->io, att);
 		return;
 	}
 
-	/* If the received response doesn't match the pending request, or if
+	/*
+	 * If the received response doesn't match the pending request, or if
 	 * the request is malformed, end the current request with failure.
 	 */
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
@@ -568,6 +614,30 @@ done:
 	wakeup_writer(att);
 }
 
+static void handle_conf(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
+{
+	struct att_send_op *op = att->pending_ind;
+
+	/*
+	 * Disconnect the bearer if the confirmation is unexpected or the PDU is
+	 * invalid.
+	 */
+	if (!op || pdu_len) {
+		util_debug(att->debug_callback, att->debug_data,
+				"Received unexpected/invalid ATT confirmation");
+		disconnect_cb(att->io, att);
+		return;
+	}
+
+	if (op->callback)
+		op->callback(BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0, op->user_data);
+
+	destroy_att_send_op(op);
+	att->pending_ind = NULL;
+
+	wakeup_writer(att);
+}
+
 struct notify_data {
 	uint8_t opcode;
 	uint8_t *pdu;
@@ -651,46 +721,6 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 		respond_not_supported(att, opcode);
 }
 
-static void disconn_handler(void *data, void *user_data)
-{
-	struct att_disconn *disconn = data;
-
-	if (disconn->removed)
-		return;
-
-	if (disconn->callback)
-		disconn->callback(disconn->user_data);
-}
-
-static bool disconnect_cb(struct io *io, void *user_data)
-{
-	struct bt_att *att = user_data;
-
-	io_destroy(att->io);
-	att->io = NULL;
-
-	util_debug(att->debug_callback, att->debug_data,
-						"Physical link disconnected");
-
-	bt_att_ref(att);
-	att->in_disconn = true;
-	queue_foreach(att->disconn_list, disconn_handler, NULL);
-	att->in_disconn = false;
-
-	if (att->need_disconn_cleanup) {
-		queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
-							destroy_att_disconn);
-		att->need_disconn_cleanup = false;
-	}
-
-	bt_att_cancel_all(att);
-	bt_att_unregister_all(att);
-
-	bt_att_unref(att);
-
-	return false;
-}
-
 static bool can_read_data(struct io *io, void *user_data)
 {
 	struct bt_att *att = user_data;
@@ -720,7 +750,8 @@ static bool can_read_data(struct io *io, void *user_data)
 		break;
 	case ATT_OP_TYPE_CONF:
 		util_debug(att->debug_callback, att->debug_data,
-				"ATT opcode cannot be handled: 0x%02x", opcode);
+				"ATT confirmation received: 0x%02x", opcode);
+		handle_conf(att, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_REQ:
 		/*
-- 
2.1.0.rc2.206.gedb03e5

