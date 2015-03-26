Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] android/avdtp: Fix test /TP/SIG/SMG/BI-19-C
Date: Thu, 26 Mar 2015 16:20:24 +0200
Message-Id: <1427379625-20412-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
References: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test /TP/SIG/SMG/BI-19-C was causing the following backtrace:

Invalid write of size 4
   at 0x415653: avdtp_parse_rej (avdtp.c:2801)
   by 0x415653: session_cb (avdtp.c:2067)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4189D1: tester_run (tester.c:831)
   by 0x40C8C7: main (test-avdtp.c:1392)
 Address 0x5c75b60 is 96 bytes inside a block of size 104 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E8450E: g_free (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4101F0: stream_free (avdtp.c:697)
   by 0x4E9C7FC: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E9C81A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4106FF: avdtp_free (avdtp.c:974)
   by 0x4106FF: avdtp_unref (avdtp.c:1042)
   by 0x40CE18: destroy_context (test-avdtp.c:130)
   by 0x40CE18: context_quit (test-avdtp.c:145)
   by 0x40E38F: sep_start_cfm (test-avdtp.c:481)
   by 0x415652: avdtp_parse_rej (avdtp.c:2799)
   by 0x415652: session_cb (avdtp.c:2067)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
---
 android/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 2252782..7dcccd0 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2808,9 +2808,9 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 		error("START request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
 		if (sep && sep->cfm && sep->cfm->start) {
+			stream->starting = FALSE;
 			sep->cfm->start(session, sep, stream, &err,
 					sep->user_data);
-			stream->starting = FALSE;
 		}
 		return TRUE;
 	case AVDTP_SUSPEND:
-- 
2.1.0

