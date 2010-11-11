Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v3] Split up object and session in pbap.c
Date: Thu, 11 Nov 2010 17:51:00 +0200
Message-Id: <1289490660-14884-1-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Object and session data is separated in PBAP plugin. Reason is that
when OBEX session firstly makes disconnect of service_data, which
corresponds to session in pbap.c, it than closes object, which also
corresponds to session in pbap.c.

Memory is deallocated after PBAP session is disconnected. When OBEX
driver closes the object, it is trying to dereference the deallocated
memory in order to free pbap->buffer data.

Here object and session are separated, while pointers are created to
make one-to-one mapping. pbap_object is created in vobject_..._open
functions after query to tracker submitted. Session and object are
handled separately when freed.
---
 plugins/pbap.c |   94 +++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index c64377c..1a7d001 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -140,8 +140,13 @@ struct pbap_session {
 	struct apparam_field *params;
 	char *folder;
 	uint32_t find_handle;
-	GString *buffer;
 	struct cache cache;
+	struct pbap_object *obj;
+};
+
+struct pbap_object {
+	GString *buffer;
+	struct pbap_session *session;
 };
 
 static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
@@ -237,9 +242,9 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	hdr->len = PHONEBOOKSIZE_LEN;
 	memcpy(hdr->val, &phonebooksize, sizeof(phonebooksize));
 
-	pbap->buffer = g_string_new_len(aparam, sizeof(aparam));
+	pbap->obj->buffer = g_string_new_len(aparam, sizeof(aparam));
 
-	obex_object_set_io_flags(pbap, G_IO_IN, 0);
+	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
@@ -250,17 +255,17 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	DBG("");
 
 	if (vcards <= 0) {
-		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
 	}
 
-	if (!pbap->buffer)
-		pbap->buffer = g_string_new_len(buffer, bufsize);
+	if (!pbap->obj->buffer)
+		pbap->obj->buffer = g_string_new_len(buffer, bufsize);
 	else
-		pbap->buffer = g_string_append_len(pbap->buffer, buffer,
+		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer, buffer,
 								bufsize);
 
-	obex_object_set_io_flags(pbap, G_IO_IN, 0);
+	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
 static void cache_entry_notify(const char *id, uint32_t handle,
@@ -392,7 +397,7 @@ static void cache_ready_notify(void *user_data)
 		hdr->len = PHONEBOOKSIZE_LEN;
 		memcpy(hdr->val, &size, sizeof(size));
 
-		pbap->buffer = g_string_new_len(aparam, sizeof(aparam));
+		pbap->obj->buffer = g_string_new_len(aparam, sizeof(aparam));
 		goto done;
 	}
 
@@ -406,29 +411,29 @@ static void cache_ready_notify(void *user_data)
 
 	if (sorted == NULL) {
 		pbap->cache.valid = TRUE;
-		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
 	}
 
 	/* Computing offset considering first entry of the phonebook */
 	l = g_slist_nth(sorted, pbap->params->liststartoffset);
 
-	pbap->buffer = g_string_new(VCARD_LISTING_BEGIN);
+	pbap->obj->buffer = g_string_new(VCARD_LISTING_BEGIN);
 	for (; l && max; l = l->next, max--) {
 		const struct cache_entry *entry = l->data;
 
-		g_string_append_printf(pbap->buffer, VCARD_LISTING_ELEMENT,
+		g_string_append_printf(pbap->obj->buffer, VCARD_LISTING_ELEMENT,
 						entry->handle, entry->name);
 	}
 
-	pbap->buffer = g_string_append(pbap->buffer, VCARD_LISTING_END);
+	pbap->obj->buffer = g_string_append(pbap->obj->buffer, VCARD_LISTING_END);
 
 	g_slist_free(sorted);
 
 done:
 	if (!pbap->cache.valid) {
 		pbap->cache.valid = TRUE;
-		obex_object_set_io_flags(pbap, G_IO_IN, 0);
+		obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 	}
 }
 
@@ -445,14 +450,14 @@ static void cache_entry_done(void *user_data)
 	id = cache_find(&pbap->cache, pbap->find_handle);
 	if (id == NULL) {
 		DBG("Entry %d not found on cache", pbap->find_handle);
-		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
 	}
 
 	ret = phonebook_get_entry(pbap->folder, id, pbap->params,
 						query_result, pbap);
 	if (ret < 0)
-		obex_object_set_io_flags(pbap, G_IO_ERR, ret);
+		obex_object_set_io_flags(pbap->obj, G_IO_ERR, ret);
 }
 
 static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
@@ -659,6 +664,9 @@ static void pbap_disconnect(struct obex_session *os, void *user_data)
 
 	manager_unregister_session(os);
 
+	if (pbap->obj)
+		pbap->obj->session = NULL;
+
 	if (pbap->params) {
 		g_free(pbap->params->searchval);
 		g_free(pbap->params);
@@ -689,6 +697,17 @@ static struct obex_service_driver pbap = {
 	.chkput = pbap_chkput
 };
 
+static struct pbap_object *vobject_create(struct pbap_session *pbap)
+{
+	struct pbap_object *obj;
+
+	obj = g_new0(struct pbap_object, 1);
+	obj->session = pbap;
+	pbap->obj = obj;
+
+	return obj;
+}
+
 static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 				void *context, size_t *size, int *err)
 {
@@ -718,7 +737,7 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	if (ret < 0)
 		goto fail;
 
-	return pbap;
+	return vobject_create(pbap);
 
 fail:
 	if (err)
@@ -752,7 +771,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		 * Valid cache and empty buffer mean that cache was already
 		 * created within a single session, but no data is available.
 		 */
-		if (!pbap->buffer) {
+		if (!pbap->obj->buffer) {
 			ret = -ENOENT;
 			goto fail;
 		}
@@ -768,7 +787,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 
 done:
-	return pbap;
+	return vobject_create(pbap);
 
 fail:
 	if (err)
@@ -817,7 +836,7 @@ done:
 	if (ret < 0)
 		goto fail;
 
-	return pbap;
+	return vobject_create(pbap);
 
 fail:
 	if (err)
@@ -829,12 +848,13 @@ fail:
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
-	struct pbap_session *pbap = object;
+	struct pbap_object *obj = object;
+	struct pbap_session *pbap = obj->session;
 
-	DBG("buffer %p maxlistcount %d", pbap->buffer,
+	DBG("buffer %p maxlistcount %d", obj->buffer,
 						pbap->params->maxlistcount);
 
-	if (!pbap->buffer)
+	if (!obj->buffer)
 		return -EAGAIN;
 
 	/* PhoneBookSize */
@@ -844,13 +864,14 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
 
-	return string_read(pbap->buffer, buf, count);
+	return string_read(obj->buffer, buf, count);
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
-	struct pbap_session *pbap = object;
+	struct pbap_object *obj = object;
+	struct pbap_session *pbap = obj->session;
 
 	DBG("valid %d maxlistcount %d", pbap->cache.valid,
 						pbap->params->maxlistcount);
@@ -864,31 +885,34 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	else
 		*hi = OBEX_HDR_BODY;
 
-	return string_read(pbap->buffer, buf, count);
+	return string_read(obj->buffer, buf, count);
 }
 
 static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
-	struct pbap_session *pbap = object;
+	struct pbap_object *obj = object;
 
-	DBG("buffer %p", pbap->buffer);
+	DBG("buffer %p", obj->buffer);
 
-	if (!pbap->buffer)
+	if (!obj->buffer)
 		return -EAGAIN;
 
 	*hi = OBEX_HDR_BODY;
-	return string_read(pbap->buffer, buf, count);
+	return string_read(obj->buffer, buf, count);
 }
 
 static int vobject_close(void *object)
 {
-	struct pbap_session *pbap = object;
+	struct pbap_object *obj = object;
 
-	if (pbap->buffer) {
-		string_free(pbap->buffer);
-		pbap->buffer = NULL;
-	}
+	if (obj->session)
+		obj->session->obj = NULL;
+
+	if (obj->buffer)
+		g_string_free(obj->buffer, TRUE);
+
+	g_free(obj);
 
 	return 0;
 }
-- 
1.7.0.4

