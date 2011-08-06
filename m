Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix memory issues in EDS PBAP
Date: Sat,  6 Aug 2011 21:27:19 +0200
Message-Id: <1312658839-26919-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |   42 +++++++++++++++++++++++++++++++++---------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index e53da12..0bd8b57 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -58,6 +58,7 @@ struct query_context {
 	unsigned queued_calls;
 	void *user_data;
 	GSList *ebooks;
+	gboolean canceled;
 };
 
 static char *attribute_mask[] = {
@@ -172,6 +173,9 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 		goto done;
 	}
 
+	if (data->canceled)
+		goto canceled;
+
 	DBG("");
 
 	/*
@@ -217,6 +221,9 @@ done:
 						0, TRUE, data->user_data);
 
 		g_string_free(buf, TRUE);
+
+canceled:
+		free_query_context(data);
 	}
 }
 
@@ -233,6 +240,9 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 		goto done;
 	}
 
+	if (data->canceled)
+		goto canceled;
+
 	DBG("");
 
 	evcard = E_VCARD(contact);
@@ -255,6 +265,7 @@ done:
 			data->contacts_cb(NULL, 0, 1, 0, TRUE,
 						data->user_data);
 
+canceled:
 		free_query_context(data);
 	}
 }
@@ -300,6 +311,9 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 		goto done;
 	}
 
+	if (data->canceled)
+		goto canceled;
+
 	DBG("");
 
 	for (l = contacts; l; l = g_list_next(l)) {
@@ -338,15 +352,20 @@ done:
 	g_list_free_full(contacts, g_object_unref);
 
 	data->queued_calls--;
-	if (data->queued_calls == 0)
+	if (data->queued_calls == 0) {
 		data->ready_cb(data->user_data);
+
+canceled:
+		free_query_context(data);
+	}
 }
 
 static GSList *traverse_sources(GSList *ebooks, GSList *sources,
-							char *default_src) {
+							char **default_src) {
 	GError *gerr;
 
 	while (sources != NULL) {
+		char *uri;
 		EBook *ebook = e_book_new(E_SOURCE(sources->data), &gerr);
 		if (ebook == NULL) {
 			error("Can't create user's address book: %s",
@@ -357,12 +376,14 @@ static GSList *traverse_sources(GSList *ebooks, GSList *sources,
 			continue;
 		}
 
-		if (g_strcmp0(default_src, e_source_get_uri(
-					E_SOURCE(sources->data))) == 0) {
+		uri = e_source_get_uri(E_SOURCE(sources->data));
+		if (g_strcmp0(*default_src, uri) == 0) {
 			sources = sources->next;
+			g_free(uri);
 
 			continue;
 		}
+		g_free(uri);
 
 		if (e_book_open(ebook, FALSE, &gerr) == FALSE) {
 			error("Can't open e-book address book: %s",
@@ -374,8 +395,9 @@ static GSList *traverse_sources(GSList *ebooks, GSList *sources,
 			continue;
 		}
 
-		if (default_src == NULL)
-			default_src = e_source_get_uri(E_SOURCE(sources->data));
+		if (*default_src == NULL)
+			*default_src = e_source_get_uri(
+						E_SOURCE(sources->data));
 
 		DBG("%s address book opened",
 					e_source_peek_name(sources->data));
@@ -416,11 +438,14 @@ static GSList *open_ebooks(void)
 
 		GSList *sources = e_source_group_peek_sources(group);
 
-		ebooks = traverse_sources(ebooks, sources, default_src);
+		ebooks = traverse_sources(ebooks, sources, &default_src);
 
 		list = list->next;
 	}
 
+	g_free(default_src);
+	g_object_unref(src_list);
+
 	return ebooks;
 }
 
@@ -526,8 +551,7 @@ void phonebook_req_finalize(void *request)
 		ebook = ebook->next;
 	}
 
-	if (data != NULL && data->queued_calls == 0)
-		free_query_context(data);
+	data->canceled = TRUE;
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
-- 
1.7.6

