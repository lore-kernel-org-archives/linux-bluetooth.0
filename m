Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix pulling phonebook size
Date: Fri, 22 Jul 2011 22:58:07 +0200
Message-Id: <1311368287-5284-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 9cb32c3..91d0c0b 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -180,7 +180,7 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 	 */
 	maxcount = data->params->maxlistcount;
 	if (maxcount == 0) {
-		count += g_list_length(contacts);
+		data->count += g_list_length(contacts);
 		goto done;
 	}
 
-- 
1.7.6

