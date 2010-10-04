Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/3] Replace hardcoded minimum length values with constants
Date: Mon,  4 Oct 2010 14:54:41 -0400
Message-Id: <1286218482-972-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1286218482-972-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1286218482-972-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c |  126 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 21659f0..a795ddd 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -90,6 +90,7 @@ void att_data_list_free(struct att_data_list *list)
 uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
 	uint16_t length;
 
 	if (!uuid)
@@ -102,7 +103,7 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	else
 		return 0;
 
-	if (len < 5 + length)
+	if (len < min_len + length)
 		return 0;
 
 	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
@@ -114,12 +115,14 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	else
 		memcpy(&pdu[5], &uuid->value.uuid128, length);
 
-	return 5 + length;
+	return min_len + length;
 }
 
 uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 						uint16_t *end, uuid_t *uuid)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
 	if (pdu == NULL)
 		return 0;
 
@@ -129,12 +132,12 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
 		return 0;
 
-	if (len < 7)
+	if (len < min_len + 2)
 		return 0;
 
 	*start = att_get_u16(&pdu[1]);
 	*end = att_get_u16(&pdu[3]);
-	if (len == 7)
+	if (len == min_len + 2)
 		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
 	else
 		sdp_uuid128_create(uuid, &pdu[5]);
@@ -203,6 +206,7 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
 	uint16_t length;
 
 	if (!uuid)
@@ -215,7 +219,7 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	else
 		return 0;
 
-	if (len < 5 + length)
+	if (len < min_len + length)
 		return 0;
 
 	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
@@ -227,19 +231,21 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	else
 		memcpy(&pdu[5], &uuid->value.uuid128, length);
 
-	return 5 + length;
+	return min_len + length;
 }
 
 uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 						uint16_t *end, uuid_t *uuid)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
 	if (pdu == NULL)
 		return 0;
 
 	if (start == NULL || end == NULL || uuid == NULL)
 		return 0;
 
-	if (len < 7)
+	if (len < min_len + 2)
 		return 0;
 
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
@@ -248,7 +254,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 	*start = att_get_u16(&pdu[1]);
 	*end = att_get_u16(&pdu[3]);
 
-	if (len == 7)
+	if (len == min_len + 2)
 		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
 	else
 		sdp_uuid128_create(uuid, &pdu[5]);
@@ -311,64 +317,72 @@ struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len)
 uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
 							uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
-	if (vlen > len - 3)
-		vlen = len - 3;
+	if (vlen > len - min_len)
+		vlen = len - min_len;
 
 	pdu[0] = ATT_OP_WRITE_CMD;
 	att_put_u16(handle, &pdu[1]);
 
 	if (vlen > 0) {
-		memcpy(pdu + 3, value, vlen);
-		return 3 + vlen;
+		memcpy(&pdu[3], value, vlen);
+		return min_len + vlen;
 	}
 
-	return 3;
+	return min_len;
 }
 
 uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
+
 	if (pdu == NULL)
 		return 0;
 
 	if (value == NULL || vlen == NULL || handle == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	if (pdu[0] != ATT_OP_WRITE_CMD)
 		return 0;
 
 	*handle = att_get_u16(&pdu[1]);
-	memcpy(value, pdu + 3, len - 3);
-	*vlen = len - 3;
+	memcpy(value, pdu + min_len, len - min_len);
+	*vlen = len - min_len;
 
 	return len;
 }
 
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	pdu[0] = ATT_OP_READ_REQ;
 	att_put_u16(handle, &pdu[1]);
 
-	return 3;
+	return min_len;
 }
 
 uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
+
 	if (pdu == NULL)
 		return 0;
 
@@ -380,7 +394,7 @@ uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle)
 
 	*handle = att_get_u16(&pdu[1]);
 
-	return 3;
+	return min_len;
 }
 
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len)
@@ -422,9 +436,11 @@ uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen)
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 							uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
+						sizeof(handle) + sizeof(status);
 	uint16_t u16;
 
-	if (len < 5)
+	if (len < min_len)
 		return 0;
 
 	u16 = htobs(handle);
@@ -433,31 +449,35 @@ uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 	memcpy(&pdu[2], &u16, sizeof(u16));
 	pdu[4] = status;
 
-	return 5;
+	return min_len;
 }
 
 uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 5)
+	if (len < min_len)
 		return 0;
 
 	pdu[0] = ATT_OP_FIND_INFO_REQ;
 	att_put_u16(start, &pdu[1]);
 	att_put_u16(end, &pdu[3]);
 
-	return 5;
+	return min_len;
 }
 
 uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
 								uint16_t *end)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 5)
+	if (len < min_len)
 		return 0;
 
 	if (start == NULL || end == NULL)
@@ -469,7 +489,7 @@ uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
 	*start = att_get_u16(&pdu[1]);
 	*end = att_get_u16(&pdu[3]);
 
-	return 5;
+	return min_len;
 }
 
 uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
@@ -520,10 +540,11 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 
 	list = malloc(sizeof(struct att_data_list));
 
+	list->len = sizeof(pdu[0]) + sizeof(*format);
 	if (*format == 0x01)
-		list->len = 4;
+		list->len += 2;
 	else if (*format == 0x02)
-		list->len = 18;
+		list->len += 16;
 
 	list->num = (len - 2) / list->len;
 	list->data = malloc(sizeof(uint8_t *) * list->num);
@@ -541,36 +562,42 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 
 uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < (a->len + 3))
+	if (len < (a->len + min_len))
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_NOTIFY;
 	att_put_u16(a->handle, &pdu[1]);
 	memcpy(&pdu[3], a->data, a->len);
 
-	return a->len + 3;
+	return a->len + min_len;
 }
 
 uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < (a->len + 3))
+	if (len < (a->len + min_len))
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_IND;
 	att_put_u16(a->handle, &pdu[1]);
 	memcpy(&pdu[3], a->data, a->len);
 
-	return a->len + 3;
+	return a->len + min_len;
 }
 
 struct attribute *dec_indication(const uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
 	struct attribute *a;
 
 	if (pdu == NULL)
@@ -579,11 +606,14 @@ struct attribute *dec_indication(const uint8_t *pdu, int len)
 	if (pdu[0] != ATT_OP_HANDLE_IND)
 		return NULL;
 
-	a = malloc(sizeof(struct attribute) + len - 3);
+	if (len < min_len)
+		return NULL;
+
+	a = malloc(sizeof(struct attribute) + len - min_len);
 	if (a == NULL)
 		return NULL;
 
-	a->len = len - 3;
+	a->len = len - min_len;
 
 	a->handle = att_get_u16(&pdu[1]);
 	memcpy(a->data, &pdu[3], a->len);
@@ -596,37 +626,41 @@ uint16_t enc_confirmation(uint8_t *pdu, int len)
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 1)
+	if (len < sizeof(pdu[0]))
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_CNF;
 
-	return 1;
+	return sizeof(pdu[0]);
 }
 
 uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	pdu[0] = ATT_OP_MTU_REQ;
 	att_put_u16(mtu, &pdu[1]);
 
-	return 3;
+	return min_len;
 }
 
 uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
+
 	if (pdu == NULL)
 		return 0;
 
 	if (mtu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	if (pdu[0] != ATT_OP_MTU_REQ)
@@ -634,32 +668,36 @@ uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu)
 
 	*mtu = att_get_u16(&pdu[1]);
 
-	return 3;
+	return min_len;
 }
 
 uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
+
 	if (pdu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	pdu[0] = ATT_OP_MTU_RESP;
 	att_put_u16(mtu, &pdu[1]);
 
-	return 3;
+	return min_len;
 }
 
 uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
 {
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
+
 	if (pdu == NULL)
 		return 0;
 
 	if (mtu == NULL)
 		return 0;
 
-	if (len < 3)
+	if (len < min_len)
 		return 0;
 
 	if (pdu[0] != ATT_OP_MTU_RESP)
@@ -667,5 +705,5 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
 
 	*mtu = att_get_u16(&pdu[1]);
 
-	return 3;
+	return min_len;
 }
-- 
1.7.0.4

