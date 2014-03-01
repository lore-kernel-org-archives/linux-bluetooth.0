Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/avctp: Fix memory leak on disconnect
Date: Sat,  1 Mar 2014 20:04:16 +0100
Message-Id: <1393700658-14323-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Free passthrough handler if it was not unregistered.

This fix following Valgrind report:

943 (12 direct, 931 indirect) bytes in 1 blocks are definitely lost in
     loss record 55 of 57
   at 0x48993CC: malloc (in /system/lib/valgrind/
     vgpreload_memcheck-arm-linux.so)
   by 0x48C5D77: g_malloc (gmem.c:159)
   by 0x1177E3: avctp_register_passthrough_handler (avctp.c:1293)
   by 0x1186BF: avrcp_new (avrcp-lib.c:230)
   by 0x117D67: connect_cb (avrcp.c:346)
   by 0x1206DB: connect_cb (btio.c:232)
   by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
   by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
   by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
   by 0x48C3167: g_main_loop_run (gmain.c:3340)
   by 0x10BA1F: main (main.c:491)
---
 android/avctp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/avctp.c b/android/avctp.c
index bc1bd80..b901371 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1501,5 +1501,6 @@ void avctp_shutdown(struct avctp *session)
 		session->uinput = -1;
 	}
 
+	g_free(session->handler);
 	g_free(session);
 }
-- 
1.8.5.3

