Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/5] Fix ebook opening error handling
Date: Wed, 13 Jul 2011 22:10:07 +0000
Message-Id: <1310595010-1033-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
References: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Individual address book may be not accessible (offline, not
authenticated etc.) it should not prevent plugin to load properly.
---
 plugins/phonebook-ebook.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index b2f16e0..0b2878a 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -331,16 +331,16 @@ done:
 
 static int traverse_sources(GSList *sources, char *default_src) {
 	GError *gerr;
-	int status;
 
 	while (sources != NULL) {
 		EBook *ebook = e_book_new(E_SOURCE(sources->data), &gerr);
 		if (ebook == NULL) {
 			error("Can't create user's address book: %s",
 								gerr->message);
+			sources = sources->next;
 
-			status = -EIO;
-			goto fail;
+			g_error_free(gerr);
+			continue;
 		}
 
 		if (g_strcmp0(default_src, e_source_get_uri(
@@ -353,9 +353,11 @@ static int traverse_sources(GSList *sources, char *default_src) {
 		if (e_book_open(ebook, FALSE, &gerr) == FALSE) {
 			error("Can't open e-book address book: %s",
 							gerr->message);
+			sources = sources->next;
 
-			status = -EIO;
-			goto fail;
+			g_object_unref(ebook);
+			g_error_free(gerr);
+			continue;
 		}
 
 		if (default_src == NULL)
@@ -370,11 +372,6 @@ static int traverse_sources(GSList *sources, char *default_src) {
 	}
 
 	return 0;
-
-fail:
-	g_error_free(gerr);
-
-	return status;
 }
 
 int phonebook_init(void)
@@ -404,9 +401,7 @@ int phonebook_init(void)
 
 		GSList *sources = e_source_group_peek_sources(group);
 
-		status = traverse_sources(sources, default_src);
-		if (status != 0)
-			goto fail;
+		traverse_sources(sources, default_src);
 
 		list = list->next;
 	}
-- 
1.7.5.3

