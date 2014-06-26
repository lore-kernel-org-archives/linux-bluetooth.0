Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 09/10] shared/att: Implement outgoing "Prepare Write" request/response.
Date: Thu, 26 Jun 2014 16:14:16 -0700
Message-Id: <1403824457-22461-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Prepare Write" requests sent via
bt_att_send and the corresponding response.
---
 src/shared/att-types.h |  4 +--
 src/shared/att.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 4809716..7dc22ad 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -162,7 +162,7 @@ struct bt_att_write_param {
 
 /* Prepare Write */
 #define BT_ATT_OP_PREP_WRITE_REQ		0x16
-struct bt_att_prepare_write_req_param {
+struct bt_att_prep_write_req_param {
 	uint16_t handle;
 	uint16_t offset;
 	const uint8_t *part_value;
@@ -170,7 +170,7 @@ struct bt_att_prepare_write_req_param {
 };
 
 #define BT_ATT_OP_PREP_WRITE_RSP		0x17
-struct bt_att_prepare_write_rsp_param {
+struct bt_att_prep_write_rsp_param {
 	uint16_t handle;
 	uint16_t offset;
 	const uint8_t *part_value;
diff --git a/src/shared/att.c b/src/shared/att.c
index caf7d35..d6c2a63 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -412,6 +412,41 @@ static bool encode_write_pdu(struct att_send_op *op, const void *param,
 	return true;
 }
 
+static bool encode_prep_write_req(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	const struct bt_att_prep_write_req_param *p = param;
+	uint16_t len;
+
+	if (length != sizeof(*p))
+		return false;
+
+	len = 5 + p->length;
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
+	op->len = len;
+
+	if (p->length) {
+		if (!p->part_value) {
+			free(op->pdu);
+			return false;
+		}
+
+		memcpy(((uint8_t *) op->pdu) + 5, p->part_value, p->length);
+	}
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -454,6 +489,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_read_by_grp_type_req(op, param, length, mtu);
 	case BT_ATT_OP_WRITE_REQ:
 		return encode_write_pdu(op, param, length, mtu);
+	case BT_ATT_OP_PREP_WRITE_REQ:
+		return encode_prep_write_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -892,6 +929,33 @@ static bool handle_write_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	return request_complete(att, BT_ATT_OP_WRITE_REQ, opcode, NULL, 0);
 }
 
+static bool handle_prep_write_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_prep_write_rsp_param param;
+
+	/* PDU must contain at least the following:
+	 * - 1 octet: ATT opcode
+	 * - 2 octets: Attribute handle
+	 * - 2 octets: Offset
+	 */
+	if (pdu_len < 5)
+		return false;
+
+	memset(&param, 0, sizeof(param));
+
+	param.handle = get_le16(pdu + 1);
+	param.offset = get_le16(pdu + 3);
+
+	if (pdu_len > 5) {
+		param.length = pdu_len - 5;
+		param.part_value = pdu + 5;
+	}
+
+	return request_complete(att, BT_ATT_OP_PREP_WRITE_REQ, opcode, &param,
+								sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -930,6 +994,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_WRITE_RSP:
 		success = handle_write_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_PREP_WRITE_RSP:
+		success = handle_prep_write_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

