Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/11] attrib: Remove unnecessary checks for PDU length on ATT encoding
Date: Sat, 11 Jan 2014 00:47:20 -0400
Message-Id: <1389415647-25831-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both userspace and kernel enforce a minimum ATT MTU of 23 octets, which
is also used as minimum size for buffers passed to ATT encoding
functions. Therefore, it is unnecessary to perform these checks on ATT
requests that are guaranteed to fit into 23 octets.

Also document ATT parameter lengths where a constant is being used for
calculating the PDU length.
---
 attrib/att.c | 131 +++++++++++++++++++++--------------------------------------
 1 file changed, 46 insertions(+), 85 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index d9ca709..a8f641a 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -123,29 +123,28 @@ struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
 uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, size_t len)
 {
-	uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-	uint16_t length;
+	uint16_t uuid_len;
 
 	if (!uuid)
 		return 0;
 
 	if (uuid->type == BT_UUID16)
-		length = 2;
+		uuid_len = 2;
 	else if (uuid->type == BT_UUID128)
-		length = 16;
+		uuid_len = 16;
 	else
 		return 0;
 
-	if (len < min_len + length)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
+	/* Starting Handle (2 octets) */
 	att_put_u16(start, &pdu[1]);
+	/* Ending Handle (2 octets) */
 	att_put_u16(end, &pdu[3]);
-
+	/* Attribute Group Type (2 or 16 octet UUID) */
 	att_put_uuid(*uuid, &pdu[5]);
 
-	return min_len + length;
+	return 5 + uuid_len;
 }
 
 uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
@@ -244,9 +243,6 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	if (uuid->type != BT_UUID16)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (vlen > len - min_len)
 		vlen = len - min_len;
 
@@ -309,7 +305,7 @@ uint16_t enc_find_by_type_resp(GSList *matches, uint8_t *pdu, size_t len)
 	GSList *l;
 	uint16_t offset;
 
-	if (pdu == NULL || len < 5)
+	if (!pdu)
 		return 0;
 
 	pdu[0] = ATT_OP_FIND_BY_TYPE_RESP;
@@ -354,29 +350,28 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, size_t len)
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, size_t len)
 {
-	uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-	uint16_t length;
+	uint16_t uuid_len;
 
 	if (!uuid)
 		return 0;
 
 	if (uuid->type == BT_UUID16)
-		length = 2;
+		uuid_len = 2;
 	else if (uuid->type == BT_UUID128)
-		length = 16;
+		uuid_len = 16;
 	else
 		return 0;
 
-	if (len < min_len + length)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
+	/* Starting Handle (2 octets) */
 	att_put_u16(start, &pdu[1]);
+	/* Ending Handle (2 octets) */
 	att_put_u16(end, &pdu[3]);
-
+	/* Attribute Type (2 or 16 octet UUID) */
 	att_put_uuid(*uuid, &pdu[5]);
 
-	return min_len + length;
+	return 5 + uuid_len;
 }
 
 uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
@@ -468,9 +463,6 @@ uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, size_t vlen,
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (vlen > len - min_len)
 		vlen = len - min_len;
 
@@ -517,9 +509,6 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (vlen > len - min_len)
 		vlen = len - min_len;
 
@@ -582,37 +571,31 @@ uint16_t dec_write_resp(const uint8_t *pdu, size_t len)
 
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_REQ;
+	/* Attribute Handle (2 octets) */
 	att_put_u16(handle, &pdu[1]);
 
-	return min_len;
+	return 3;
 }
 
 uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
 								size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
-							sizeof(offset);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_READ_BLOB_REQ;
+	/* Attribute Handle (2 octets) */
 	att_put_u16(handle, &pdu[1]);
+	/* Value Offset (2 octets) */
 	att_put_u16(offset, &pdu[3]);
 
-	return min_len;
+	return 5;
 }
 
 uint16_t dec_read_req(const uint8_t *pdu, size_t len, uint16_t *handle)
@@ -721,36 +704,32 @@ ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value,
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 						uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
-						sizeof(handle) + sizeof(status);
-
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_ERROR;
+	/* Request Opcode In Error (1 octet) */
 	pdu[1] = opcode;
+	/* Attribute Handle In Error (2 octets) */
 	att_put_u16(handle, &pdu[2]);
+	/* Error Code (1 octet) */
 	pdu[4] = status;
 
-	return min_len;
+	return 5;
 }
 
 uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu,
 								size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_FIND_INFO_REQ;
+	/* Starting Handle (2 octets) */
 	att_put_u16(start, &pdu[1]);
+	/* Ending Handle (2 octets) */
 	att_put_u16(end, &pdu[3]);
 
-	return min_len;
+	return 5;
 }
 
 uint16_t dec_find_info_req(const uint8_t *pdu, size_t len, uint16_t *start,
@@ -907,33 +886,26 @@ uint16_t dec_indication(const uint8_t *pdu, size_t len, uint16_t *handle,
 
 uint16_t enc_confirmation(uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_HANDLE_CNF;
 
-	return min_len;
+	return 1;
 }
 
 uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_MTU_REQ;
+	/* Client Rx MTU (2 octets) */
 	att_put_u16(mtu, &pdu[1]);
 
-	return min_len;
+	return 3;
 }
 
 uint16_t dec_mtu_req(const uint8_t *pdu, size_t len, uint16_t *mtu)
@@ -959,18 +931,15 @@ uint16_t dec_mtu_req(const uint8_t *pdu, size_t len, uint16_t *mtu)
 
 uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_MTU_RESP;
+	/* Server Rx MTU (2 octets) */
 	att_put_u16(mtu, &pdu[1]);
 
-	return min_len;
+	return 3;
 }
 
 uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu)
@@ -1004,9 +973,6 @@ uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (vlen > len - min_len)
 		vlen = len - min_len;
 
@@ -1060,9 +1026,6 @@ uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (vlen > len - min_len)
 		vlen = len - min_len;
 
@@ -1107,21 +1070,18 @@ uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
 
 uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, size_t len)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(flags);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
-		return 0;
-
 	if (flags > 1)
 		return 0;
 
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_EXEC_WRITE_REQ;
+	/* Flags (1 octet) */
 	pdu[1] = flags;
 
-	return min_len;
+	return 2;
 }
 
 uint16_t dec_exec_write_req(const uint8_t *pdu, size_t len, uint8_t *flags)
@@ -1150,9 +1110,10 @@ uint16_t enc_exec_write_resp(uint8_t *pdu)
 	if (pdu == NULL)
 		return 0;
 
+	/* Attribute Opcode (1 octet) */
 	pdu[0] = ATT_OP_EXEC_WRITE_RESP;
 
-	return sizeof(pdu[0]);
+	return 1;
 }
 
 uint16_t dec_exec_write_resp(const uint8_t *pdu, size_t len)
-- 
1.8.3.2

