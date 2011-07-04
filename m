Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/5] Change EDS backend to support multiple ebooks
Date: Mon,  4 Jul 2011 23:51:37 +0200
Message-Id: <1309816301-18377-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now only default ebook was used, this patch change this behaviour
so each function is run on all available (active) ebooks and merging
results from each of them.
---
 plugins/phonebook-ebook.c |  281 +++++++++++++++++++++++++++++----------------
 1 files changed, 182 insertions(+), 99 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 82019da..f223965 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -45,17 +45,20 @@
 #define QUERY_NAME "(contains \"given_name\" \"%s\")"
 #define QUERY_PHONE "(contains \"phone\" \"%s\")"
 
-
 struct query_context {
-	gboolean completed;
 	const struct apparam_field *params;
 	phonebook_cb contacts_cb;
 	phonebook_entry_cb entry_cb;
 	phonebook_cache_ready_cb ready_cb;
+	EBookQuery *query;
+	int count;
+	GString *buf;
+	char *id;
+	unsigned queued_calls;
 	void *user_data;
 };
 
-static EBook *ebook = NULL;
+static GSList *ebooks = NULL;
 
 static char *attribute_mask[] = {
 /* 0 */		"VERSION",
@@ -91,6 +94,19 @@ static char *attribute_mask[] = {
 
 };
 
+static void free_query_context(struct query_context *data)
+{
+	g_free(data->id);
+
+	if (data->buf != NULL)
+		g_string_free(data->buf, TRUE);
+
+	if (data->query != NULL)
+		e_book_query_unref(data->query);
+
+	g_free(data);
+}
+
 static char *evcard_to_string(EVCard *evcard, unsigned int format,
 							uint64_t filter)
 {
@@ -99,7 +115,8 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 	char *vcard;
 
 	if (!filter)
-		return e_vcard_to_string(evcard, format);
+		return e_vcard_to_string(evcard, EVC_FORMAT_VCARD_30);
+		/* XXX There is no support for VCARD 2.1 at this time */
 
 	/*
 	 * Mandatory attributes for vCard 2.1 are VERSION ,N and TEL.
@@ -136,24 +153,20 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 	return vcard;
 }
 
-static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
+static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 							void *user_data)
 {
 	struct query_context *data = user_data;
-	GString *string = g_string_new("");
-	unsigned int count = 0, maxcount;
 	GList *l;
+	unsigned int count = data->count, maxcount;
 
-	if (estatus == E_BOOK_ERROR_CANCELLED) {
-		error("E-Book operation was cancelled: status %d", estatus);
-		goto fail;
-	}
-
-	if (estatus != E_BOOK_ERROR_OK) {
-		error("E-Book query failed: status %d", estatus);
+	if (gerr != NULL) {
+		error("E-Book query failed: %s", gerr->message);
 		goto done;
 	}
 
+	DBG("");
+
 	/*
 	 * When MaxListCount is zero, PCE wants to know the number of used
 	 * indexes in the phonebook of interest. All other parameters that
@@ -161,7 +174,7 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 	 */
 	maxcount = data->params->maxlistcount;
 	if (maxcount == 0) {
-		count = g_list_length(contacts);
+		count += g_list_length(contacts);
 		goto done;
 	}
 
@@ -177,45 +190,36 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 		vcard = evcard_to_string(evcard, data->params->format,
 						data->params->filter);
 
-		string = g_string_append(string, vcard);
-		string = g_string_append(string, "\r\n");
+		data->buf = g_string_append(data->buf, vcard);
+		data->buf = g_string_append(data->buf, "\r\n");
 		g_free(vcard);
 	}
-	DBG("collected %d vcards", count);
-
 
 done:
-	data->completed = TRUE;
-	data->contacts_cb(string->str, string->len, count, 0, TRUE,
-							data->user_data);
+	g_list_free_full(contacts, g_object_unref);
 
-fail:
-	g_string_free(string, TRUE);
+	DBG("collected %d vcards", count);
 
-	if (data->completed)
-		g_free(data);
+	data->queued_calls--;
+	if (data->queued_calls == 0)
+		data->contacts_cb(data->buf->str, data->buf->len, count, 0,
+							TRUE, data->user_data);
 }
 
-static void ebook_entry_cb(EBook *book, EBookStatus estatus,
-			EContact *contact, void *user_data)
+static void ebook_entry_cb(EBook *book, const GError *gerr,
+				EContact *contact, void *user_data)
 {
 	struct query_context *data = user_data;
 	EVCard *evcard;
 	char *vcard;
 	size_t len;
 
-	if (estatus == E_BOOK_ERROR_CANCELLED) {
-		error("E-Book operation was cancelled: status %d", estatus);
-		goto fail;
+	if (gerr != NULL) {
+		error("E-Book query failed: %s", gerr->message);
+		goto done;
 	}
 
-	data->completed = TRUE;
-
-	if (estatus != E_BOOK_ERROR_OK) {
-		error("E-Book query failed: status %d", estatus);
-		data->contacts_cb(NULL, 0, 1, 0, TRUE, data->user_data);
-		goto fail;
-	}
+	DBG("");
 
 	evcard = E_VCARD(contact);
 
@@ -224,13 +228,21 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 
 	len = vcard ? strlen(vcard) : 0;
 
+	data->count++;
 	data->contacts_cb(vcard, len, 1, 0, TRUE, data->user_data);
 
 	g_free(vcard);
+	g_object_unref(contact);
 
-fail:
-	if (data->completed)
-		g_free(data);
+done:
+	data->queued_calls--;
+	if (data->queued_calls == 0) {
+		if (data->count == 0)
+			data->contacts_cb(NULL, 0, 1, 0, TRUE,
+						data->user_data);
+
+		free_query_context(data);
+	}
 }
 
 static char *evcard_name_attribute_to_string(EVCard *evcard)
@@ -263,24 +275,19 @@ static char *evcard_name_attribute_to_string(EVCard *evcard)
 	return g_string_free(name, FALSE);
 }
 
-static void cache_cb(EBook *book, EBookStatus estatus, GList *contacts,
+static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 							void *user_data)
 {
 	struct query_context *data = user_data;
 	GList *l;
 
-	if (estatus == E_BOOK_ERROR_CANCELLED) {
-		error("E-Book operation was cancelled: status %d", estatus);
-		goto fail;
-	}
-
-	data->completed = TRUE;
-
-	if (estatus != E_BOOK_ERROR_OK) {
-		error("E-Book query failed: status %d", estatus);
+	if (gerr != NULL) {
+		error("E-Book operation failed: %s", gerr->message);
 		goto done;
 	}
 
+	DBG("");
+
 	for (l = contacts; l; l = g_list_next(l)) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
@@ -295,61 +302,116 @@ static void cache_cb(EBook *book, EBookStatus estatus, GList *contacts,
 		if (!attrib)
 			continue;
 
-		uid =  e_vcard_attribute_get_value(attrib);
+		uid = e_vcard_attribute_get_value(attrib);
 		if (!uid)
 			continue;
 
 		attrib = e_vcard_get_attribute(evcard, EVC_TEL);
 		if (!attrib)
-			continue;
-
-		tel =  e_vcard_attribute_get_value(attrib);
+			tel = e_vcard_attribute_get_value(attrib);
+		else
+			tel = g_strdup("");
 
 		data->entry_cb(uid, PHONEBOOK_INVALID_HANDLE, name, NULL,
 							tel, data->user_data);
+
 		g_free(name);
 		g_free(uid);
 		g_free(tel);
 	}
+
 done:
-	data->ready_cb(data->user_data);
+	g_list_free_full(contacts, g_object_unref);
 
-fail:
-	if (data->completed)
-		g_free(data);
+	data->queued_calls--;
+	if (data->queued_calls == 0)
+		data->ready_cb(data->user_data);
 }
 
 int phonebook_init(void)
 {
-	GError *gerr = NULL;
+	GError *gerr;
+	ESourceList *src_list;
+	GSList *list;
+	gchar *default_src = NULL;
+	int status = 0;
 
-	if (ebook)
+	if (ebooks)
 		return 0;
 
 	g_type_init();
 
-	ebook = e_book_new_default_addressbook(&gerr);
-	if (!ebook) {
-		error("Can't create user's default address book: %s",
-				gerr->message);
-		g_error_free(gerr);
-		return -EIO;
+	if (e_book_get_addressbooks(&src_list, &gerr) == FALSE) {
+		error("Can't list user's address books: %s", gerr->message);
+
+		status = -EIO;
+		goto fail;
 	}
 
-	if (!e_book_open(ebook, FALSE, &gerr)) {
-		error("Can't open e-book address book: %s", gerr->message);
-		g_error_free(gerr);
-		return -EIO;
+	list = e_source_list_peek_groups(src_list);
+	while (list) {
+		ESourceGroup *group = E_SOURCE_GROUP(list->data);
+
+		GSList *sources = e_source_group_peek_sources(group);
+		while (sources != NULL) {
+			EBook *ebook = e_book_new(E_SOURCE(sources->data),
+									&gerr);
+			if (ebook == NULL) {
+				error("Can't create user's address book: %s",
+								gerr->message);
+
+				status = -EIO;
+				goto fail;
+			}
+
+			if (g_strcmp0(default_src, e_source_get_uri(
+					E_SOURCE(sources->data))) == 0) {
+				sources = sources->next;
+
+				continue;
+			}
+
+			if (e_book_open(ebook, FALSE, &gerr) == FALSE) {
+				error("Can't open e-book address book: %s",
+								gerr->message);
+
+				status = -EIO;
+				goto fail;
+			}
+
+			if (default_src == NULL)
+				default_src = e_source_get_uri(
+						E_SOURCE(sources->data));
+
+			DBG("%s address book opened",
+					e_source_peek_name(sources->data));
+
+			ebooks = g_slist_append(ebooks, ebook);
+
+			sources = sources->next;
+		}
+
+		list = list->next;
 	}
 
-	return 0;
+	return status;
+
+fail:
+	g_error_free(gerr);
+	g_slist_free_full(ebooks, g_object_unref);
+	g_object_unref(src_list);
+
+	return status;
 }
 
 void phonebook_exit(void)
 {
-	if (ebook)
-		g_object_unref(ebook);
-	ebook = NULL;
+	DBG("");
+
+	if (ebooks == NULL)
+		return;
+
+	g_slist_free_full(ebooks, g_object_unref);
 }
 
 char *phonebook_set_folder(const char *current_folder,
@@ -440,13 +502,10 @@ void phonebook_req_finalize(void *request)
 {
 	struct query_context *data = request;
 
-	if (!data)
-		return;
+	DBG("");
 
-	if (!data->completed) {
-		data->completed = TRUE;
-		e_book_cancel_async_op(ebook, NULL);
-	}
+	if (data != NULL && data->queued_calls == 0)
+		free_query_context(data);
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
@@ -458,6 +517,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->contacts_cb = cb;
 	data->params = params;
 	data->user_data = user_data;
+	data->buf = g_string_new("");
 
 	if (err)
 		*err = 0;
@@ -468,15 +528,26 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 int phonebook_pull_read(void *request)
 {
 	struct query_context *data = request;
-	EBookQuery *query;
+	gboolean ret;
+	GSList *ebook;
 
 	if (!data)
 		return -ENOENT;
 
-	query = e_book_query_any_field_contains("");
-	e_book_async_get_contacts(ebook, query, ebookpull_cb, data);
+	data->query = e_book_query_any_field_contains("");
+
+	ebook = ebooks;
+	while (ebook != NULL) {
+		ret = e_book_get_contacts_async(ebook->data, data->query,
+							ebookpull_cb, data);
+		if (ret == TRUE)
+			data->queued_calls++;
 
-	e_book_query_unref(query);
+		ebook = ebook->next;
+	}
+
+	if (data->queued_calls == 0)
+		return -ENOENT;
 
 	return 0;
 }
@@ -485,22 +556,28 @@ void *phonebook_get_entry(const char *folder, const char *id,
 				const struct apparam_field *params,
 				phonebook_cb cb, void *user_data, int *err)
 {
+	gboolean ret;
 	struct query_context *data;
+	GSList *ebook;
 
 	data = g_new0(struct query_context, 1);
 	data->contacts_cb = cb;
 	data->params = params;
 	data->user_data = user_data;
+	data->id = g_strdup(id);
 
-	if (e_book_async_get_contact(ebook, id, ebook_entry_cb, data)) {
-		g_free(data);
-		if (err)
-			*err = -ENOENT;
-		return NULL;
+	ebook = ebooks;
+	while (ebook != NULL) {
+		ret = e_book_get_contact_async(ebook->data, data->id,
+							ebook_entry_cb, data);
+		if (ret == TRUE)
+			data->queued_calls++;
+
+		ebook = ebook->next;
 	}
 
 	if (err)
-		*err = 0;
+		*err = (data->queued_calls == 0 ? -ENOENT : 0);
 
 	return data;
 }
@@ -511,31 +588,37 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	struct query_context *data;
 	EBookQuery *query;
 	gboolean ret;
+	GSList *ebook;
 
 	if (g_strcmp0("/telecom/pb", name) != 0) {
 		if (err)
 			*err = -ENOENT;
+
 		return NULL;
 	}
 
+	DBG("");
+
 	query = e_book_query_any_field_contains("");
 
 	data = g_new0(struct query_context, 1);
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
+	data->query = query;
 
-	ret = e_book_async_get_contacts(ebook, query, cache_cb, data);
-	e_book_query_unref(query);
-	if (ret != FALSE) {
-		g_free(data);
-		if (err)
-			*err = -EFAULT;
-		return NULL;
+	ebook = ebooks;
+	while (ebook != NULL) {
+		ret = e_book_get_contacts_async(ebook->data, query,
+							cache_cb, data);
+		if (ret == TRUE)
+			data->queued_calls++;
+
+		ebook = ebook->next;
 	}
 
 	if (err)
-		*err = 0;
+		*err = (data->queued_calls == 0 ? -ENOENT : 0);
 
 	return data;
 }
-- 
1.7.5.3

