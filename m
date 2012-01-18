Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 3/4] Fix memory leak when loading keys
Date: Wed, 18 Jan 2012 20:13:31 -0300
Message-Id: <1326928412-25910-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we need a copy of those keys we should copy them.
---
 plugins/hciops.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index d4d219c..4e0729e 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3563,6 +3563,7 @@ static int hciops_restore_powered(int index)
 static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *l, *new;
 
 	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
 								debug_keys);
@@ -3570,7 +3571,17 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
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
1.7.8.1

