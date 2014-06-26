Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 04/10] shared/att: Implement outgoing "Read" request/response.
Date: Thu, 26 Jun 2014 16:14:11 -0700
Message-Id: <1403824457-22461-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Read" requests sent via bt_att_send and the
corresponding response.
---
 src/shared/att.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index abf1440..288442f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -261,6 +261,30 @@ static bool encode_read_by_type_req(struct att_send_op *op,
 	return true;
 }
 
+static bool encode_read_req(struct att_send_op *op,
+					const void *param, uint16_t length,
+					uint16_t mtu)
+{
+	const struct bt_att_read_req_param *p = param;
+	uint16_t len = 3;
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
+	put_le16(p->handle, ((uint8_t *) op->pdu) + 1);
+	op->len = len;
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -293,6 +317,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_find_by_type_val_req(op, param, length, mtu);
 	case BT_ATT_OP_READ_BY_TYPE_REQ:
 		return encode_read_by_type_req(op, param, length, mtu);
+	case BT_ATT_OP_READ_REQ:
+		return encode_read_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -649,6 +675,22 @@ static bool handle_read_by_type_rsp(struct bt_att *att, uint8_t opcode,
 							&param, sizeof(param));
 }
 
+static bool handle_read_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+								ssize_t pdu_len)
+{
+	struct bt_att_read_rsp_param param;
+
+	memset(&param, 0, sizeof(param));
+
+	if (pdu_len > 1) {
+		param.length = pdu_len - 1;
+		param.value = pdu + 1;
+	}
+
+	return request_complete(att, BT_ATT_OP_READ_REQ, opcode, &param,
+								sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -671,6 +713,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_READ_BY_TYPE_RSP:
 		success = handle_read_by_type_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_READ_RSP:
+		success = handle_read_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

