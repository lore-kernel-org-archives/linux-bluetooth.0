Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVDTP: Fix memory leak
Date: Fri,  1 Feb 2013 12:20:44 -0600
Message-Id: <1359742844-4612-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

56 (16 direct, 40 indirect) bytes in 1 blocks are definitely lost in loss record 173 of 263
   at 0x4A0883C: malloc (vg_replace_malloc.c:270)
   by 0x4C8568E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x4C9A7F1: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x4C9BB92: g_slist_append (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x422072: send_req (avdtp.c:2569)
   by 0x422D0B: avdtp_discover (avdtp.c:3380)
   by 0x41D16C: source_setup_stream (source.c:307)
   by 0x41D1EF: source_connect (source.c:331)
   by 0x465411: connect_next (device.c:1073)
   by 0x466C92: device_profile_connected (device.c:1097)
   by 0x4629EB: ext_connect (profile.c:950)
   by 0x44AECB: connect_cb (btio.c:230)
---
 profiles/audio/avdtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0187691..403a22b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -599,8 +599,10 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 	return TRUE;
 }
 
-static void pending_req_free(struct pending_req *req)
+static void pending_req_free(void *data)
 {
+	struct pending_req *req = data;
+
 	if (req->timeout)
 		g_source_remove(req->timeout);
 	g_free(req->data);
@@ -1137,6 +1139,8 @@ static void avdtp_free(void *data)
 	if (session->req)
 		pending_req_free(session->req);
 
+	g_slist_free_full(session->req_queue, pending_req_free);
+	g_slist_free_full(session->prio_queue, pending_req_free);
 	g_slist_free_full(session->seps, sep_free);
 
 	g_free(session->buf);
-- 
1.8.1

