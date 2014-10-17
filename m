Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/tester: Add missing hook removal
Date: Fri, 17 Oct 2014 14:10:12 +0200
Message-Id: <1413547812-12345-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Missing hook removal was resulting in memory leak:
936 bytes in 39 blocks are definitely lost in loss record 42 of 45
==15026==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==15026==    by 0x407D60: btdev_add_hook (btdev.c:3226)
==15026==    by 0x40EB75: read_info_callback (tester-main.c:364)
==15026==    by 0x4142B5: request_complete (mgmt.c:245)
==15026==    by 0x41441A: can_read_data (mgmt.c:349)
==15026==    by 0x41663C: read_callback (io-glib.c:170)
==15026==    by 0x5083CE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==15026==    by 0x5084047: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==15026==    by 0x5084309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==15026==    by 0x4162D0: tester_run (tester.c:815)
==15026==    by 0x40263E: main (tester-main.c:2716)
---
 android/tester-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index a804f11..fc1de06 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -212,6 +212,9 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	/* remove hook for encryption change */
+	hciemu_del_hook(data->hciemu, HCIEMU_HOOK_POST_EVT, 0x08);
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 
-- 
1.9.1

