Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/9] PBAP: Make use of GObexApparam API
Date: Thu,  9 Aug 2012 13:32:31 +0300
Message-Id: <1344508353-24647-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/pbap.c      | 180 +++++++++++-----------------------------------------
 plugins/phonebook.h |   2 +-
 2 files changed, 39 insertions(+), 143 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index c7e792a..c36fab2 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -39,6 +39,7 @@
 #include <inttypes.h>
 
 #include <gobex.h>
+#include <gobex-apparam.h>
 
 #include "obexd.h"
 #include "plugin.h"
@@ -64,16 +65,6 @@
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
 
-/* The following length is in the unit of byte */
-#define ORDER_LEN		1
-#define SEARCHATTRIB_LEN	1
-#define MAXLISTCOUNT_LEN	2
-#define LISTSTARTOFFSET_LEN	2
-#define FILTER_LEN		8
-#define FORMAT_LEN		1
-#define PHONEBOOKSIZE_LEN	2
-#define NEWMISSEDCALLS_LEN	1
-
 #define PBAP_CHANNEL	15
 
 #define PBAP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
@@ -117,12 +108,6 @@
   </attribute>								\
 </record>"
 
-struct aparam_header {
-	uint8_t tag;
-	uint8_t len;
-	uint8_t val[0];
-} __attribute__ ((packed));
-
 struct cache {
 	gboolean valid;
 	uint32_t index;
@@ -147,7 +132,7 @@ struct pbap_session {
 
 struct pbap_object {
 	GString *buffer;
-	GByteArray *aparams;
+	GObexApparam *apparam;
 	gboolean firstpacket;
 	gboolean lastpart;
 	struct pbap_session *session;
@@ -229,33 +214,6 @@ static void cache_clear(struct cache *cache)
 	cache->entries = NULL;
 }
 
-static GByteArray *append_aparam_header(GByteArray *buf, uint8_t tag,
-							const void *val)
-{
-	/* largest aparam is for phonebooksize (4 bytes) */
-	uint8_t aparam[sizeof(struct aparam_header) + PHONEBOOKSIZE_LEN];
-	struct aparam_header *hdr = (struct aparam_header *) aparam;
-
-	switch (tag) {
-	case PHONEBOOKSIZE_TAG:
-		hdr->tag = PHONEBOOKSIZE_TAG;
-		hdr->len = PHONEBOOKSIZE_LEN;
-		memcpy(hdr->val, val, PHONEBOOKSIZE_LEN);
-
-		return g_byte_array_append(buf,	aparam,
-			sizeof(struct aparam_header) + PHONEBOOKSIZE_LEN);
-	case NEWMISSEDCALLS_TAG:
-		hdr->tag = NEWMISSEDCALLS_TAG;
-		hdr->len = NEWMISSEDCALLS_LEN;
-		memcpy(hdr->val, val, NEWMISSEDCALLS_LEN);
-
-		return g_byte_array_append(buf,	aparam,
-			sizeof(struct aparam_header) + NEWMISSEDCALLS_LEN);
-	default:
-		return buf;
-	}
-}
-
 static void phonebook_size_result(const char *buffer, size_t bufsize,
 					int vcards, int missed,
 					gboolean lastpart, void *user_data)
@@ -275,15 +233,16 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 
 	phonebooksize = htons(vcards);
 
-	pbap->obj->aparams = g_byte_array_new();
-	pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
-					PHONEBOOKSIZE_TAG, &phonebooksize);
+	pbap->obj->apparam = g_obex_apparam_set_uint16(NULL, PHONEBOOKSIZE_TAG,
+								phonebooksize);
 
 	if (missed > 0)	{
 		DBG("missed %d", missed);
 
-		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
-						NEWMISSEDCALLS_TAG, &missed);
+		pbap->obj->apparam = g_obex_apparam_set_uint16(
+							pbap->obj->apparam,
+							NEWMISSEDCALLS_TAG,
+							missed);
 	}
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
@@ -319,9 +278,10 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 		pbap->obj->firstpacket = TRUE;
 
-		pbap->obj->aparams = g_byte_array_new();
-		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
-						NEWMISSEDCALLS_TAG, &missed);
+		pbap->obj->apparam = g_obex_apparam_set_uint16(
+							pbap->obj->apparam,
+							NEWMISSEDCALLS_TAG,
+							missed);
 	}
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
@@ -450,9 +410,10 @@ static int generate_response(void *user_data)
 		/* Ignore all other parameter and return PhoneBookSize */
 		uint16_t size = htons(g_slist_length(pbap->cache.entries));
 
-		pbap->obj->aparams = g_byte_array_new();
-		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
-						PHONEBOOKSIZE_TAG, &size);
+		pbap->obj->apparam = g_obex_apparam_set_uint16(
+							pbap->obj->apparam,
+							PHONEBOOKSIZE_TAG,
+							size);
 
 		return 0;
 	}
@@ -527,85 +488,34 @@ static void cache_entry_done(void *user_data)
 
 static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 {
+	GObexApparam *apparam;
 	struct apparam_field *param;
-	struct aparam_header *hdr;
-	uint64_t val64;
-	uint32_t len = 0;
-	uint16_t val16;
-
-	param = g_new0(struct apparam_field, 1);
-
-	while (len < hlen) {
-		hdr = (void *) buffer + len;
-
-		switch (hdr->tag) {
-		case ORDER_TAG:
-			if (hdr->len != ORDER_LEN)
-				goto failed;
-
-			param->order = hdr->val[0];
-			break;
-
-		case SEARCHATTRIB_TAG:
-			if (hdr->len != SEARCHATTRIB_LEN)
-				goto failed;
-
-			param->searchattrib = hdr->val[0];
-			break;
-		case SEARCHVALUE_TAG:
-			if (hdr->len == 0)
-				goto failed;
-
-			param->searchval = g_try_malloc0(hdr->len + 1);
-			if (param->searchval)
-				memcpy(param->searchval, hdr->val, hdr->len);
-			break;
-		case FILTER_TAG:
-			if (hdr->len != FILTER_LEN)
-				goto failed;
-
-			memcpy(&val64, hdr->val, sizeof(val64));
-			param->filter = GUINT64_FROM_BE(val64);
-
-			break;
-		case FORMAT_TAG:
-			if (hdr->len != FORMAT_LEN)
-				goto failed;
 
-			param->format = hdr->val[0];
-			break;
-		case MAXLISTCOUNT_TAG:
-			if (hdr->len != MAXLISTCOUNT_LEN)
-				goto failed;
+	apparam = g_obex_apparam_decode(buffer, hlen);
+	if (apparam == NULL)
+		return NULL;
 
-			memcpy(&val16, hdr->val, sizeof(val16));
-			param->maxlistcount = GUINT16_FROM_BE(val16);
-			break;
-		case LISTSTARTOFFSET_TAG:
-			if (hdr->len != LISTSTARTOFFSET_LEN)
-				goto failed;
-
-			memcpy(&val16, hdr->val, sizeof(val16));
-			param->liststartoffset = GUINT16_FROM_BE(val16);
-			break;
-		default:
-			goto failed;
-		}
+	param = g_new0(struct apparam_field, 1);
 
-		len += hdr->len + sizeof(struct aparam_header);
-	}
+	g_obex_apparam_get_uint8(apparam, ORDER_TAG, &param->order);
+	g_obex_apparam_get_uint8(apparam, SEARCHATTRIB_TAG,
+						&param->searchattrib);
+	g_obex_apparam_get_uint8(apparam, FORMAT_TAG, &param->format);
+	g_obex_apparam_get_uint16(apparam, MAXLISTCOUNT_TAG,
+						&param->maxlistcount);
+	g_obex_apparam_get_uint16(apparam, LISTSTARTOFFSET_TAG,
+						&param->liststartoffset);
+	g_obex_apparam_get_uint64(apparam, FILTER_TAG, &param->filter);
+	param->searchval = g_obex_apparam_get_string(apparam, SEARCHVALUE_TAG);
 
 	DBG("o %x sa %x sv %s fil %" G_GINT64_MODIFIER "x for %x max %x off %x",
 			param->order, param->searchattrib, param->searchval,
 			param->filter, param->format, param->maxlistcount,
 			param->liststartoffset);
 
-	return param;
-
-failed:
-	g_free(param);
+	g_obex_apparam_free(apparam);
 
-	return NULL;
+	return param;
 }
 
 static void *pbap_connect(struct obex_session *os, int *err)
@@ -839,8 +749,8 @@ static int vobject_close(void *object)
 	if (obj->buffer)
 		g_string_free(obj->buffer, TRUE);
 
-	if (obj->aparams)
-		g_byte_array_free(obj->aparams, TRUE);
+	if (obj->apparam)
+		g_obex_apparam_free(obj->apparam);
 
 	if (obj->request)
 		phonebook_req_finalize(obj->request);
@@ -952,27 +862,13 @@ fail:
 	return NULL;
 }
 
-static ssize_t array_read(GByteArray *array, void *buf, size_t count)
-{
-	ssize_t len;
-
-	if (array->len == 0)
-		return 0;
-
-	len = MIN(array->len, count);
-	memcpy(buf, array->data, len);
-	g_byte_array_remove_range(array, 0, len);
-
-	return len;
-}
-
 static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
 
-	if (!obj->buffer && !obj->aparams)
+	if (!obj->buffer && !obj->apparam)
 		return -EAGAIN;
 
 	*hi = G_OBEX_HDR_APPARAM;
@@ -980,7 +876,7 @@ static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 	if (pbap->params->maxlistcount == 0 || obj->firstpacket) {
 		obj->firstpacket = FALSE;
 
-		return array_read(obj->aparams, buf, mtu);
+		return g_obex_apparam_encode(obj->apparam, buf, mtu);
 	}
 
 	return 0;
@@ -1031,7 +927,7 @@ static ssize_t vobject_list_get_next_header(void *object, void *buf, size_t mtu,
 	*hi = G_OBEX_HDR_APPARAM;
 
 	if (pbap->params->maxlistcount == 0)
-		return array_read(obj->aparams, buf, mtu);
+		return g_obex_apparam_encode(obj->apparam, buf, mtu);
 
 	return 0;
 }
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index 6e51c73..441cff2 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -61,7 +61,7 @@ struct apparam_field {
 	/* list attributes only */
 	uint8_t order;
 	uint8_t searchattrib;
-	uint8_t *searchval;
+	char *searchval;
 };
 
 /*
-- 
1.7.11.2

