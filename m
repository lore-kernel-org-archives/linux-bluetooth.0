Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/queue: Fix invalid read
Date: Fri, 27 Jun 2014 13:47:49 +0300
Message-Id: <1403866069-15394-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the queue elements are destroyed by queue_destroy the head will point
to freed memory causing the following error when unit/test-queue is run:

Invalid read of size 8
   at 0x401040: queue_foreach (queue.c:194)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40083E: main (test-queue.c:109)
 Address 0x7f65738 is 8 bytes inside a block of size 16 free'd
   at 0x4C28577: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x400E29: queue_destroy (queue.c:93)
   by 0x40102C: queue_foreach (queue.c:219)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40083E: main (test-queue.c:109)
---
 src/shared/queue.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 4013293..3bdc1ec 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -75,23 +75,10 @@ struct queue *queue_new(void)
 
 void queue_destroy(struct queue *queue, queue_destroy_func_t destroy)
 {
-	struct queue_entry *entry;
-
 	if (!queue)
 		return;
 
-	entry = queue->head;
-
-	while (entry) {
-		struct queue_entry *tmp = entry;
-
-		if (destroy)
-			destroy(entry->data);
-
-		entry = entry->next;
-
-		free(tmp);
-	}
+	queue_remove_all(queue, NULL, NULL, destroy);
 
 	queue_unref(queue);
 }
-- 
1.9.3

