Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] android/avdtp: Fix test /TP/SIG/SMG/BV-09-C
Date: Thu, 26 Mar 2015 16:20:25 +0200
Message-Id: <1427379625-20412-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
References: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test /TP/SIG/SMG/BV-09-C frees the session after set_configuration is
called causing the following backtrace:

Invalid read of size 8
   at 0x412B81: avdtp_sep_set_state (avdtp.c:846)
   by 0x413F3F: avdtp_set_configuration_resp (avdtp.c:2515)
   by 0x413F3F: avdtp_parse_resp (avdtp.c:2656)
   by 0x4159B7: session_cb (avdtp.c:2057)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4189D1: tester_run (tester.c:831)
   by 0x40C8C7: main (test-avdtp.c:1392)
 Address 0x58572b8 is 8 bytes inside a block of size 64 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E8450E: g_free (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4164B8: avdtp_unregister_sep (avdtp.c:3417)
   by 0x40CEA5: unregister_sep (test-avdtp.c:123)
   by 0x41704F: queue_remove_all (queue.c:387)
   by 0x4170B4: queue_destroy (queue.c:76)
   by 0x40CE54: destroy_context (test-avdtp.c:133)
   by 0x40CE54: context_quit (test-avdtp.c:145)
   by 0x40E74F: sep_setconf_cfm (test-avdtp.c:417)
   by 0x413F27: avdtp_set_configuration_resp (avdtp.c:2512)
   by 0x413F27: avdtp_parse_resp (avdtp.c:2656)
   by 0x4159B7: session_cb (avdtp.c:2057)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
---
 android/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 7dcccd0..7e61280 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2522,12 +2522,12 @@ static gboolean avdtp_set_configuration_resp(struct avdtp *session,
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
+	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
+
 	if (sep->cfm && sep->cfm->set_configuration)
 		sep->cfm->set_configuration(session, sep, stream, NULL,
 						sep->user_data);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
-
 	return TRUE;
 }
 
-- 
2.1.0

