Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 06/10] shared/att: Implement outgoing "Read Multiple" request/response.
Date: Thu, 26 Jun 2014 16:14:13 -0700
Message-Id: <1403824457-22461-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Read Multiple" requests sent via
bt_att_send and the corresponding response.
---
 src/shared/att-types.h |  4 ++--
 src/shared/att.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index b6f32dd..ae2dfb6 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -114,13 +114,13 @@ struct bt_att_read_blob_rsp_param {
 
 /* Read Multiple */
 #define BT_ATT_OP_READ_MULT_REQ			0x0e
-struct bt_att_read_multiple_req_param {
+struct bt_att_read_mult_req_param {
 	const uint16_t *handles;
 	uint16_t num_handles;
 };
 
 #define BT_ATT_OP_READ_MULT_RSP			0x0f
-struct bt_att_read_multiple_rsp_param {
+struct bt_att_read_mult_rsp_param {
 	const uint8_t *values;
 	uint16_t length;
 };
diff --git a/src/shared/att.c b/src/shared/att.c
index 1b6d568..2658969 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -310,6 +310,37 @@ static bool encode_read_blob_req(struct att_send_op *op,
 	return true;
 }
 
+static bool encode_read_mult_req(struct att_send_op *op,
+					const void *param, uint16_t length,
+					uint16_t mtu)
+{
+	const struct bt_att_read_mult_req_param *p = param;
+	uint16_t len;
+	int i;
+
+	if (length != sizeof(*p))
+		return false;
+
+	if (p->num_handles < 1)
+		return false;
+
+	len = 1 + 2 * p->num_handles;
+	if (len > mtu)
+		return false;
+
+	op->pdu = malloc(len);
+	if (!op->pdu)
+		return false;
+
+	((uint8_t *) op->pdu)[0] = op->opcode;
+	op->len = len;
+
+	for (i = 0; i < p->num_handles; i++)
+		put_le16(p->handles[i], ((uint8_t *) op->pdu) + 1 + 2 * i);
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -346,6 +377,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_read_req(op, param, length, mtu);
 	case BT_ATT_OP_READ_BLOB_REQ:
 		return encode_read_blob_req(op, param, length, mtu);
+	case BT_ATT_OP_READ_MULT_REQ:
+		return encode_read_mult_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -733,6 +766,22 @@ static bool handle_read_blob_rsp(struct bt_att *att, uint8_t opcode,
 								sizeof(param));
 }
 
+static bool handle_read_mult_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_read_mult_rsp_param param;
+
+	memset(&param, 0, sizeof(param));
+
+	if (pdu_len > 1) {
+		param.length = pdu_len - 1;
+		param.values = pdu + 1;
+	}
+
+	return request_complete(att, BT_ATT_OP_READ_MULT_REQ, opcode, &param,
+								sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -761,6 +810,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_READ_BLOB_RSP:
 		success = handle_read_blob_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_READ_MULT_RSP:
+		success = handle_read_mult_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

