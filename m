Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 08/10] src/shared/att: Add "Find By Type Value" request and response.
Date: Mon,  5 May 2014 21:46:01 -0700
Message-Id: <1399351563-25991-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1399351563-25991-1-git-send-email-armansito@chromium.org>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "Find By Type Value" request and
response with their corresponding parameter structures.
---
 src/shared/att.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h | 16 +++++++++++
 2 files changed, 102 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 25112c7..44e2abd 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -212,6 +212,11 @@ static bool handle_find_info_rsp(struct bt_att *att, const uint8_t *pdu,
 	struct bt_att_find_information_rsp_param param;
 	uint8_t *information_data;
 
+	/* PDU must contain at least the following:
+	 * - Attribute Opcode (1 octet)
+	 * - Format (1 octet)
+	 * - Information Data (4 to MTU-2 octets)
+	 */
 	if (pdu_length < 6)
 		return false;
 
@@ -237,6 +242,45 @@ static bool handle_find_info_rsp(struct bt_att *att, const uint8_t *pdu,
 	return true;
 }
 
+static bool handle_find_by_type_value_rsp(struct bt_att *att,
+							const uint8_t *pdu,
+							uint16_t pdu_length)
+{
+	struct bt_att_find_by_type_value_rsp_param param;
+	uint8_t *handles_info_list;
+
+	/* PDU must contain at least the following:
+	 * - Attribute Opcode (1 octet)
+	 * - Handles Information List (4 to MTU-1 octets)
+	 */
+	if (pdu_length < 5)
+		return false;
+
+	/* Each Handle Information field is composed of 4 octets. Return error,
+	 * if the length of the field is not a multiple of 4.
+	 */
+	if ((pdu_length - 1) % 4)
+		return false;
+
+	memset(&param, 0, sizeof(param));
+
+	param.length = pdu_length - 1;
+	handles_info_list = malloc(param.length);
+	if (!handles_info_list)
+		return false;
+
+	memcpy(handles_info_list, pdu + 1, param.length);
+
+	param.handles_information_list = handles_info_list;
+
+	request_complete(att, ATT_OP_FIND_BY_TYPE_VALUE_REQ, pdu[0], &param,
+								sizeof(param));
+
+	free(handles_info_list);
+
+	return true;
+}
+
 static bool handle_response(struct bt_att *att, const uint8_t *pdu,
 							uint16_t pdu_length)
 {
@@ -261,6 +305,13 @@ static bool handle_response(struct bt_att *att, const uint8_t *pdu,
 		}
 		return true;
 
+	case ATT_OP_FIND_BY_TYPE_VALUE_RESP:
+		if (!handle_find_by_type_value_rsp(att, pdu, pdu_length)) {
+			req_opcode = ATT_OP_FIND_BY_TYPE_VALUE_REQ;
+			goto fail;
+		}
+		return true;
+
 	default:
 		break;
 	}
@@ -488,6 +539,37 @@ static bool encode_find_info_req(const void *param, uint16_t length, void *buf,
 	return true;
 }
 
+static bool encode_find_by_type_value_req(const void *param, uint16_t length,
+							void *buf, uint16_t mtu,
+							uint16_t *pdu_length)
+{
+	const struct bt_att_find_by_type_value_req_param *cp = param;
+	const uint16_t len =  7 + cp->length;
+	uint8_t *bytes = buf;
+
+	if (length != sizeof(*cp))
+		return false;
+
+	if (len > mtu)
+		return false;
+
+	put_le16(cp->start_handle, bytes + 1);
+	put_le16(cp->end_handle, bytes + 3);
+	put_le16(cp->type, bytes + 5);
+
+	*pdu_length = len;
+
+	if (cp->length == 0)
+		return true;
+
+	if (!cp->value)
+		return false;
+
+	memcpy(bytes + 7, cp->value, cp->length);
+
+	return true;
+}
+
 static bool encode_pdu(uint8_t opcode, const void *param, uint16_t length,
 				uint16_t mtu, void *pdu, uint16_t *pdu_length)
 {
@@ -516,6 +598,10 @@ static bool encode_pdu(uint8_t opcode, const void *param, uint16_t length,
 		return encode_find_info_req(param, length, bytes,
 							mtu, pdu_length);
 
+	if (opcode == ATT_OP_FIND_BY_TYPE_VALUE_REQ)
+		return encode_find_by_type_value_req(param, length, bytes,
+							mtu, pdu_length);
+
 	return false;
 }
 
diff --git a/src/shared/att.h b/src/shared/att.h
index b9b4037..82a8321 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -57,6 +57,22 @@ struct bt_att_find_information_rsp_param {
 	uint16_t length;
 };
 
+/* Find By Type Value */
+#define ATT_OP_FIND_BY_TYPE_VALUE_REQ	0x06
+struct bt_att_find_by_type_value_req_param {
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint16_t type;  /* 2 octet UUID */
+	const uint8_t *value;
+	uint16_t length;  /* MAX length: (ATT_MTU - 7) */
+};
+
+#define ATT_OP_FIND_BY_TYPE_VALUE_RESP	0x07
+struct bt_att_find_by_type_value_rsp_param {
+	const uint8_t *handles_information_list;
+	uint16_t length;
+};
+
 /* Error codes for Error response PDU */
 #define ATT_ERROR_INVALID_HANDLE			0x01
 #define ATT_ERROR_READ_NOT_PERMITTED			0x02
-- 
1.9.1.423.g4596e3a

