Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/tester-ng: Fix not freeing porperties value
Date: Fri, 25 Jul 2014 12:45:06 +0200
Message-Id: <1406285106-14588-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes 3 valgrind reports like:

8 bytes in 2 blocks are definitely lost in loss record 7 of 47
==8437==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==8437==    by 0x5089610: g_malloc (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==8437==    by 0x50A0B57: g_memdup (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==8437==    by 0x40E94E: create_property (tester-main.c:623)
==8437==    by 0x40F96C: ssp_request_cb (tester-main.c:741)
==8437==    by 0x5F70E5A: notification_handler (hal-ipc.c:125)
==8437==    by 0x534B181: start_thread (pthread_create.c:312)
==8437==    by 0x565C30C: clone (clone.S:111)
---
 android/tester-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 42790b6..abef822 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -744,8 +744,11 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
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

