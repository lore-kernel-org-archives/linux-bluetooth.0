Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/2] Coding standard change replacing malloc by glib functions
Date: Thu, 24 Feb 2011 18:18:22 -0300
Message-Id: <1298582302-28775-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <AANLkTi=uNVCKVMFXNE7oAQVckB8XqkDthoZeXCvfdf5V@mail.gmail.com>
References: <AANLkTi=uNVCKVMFXNE7oAQVckB8XqkDthoZeXCvfdf5V@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use glib memory allocation functions instead of malloc for attribute
data list in ATT protocol utility functions.
---
 attrib/att.c |   76 ++++++++++++++++++++++++++++++++++-----------------------
 attrib/att.h |    1 +
 2 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 3259fca..b96b97d 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -80,13 +80,34 @@ const char *att_ecode2str(uint8_t status)
 
 void att_data_list_free(struct att_data_list *list)
 {
+	if (list == NULL)
+		return;
+
+	if (list->data) {
+		int i;
+		for (i = 0; i < list->num; i++)
+			g_free(list->data[i]);
+	}
+
+	g_free(list->data);
+	g_free(list);
+}
+
+struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
+{
+	struct att_data_list *list;
 	int i;
 
-	for (i = 0; i < list->num; i++)
-		free(list->data[i]);
+	list = g_new0(struct att_data_list, 1);
+	list->len = len;
+	list->num = num;
 
-	free(list->data);
-	free(list);
+	list->data = g_malloc0(sizeof(uint8_t *) * num);
+
+	for (i = 0; i < num; i++)
+		list->data[i] = g_malloc0(sizeof(uint8_t) * len);
+
+	return list;
 }
 
 uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
@@ -178,20 +199,19 @@ struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
 {
 	struct att_data_list *list;
 	const uint8_t *ptr;
+	uint16_t elen, num;
 	int i;
 
 	if (pdu[0] != ATT_OP_READ_BY_GROUP_RESP)
 		return NULL;
 
-	list = malloc(sizeof(struct att_data_list));
-	list->len = pdu[1];
-	list->num = (len - 2) / list->len;
+	elen = pdu[1];
+	num = (len - 2) / elen;
+	list = att_data_list_alloc(num, elen);
 
-	list->data = malloc(sizeof(uint8_t *) * list->num);
 	ptr = &pdu[2];
 
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -307,7 +327,7 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, int len)
 		return NULL;
 
 	for (offset = 1, matches = NULL; len >= (offset + 4); offset += 4) {
-		range = malloc(sizeof(struct att_range));
+		range = g_new0(struct att_range, 1);
 		range->start = att_get_u16(&pdu[offset]);
 		range->end = att_get_u16(&pdu[offset + 2]);
 
@@ -406,20 +426,19 @@ struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len)
 {
 	struct att_data_list *list;
 	const uint8_t *ptr;
+	uint16_t elen, num;
 	int i;
 
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_RESP)
 		return NULL;
 
-	list = malloc(sizeof(struct att_data_list));
-	list->len = pdu[1];
-	list->num = (len - 2) / list->len;
+	elen = pdu[1];
+	num = (len - 2) / elen;
+	list = att_data_list_alloc(num, elen);
 
-	list->data = malloc(sizeof(uint8_t *) * list->num);
 	ptr = &pdu[2];
 
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -775,6 +794,7 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 {
 	struct att_data_list *list;
 	uint8_t *ptr;
+	uint16_t elen, num;
 	int i;
 
 	if (pdu == NULL)
@@ -787,22 +807,19 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 		return 0;
 
 	*format = pdu[1];
-
-	list = malloc(sizeof(struct att_data_list));
-
-	list->len = sizeof(pdu[0]) + sizeof(*format);
+	elen = sizeof(pdu[0]) + sizeof(*format);
 	if (*format == 0x01)
-		list->len += 2;
+		elen += 2;
 	else if (*format == 0x02)
-		list->len += 16;
+		elen += 16;
 
-	list->num = (len - 2) / list->len;
-	list->data = malloc(sizeof(uint8_t *) * list->num);
+	num = (len - 2) / elen;
 
 	ptr = (void *) &pdu[2];
 
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(list->len);
+	list = att_data_list_alloc(num, elen);
+
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -859,10 +876,7 @@ struct attribute *dec_indication(const uint8_t *pdu, int len)
 	if (len < min_len)
 		return NULL;
 
-	a = malloc(sizeof(struct attribute) + len - min_len);
-	if (a == NULL)
-		return NULL;
-
+	a = g_malloc0(sizeof(struct attribute) + len - min_len);
 	a->len = len - min_len;
 
 	a->handle = att_get_u16(&pdu[1]);
diff --git a/attrib/att.h b/attrib/att.h
index 9b0b538..b62f254 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -188,6 +188,7 @@ static inline void att_put_u32(uint32_t src, void *dst)
 	bt_put_unaligned(htobl(src), (uint32_t *) dst);
 }
 
+struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
 const char *att_ecode2str(uint8_t status);
-- 
1.7.4.1

