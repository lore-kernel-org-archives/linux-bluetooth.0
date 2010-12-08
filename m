Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix regression causing crash in 3-way calling
Date: Wed,  8 Dec 2010 12:04:38 +0200
Message-Id: <1291802678-14639-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix possible obexd crash in 3-way calling scenario. Callback
function cache_ready_notify is splitted in two cache_ready_notify
and generate_response functions.

generate_response fills data to buffer and returns error, if any.
---
 plugins/pbap.c |   94 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 1a7d001..83c8ff4 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -378,7 +378,7 @@ static GSList *sort_entries(GSList *l, uint8_t order, uint8_t search_attrib,
 	return sorted;
 }
 
-static void cache_ready_notify(void *user_data)
+static int generate_response(void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	GSList *sorted;
@@ -409,11 +409,8 @@ static void cache_ready_notify(void *user_data)
 			pbap->params->searchattrib,
 			(const char *) pbap->params->searchval);
 
-	if (sorted == NULL) {
-		pbap->cache.valid = TRUE;
-		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
-		return;
-	}
+	if (sorted == NULL)
+		return -ENOENT;
 
 	/* Computing offset considering first entry of the phonebook */
 	l = g_slist_nth(sorted, pbap->params->liststartoffset);
@@ -431,10 +428,25 @@ static void cache_ready_notify(void *user_data)
 	g_slist_free(sorted);
 
 done:
-	if (!pbap->cache.valid) {
-		pbap->cache.valid = TRUE;
-		obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
+	return 0;
+}
+
+static void cache_ready_notify(void *user_data)
+{
+	struct pbap_session *pbap = user_data;
+	int err;
+
+	DBG("");
+
+	pbap->cache.valid = TRUE;
+
+	err = generate_response(pbap);
+	if (err < 0) {
+		obex_object_set_io_flags(pbap->obj, G_IO_ERR, err);
+		return;
 	}
+
+	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
 static void cache_entry_done(void *user_data)
@@ -746,10 +758,28 @@ fail:
 	return NULL;
 }
 
+static int vobject_close(void *object)
+{
+	struct pbap_object *obj = object;
+
+	DBG("");
+
+	if (obj->session)
+		obj->session->obj = NULL;
+
+	if (obj->buffer)
+		g_string_free(obj->buffer, TRUE);
+
+	g_free(obj);
+
+	return 0;
+}
+
 static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 				void *context, size_t *size, int *err)
 {
 	struct pbap_session *pbap = context;
+	struct pbap_object *obj = NULL;
 	int ret;
 
 	DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
@@ -766,30 +796,25 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 
 	/* PullvCardListing always get the contacts from the cache */
 
-	if (pbap->cache.valid) {
-		/*
-		 * Valid cache and empty buffer mean that cache was already
-		 * created within a single session, but no data is available.
-		 */
-		if (!pbap->obj->buffer) {
-			ret = -ENOENT;
-			goto fail;
-		}
-
-		cache_ready_notify(pbap);
-		goto done;
-	}
-
-	ret = phonebook_create_cache(name,
-		cache_entry_notify, cache_ready_notify, pbap);
+	obj = vobject_create(pbap);
 
+	if (pbap->cache.valid)
+		ret = generate_response(pbap);
+	else
+		ret = phonebook_create_cache(name, cache_entry_notify,
+						cache_ready_notify, pbap);
 	if (ret < 0)
 		goto fail;
 
-done:
-	return vobject_create(pbap);
+	if (err)
+		*err = 0;
+
+	return obj;
 
 fail:
+	if (obj)
+		vobject_close(obj);
+
 	if (err)
 		*err = ret;
 
@@ -902,21 +927,6 @@ static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
 	return string_read(obj->buffer, buf, count);
 }
 
-static int vobject_close(void *object)
-{
-	struct pbap_object *obj = object;
-
-	if (obj->session)
-		obj->session->obj = NULL;
-
-	if (obj->buffer)
-		g_string_free(obj->buffer, TRUE);
-
-	g_free(obj);
-
-	return 0;
-}
-
 static struct obex_mime_type_driver mime_pull = {
 	.target = PBAP_TARGET,
 	.target_size = TARGET_SIZE,
-- 
1.7.0.4

