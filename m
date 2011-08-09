Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/2] Fix callback logic in EDS PBAP
Date: Wed, 10 Aug 2011 01:05:40 +0200
Message-Id: <1312931140-9143-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
References: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It seems that e_book_cancel (in libebook) is broken -- it should return
TRUE when request is canceled and FALSE otherwise, but after
"successfully" canceling async request, supplied callback is still
called without any error.
---
 plugins/phonebook-ebook.c |   56 ++++++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 903cd01..d0e08a5 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -58,6 +58,7 @@ struct query_context {
 	unsigned queued_calls;
 	void *user_data;
 	GSList *ebooks;
+	gboolean canceled;
 };
 
 static char *attribute_mask[] = {
@@ -167,6 +168,11 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 	GList *l;
 	unsigned int count, maxcount;
 
+	data->queued_calls--;
+
+	if (data->canceled)
+		goto canceled;
+
 	if (gerr != NULL) {
 		error("E-Book query failed: %s", gerr->message);
 		goto done;
@@ -205,10 +211,9 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 
 	data->count += count;
 
-done:
 	g_list_free_full(contacts, g_object_unref);
 
-	data->queued_calls--;
+done:
 	if (data->queued_calls == 0) {
 		GString *buf = data->buf;
 		data->buf = NULL;
@@ -217,7 +222,14 @@ done:
 						0, TRUE, data->user_data);
 
 		g_string_free(buf, TRUE);
+
 	}
+
+	return;
+
+canceled:
+	if (data->queued_calls == 0)
+		free_query_context(data);
 }
 
 static void ebook_entry_cb(EBook *book, const GError *gerr,
@@ -228,6 +240,11 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 	char *vcard;
 	size_t len;
 
+	data->queued_calls--;
+
+	if (data->canceled)
+		goto done;
+
 	if (gerr != NULL) {
 		error("E-Book query failed: %s", gerr->message);
 		goto done;
@@ -248,14 +265,15 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 	g_free(vcard);
 	g_object_unref(contact);
 
+	return;
+
 done:
-	data->queued_calls--;
 	if (data->queued_calls == 0) {
 		if (data->count == 0)
 			data->contacts_cb(NULL, 0, 1, 0, TRUE,
 						data->user_data);
-
-		free_query_context(data);
+		else if (data->canceled)
+			free_query_context(data);
 	}
 }
 
@@ -295,6 +313,11 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 	struct query_context *data = user_data;
 	GList *l;
 
+	data->queued_calls--;
+
+	if (data->canceled)
+		goto canceled;
+
 	if (gerr != NULL) {
 		error("E-Book operation failed: %s", gerr->message);
 		goto done;
@@ -334,12 +357,17 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 		g_free(tel);
 	}
 
-done:
 	g_list_free_full(contacts, g_object_unref);
 
-	data->queued_calls--;
+done:
 	if (data->queued_calls == 0)
 		data->ready_cb(data->user_data);
+
+	return;
+
+canceled:
+	if (data->queued_calls == 0)
+		free_query_context(data);
 }
 
 static GSList *traverse_sources(GSList *ebooks, GSList *sources,
@@ -522,19 +550,11 @@ done:
 void phonebook_req_finalize(void *request)
 {
 	struct query_context *data = request;
-	GSList *ebook = data->ebooks;
 
-	DBG("");
-
-	while (ebook != NULL) {
-		if (e_book_cancel(ebook->data, NULL) == TRUE)
-			data->queued_calls--;
-
-		ebook = ebook->next;
-	}
-
-	if (data != NULL && data->queued_calls == 0)
+	if (data->queued_calls == 0)
 		free_query_context(data);
+	else
+		data->canceled = TRUE;
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
-- 
1.7.6

