Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v3 6/9] Fix memory leak when loading keys
Date: Thu,  7 Jul 2011 19:03:27 -0300
Message-Id: <1310076210-15565-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Core bluetoothd doesn't need to have a reference to the link key list,
so we pass a reference to the list and free it as soon as possible. If any
user need to keep a copy of that list around, they need to copy it. This makes
the memory management more consistent.
---
 plugins/hciops.c |   19 ++++++++++++++++++-
 src/adapter.c    |    6 +++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 207e187..d44aec5 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3450,6 +3450,7 @@ static int hciops_restore_powered(int index)
 static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *l, *new;
 
 	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
 								debug_keys);
@@ -3457,7 +3458,23 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 	if (dev->keys != NULL)
 		return -EEXIST;
 
-	dev->keys = keys;
+	for (new = NULL, l = keys; l; l = l->next) {
+		struct link_key_info *orig, *dup;
+
+		orig = l->data;
+
+		dup = g_try_malloc(sizeof(*orig) + orig->dlen);
+		if (dup == NULL) {
+			g_slist_free_full(new, g_free);
+			return -ENOMEM;
+		}
+
+		memcpy(dup, orig, sizeof(*orig) + orig->dlen);
+
+		new = g_slist_prepend(new, dup);
+	}
+
+	dev->keys = new;
 	dev->debug_keys = debug_keys;
 
 	return 0;
diff --git a/src/adapter.c b/src/adapter.c
index 85979f5..cde0244 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2154,11 +2154,11 @@ static void load_devices(struct btd_adapter *adapter)
 
 	err = adapter_ops->load_keys(adapter->dev_id, keys.keys,
 							main_opts.debug_keys);
-	if (err < 0) {
+	if (err < 0)
 		error("Unable to load keys to adapter_ops: %s (%d)",
 							strerror(-err), -err);
-		g_slist_free_full(keys.keys, g_free);
-	}
+
+	g_slist_free_full(keys.keys, g_free);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
-- 
1.7.6

