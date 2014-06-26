Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 02/10] shared/att: Implement outgoing "Find By Type Value" request/response.
Date: Thu, 26 Jun 2014 16:14:09 -0700
Message-Id: <1403824457-22461-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Find By Type Value" requests sent via
bt_att_send and the corresponding response.
---
 src/shared/att-types.h |  4 +--
 src/shared/att.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 636a5e3..b6f32dd 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -58,7 +58,7 @@ struct bt_att_find_info_rsp_param {
 
 /* Find By Type Value */
 #define BT_ATT_OP_FIND_BY_TYPE_VAL_REQ		0x06
-struct bt_att_find_by_type_value_req_param {
+struct bt_att_find_by_type_val_req_param {
 	uint16_t start_handle;
 	uint16_t end_handle;
 	uint16_t type;  /* 2 octet UUID */
@@ -67,7 +67,7 @@ struct bt_att_find_by_type_value_req_param {
 };
 
 #define BT_ATT_OP_FIND_BY_TYPE_VAL_RSP		0x07
-struct bt_att_find_by_type_value_rsp_param {
+struct bt_att_find_by_type_val_rsp_param {
 	const uint8_t *handles_info_list;
 	uint16_t length;
 };
diff --git a/src/shared/att.c b/src/shared/att.c
index 22dd471..9e16a6f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -189,6 +189,40 @@ static bool encode_find_info_req(struct att_send_op *op, const void *param,
 	return true;
 }
 
+static bool encode_find_by_type_val_req(struct att_send_op *op,
+					const void *param, uint16_t length,
+					uint16_t mtu)
+{
+	const struct bt_att_find_by_type_val_req_param *p = param;
+	const uint16_t len = 7 + p->length;
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
+	put_le16(p->start_handle, ((uint8_t *) op->pdu) + 1);
+	put_le16(p->end_handle, ((uint8_t *) op->pdu) + 3);
+	put_le16(p->type, ((uint8_t *) op->pdu) + 5);
+	op->len = len;
+
+	if (p->length == 0)
+		return true;
+
+	if (!p->value)
+		return false;
+
+	memcpy(((uint8_t *) op->pdu) + 7, p->value, p->length);
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -217,6 +251,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_mtu_req(op, param, length, mtu);
 	case BT_ATT_OP_FIND_INFO_REQ:
 		return encode_find_info_req(op, param, length, mtu);
+	case BT_ATT_OP_FIND_BY_TYPE_VAL_REQ:
+		return encode_find_by_type_val_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -520,6 +556,33 @@ static bool handle_find_info_rsp(struct bt_att *att, uint8_t opcode,
 							&param, sizeof(param));
 }
 
+static bool handle_find_by_type_val_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_find_by_type_val_rsp_param param;
+
+	/* PDU must contain at least the following:
+	 * - 1 octet: ATT opcode
+	 * - 4 to MTU-1 octets: Handles Information List
+	 */
+	if (pdu_len < 5)
+		return false;
+
+	/* Each Handle Information field is composed of 4 octets. Return error,
+	 * if the length of the field is not a multiple of 4.
+	 */
+	if ((pdu_len - 1) % 4)
+		return false;
+
+	memset(&param, 0, sizeof(param));
+
+	param.length = pdu_len -1;
+	param.handles_info_list = pdu + 1;
+
+	return request_complete(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ, opcode,
+							&param, sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -535,6 +598,10 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_FIND_INFO_RSP:
 		success = handle_find_info_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_FIND_BY_TYPE_VAL_RSP:
+		success = handle_find_by_type_val_rsp(att, opcode,
+								pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

