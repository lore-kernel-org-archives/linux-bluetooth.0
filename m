Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] shared/att: Auto retry if request fails
Date: Tue, 23 Jun 2015 15:53:27 +0300
Message-Id: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds auto retry logic to requests when a security error happen,
it will first attempt to elevate the security to match the requirement
and then retry sending the request once again.
---
 src/shared/att.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index f9a5817..e8be4cc 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -576,6 +576,55 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	return false;
 }
 
+static bool change_security(struct bt_att *att, uint8_t ecode)
+{
+	int security;
+
+	security = bt_att_get_security(att);
+	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
+					security < BT_ATT_SECURITY_MEDIUM)
+		security = BT_ATT_SECURITY_MEDIUM;
+	else if (ecode == BT_ATT_ERROR_AUTHENTICATION &&
+					security < BT_ATT_SECURITY_HIGH)
+		security = BT_ATT_SECURITY_HIGH;
+	else
+		return false;
+
+	return bt_att_set_security(att, security);
+}
+
+static bool handle_error_rsp(struct bt_att *att, uint8_t *pdu,
+					ssize_t pdu_len, uint8_t *opcode)
+{
+	const struct bt_att_pdu_error_rsp *rsp;
+	struct att_send_op *op = att->pending_req;
+
+	if (pdu_len != sizeof(*rsp)) {
+		*opcode = 0;
+		return false;
+	}
+
+	rsp = (void *) pdu;
+
+	*opcode = rsp->opcode;
+
+	/* Only try to change security on L2CAP */
+	if (!att->io_on_l2cap)
+		return false;
+
+	/* Attempt to change security */
+	if (!change_security(att, rsp->ecode))
+		return false;
+
+	util_debug(att->debug_callback, att->debug_data,
+						"Retrying operation %p", op);
+
+	att->pending_req = NULL;
+
+	/* Push operation back to request queue */
+	return queue_push_head(att->req_queue, op);
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -601,10 +650,11 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	 * the request is malformed, end the current request with failure.
 	 */
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		if (pdu_len != 4)
-			goto fail;
-
-		req_opcode = pdu[0];
+		/* Return if error response cause a retry */
+		if (handle_error_rsp(att, pdu, pdu_len, &req_opcode)) {
+			wakeup_writer(att);
+			return;
+		}
 	} else if (!(req_opcode = get_req_opcode(opcode)))
 		goto fail;
 
-- 
2.1.0

