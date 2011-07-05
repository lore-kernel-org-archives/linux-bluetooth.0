Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/5 v2] Add checking ebook availability before processing
Date: Tue,  5 Jul 2011 22:53:20 +0200
Message-Id: <1309899202-23849-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
References: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some ebooks may be offline due to lack of internet connection or it may
require prior authorizations.
---
 plugins/phonebook-ebook.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 9c55860..97785b5 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -561,10 +561,12 @@ int phonebook_pull_read(void *request)
 
 	ebook = ebooks;
 	while (ebook != NULL) {
-		ret = e_book_get_contacts_async(ebook->data, data->query,
-							ebookpull_cb, data);
-		if (ret == TRUE)
-			data->queued_calls++;
+		if (e_book_is_opened(ebook->data) == TRUE) {
+			ret = e_book_get_contacts_async(ebook->data,
+					data->query, ebookpull_cb, data);
+			if (ret == TRUE)
+				data->queued_calls++;
+		}
 
 		ebook = ebook->next;
 	}
@@ -591,10 +593,12 @@ void *phonebook_get_entry(const char *folder, const char *id,
 
 	ebook = ebooks;
 	while (ebook != NULL) {
-		ret = e_book_get_contact_async(ebook->data, data->id,
+		if (e_book_is_opened(ebook->data) == TRUE) {
+			ret = e_book_get_contact_async(ebook->data, data->id,
 							ebook_entry_cb, data);
-		if (ret == TRUE)
-			data->queued_calls++;
+			if (ret == TRUE)
+				data->queued_calls++;
+		}
 
 		ebook = ebook->next;
 	}
@@ -632,10 +636,12 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 
 	ebook = ebooks;
 	while (ebook != NULL) {
-		ret = e_book_get_contacts_async(ebook->data, query,
-							cache_cb, data);
-		if (ret == TRUE)
-			data->queued_calls++;
+		if (e_book_is_opened(ebook->data) == TRUE) {
+			ret = e_book_get_contacts_async(ebook->data, query,
+								cache_cb, data);
+			if (ret == TRUE)
+				data->queued_calls++;
+		}
 
 		ebook = ebook->next;
 	}
-- 
1.7.5.3

