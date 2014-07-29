Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/8] android/tester: Fix memory leak
Date: Tue, 29 Jul 2014 15:01:25 +0300
Message-Id: <1406635292-30691-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes valgrind report.

==26707== HEAP SUMMARY:
==26707==     in use at exit: 4,943 bytes in 41 blocks
==26707==   total heap usage: 25,702 allocs, 25,661 frees, 1,379,978 bytes allocated
==26707==
==26707== 8 bytes in 2 blocks are definitely lost in loss record 6 of 39
==26707==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==26707==    by 0x5089610: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==26707==    by 0x50A0B57: g_memdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==26707==    by 0x40E57E: create_property (tester-main.c:623)
==26707==    by 0x40F49C: pin_request_cb (tester-main.c:713)
==26707==    by 0x5F70E7A: notification_handler (hal-ipc.c:125)
==26707==    by 0x534B181: start_thread (pthread_create.c:312)
==26707==    by 0x565C30C: clone (clone.S:111)
==26707==
==26707== 12 bytes in 2 blocks are definitely lost in loss record 7 of 39
==26707==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==26707==    by 0x5089610: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==26707==    by 0x50A0B57: g_memdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==26707==    by 0x40E57E: create_property (tester-main.c:623)
==26707==    by 0x40F467: pin_request_cb (tester-main.c:709)
==26707==    by 0x5F70E7A: notification_handler (hal-ipc.c:125)
==26707==    by 0x534B181: start_thread (pthread_create.c:312)
==26707==    by 0x565C30C: clone (clone.S:111)
==26707==
==26707== LEAK SUMMARY:
==26707==    definitely lost: 20 bytes in 4 blocks
==26707==    indirectly lost: 0 bytes in 0 blocks
==26707==      possibly lost: 0 bytes in 0 blocks
==26707==    still reachable: 4,923 bytes in 37 blocks
==26707==         suppressed: 0 bytes in 0 blocks
---
 android/tester-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index abef822..91a79ba 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -716,8 +716,11 @@ static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
 	step->callback_result.num_properties = 3;
 	step->callback_result.properties = repack_properties(3, props);
 
+	g_free(props[0]->val);
 	g_free(props[0]);
+	g_free(props[1]->val);
 	g_free(props[1]);
+	g_free(props[2]->val);
 	g_free(props[2]);
 
 	schedule_callback_call(step);
-- 
1.9.1

