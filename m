Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 4/5] Fix no phone number in vCard listing
Date: Wed, 13 Jul 2011 22:10:09 +0000
Message-Id: <1310595010-1033-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
References: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-ebook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 2ee5473..06ae1ec 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -314,7 +314,7 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 			continue;
 
 		attrib = e_vcard_get_attribute(evcard, EVC_TEL);
-		if (!attrib)
+		if (attrib)
 			tel = e_vcard_attribute_get_value(attrib);
 		else
 			tel = g_strdup("");
-- 
1.7.5.3

