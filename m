Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android: Remove reduntant structure
Date: Tue, 29 Oct 2013 13:16:51 +0100
Message-Id: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 15b65e5..7e5c1a1 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -234,12 +234,11 @@ static void load_link_keys(GSList *keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	size_t key_len = g_slist_length(keys);
-	struct mgmt_link_key_info *key;
 	size_t len;
 
 	DBG("");
 
-	len = sizeof(*cp) + key_len * sizeof(*key);
+	len = sizeof(*cp) + key_len * sizeof(struct mgmt_link_key_info);
 	cp = g_malloc0(len);
 
 	cp->debug_keys = 0;
-- 
1.8.4.1

