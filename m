Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix memory leak
Date: Fri, 20 Dec 2013 14:35:35 +0200
Message-Id: <1387542935-15736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Call del_hook() after add_hook(). This fixes valgrind warnings:

...
==15303==
==15303== HEAP SUMMARY:
==15303==     in use at exit: 3,060 bytes in 27 blocks
==15303==   total heap usage: 6,410 allocs, 6,383 frees, 332,477 bytes
allocated
==15303==
==15303== 24 bytes in 1 blocks are definitely lost in loss record 9 of
27
==15303==    at 0x4C2A2DB: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==15303==    by 0x406E20: btdev_add_hook (btdev.c:2166)
==15303==    by 0x40BFC2: test_discovery_start_done
(android-tester.c:1401)
==15303==    by 0x409C65: run_callback (tester.c:385)
==15303==    by 0x4E7C3B5: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x4E7C707: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x4E7CB09: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x40A85C: tester_run (tester.c:784)
==15303==    by 0x40368B: main (android-tester.c:1654)
==15303==
==15303== 24 bytes in 1 blocks are definitely lost in loss record 10 of
27
==15303==    at 0x4C2A2DB: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==15303==    by 0x406E20: btdev_add_hook (btdev.c:2166)
==15303==    by 0x40BF12: test_discovery_stop_success
(android-tester.c:1386)
==15303==    by 0x409C65: run_callback (tester.c:385)
==15303==    by 0x4E7C3B5: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x4E7C707: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x4E7CB09: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==15303==    by 0x40A85C: tester_run (tester.c:784)
==15303==    by 0x40368B: main (android-tester.c:1654)
==15303==
...
---
 android/android-tester.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 688e33c..1ed6586 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1368,9 +1368,14 @@ static void test_discovery_stop_done(const void *test_data)
 	check_expected_status(status);
 }
 
-static bool pre_inq_compl_hook(const void *data, uint16_t len, void *user_data)
+static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
 {
+	struct test_data *data = tester_get_data();
+
 	/* Make sure Inquiry Command Complete is not called */
+
+	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY);
+
 	return false;
 }
 
-- 
1.8.3.2

