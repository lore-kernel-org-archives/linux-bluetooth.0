Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/5] Fix pulling vCard for multiple ebooks
Date: Wed, 13 Jul 2011 22:10:06 +0000
Message-Id: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Problem occurred when there were multiple ebooks and the last one was
empty. Reported vCard number was 0 and no data was transported.
---
 plugins/phonebook-ebook.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index b51d34d..b2f16e0 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -51,7 +51,7 @@ struct query_context {
 	phonebook_entry_cb entry_cb;
 	phonebook_cache_ready_cb ready_cb;
 	EBookQuery *query;
-	int count;
+	unsigned int count;
 	GString *buf;
 	char *id;
 	unsigned queued_calls;
@@ -158,7 +158,7 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 {
 	struct query_context *data = user_data;
 	GList *l;
-	unsigned int count = data->count, maxcount;
+	unsigned int count = 0, maxcount;
 
 	if (gerr != NULL) {
 		error("E-Book query failed: %s", gerr->message);
@@ -180,9 +180,8 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 
 	l = g_list_nth(contacts, data->params->liststartoffset);
 
-	/* FIXME: Missing 0.vcf */
-
-	for (; l && count < maxcount; l = g_list_next(l), count++) {
+	for (; l && count + data->count < maxcount; l = g_list_next(l),
+								count++) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
 		char *vcard;
@@ -195,6 +194,8 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 		g_free(vcard);
 	}
 
+	data->count += count;
+
 done:
 	g_list_free_full(contacts, g_object_unref);
 
@@ -202,8 +203,8 @@ done:
 
 	data->queued_calls--;
 	if (data->queued_calls == 0)
-		data->contacts_cb(data->buf->str, data->buf->len, count, 0,
-							TRUE, data->user_data);
+		data->contacts_cb(data->buf->str, data->buf->len, data->count,
+						0, TRUE, data->user_data);
 }
 
 static void ebook_entry_cb(EBook *book, const GError *gerr,
-- 
1.7.5.3

