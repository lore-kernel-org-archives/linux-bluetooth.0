Return-Path: <cyrus@holtmann.org>
From: Hannu Mallat <hannu.mallat@jollamobile.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hannu Mallat <hannu.mallat@jollamobile.com>
Subject: [PATCH] pbap: Fix PhonebookSize endianness
Date: Mon,  3 Feb 2014 09:47:49 +0200
Message-Id: <1391413669-10534-1-git-send-email-hannu.mallat@jollamobile.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As g_obex_apparam_set_uint16() converts data to big-endian format
internally, do not call htons() prior to it.
---
 obexd/plugins/pbap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4740188..acac3aa 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -188,7 +188,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 
 	DBG("vcards %d", vcards);
 
-	phonebooksize = htons(vcards);
+	phonebooksize = vcards;
 
 	pbap->obj->apparam = g_obex_apparam_set_uint16(NULL, PHONEBOOKSIZE_TAG,
 								phonebooksize);
@@ -365,7 +365,7 @@ static int generate_response(void *user_data)
 
 	if (max == 0) {
 		/* Ignore all other parameter and return PhoneBookSize */
-		uint16_t size = htons(g_slist_length(pbap->cache.entries));
+		uint16_t size = g_slist_length(pbap->cache.entries);
 
 		pbap->obj->apparam = g_obex_apparam_set_uint16(
 							pbap->obj->apparam,
-- 
1.8.5.3

