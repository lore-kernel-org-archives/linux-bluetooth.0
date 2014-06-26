Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 08/10] shared/att: Implement outgoing "Write" request/response.
Date: Thu, 26 Jun 2014 16:14:15 -0700
Message-Id: <1403824457-22461-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Write" requests sent via bt_att_send and
the corresponding response. The same encode helper will also be used for the
"Write" and "Signed Write" commands in the future.
---
 src/shared/att.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3406b24..caf7d35 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -379,6 +379,39 @@ static bool encode_read_by_grp_type_req(struct att_send_op *op,
 	return true;
 }
 
+static bool encode_write_pdu(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	const struct bt_att_write_param *p = param;
+	uint16_t len;
+
+	if (length != sizeof(*p))
+		return false;
+
+	len = 3 + p->length;
+	if (len > mtu)
+		return false;
+
+	op->pdu = malloc(len);
+	if (!op->pdu)
+		return false;
+
+	((uint8_t *) op->pdu)[0] = op->opcode;
+	put_le16(p->handle, ((uint8_t *) op->pdu) + 1);
+	op->len = len;
+
+	if (p->length) {
+		if (!p->value) {
+			free(op->pdu);
+			return false;
+		}
+
+		memcpy(((uint8_t *) op->pdu) + 3, p->value, p->length);
+	}
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -419,6 +452,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_read_mult_req(op, param, length, mtu);
 	case BT_ATT_OP_READ_BY_GRP_TYPE_REQ:
 		return encode_read_by_grp_type_req(op, param, length, mtu);
+	case BT_ATT_OP_WRITE_REQ:
+		return encode_write_pdu(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -848,6 +883,15 @@ static bool handle_read_by_grp_type_rsp(struct bt_att *att, uint8_t opcode,
 							&param, sizeof(param));
 }
 
+static bool handle_write_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+								ssize_t pdu_len)
+{
+	if (pdu_len > 1)
+		return false;
+
+	return request_complete(att, BT_ATT_OP_WRITE_REQ, opcode, NULL, 0);
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -883,6 +927,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 		success = handle_read_by_grp_type_rsp(att, opcode,
 								pdu, pdu_len);
 		break;
+	case BT_ATT_OP_WRITE_RSP:
+		success = handle_write_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

