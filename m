Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/4] Add aparams to pbap_object in pbap.c
Date: Fri, 31 Dec 2010 09:45:00 +0200
Message-Id: <1293781502-2709-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

aparams is added to pbap_object to handle application parameters
header separately from body header when assembling OBEX packet.
This modification is used in successive patch where headers of
different types can be added to a single OBEX packet.

append_aparam_header and array_read functions are created as a result
of such modification.
---
 plugins/pbap.c |   78 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 3ebfbe8..c0093de 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -146,6 +146,7 @@ struct pbap_session {
 
 struct pbap_object {
 	GString *buffer;
+	GByteArray *aparams;
 	struct pbap_session *session;
 	void *request;
 };
@@ -224,12 +225,28 @@ static void cache_clear(struct cache *cache)
 	cache->entries = NULL;
 }
 
+static GByteArray *append_aparam_header(GByteArray *buf, uint8_t tag,
+							const uint8_t *val)
+{
+	if (tag == PHONEBOOKSIZE_TAG) {
+		uint8_t aparam[sizeof(struct aparam_header) +
+							sizeof(uint16_t)];
+		struct aparam_header *hdr = (struct aparam_header *) aparam;
+
+		hdr->tag = PHONEBOOKSIZE_TAG;
+		hdr->len = PHONEBOOKSIZE_LEN;
+		memcpy(hdr->val, val, PHONEBOOKSIZE_LEN);
+
+		return g_byte_array_append(buf,	aparam,	sizeof(aparam));
+	}
+
+	return buf;
+}
+
 static void phonebook_size_result(const char *buffer, size_t bufsize,
 				int vcards, int missed, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
-	char aparam[4];
-	struct aparam_header *hdr = (struct aparam_header *) aparam;
 	uint16_t phonebooksize;
 
 	if (pbap->obj->request) {
@@ -244,11 +261,9 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 
 	phonebooksize = htons(vcards);
 
-	hdr->tag = PHONEBOOKSIZE_TAG;
-	hdr->len = PHONEBOOKSIZE_LEN;
-	memcpy(hdr->val, &phonebooksize, sizeof(phonebooksize));
-
-	pbap->obj->buffer = g_string_new_len(aparam, sizeof(aparam));
+	pbap->obj->aparams = g_byte_array_new();
+	pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
+			PHONEBOOKSIZE_TAG, (uint8_t*) &phonebooksize);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -400,15 +415,11 @@ static int generate_response(void *user_data)
 
 	if (max == 0) {
 		/* Ignore all other parameter and return PhoneBookSize */
-		char aparam[4];
-		struct aparam_header *hdr = (struct aparam_header *) aparam;
 		uint16_t size = htons(g_slist_length(pbap->cache.entries));
 
-		hdr->tag = PHONEBOOKSIZE_TAG;
-		hdr->len = PHONEBOOKSIZE_LEN;
-		memcpy(hdr->val, &size, sizeof(size));
-
-		pbap->obj->buffer = g_string_new_len(aparam, sizeof(aparam));
+		pbap->obj->aparams = g_byte_array_new();
+		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
+					PHONEBOOKSIZE_TAG, (uint8_t*) &size);
 
 		return 0;
 	}
@@ -790,6 +801,9 @@ static int vobject_close(void *object)
 	if (obj->buffer)
 		g_string_free(obj->buffer, TRUE);
 
+	if (obj->aparams)
+		g_byte_array_free(obj->aparams, TRUE);
+
 	if (obj->request) {
 		phonebook_req_finalize(obj->request);
 		obj->request = NULL;
@@ -902,6 +916,20 @@ fail:
 	return NULL;
 }
 
+ssize_t array_read(GByteArray *array, void *buf, size_t count)
+{
+	ssize_t len;
+
+	if (array->len == 0)
+		return 0;
+
+	len = MIN(array->len, count);
+	memcpy(buf, array->data, len);
+	array = g_byte_array_remove_range(array, 0, len);
+
+	return len;
+}
+
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
@@ -911,17 +939,18 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	DBG("buffer %p maxlistcount %d", obj->buffer,
 						pbap->params->maxlistcount);
 
-	if (!obj->buffer)
+	if (!obj->buffer && !obj->aparams)
 		return -EAGAIN;
 
-	/* PhoneBookSize */
-	if (pbap->params->maxlistcount == 0)
+	if (pbap->params->maxlistcount == 0) {
+		/* PhoneBookSize */
 		*hi = OBEX_HDR_APPARAM;
-	else
+		return array_read(obj->aparams, buf, count);
+	} else {
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
-
-	return string_read(obj->buffer, buf, count);
+		return string_read(obj->buffer, buf, count);
+	}
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
@@ -937,12 +966,13 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	if (!pbap->cache.valid)
 		return -EAGAIN;
 
-	if (pbap->params->maxlistcount == 0)
+	if (pbap->params->maxlistcount == 0) {
 		*hi = OBEX_HDR_APPARAM;
-	else
+		return array_read(obj->aparams, buf, count);
+	} else {
 		*hi = OBEX_HDR_BODY;
-
-	return string_read(obj->buffer, buf, count);
+		return string_read(obj->buffer, buf, count);
+	}
 }
 
 static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
-- 
1.7.0.4

