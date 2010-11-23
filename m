Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 5/7] Add update phonebook_get_entry
Date: Tue, 23 Nov 2010 20:11:27 +0200
Message-Id: <1290535889-17038-6-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_get_entry function prototype update to return void
pointer to backend specific request and error code. All backend
handlers updated accordingly (phonebook-tracker.c,
phonebook-dummy.c, and phonebook-ebook.c).

Phonebook request is created dynamically only for tracker,
therefore, removed appropriately when PBAP object is destroyed.

IRMC does not invoke phonebook_get_entry therefore is not changed.
---
 plugins/pbap.c              |   11 ++++++-----
 plugins/phonebook-dummy.c   |   18 +++++++++++-------
 plugins/phonebook-ebook.c   |   15 ++++++++++-----
 plugins/phonebook-tracker.c |   17 ++++++++++++-----
 plugins/phonebook.h         |    4 ++--
 5 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0ceaf95..2ce580b 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -455,8 +455,8 @@ static void cache_entry_done(void *user_data)
 		return;
 	}
 
-	ret = phonebook_get_entry(pbap->folder, id, pbap->params,
-						query_result, pbap);
+	pbap->obj->request = phonebook_get_entry(pbap->folder, id,
+				pbap->params, query_result, pbap, &ret);
 	if (ret < 0)
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, ret);
 }
@@ -811,6 +811,7 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 	const char *id;
 	uint32_t handle;
 	int ret;
+	void *request = NULL;
 
 	DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
 
@@ -837,14 +838,14 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
-	ret = phonebook_get_entry(pbap->folder, id, pbap->params, query_result,
-									pbap);
+	request = phonebook_get_entry(pbap->folder, id, pbap->params,
+						query_result, pbap, &ret);
 
 done:
 	if (ret < 0)
 		goto fail;
 
-	return vobject_create(pbap, NULL);
+	return vobject_create(pbap, request);
 
 fail:
 	if (err)
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index d9a5a29..7a963b6 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -496,9 +496,9 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	return NULL;
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+			const struct apparam_field *params, phonebook_cb cb,
+			void *user_data, int *err)
 {
 	struct dummy_data *dummy;
 	char *filename;
@@ -508,9 +508,10 @@ int phonebook_get_entry(const char *folder, const char *id,
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0) {
-		int err = errno;
-		DBG("open(): %s(%d)", strerror(err), err);
-		return -ENOENT;
+		DBG("open(): %s(%d)", strerror(errno), errno);
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
 	dummy = g_new0(struct dummy_data, 1);
@@ -521,7 +522,10 @@ int phonebook_get_entry(const char *folder, const char *id,
 
 	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_entry, dummy, dummy_free);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
 
 int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 9097a0b..2515bb0 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -435,9 +435,9 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	return NULL;
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+				const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct contacts_query *data;
 
@@ -448,10 +448,15 @@ int phonebook_get_entry(const char *folder, const char *id,
 
 	if (e_book_async_get_contact(ebook, id, ebook_entry_cb, data)) {
 		g_free(data);
-		return -ENOENT;
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
 
 int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index bce60d6..ead583e 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1868,13 +1868,14 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	return req;
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+				const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct phonebook_data *data;
 	char *query;
 	int ret;
+	struct phonebook_req *req = g_new0(struct phonebook_req, 1);
 
 	DBG("folder %s id %s", folder, id);
 
@@ -1893,11 +1894,17 @@ int phonebook_get_entry(const char *folder, const char *id,
 								id, id, id);
 
 	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data,
-									NULL);
+									req);
 
 	g_free(query);
 
-	return ret;
+	if (ret < 0)
+		phonebook_req_cancel(req);
+
+	if (err)
+		*err = ret;
+
+	return req;
 }
 
 int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index 951b370..5342841 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -95,9 +95,9 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
  * return only the content based on the application parameters requested
  * by the client.
  */
-int phonebook_get_entry(const char *folder, const char *id,
+void *phonebook_get_entry(const char *folder, const char *id,
 				const struct apparam_field *params,
-				phonebook_cb cb, void *user_data);
+				phonebook_cb cb, void *user_data, int *err);
 
 /*
  * PBAP core will keep the contacts cache per folder. SetPhoneBook or
-- 
1.7.0.4

