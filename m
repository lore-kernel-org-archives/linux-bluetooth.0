Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
Date: Thu, 26 Jun 2014 16:14:08 -0700
Message-Id: <1403824457-22461-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1403824457-22461-1-git-send-email-armansito@chromium.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for "Find Information" requests sent via
bt_att_send and the corresponding response.
---
 src/shared/att.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 57f887e..22dd471 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -165,6 +165,30 @@ static bool encode_mtu_req(struct att_send_op *op, const void *param,
 	return true;
 }
 
+static bool encode_find_info_req(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	const struct bt_att_find_info_req_param *p = param;
+	const uint16_t len = 5;
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
+	op->len = len;
+
+	return true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *param,
 						uint16_t length, uint16_t mtu)
 {
@@ -191,6 +215,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
 	switch (op->opcode) {
 	case BT_ATT_OP_MTU_REQ:
 		return encode_mtu_req(op, param, length, mtu);
+	case BT_ATT_OP_FIND_INFO_REQ:
+		return encode_find_info_req(op, param, length, mtu);
 	default:
 		break;
 	}
@@ -471,6 +497,29 @@ static bool handle_mtu_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 							&param, sizeof(param));
 }
 
+static bool handle_find_info_rsp(struct bt_att *att, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
+{
+	struct bt_att_find_info_rsp_param param;
+
+	/* PDU must have the following data:
+	 * - 1 octet: ATT opcode
+	 * - 1 octet: Format
+	 * - 4 to MTU-2 octetsS; Information data
+	 */
+	if (pdu_len < 6)
+		return false;
+
+	memset(&param, 0, sizeof(param));
+
+	param.format = pdu[1];
+	param.length = pdu_len - 2;
+	param.info_data = pdu + 2;
+
+	return request_complete(att, BT_ATT_OP_FIND_INFO_REQ, opcode,
+							&param, sizeof(param));
+}
+
 static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
@@ -483,6 +532,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	case BT_ATT_OP_MTU_RSP:
 		success = handle_mtu_rsp(att, opcode, pdu, pdu_len);
 		break;
+	case BT_ATT_OP_FIND_INFO_RSP:
+		success = handle_find_info_rsp(att, opcode, pdu, pdu_len);
+		break;
 	default:
 		success = false;
 		util_debug(att->debug_callback, att->debug_data,
-- 
2.0.0.526.g5318336

