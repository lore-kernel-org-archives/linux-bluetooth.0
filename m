Return-Path: <cyrus@holtmann.org>
Message-Id: <201008092047.o79KlQDL015265@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Mon, 9 Aug 2010 22:43:55 +0200
Subject: [PATCH] return value checking of e_book_async_get_contacts() was wrong.
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

phonebook_create_cache() failed because checking the return value
e_book_async_get_contacts() was wrong. This would lead to a core dump
as the data was freed but was still used in the callbacks.
---
 plugins/phonebook-ebook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 3c24107..1598d5f 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -459,7 +459,7 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 
 	ret = e_book_async_get_contacts(ebook, query, cache_cb, data);
 	e_book_query_unref(query);
-	if (ret == FALSE) {
+	if (ret != FALSE) {
 		g_free(data);
 		return -EFAULT;
 	}
-- 
1.7.2

