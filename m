Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix memory leak when loading keys
Date: Mon, 23 Jan 2012 21:21:51 -0300
Message-Id: <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <20120123132915.GA2879@samus>
References: <20120123132915.GA2879@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we need a copy of those keys we should copy them.
---
 plugins/hciops.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index d4d219c..f4af637 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3563,6 +3563,7 @@ static int hciops_restore_powered(int index)
 static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *l;
 
 	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
 								debug_keys);
@@ -3570,7 +3571,16 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
 	if (dev->keys != NULL)
 		return -EEXIST;
 
-	dev->keys = keys;
+	for (l = keys; l; l = l->next) {
+		struct link_key_info *orig, *dup;
+
+		orig = l->data;
+
+		dup = g_memdup(orig, sizeof(*orig));
+
+		dev->keys = g_slist_prepend(dev->keys, dup);
+	}
+
 	dev->debug_keys = debug_keys;
 
 	return 0;
-- 
1.7.8.1

