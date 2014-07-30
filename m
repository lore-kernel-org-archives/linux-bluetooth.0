Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/bluetooth: Fix loading LTKs
Date: Wed, 30 Jul 2014 11:38:50 +0200
Message-Id: <1406713130-3825-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 563a743..a8d85ce 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2318,7 +2318,7 @@ static void load_ltks(GSList *ltks)
 	cp->key_count = htobs(ltk_count);
 
 	for (l = ltks, ltk = cp->keys; l != NULL; l = g_slist_next(l), ltk++)
-		memcpy(ltk, ltks->data, sizeof(*ltk));
+		memcpy(ltk, l->data, sizeof(*ltk));
 
 	if (mgmt_send(mgmt_if, MGMT_OP_LOAD_LONG_TERM_KEYS, adapter.index,
 			cp_size, cp, load_ltk_complete, NULL, NULL) == 0)
-- 
1.9.3

