Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/5] Add opening ebooks before each operation
Date: Wed, 13 Jul 2011 22:10:08 +0000
Message-Id: <1310595010-1033-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
References: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now ebooks were opened only on phonebook_init, but particular ebook
may be offline or not authenticated or user may be offline at the time.
Better idea is try to open ebooks before each operation, especially
as time overhead is minimal.
---
 plugins/phonebook-ebook.c |   66 +++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 0b2878a..2ee5473 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -56,10 +56,9 @@ struct query_context {
 	char *id;
 	unsigned queued_calls;
 	void *user_data;
+	GSList *ebooks;
 };
 
-static GSList *ebooks = NULL;
-
 static char *attribute_mask[] = {
 /* 0 */		"VERSION",
 		"FN",
@@ -94,6 +93,11 @@ static char *attribute_mask[] = {
 
 };
 
+static void close_ebooks(GSList *ebooks)
+{
+	g_slist_free_full(ebooks, g_object_unref);
+}
+
 static void free_query_context(struct query_context *data)
 {
 	g_free(data->id);
@@ -104,6 +108,8 @@ static void free_query_context(struct query_context *data)
 	if (data->query != NULL)
 		e_book_query_unref(data->query);
 
+	close_ebooks(data->ebooks);
+
 	g_free(data);
 }
 
@@ -329,7 +335,8 @@ done:
 		data->ready_cb(data->user_data);
 }
 
-static int traverse_sources(GSList *sources, char *default_src) {
+static GSList *traverse_sources(GSList *ebooks, GSList *sources,
+							char *default_src) {
 	GError *gerr;
 
 	while (sources != NULL) {
@@ -371,28 +378,29 @@ static int traverse_sources(GSList *sources, char *default_src) {
 		sources = sources->next;
 	}
 
-	return 0;
+	return ebooks;
 }
 
 int phonebook_init(void)
 {
+	g_type_init();
+
+	return 0;
+}
+
+static GSList *open_ebooks(void)
+{
 	GError *gerr;
 	ESourceList *src_list;
 	GSList *list;
 	gchar *default_src = NULL;
-	int status = 0;
-
-	if (ebooks)
-		return 0;
-
-	g_type_init();
+	GSList *ebooks = NULL;
 
 	if (e_book_get_addressbooks(&src_list, &gerr) == FALSE) {
 		error("Can't list user's address books: %s", gerr->message);
 		g_error_free(gerr);
 
-		status = -EIO;
-		goto fail;
+		return NULL;
 	}
 
 	list = e_source_list_peek_groups(src_list);
@@ -401,29 +409,16 @@ int phonebook_init(void)
 
 		GSList *sources = e_source_group_peek_sources(group);
 
-		traverse_sources(sources, default_src);
+		ebooks = traverse_sources(ebooks, sources, default_src);
 
 		list = list->next;
 	}
 
-	return status;
-
-fail:
-	g_slist_free_full(ebooks, g_object_unref);
-	g_object_unref(src_list);
-
-	return status;
+	return ebooks;
 }
 
 void phonebook_exit(void)
 {
-	DBG("");
-
-	if (ebooks == NULL)
-		return;
-
-	g_slist_free_full(ebooks, g_object_unref);
-	ebooks = NULL;
 }
 
 char *phonebook_set_folder(const char *current_folder,
@@ -513,7 +508,7 @@ done:
 void phonebook_req_finalize(void *request)
 {
 	struct query_context *data = request;
-	GSList *ebook = ebooks;
+	GSList *ebook = data->ebooks;
 
 	DBG("");
 
@@ -545,9 +540,11 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->buf = g_string_new("");
+	data->query = e_book_query_any_field_contains("");
+	data->ebooks = open_ebooks();
 
 	if (err)
-		*err = 0;
+		*err = data->ebooks == NULL ? -EIO : 0;
 
 	return data;
 }
@@ -561,9 +558,7 @@ int phonebook_pull_read(void *request)
 	if (!data)
 		return -ENOENT;
 
-	data->query = e_book_query_any_field_contains("");
-
-	ebook = ebooks;
+	ebook = data->ebooks;
 	while (ebook != NULL) {
 		if (e_book_is_opened(ebook->data) == TRUE) {
 			ret = e_book_get_contacts_async(ebook->data,
@@ -594,8 +589,9 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	data->params = params;
 	data->user_data = user_data;
 	data->id = g_strdup(id);
+	data->ebooks = open_ebooks();
 
-	ebook = ebooks;
+	ebook = data->ebooks;
 	while (ebook != NULL) {
 		if (e_book_is_opened(ebook->data) == TRUE) {
 			ret = e_book_get_contact_async(ebook->data, data->id,
@@ -627,7 +623,6 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	EVCardAttribute *attrib;
 	char *uid, *tel, *cname;
 
-
 	if (g_strcmp0("/telecom/pb", name) != 0) {
 		if (err)
 			*err = -ENOENT;
@@ -644,6 +639,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
 	data->query = query;
+	data->ebooks = open_ebooks();
 
 	/* Add 0.vcf */
 	if (e_book_get_self(&me, &eb, &gerr) == FALSE) {
@@ -678,7 +674,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	g_object_unref(eb);
 
 next:
-	ebook = ebooks;
+	ebook = data->ebooks;
 	while (ebook != NULL) {
 		if (e_book_is_opened(ebook->data) == TRUE) {
 			ret = e_book_get_contacts_async(ebook->data, query,
-- 
1.7.5.3

