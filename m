Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/14] android: Make load_link_keys function load keys
Date: Thu, 31 Oct 2013 02:55:44 +0000
Message-Id: <1383188154-22905-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GSlist passed is expected to hold mgmt_link_key_info structures.
---
 android/adapter.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 4b4905b..d55a070 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -290,22 +290,37 @@ failed:
 static void load_link_keys(GSList *keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
-	size_t key_len = g_slist_length(keys);
 	struct mgmt_link_key_info *key;
-	size_t len;
+	size_t key_count, cp_size;
+	unsigned int id;
 
-	DBG("");
+	key_count = g_slist_length(keys);
+
+	DBG("keys %zu ", key_count);
+
+	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
+
+	cp = g_malloc0(cp_size);
 
-	len = sizeof(*cp) + key_len * sizeof(*key);
-	cp = g_malloc0(len);
+	/*
+	 * Even if the list of stored keys is empty, it is important to
+	 * load an empty list into the kernel. That way it is ensured
+	 * that no old keys from a previous daemon are present.
+	 */
+	cp->key_count = htobs(key_count);
 
-	cp->debug_keys = 0;
-	cp->key_count = htobs(key_len);
+	for (key = cp->keys; keys != NULL; keys = g_slist_next(keys), key++)
+		memcpy(key, keys->data, sizeof(*key));
 
-	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, adapter->index, len,
-				cp, load_link_keys_complete, NULL, NULL);
+	id = mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, adapter->index,
+			cp_size, cp, load_link_keys_complete, NULL, NULL);
 
 	g_free(cp);
+
+	if (id == 0) {
+		error("Failed to load link keys");
+		adapter->ready(-EIO);
+	}
 }
 
 static void set_mode_complete(uint8_t status, uint16_t length,
-- 
1.8.4.rc3

