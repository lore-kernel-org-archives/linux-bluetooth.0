Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 12/12] android/AVDTP: Fix invalid free of struct discover
Date: Tue, 14 Jan 2014 12:42:48 +0200
Message-Id: <1389696168-26947-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
References: <1389696168-26947-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If callback releases the last reference it can cause the following:
Invalid free() / delete / delete[] / realloc()
   at 0x4A07577: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x386244EF7E: g_free (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x410356: finalize_discovery (avdtp.c:933)
   by 0x414462: session_cb (avdtp.c:2555)
   by 0x38624492A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x3862449627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x3862449A39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x403A95: main (main.c:439)
 Address 0x4cf7af0 is 0 bytes inside a block of size 24 free'd
   at 0x4A07577: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x386244EF7E: g_free (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x410356: finalize_discovery (avdtp.c:933)
   by 0x4110BC: avdtp_unref (avdtp.c:1026)
   by 0x416491: a2dp_device_free (a2dp.c:122)
   by 0x4165DF: bt_a2dp_notify_state (a2dp.c:166)
   by 0x417170: discover_cb (a2dp.c:333)
   by 0x41034E: finalize_discovery (avdtp.c:931)
   by 0x414462: session_cb (avdtp.c:2555)
   by 0x38624492A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x3862449627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x3862449A39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
---
 android/avdtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 473e02b..5da1206 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -923,6 +923,8 @@ static void finalize_discovery(struct avdtp *session, int err)
 	if (!discover)
 		return;
 
+	session->discover = NULL;
+
 	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
 
 	if (discover->id > 0)
@@ -931,7 +933,6 @@ static void finalize_discovery(struct avdtp *session, int err)
 	discover->cb(session, session->seps, err ? &avdtp_err : NULL,
 							discover->user_data);
 	g_free(discover);
-	session->discover = NULL;
 }
 
 static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
-- 
1.8.4.2

