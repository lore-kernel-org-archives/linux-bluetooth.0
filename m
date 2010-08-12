Return-Path: <cyrus@holtmann.org>
Message-Id: <201008121026.o7CAQDVU005280@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Thu, 12 Aug 2010 12:20:46 +0200
Subject: [PATCH] ebook backend: separate concatenated vcards with \r\n.
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The END:VCARD is not ended with \r\n for single vcards.
In a phonebook pull request vcards are concatenated as one
big blob. Carkits seem to choke on the fact that an END:VCARD
is directly followed by BEGIN:VCARD without \r\n separation.
(as observed by many n900 users).
---
 plugins/phonebook-ebook.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index ad40be3..da68ac0 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -175,8 +175,11 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 						data->params->filter);
 
 		string = g_string_append(string, vcard);
+		string = g_string_append(string, "\r\n");
 		g_free(vcard);
 	}
+	DBG("collected %d vcards", count);
+
 
 done:
 	data->cb(string->str, string->len, count, 0, data->user_data);
-- 
1.7.2

