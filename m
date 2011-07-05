Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 4/5 v2] Add 0.vcf (me contact) when generating cache
Date: Tue,  5 Jul 2011 22:53:21 +0200
Message-Id: <1309899202-23849-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
References: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When pulling all contacts self is already present, but it have to
be manually added when generating cache.
---
 plugins/phonebook-ebook.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 97785b5..181585a 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -616,6 +616,13 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	EBookQuery *query;
 	gboolean ret;
 	GSList *ebook;
+	EContact *me;
+	EVCard *evcard;
+	GError *gerr;
+	EBook *eb;
+	EVCardAttribute *attrib;
+	char *uid, *tel, *cname;
+
 
 	if (g_strcmp0("/telecom/pb", name) != 0) {
 		if (err)
@@ -634,6 +641,39 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->user_data = user_data;
 	data->query = query;
 
+	/* Add 0.vcf */
+	if (e_book_get_self(&me, &eb, &gerr) == FALSE) {
+		g_error_free(gerr);
+		goto next;
+	}
+
+	evcard = E_VCARD(me);
+
+	cname = evcard_name_attribute_to_string(evcard);
+	if (!cname)
+		cname = g_strdup("");
+
+	attrib = e_vcard_get_attribute(evcard, EVC_UID);
+	uid = e_vcard_attribute_get_value(attrib);
+	if (!uid)
+		uid = g_strdup("");
+
+	attrib = e_vcard_get_attribute(evcard, EVC_TEL);
+	if (attrib)
+		tel =  e_vcard_attribute_get_value(attrib);
+	else
+		tel = g_strdup("");
+
+	data->entry_cb(uid, 0, cname, NULL, tel, data->user_data);
+
+	data->count++;
+
+	g_free(cname);
+	g_free(uid);
+	g_free(tel);
+	g_object_unref(eb);
+
+next:
 	ebook = ebooks;
 	while (ebook != NULL) {
 		if (e_book_is_opened(ebook->data) == TRUE) {
-- 
1.7.5.3

