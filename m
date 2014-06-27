Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] unit/test-queue: Fix memory leak
Date: Fri, 27 Jun 2014 13:52:46 +0300
Message-Id: <1403866366-18416-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following memory leak:

32 bytes in 1 blocks are definitely lost in loss record 20 of 35
   at 0x4C291D4: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x400DC2: queue_new (queue.c:65)
   by 0x400AA5: test_foreach_remove_all (test-queue.c:92)
   by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4E9EB1A: g_test_run_suite (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40083E: main (test-queue.c:109)
---
 unit/test-queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index af7dfd3..5cbe529 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -96,6 +96,7 @@ static void test_foreach_remove_all(void)
 	queue_push_tail(queue, UINT_TO_PTR(2));
 
 	queue_foreach(queue, foreach_remove_all, queue);
+	queue_destroy(queue, NULL);
 }
 
 int main(int argc, char *argv[])
-- 
1.9.3

