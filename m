Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/2] Fix memory issues in EDS PBAP
Date: Wed, 10 Aug 2011 01:05:39 +0200
Message-Id: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index e53da12..903cd01 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -343,10 +343,11 @@ done:
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
@@ -357,12 +358,14 @@ static GSList *traverse_sources(GSList *ebooks, GSList *sources,
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
@@ -374,8 +377,9 @@ static GSList *traverse_sources(GSList *ebooks, GSList *sources,
 			continue;
 		}
 
-		if (default_src == NULL)
-			default_src = e_source_get_uri(E_SOURCE(sources->data));
+		if (*default_src == NULL)
+			*default_src = e_source_get_uri(
+						E_SOURCE(sources->data));
 
 		DBG("%s address book opened",
 					e_source_peek_name(sources->data));
@@ -416,11 +420,14 @@ static GSList *open_ebooks(void)
 
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
 
-- 
1.7.6

