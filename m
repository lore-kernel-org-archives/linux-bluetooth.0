Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 6/7] Add update phonebook_create_cache
Date: Tue, 23 Nov 2010 20:11:28 +0200
Message-Id: <1290535889-17038-7-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_create_cache updated function prototype to return void
pointer to backend specific request and error code. All backend
handlers updated accordingly (phonebook-tracker.c,
phonebook-dummy.c, and phonebook-ebook.c).

In PBAP vobject_list_open and vobject_vcard_open are updated to
store pointer to phonebook request. IRMC is not modified.

Phonebook request is created and stored dynamically only for tracker.
---
 plugins/pbap.c              |   18 +++++++++++++-----
 plugins/phonebook-dummy.c   |   16 ++++++++++------
 plugins/phonebook-ebook.c   |   20 ++++++++++++++------
 plugins/phonebook-tracker.c |   25 ++++++++++++++++++++-----
 plugins/phonebook.h         |    4 ++--
 5 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 2ce580b..5137d07 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -455,6 +455,13 @@ static void cache_entry_done(void *user_data)
 		return;
 	}
 
+	/*
+	 * If request to create cache succeeded, vobject and phonebook
+	 * request were created, then previous request has to be deleted,
+	 * even though there is no pending call anymore. In
+	 * phonebook_get_entry a new request will be created.
+	 */
+	phonebook_req_cancel(pbap->obj->request);
 	pbap->obj->request = phonebook_get_entry(pbap->folder, id,
 				pbap->params, query_result, pbap, &ret);
 	if (ret < 0)
@@ -759,6 +766,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 {
 	struct pbap_session *pbap = context;
 	int ret;
+	void *request = NULL;
 
 	DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
 
@@ -788,14 +796,14 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto done;
 	}
 
-	ret = phonebook_create_cache(name,
-		cache_entry_notify, cache_ready_notify, pbap);
+	request = phonebook_create_cache(name,
+		cache_entry_notify, cache_ready_notify, pbap, &ret);
 
 	if (ret < 0)
 		goto fail;
 
 done:
-	return vobject_create(pbap, NULL);
+	return vobject_create(pbap, request);
 
 fail:
 	if (err)
@@ -827,8 +835,8 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 
 	if (pbap->cache.valid == FALSE) {
 		pbap->find_handle = handle;
-		ret = phonebook_create_cache(pbap->folder, cache_entry_notify,
-						cache_entry_done, pbap);
+		request = phonebook_create_cache(pbap->folder,
+			cache_entry_notify, cache_entry_done, pbap, &ret);
 		goto done;
 	}
 
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 7a963b6..a269ea8 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -528,8 +528,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	return NULL;
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-		phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct cache_query *query;
 	char *foldername;
@@ -540,9 +540,10 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	g_free(foldername);
 
 	if (dp == NULL) {
-		int err = errno;
-		DBG("opendir(): %s(%d)", strerror(err), err);
-		return -ENOENT;
+		DBG("opendir(): %s(%d)", strerror(errno), errno);
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
 	query = g_new0(struct cache_query, 1);
@@ -553,5 +554,8 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 
 	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
 								query_free);
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 2515bb0..5d7f624 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -459,15 +459,18 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	return NULL;
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct cache_query *data;
 	EBookQuery *query;
 	gboolean ret;
 
-	if (g_strcmp0("/telecom/pb", name) != 0)
-		return -ENOENT;
+	if (g_strcmp0("/telecom/pb", name) != 0) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
 
 	query = e_book_query_any_field_contains("");
 
@@ -480,8 +483,13 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	e_book_query_unref(query);
 	if (ret != FALSE) {
 		g_free(data);
-		return -EFAULT;
+		if (err)
+			*err = -EFAULT;
+		return NULL;
 	}
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index ead583e..3577212 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1907,22 +1907,37 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	return req;
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct cache_data *cache;
 	const char *query;
+	int ret;
+	struct phonebook_req *req;
 
 	DBG("name %s", name);
 
 	query = folder2query(name);
-	if (query == NULL)
-		return -ENOENT;
+	if (query == NULL) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
 
 	cache = g_new0(struct cache_data, 1);
 	cache->entry_cb = entry_cb;
 	cache->ready_cb = ready_cb;
 	cache->user_data = user_data;
 
-	return query_tracker(query, 7, add_to_cache, cache, NULL);
+	req = g_new0(struct phonebook_req, 1);
+
+	ret = query_tracker(query, 7, add_to_cache, cache, req);
+
+	if (ret < 0)
+		phonebook_req_cancel(req);
+
+	if (err)
+		*err = ret;
+
+	return req;
 }
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index 5342841..b6ae5a8 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -105,8 +105,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
  * Cache will store only the necessary information required to reply to
  * PullvCardListing request and verify if a given contact belongs to the source.
  */
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data);
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err);
 
 /* 
  * Function used to cancel pending request to backend and free resources
-- 
1.7.0.4

