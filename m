Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/avrcp: Fix crash while discovering records
Date: Wed, 30 Jul 2014 13:00:03 +0300
Message-Id: <1406714403-3474-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is removed before SDP discovery is completed the following
crash can happen:

Invalid read of size 4
    at 0x11CA6A: avrcp_device_free (avrcp.c:472)
    by 0x11D70F: search_cb (avrcp.c:944)
    by 0x13749D: search_completed_cb (sdp-client.c:176)
    by 0x134E0F: sdp_process (sdp.c:4345)
    by 0x1374F5: search_process_cb (sdp-client.c:201)
    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
    by 0x48C3167: g_main_loop_run (gmain.c:3340)
    by 0x10D00D: main (main.c:538)
Address 0x4bcb904 is 20 bytes inside a block of size 24 free'd
    at 0x4897E6C: free (in /system/lib/valgrind/vgpreload_memcheck-arm-linux.so)
    by 0x48C5E2B: g_free (gmem.c:252)
    by 0x11A52F: bt_a2dp_notify_state (a2dp.c:238)
    by 0x1172C1: process_disconnect (avdtp.c:1005)
    by 0x48C146B: g_list_foreach (gslist.c:840)
    by 0x48CD869: g_slist_free_full (gslist.c:177)
    by 0x117CAB: connection_lost (avdtp.c:1021)
    by 0x11A02F: session_cb (avdtp.c:2081)
    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
    by 0x48C3167: g_main_loop_run (gmain.c:3340)
---
 android/avrcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index caf9335..8c5cf8a 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -892,6 +892,9 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	DBG("");
 
+	if (!g_slist_find(devices, dev))
+		return;
+
 	if (err < 0) {
 		error("Unable to get AV_REMOTE_SVCLASS_ID SDP record: %s",
 							strerror(-err));
-- 
1.9.3

