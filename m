Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] shared: Fix use after free in read_watch_destroy
Date: Sat,  2 Feb 2013 19:39:58 +0100
Message-Id: <1359830398-23165-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

read_watch_destroy is called when received_data returns FALSE.
free mgmt in read_watch_destroy instead of received_data to avoid
use after free.

Invalid write of size 4
   at 0x8051604: read_watch_destroy (mgmt.c:271)
   by 0x48C7468E: g_source_callback_unref (gmain.c:1457)
   by 0x48C77287: g_main_context_dispatch (gmain.c:2723)
   by 0x48C774FF: g_main_context_iterate.isra.22 (gmain.c:3290)
   by 0x48C77962: g_main_loop_run (gmain.c:3484)
   by 0x805393E: tester_run (tester.c:784)
   by 0x804D1C7: main (mgmt-tester.c:2558)
 Address 0x4039b80 is 16 bytes inside a block of size 76 free'd
   at 0x4007F0F: free (vg_replace_malloc.c:446)
   by 0x48C7D44B: standard_free (gmem.c:98)
   by 0x48C7D607: g_free (gmem.c:252)
   by 0x8051BB6: received_data (mgmt.c:337)
   by 0x48CBA72E: g_io_unix_dispatch (giounix.c:167)
   by 0x48C7715A: g_main_context_dispatch (gmain.c:2715)
   by 0x48C774FF: g_main_context_iterate.isra.22 (gmain.c:3290)
   by 0x48C77962: g_main_loop_run (gmain.c:3484)
   by 0x805393E: tester_run (tester.c:784)
   by 0x804D1C7: main (mgmt-tester.c:2558)
---
 src/shared/mgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index cf7fdcf..ca4b05f 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -268,6 +268,11 @@ static void read_watch_destroy(gpointer user_data)
 {
 	struct mgmt *mgmt = user_data;
 
+	if (mgmt->destroyed) {
+		g_free(mgmt);
+		return;
+	}
+
 	mgmt->read_watch = 0;
 }
 
@@ -333,10 +338,8 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		break;
 	}
 
-	if (mgmt->destroyed) {
-		g_free(mgmt);
+	if (mgmt->destroyed)
 		return FALSE;
-	}
 
 	return TRUE;
 }
-- 
1.8.1.2

