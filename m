Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] android/avrcp-lib: Fix test /TP/MPS/BV-06-C
Date: Fri, 27 Mar 2015 10:49:52 +0200
Message-Id: <1427446194-5646-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
References: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash on /TP/MPS/BV-06-C:

Invalid write of size 4
   at 0x414A98: browsing_disconnect_cb (avrcp-lib.c:652)
   by 0x4122B2: handler_free (avctp.c:1121)
   by 0x4E9C7FC: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E9C81A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x413219: avctp_destroy_browsing (avctp.c:1130)
   by 0x4132B4: avctp_channel_destroy (avctp.c:499)
   by 0x4133E0: avctp_unref (avctp.c:729)
   by 0x413682: avctp_shutdown (avctp.c:1650)
   by 0x413682: session_cb (avctp.c:1020)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x41D301: tester_run (tester.c:831)
 Address 0x57bc0e8 is 88 bytes inside a block of size 112 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E8450E: g_free (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x419A75: avrcp_shutdown (avrcp-lib.c:382)
   by 0x40E77E: destroy_context (test-avrcp.c:140)
   by 0x40E82F: context_quit (test-avrcp.c:153)
   by 0x40EA01: get_folder_items_rsp (test-avrcp.c:884)
   by 0x415DA0: get_folder_items_rsp (avrcp-lib.c:2731)
   by 0x413EC1: browsing_response (avctp.c:835)
   by 0x413EC1: session_browsing_cb (avctp.c:883)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x41D301: tester_run (tester.c:831)
---
 android/avrcp-lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 23dea62..353bee5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -367,6 +367,10 @@ void avrcp_shutdown(struct avrcp *session)
 			avctp_unregister_passthrough_handler(session->conn,
 						session->passthrough_id);
 
+		if (session->browsing_id > 0)
+			avctp_unregister_browsing_pdu_handler(session->conn,
+							session->browsing_id);
+
 		/* clear destroy callback that would call shutdown again */
 		avctp_set_destroy_cb(session->conn, NULL, NULL);
 		avctp_shutdown(session->conn);
-- 
2.1.0

