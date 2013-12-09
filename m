Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Remove not needed struct adapter_keys
Date: Mon,  9 Dec 2013 11:11:33 +0100
Message-Id: <1386583893-22676-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a leftover from using old storage format.
---
 src/adapter.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 41f7bd6..8ec9e92 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2196,11 +2196,6 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ }
 };
 
-struct adapter_keys {
-	struct btd_adapter *adapter;
-	GSList *keys;
-};
-
 static int str2buf(const char *str, uint8_t *buf, size_t blen)
 {
 	int i, dlen;
@@ -2479,8 +2474,8 @@ static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
 	char srcaddr[18];
-	struct adapter_keys keys = { adapter, NULL };
-	struct adapter_keys ltks = { adapter, NULL };
+	GSList *keys = NULL;
+	GSList *ltks = NULL;
 	DIR *dir;
 	struct dirent *entry;
 
@@ -2514,11 +2509,11 @@ static void load_devices(struct btd_adapter *adapter)
 
 		key_info = get_key_info(key_file, entry->d_name);
 		if (key_info)
-			keys.keys = g_slist_append(keys.keys, key_info);
+			keys = g_slist_append(keys, key_info);
 
 		ltk_info = get_ltk_info(key_file, entry->d_name);
 		if (ltk_info)
-			ltks.keys = g_slist_append(ltks.keys, ltk_info);
+			ltks = g_slist_append(ltks, ltk_info);
 
 		list = g_slist_find_custom(adapter->devices, entry->d_name,
 							device_address_cmp);
@@ -2553,11 +2548,11 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, keys.keys, main_opts.debug_keys);
-	g_slist_free_full(keys.keys, g_free);
+	load_link_keys(adapter, keys, main_opts.debug_keys);
+	g_slist_free_full(keys, g_free);
 
-	load_ltks(adapter, ltks.keys);
-	g_slist_free_full(ltks.keys, g_free);
+	load_ltks(adapter, ltks);
+	g_slist_free_full(ltks, g_free);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
-- 
1.8.3.2

