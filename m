Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH] adapter: fix call to get_key_info
Date: Thu, 16 Aug 2012 15:15:26 -0300
Message-Id: <1345140926-19076-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements commit 85128d40f4788acb0115f09c07b716e741444406 that
changed the "linkkeys" file format. The call to get_key_info must
include only the address string, instead of the new combined
address#type text.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index e6b5559..b642e37 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1808,7 +1808,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
 		bdaddr_type = BDADDR_BREDR;
 
-	info = get_key_info(key, value);
+	info = get_key_info(address, value);
 	if (info)
 		keys->keys = g_slist_append(keys->keys, info);
 
-- 
1.7.12.rc2.16.g034161a

