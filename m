Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix using the attribute struct for encoding ATT pdus
Date: Thu,  6 Oct 2011 11:38:17 -0300
Message-Id: <1317911897-6567-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The enconding and decoding of ATT pdus should be kept as much
free of dependences from other parts of the code as possible, so
it can be used in many contexts.

In this case, for encoding and decoding notifications and indications
we did have to pass an instance of an attribute instead of direct
values.
---
 attrib/att.c |   45 +++++++++++++++++++++++++--------------------
 attrib/att.h |    9 ++++++---
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index c3cbf86..a3a8947 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -820,60 +820,65 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 	return list;
 }
 
-uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len)
+uint16_t enc_notification(uint16_t handle, uint8_t *value, int vlen,
+						uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
 
 	if (pdu == NULL)
 		return 0;
 
-	if (len < (a->len + min_len))
+	if (len < (vlen + min_len))
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_NOTIFY;
-	att_put_u16(a->handle, &pdu[1]);
-	memcpy(&pdu[3], a->data, a->len);
+	att_put_u16(handle, &pdu[1]);
+	memcpy(&pdu[3], value, vlen);
 
-	return a->len + min_len;
+	return vlen + min_len;
 }
 
-uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len)
+uint16_t enc_indication(uint16_t handle, uint8_t *value, int vlen,
+						uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
 
 	if (pdu == NULL)
 		return 0;
 
-	if (len < (a->len + min_len))
+	if (len < (vlen + min_len))
 		return 0;
 
 	pdu[0] = ATT_OP_HANDLE_IND;
-	att_put_u16(a->handle, &pdu[1]);
-	memcpy(&pdu[3], a->data, a->len);
+	att_put_u16(handle, &pdu[1]);
+	memcpy(&pdu[3], value, vlen);
 
-	return a->len + min_len;
+	return vlen + min_len;
 }
 
-struct attribute *dec_indication(const uint8_t *pdu, int len)
+uint16_t dec_indication(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int vlen)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-	struct attribute *a;
+	uint16_t dlen;
 
 	if (pdu == NULL)
-		return NULL;
+		return 0;
 
 	if (pdu[0] != ATT_OP_HANDLE_IND)
-		return NULL;
+		return 0;
 
 	if (len < min_len)
-		return NULL;
+		return 0;
+
+	dlen = MIN(len - min_len, vlen);
+
+	if (handle)
+		*handle = att_get_u16(&pdu[1]);
 
-	a = g_new0(struct attribute, 1);
-	a->handle = att_get_u16(&pdu[1]);
-	a->len = len - min_len;
-	a->data = g_memdup(&pdu[3], a->len);
+	memcpy(value, &pdu[3], dlen);
 
-	return a;
+	return dlen;
 }
 
 uint16_t enc_confirmation(uint8_t *pdu, int len)
diff --git a/attrib/att.h b/attrib/att.h
index 3de1726..851e6ba 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -299,9 +299,12 @@ uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
 							uint8_t *pdu, int len);
 struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 							uint8_t *format);
-uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len);
-uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len);
-struct attribute *dec_indication(const uint8_t *pdu, int len);
+uint16_t enc_notification(uint16_t handle, uint8_t *value, int vlen,
+						uint8_t *pdu, int len);
+uint16_t enc_indication(uint16_t handle, uint8_t *value, int vlen,
+						uint8_t *pdu, int len);
+uint16_t dec_indication(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int vlen);
 uint16_t enc_confirmation(uint8_t *pdu, int len);
 
 uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len);
-- 
1.7.6.1

