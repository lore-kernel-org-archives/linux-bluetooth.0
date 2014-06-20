Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Fix loading device address type from storage
Date: Fri, 20 Jun 2014 16:33:34 +0200
Message-Id: <1403274814-8902-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Address type is stored as "AddressType" key. Also this is valid only
for LE capable devices.
---
 android/bluetooth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0e5c9d7..17a59e2 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2685,8 +2685,6 @@ static struct mgmt_link_key_info *get_key_info(GKeyFile *key_file,
 
 	str2ba(peer, &info->addr.bdaddr);
 
-	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
-
 	for (i = 0; i < sizeof(info->val); i++)
 		sscanf(str + (i * 2), "%02hhX", &info->val[i]);
 
@@ -2723,7 +2721,8 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 
 	str2ba(peer, &info->addr.bdaddr);
 
-	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+	info->addr.type = g_key_file_get_integer(key_file, peer, "AddressType",
+									NULL);
 
 	for (i = 0; i < sizeof(info->val); i++)
 		sscanf(key + (i * 2), "%02hhX", &info->val[i]);
@@ -2762,7 +2761,8 @@ static struct mgmt_irk_info *get_irk_info(GKeyFile *key_file, const char *peer)
 
 	str2ba(peer, &info->addr.bdaddr);
 
-	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+	info->addr.type = g_key_file_get_integer(key_file, peer, "AddressType",
+									NULL);
 
 	for (i = 0; i < sizeof(info->val); i++)
 		sscanf(str + (i * 2), "%02hhX", &info->val[i]);
-- 
1.9.1

