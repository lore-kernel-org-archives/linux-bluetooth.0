Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/3 v4] Unified ebook data structures
Date: Thu,  9 Dec 2010 12:05:17 +0200
Message-Id: <1291889119-23915-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Query data structures are unified in phonebook-ebook.c to have a
unique identifier for ebook async operation. Purpose of this
modification is next commit where pending async operation can be
cancelled.
---
 plugins/phonebook-ebook.c |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 073ff33..80398ef 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -45,13 +45,9 @@
 #define QUERY_NAME "(contains \"given_name\" \"%s\")"
 #define QUERY_PHONE "(contains \"phone\" \"%s\")"
 
-struct contacts_query {
+struct query_context {
 	const struct apparam_field *params;
-	phonebook_cb cb;
-	void *user_data;
-};
-
-struct cache_query {
+	phonebook_cb contacts_cb;
 	phonebook_entry_cb entry_cb;
 	phonebook_cache_ready_cb ready_cb;
 	void *user_data;
@@ -141,7 +137,7 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 							void *user_data)
 {
-	struct contacts_query *data = user_data;
+	struct query_context *data = user_data;
 	GString *string = g_string_new("");
 	unsigned int count = 0, maxcount;
 	GList *l;
@@ -182,7 +178,7 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 
 
 done:
-	data->cb(string->str, string->len, count, 0, data->user_data);
+	data->contacts_cb(string->str, string->len, count, 0, data->user_data);
 
 	g_string_free(string, TRUE);
 	g_free(data);
@@ -191,14 +187,14 @@ done:
 static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 			EContact *contact, void *user_data)
 {
-	struct contacts_query *data = user_data;
+	struct query_context *data = user_data;
 	EVCard *evcard;
 	char *vcard;
 	size_t len;
 
 	if (estatus != E_BOOK_ERROR_OK) {
 		error("E-Book query failed: status %d", estatus);
-		data->cb(NULL, 0, 1, 0, data->user_data);
+		data->contacts_cb(NULL, 0, 1, 0, data->user_data);
 		g_free(data);
 		return;
 	}
@@ -210,7 +206,7 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 
 	len = vcard ? strlen(vcard) : 0;
 
-	data->cb(vcard, len, 1, 0, data->user_data);
+	data->contacts_cb(vcard, len, 1, 0, data->user_data);
 
 	g_free(vcard);
 	g_free(data);
@@ -249,7 +245,7 @@ static char *evcard_name_attribute_to_string(EVCard *evcard)
 static void cache_cb(EBook *book, EBookStatus estatus, GList *contacts,
 							void *user_data)
 {
-	struct cache_query *data = user_data;
+	struct query_context *data = user_data;
 	GList *l;
 
 	if (estatus != E_BOOK_ERROR_OK) {
@@ -411,13 +407,13 @@ done:
 int phonebook_pull(const char *name, const struct apparam_field *params,
 					phonebook_cb cb, void *user_data)
 {
-	struct contacts_query *data;
+	struct query_context *data;
 	EBookQuery *query;
 
 	query = e_book_query_any_field_contains("");
 
-	data = g_new0(struct contacts_query, 1);
-	data->cb = cb;
+	data = g_new0(struct query_context, 1);
+	data->contacts_cb = cb;
 	data->params = params;
 	data->user_data = user_data;
 
@@ -432,10 +428,10 @@ int phonebook_get_entry(const char *folder, const char *id,
 					const struct apparam_field *params,
 					phonebook_cb cb, void *user_data)
 {
-	struct contacts_query *data;
+	struct query_context *data;
 
-	data = g_new0(struct contacts_query, 1);
-	data->cb = cb;
+	data = g_new0(struct query_context, 1);
+	data->contacts_cb = cb;
 	data->params = params;
 	data->user_data = user_data;
 
@@ -450,7 +446,7 @@ int phonebook_get_entry(const char *folder, const char *id,
 int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 			phonebook_cache_ready_cb ready_cb, void *user_data)
 {
-	struct cache_query *data;
+	struct query_context *data;
 	EBookQuery *query;
 	gboolean ret;
 
@@ -459,7 +455,7 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 
 	query = e_book_query_any_field_contains("");
 
-	data = g_new0(struct cache_query, 1);
+	data = g_new0(struct query_context, 1);
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-- 
1.7.0.4

