Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] android/a2dp: Fix memory leak
Date: Wed, 15 Jan 2014 22:01:38 +0100
Message-Id: <1389819699-12055-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

avdtp_service_cap_new() makes own copy of data stored in "codec" thus
it should be freed by caller.

This fixes following Valgrind report:

==1238== 6 bytes in 1 blocks are definitely lost in loss record 27 of 54
==1238==    at 0x4896DC8: calloc (in /system/lib/valgrind/vgpreload_memcheck-arm-linux.so)
==1238==    by 0x48C5DB7: g_malloc0 (gmem.c:189)
==1238==    by 0x115B4B: discover_cb (a2dp.c:303)
==1238==    by 0x111DE7: finalize_discovery (avdtp.c:933)
==1238==    by 0x114441: session_cb (avdtp.c:2556)
==1238==    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
==1238==    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
==1238==    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
==1238==    by 0x48C3167: g_main_loop_run (gmain.c:3340)
==1238==    by 0x10B207: main (main.c:436)
---
 android/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 35ffe46..a5ea5a0 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -309,6 +309,8 @@ static int select_configuration(struct a2dp_device *dev,
 						sizeof(*codec) + preset->len);
 	caps = g_slist_append(caps, service);
 
+	g_free(codec);
+
 	err = avdtp_set_configuration(dev->session, rsep, endpoint->sep, caps,
 								&stream);
 	g_slist_free_full(caps, g_free);
-- 
1.8.5.2

