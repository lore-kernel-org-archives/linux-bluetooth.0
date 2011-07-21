Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix sent vCard format
Date: Thu, 21 Jul 2011 23:03:59 +0200
Message-Id: <1311282239-5437-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now phonebook eds backend supports only vCard 3.0.
---
 plugins/phonebook-ebook.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 4a14eca..9cb32c3 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -192,7 +192,7 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 		EVCard *evcard = E_VCARD(contact);
 		char *vcard;
 
-		vcard = evcard_to_string(evcard, data->params->format,
+		vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
 						data->params->filter);
 
 		data->buf = g_string_append(data->buf, vcard);
@@ -236,7 +236,7 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 
 	evcard = E_VCARD(contact);
 
-	vcard = evcard_to_string(evcard, data->params->format,
+	vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
 					data->params->filter);
 
 	len = vcard ? strlen(vcard) : 0;
-- 
1.7.6

