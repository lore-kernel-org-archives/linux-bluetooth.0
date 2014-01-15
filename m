Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] android/a2dp: Fix memory leak
Date: Wed, 15 Jan 2014 22:01:39 +0100
Message-Id: <1389819699-12055-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

audio_ipc_send_rsp_full() does not free buffer passed as parameter
thus it should be freed by caller.

This fixes following Valgrind report:

==1238== 5 bytes in 1 blocks are definitely lost in loss record 22 of 54
==1238==    at 0x4896DC8: calloc (in /system/lib/valgrind/vgpreload_memcheck-arm-linux.so)
==1238==    by 0x48C5DB7: g_malloc0 (gmem.c:189)
==1238==    by 0x1150EF: bt_stream_open (a2dp.c:1177)
==1238==    by 0x1116A7: ipc_handle_msg (ipc.c:95)
==1238==    by 0x111C11: audio_watch_cb (audio-ipc.c:66)
==1238==    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
==1238==    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
==1238==    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
==1238==    by 0x48C3167: g_main_loop_run (gmain.c:3340)
==1238==    by 0x10B207: main (main.c:436)
---
 android/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index a5ea5a0..a36e9a3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1181,6 +1181,8 @@ static void bt_stream_open(const void *buf, uint16_t len)
 	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
 
 	audio_ipc_send_rsp_full(AUDIO_OP_OPEN_STREAM, len, rsp, -1);
+
+	g_free(rsp);
 }
 
 static void bt_stream_close(const void *buf, uint16_t len)
-- 
1.8.5.2

