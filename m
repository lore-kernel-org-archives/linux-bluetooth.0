Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 05/10] shared/att: Implement outgoing "Read Blob" request/response.
Date: Thu, 26 Jun 2014 16:14:12 -0700
Message-Id: <1403824457-22461-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Read Blob" requests sent via bt_att_send
and the corresponding response.
---
 src/shared/att.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 288442f..1b6d568 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -285,6 +285,31 @@ static bool encode_read_req(struct att_send_op *op,
 	return true;
 }
 
+static bool encode_read_blob_req(struct att_send_op *op,
+					const void *param, uint16_t length,
+					uint16_t mtu)
+{
+	const struct bt_att_read_blob_req_param *p = param;
+	uint16_t len = 5;
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
+	put_le16(p->offset, ((uint8_t *) op->pdu) + 3);
+	op->len = len;
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -319,6 +344,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_read_by_type_req(op, param, length, mtu);
 	case BT_ATT_OP_READ_REQ:
 		return encode_read_req(op, param, length, mtu);
+	case BT_ATT_OP_READ_BLOB_REQ:
+		return encode_read_blob_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -691,6 +718,21 @@ static bool handle_read_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								sizeof(param));
 }
 
+static bool handle_read_blob_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_read_blob_rsp_param param;
+	memset(&param, 0, sizeof(param));
+
+	if (pdu_len > 1) {
+		param.length = pdu_len - 1;
+		param.part_value = pdu + 1;
+	}
+
+	return request_complete(att, BT_ATT_OP_READ_BLOB_REQ, opcode, &param,
+								sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -716,6 +758,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_READ_RSP:
 		success = handle_read_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_READ_BLOB_RSP:
+		success = handle_read_blob_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

