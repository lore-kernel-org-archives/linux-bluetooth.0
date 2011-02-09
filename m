Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/3] Introduction of phonebook_pull_read
Date: Wed,  9 Feb 2011 09:38:46 +0200
Message-Id: <1297237127-16286-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1297237127-16286-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1297237127-16286-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previosly reading from backend was initialized in phonebook_pull.
Now phonebook_pull should be used only for preparing request data
and phonebook_pull_read for 'real' reading vcards data from back-end.
The back-end can return data in one response or it can return data in
many parts. After obtaining one part, PBAP core need to call
phonebook_pull_read with the same request again to get more results.
Using that, PBAP core has control of its the buffer size - it can
ask for new parts of data when buffer is empty or when its size
will be lower than some level.
---
 plugins/pbap.c              |   23 +++++++++++++++++++-
 plugins/phonebook-dummy.c   |   32 +++++++++++++++++++++------
 plugins/phonebook-ebook.c   |   24 ++++++++++++++++----
 plugins/phonebook-tracker.c |   50 +++++++++++++++++++++++++++++-------------
 plugins/phonebook.h         |   18 ++++++++++++---
 5 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 5775eea..7d46f91 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -806,6 +806,12 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	if (ret < 0)
 		goto fail;
 
+	/* reading first part of results from backend */
+	phonebook_pull_read(request, &ret);
+
+	if (ret < 0)
+		goto fail;
+
 	if (err)
 		*err = 0;
 
@@ -962,6 +968,7 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
+	int len, err;
 
 	DBG("buffer %p maxlistcount %d", obj->buffer,
 						pbap->params->maxlistcount);
@@ -987,7 +994,21 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 		*hi = OBEX_HDR_BODY;
 		if (flags)
 			*flags = 0;
-		return string_read(obj->buffer, buf, count);
+
+		len = string_read(obj->buffer, buf, count);
+
+		if (len == 0 && !obj->lastpart) {
+			/* in case when buffer is empty and we know that more
+			 * data is still available in backend, requesting new
+			 * data part via phonebook_pull_read and returning
+			 * -EAGAIN to suspend request for now */
+			phonebook_pull_read(obj->request, &err);
+			if (err)
+				return -EPERM;
+
+			return -EAGAIN;
+		} else
+			return len;
 	}
 }
 
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 76dd550..0bf9132 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -52,6 +52,7 @@ struct dummy_data {
 	const struct apparam_field *apparams;
 	char *folder;
 	int fd;
+	guint id;
 };
 
 struct cache_query {
@@ -449,9 +450,12 @@ done:
 
 void phonebook_req_finalize(void *request)
 {
-	guint id = GPOINTER_TO_INT(request);
+	struct dummy_data *dummy = request;
 
-	g_source_remove(id);
+	/* dummy_data will be cleaned when request will be finished via
+	 * g_source_remove */
+	if (dummy && dummy->id)
+		g_source_remove(dummy->id);
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
@@ -459,7 +463,6 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 {
 	struct dummy_data *dummy;
 	char *filename, *folder;
-	guint ret;
 
 	/*
 	 * Main phonebook objects will be created dinamically based on the
@@ -492,13 +495,28 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	dummy->folder = folder;
 	dummy->fd = -1;
 
-	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_dir, dummy,
-								dummy_free);
-
 	if (err)
 		*err = 0;
 
-	return GINT_TO_POINTER(ret);
+	return dummy;
+}
+
+void phonebook_pull_read(void *request, int *err)
+{
+	struct dummy_data *dummy = request;
+
+	if (!dummy) {
+		if (err)
+			*err = -ENOENT;
+
+		return;
+	}
+
+	dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_dir, dummy,
+			dummy_free);
+
+	if (err)
+		*err = 0;
 }
 
 void *phonebook_get_entry(const char *folder, const char *id,
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 6cc4f31..4a222a8 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -453,23 +453,37 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 				phonebook_cb cb, void *user_data, int *err)
 {
 	struct query_context *data;
-	EBookQuery *query;
-
-	query = e_book_query_any_field_contains("");
 
 	data = g_new0(struct query_context, 1);
 	data->contacts_cb = cb;
 	data->params = params;
 	data->user_data = user_data;
 
+	if (err)
+		*err = 0;
+
+	return data;
+}
+
+void phonebook_pull_read(void *request, int *err)
+{
+	struct query_context *data = request;
+	EBookQuery *query;
+
+	if (!data) {
+		if (err)
+			*err = -ENOENT;
+
+		return;
+	}
+
+	query = e_book_query_any_field_contains("");
 	e_book_async_get_contacts(ebook, query, ebookpull_cb, data);
 
 	e_book_query_unref(query);
 
 	if (err)
 		*err = 0;
-
-	return data;
 }
 
 void *phonebook_get_entry(const char *folder, const char *id,
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e3f26a1..d632744 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -918,6 +918,7 @@ struct phonebook_data {
 	phonebook_entry_cb entry_cb;
 	int newmissedcalls;
 	GCancellable *query_canc;
+	char *req_name;
 };
 
 struct phonebook_index {
@@ -1827,6 +1828,7 @@ void phonebook_req_finalize(void *request)
 	}
 
 	g_slist_free(data->contacts);
+	g_free(data->req_name);
 	g_free(data);
 }
 
@@ -1902,39 +1904,55 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 				phonebook_cb cb, void *user_data, int *err)
 {
 	struct phonebook_data *data;
-	const char *query;
+
+	DBG("name %s", name);
+
+	data = g_new0(struct phonebook_data, 1);
+	data->params = params;
+	data->user_data = user_data;
+	data->cb = cb;
+	data->req_name = g_strdup(name);
+
+	if (err)
+		*err = 0;
+
+	return data;
+}
+
+void phonebook_pull_read(void *request, int *err)
+{
+	struct phonebook_data *data = request;
 	reply_list_foreach_t pull_cb;
+	const char *query;
 	int col_amount;
 
-	DBG("name %s", name);
+	if(!data)
+		goto failed;
 
-	if (g_strcmp0(name, "telecom/mch.vcf") == 0) {
+	if (g_strcmp0(data->req_name, "telecom/mch.vcf") == 0) {
 		query = NEW_MISSED_CALLS_LIST;
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
-	} else if (params->maxlistcount == 0) {
-		query = name2count_query(name);
+	} else if (data->params->maxlistcount == 0) {
+		query = name2count_query(data->req_name);
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
 	} else {
-		query = name2query(name);
+		query = name2query(data->req_name);
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts;
 	}
 
-	if (query == NULL) {
-		if (err)
-			*err = -ENOENT;
-		return NULL;
-	}
+	if (query == NULL)
+		goto failed;
 
-	data = g_new0(struct phonebook_data, 1);
-	data->params = params;
-	data->user_data = user_data;
-	data->cb = cb;
 	query_tracker(query, col_amount, pull_cb, data, err);
 
-	return data;
+	return;
+
+failed:
+	if (err)
+		*err = -ENOENT;
 }
 
 void *phonebook_get_entry(const char *folder, const char *id,
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index f6df164..cbc0e38 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -82,17 +82,27 @@ char *phonebook_set_folder(const char *current_folder,
 		const char *new_folder, uint8_t flags, int *err);
 
 /*
- * PullPhoneBook never use cached entries. PCE use this function to get all
- * entries of a given folder. The back-end MUST return only the content based
- * on the application parameters requested by the client.
+ * phonebook_pull should be used only to prepare pull request - prepared
+ * request data is returned by this function. Start of fetching data from
+ * back-end will be done only after calling phonebook_pull_read with this
+ * returned request given as a parameter.
  *
- * Return value is a pointer to asynchronous request to phonebook back-end.
  * phonebook_req_finalize MUST always be used to free associated resources.
  */
 void *phonebook_pull(const char *name, const struct apparam_field *params,
 				phonebook_cb cb, void *user_data, int *err);
 
 /*
+ * phonebook_pull_read should be used to start getting results from back-end.
+ * The back-end can return data as one response or can return it many parts.
+ * After obtaining one part, PBAP core need to call phonebook_pull_read with
+ * the same request again to get more results from back-end.
+ * The back-end MUST return only the content based on the application
+ * parameters requested by the client.
+ */
+void phonebook_pull_read(void *request, int *err);
+
+/*
  * Function used to retrieve a contact from the backend. Only contacts
  * found in the cache are requested to the back-ends. The back-end MUST
  * return only the content based on the application parameters requested
-- 
1.7.0.4

