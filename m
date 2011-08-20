Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 08/12] Fix memory leak when loading keys
Date: Fri, 19 Aug 2011 21:12:04 -0300
Message-Id: <1313799128-8842-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we need a copy of those keys we should copy them.
---
 plugins/hciops.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index cf8dd3a..03eec82 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3450,6 +3450,7 @@ static int hciops_restore_powered(int index)
 static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *l, *new;
 
 	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
 								debug_keys);
@@ -3457,7 +3458,17 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 	if (dev->keys != NULL)
 		return -EEXIST;
 
-	dev->keys = keys;
+	for (new = NULL, l = keys; l; l = l->next) {
+		struct link_key_info *orig, *dup;
+
+		orig = l->data;
+
+		dup = g_memdup(orig, sizeof(*orig));
+
+		new = g_slist_prepend(new, dup);
+	}
+
+	dev->keys = new;
 	dev->debug_keys = debug_keys;
 
 	return 0;
-- 
1.7.6

