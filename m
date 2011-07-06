Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 6/9] Fix memory leak when loading keys
Date: Wed,  6 Jul 2011 17:10:38 -0300
Message-Id: <1309983041-23744-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
References: <y>
 <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Core bluetoothd doesn't need to have a reference to the link key list,
so we pass a reference to the list and free it as soon as possible. If any
user need to keep a copy of that list around, they need to copy it. This makes
the memory management more consistent.
---
 plugins/hciops.c |   14 +++++++++++++-
 src/adapter.c    |    6 +++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 207e187..56daf0d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3450,6 +3450,7 @@ static int hciops_restore_powered(int index)
 static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *l, *n, *new;
 
 	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
 								debug_keys);
@@ -3457,7 +3458,18 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 	if (dev->keys != NULL)
 		return -EEXIST;
 
-	dev->keys = keys;
+	new = g_slist_copy(keys);
+
+	for (n = new, l = keys; l && n; l = l->next, n = n->next) {
+		struct link_key_info *orig;
+
+		orig = l->data;
+
+		n->data = g_malloc0(sizeof(*orig) + orig->dlen);
+		memcpy(n->data, orig, sizeof(*orig) + orig->dlen);
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

