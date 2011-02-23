Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Coding standard change replacing malloc by glib functions
Date: Wed, 23 Feb 2011 19:33:12 -0300
Message-Id: <1298500393-4894-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use glib memory allocation functions instead of malloc for attribute
data list in ATT protocol utility functions.
---
 attrib/att.c |  101 ++++++++++++++++++++++++++++++++++++++++++----------------
 attrib/att.h |    1 +
 2 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 3259fca..1de93c4 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -80,13 +80,47 @@ const char *att_ecode2str(uint8_t status)
 
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
+	list = g_try_new0(struct att_data_list, 1);
+	if (list == NULL)
+		return NULL;
+
+	list->len = len;
+	list->num = num;
+
+	list->data = g_try_malloc0(sizeof(uint8_t *) * num);
+	if (list->data == NULL)
+		goto enomem;
 
-	free(list->data);
-	free(list);
+	for (i = 0; i < num; i++) {
+		list->data[i] = g_try_malloc0(sizeof(uint8_t) * len);
+		if (list->data[i] == NULL)
+			goto enomem;
+	}
+
+	return list;
+
+enomem:
+	att_data_list_free(list);
+
+	return NULL;
 }
 
 uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
@@ -178,20 +212,21 @@ struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
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
+	if (list == NULL)
+		return NULL;
 
-	list->data = malloc(sizeof(uint8_t *) * list->num);
 	ptr = &pdu[2];
 
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -307,7 +342,10 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, int len)
 		return NULL;
 
 	for (offset = 1, matches = NULL; len >= (offset + 4); offset += 4) {
-		range = malloc(sizeof(struct att_range));
+		range = g_try_new0(struct att_range, 1);
+		if (range == NULL)
+			goto enomem;
+
 		range->start = att_get_u16(&pdu[offset]);
 		range->end = att_get_u16(&pdu[offset + 2]);
 
@@ -315,6 +353,12 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, int len)
 	}
 
 	return matches;
+
+enomem:
+	g_slist_foreach(matches, (GFunc) g_free, NULL);
+	g_slist_free(matches);
+
+	return NULL;
 }
 
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
@@ -406,20 +450,21 @@ struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len)
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
+	if (list == NULL)
+		return NULL;
 
-	list->data = malloc(sizeof(uint8_t *) * list->num);
 	ptr = &pdu[2];
 
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -775,6 +820,7 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
 {
 	struct att_data_list *list;
 	uint8_t *ptr;
+	uint16_t elen, num;
 	int i;
 
 	if (pdu == NULL)
@@ -787,22 +833,21 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
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
+	if (list == NULL)
+		return NULL;
+
+	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
 		ptr += list->len;
 	}
@@ -859,7 +904,7 @@ struct attribute *dec_indication(const uint8_t *pdu, int len)
 	if (len < min_len)
 		return NULL;
 
-	a = malloc(sizeof(struct attribute) + len - min_len);
+	a = g_try_malloc0(sizeof(struct attribute) + len - min_len);
 	if (a == NULL)
 		return NULL;
 
diff --git a/attrib/att.h b/attrib/att.h
index 7d9afeb..76072c0 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -185,6 +185,7 @@ static inline void att_put_u32(uint32_t src, void *dst)
 	bt_put_unaligned(htobl(src), (uint32_t *) dst);
 }
 
+struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
 const char *att_ecode2str(uint8_t status);
-- 
1.7.4.1

