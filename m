Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared: Fix use after free in queue_foreach
Date: Thu,  9 Jan 2014 14:32:37 +0100
Message-Id: <1389274357-25902-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function passed to queue_foreach may free queue entry. Make loop safe
with that. Fix number of following valgrin reports.

Invalid read of size 8
   at 0x408EEC: queue_foreach (queue.c:181)
   by 0x409A0E: can_read_data (mgmt.c:286)
   by 0x40896C: read_callback (io-glib.c:164)
   by 0x4E7C3B5: g_main_context_dispatch (in
       /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B5FC: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)
 Address 0x59603a8 is 8 bytes inside a block of size 16 free'd
   at 0x4C2B60C: free (in /usr/lib/valgrind/
       vgpreload_memcheck-amd64-linux.so)
   by 0x40910D: queue_remove_all (queue.c:289)
   by 0x40A0BD: mgmt_unregister_all (mgmt.c:792)
   by 0x40A0F4: mgmt_unref (mgmt.c:499)
   by 0x40D814: index_removed_callback (android-tester.c:329)
   by 0x408EEB: queue_foreach (queue.c:184)
   by 0x409A0E: can_read_data (mgmt.c:286)
   by 0x40896C: read_callback (io-glib.c:164)
   by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B5FC: tester_run (tester.c:784)
---
 src/shared/queue.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 0019e53..a7cc8d5 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -176,8 +176,15 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 	if (!queue || !function)
 		return;
 
-	for (entry = queue->head; entry; entry = entry->next)
-		function(entry->data, user_data);
+	entry = queue->head;
+
+	while (entry) {
+		struct queue_entry *tmp = entry;
+
+		entry = tmp->next;
+
+		function(tmp->data, user_data);
+	}
 }
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
-- 
1.8.3.2

