Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 03/10] shared/att: Implement outgoing "Read By Type" request/response.
Date: Thu, 26 Jun 2014 16:14:10 -0700
Message-Id: <1403824457-22461-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for "Read By Type" requests sent via bt_att_send
and the corresponding response.
---
 src/shared/att.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 9e16a6f..abf1440 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -223,6 +223,44 @@ static bool encode_find_by_type_val_req(struct att_send_op *op,
 	return true;
 }
 
+static bool encode_read_by_type_req(struct att_send_op *op,
+					const void *param, uint16_t length,
+					uint16_t mtu)
+{
+	const struct bt_att_read_by_type_req_param *p = param;
+	uint8_t uuid[16];
+	uint8_t uuid_len;
+	uint16_t len;
+
+	if (length != sizeof(*p))
+		return false;
+
+	if (p->type.type == BT_UUID16) {
+		uuid_len = 2;
+		put_le16(p->type.value.u16, uuid);
+	} else if (p->type.type == BT_UUID128) {
+		uuid_len = 16;
+		bswap_128(&p->type.value.u128, uuid);
+	} else
+		return false;
+
+	len = 5 + uuid_len;
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
+	memcpy(((uint8_t *) op->pdu) + 5, uuid, uuid_len);
+	op->len = len;
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -253,6 +291,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 		return encode_find_info_req(op, param, length, mtu);
 	case BT_ATT_OP_FIND_BY_TYPE_VAL_REQ:
 		return encode_find_by_type_val_req(op, param, length, mtu);
+	case BT_ATT_OP_READ_BY_TYPE_REQ:
+		return encode_read_by_type_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -583,6 +623,32 @@ static bool handle_find_by_type_val_rsp(struct bt_att *att, uint8_t opcode,
 							&param, sizeof(param));
 }
 
+static bool handle_read_by_type_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_read_by_type_rsp_param param;
+
+	/* PDU must contain at least the following:
+	 * - 1 octet: ATT opcode
+	 * - 1 octet: The size of each Attribute handle-value pair
+	 * - 2 to MTU-2 octets: Attribute Data List
+	 */
+	if (pdu_len < 4)
+		return false;
+
+	memset(&param, 0, sizeof(param));
+
+	param.length = pdu[1];
+	param.attr_data_list = pdu + 2;
+	param.list_length = pdu_len - 2;
+
+	if (param.list_length % param.length)
+		return false;
+
+	return request_complete(att, BT_ATT_OP_READ_BY_TYPE_REQ, opcode,
+							&param, sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -602,6 +668,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 		success = handle_find_by_type_val_rsp(att, opcode,
 								pdu, pdu_len);
 		break;
+	case BT_ATT_OP_READ_BY_TYPE_RSP:
+		success = handle_read_by_type_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

