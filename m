Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 10/10] shared/att: Implement outgoing "Execute Write" request/response.
Date: Thu, 26 Jun 2014 16:14:17 -0700
Message-Id: <1403824457-22461-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Execute Write" requests sent via
bt_att_send and the corresponding response.
---
 src/shared/att.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index d6c2a63..0e67786 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -447,6 +447,29 @@ static bool encode_prep_write_req(struct att_send_op *op, const void *param,
 	return true;
 }
 
+static bool encode_exec_write_req(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	const struct bt_att_exec_write_req_param *p = param;
+	uint16_t len = 2;
+
+	if (length != sizeof(*p))
+		return false;
+
+	if (len > mtu)
+		return false;
+
+	op->pdu = malloc(len);
+	if (!op->pdu)
+		return false;
+
+	((uint8_t *) op->pdu)[0] = op->opcode;
+	((uint8_t *) op->pdu)[1] = p->flags;
+	op->len = len;
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -491,6 +514,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_write_pdu(op, param, length, mtu);
 	case BT_ATT_OP_PREP_WRITE_REQ:
 		return encode_prep_write_req(op, param, length, mtu);
+	case BT_ATT_OP_EXEC_WRITE_REQ:
+		return encode_exec_write_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -956,6 +981,15 @@ static bool handle_prep_write_rsp(struct bt_att *att, uint8_t opcode,
 								sizeof(param));
 }
 
+static bool handle_exec_write_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	if (pdu_len > 1)
+		return false;
+
+	return request_complete(att, BT_ATT_OP_EXEC_WRITE_REQ, opcode, NULL, 0);
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -997,6 +1031,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_PREP_WRITE_RSP:
 		success = handle_prep_write_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_EXEC_WRITE_RSP:
+		success = handle_exec_write_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

