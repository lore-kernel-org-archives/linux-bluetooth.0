Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix pulling phonebook size
Date: Tue, 26 Jul 2011 21:21:06 +0200
Message-Id: <1311708066-6848-1-git-send-email-bulislaw@linux.com>
In-Reply-To: <20110726104752.GD5470@dell>
References: <20110726104752.GD5470@dell>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 9cb32c3..683037a 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -164,7 +164,7 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 {
 	struct query_context *data = user_data;
 	GList *l;
-	unsigned int count = 0, maxcount;
+	unsigned int count, maxcount;
 
 	if (gerr != NULL) {
 		error("E-Book query failed: %s", gerr->message);
@@ -180,13 +180,13 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 	 */
 	maxcount = data->params->maxlistcount;
 	if (maxcount == 0) {
-		count += g_list_length(contacts);
+		data->count += g_list_length(contacts);
 		goto done;
 	}
 
 	l = g_list_nth(contacts, data->params->liststartoffset);
 
-	for (; l && count + data->count < maxcount; l = g_list_next(l),
+	for (count = 0; l && count + data->count < maxcount; l = g_list_next(l),
 								count++) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
@@ -200,13 +200,13 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 		g_free(vcard);
 	}
 
+	DBG("collected %d vcards", count);
+
 	data->count += count;
 
 done:
 	g_list_free_full(contacts, g_object_unref);
 
-	DBG("collected %d vcards", count);
-
 	data->queued_calls--;
 	if (data->queued_calls == 0) {
 		GString *buf = data->buf;
-- 
1.7.6

