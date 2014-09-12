Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] core: Fix missing channel unref on cached session watch
Date: Fri, 12 Sep 2014 10:54:07 +0200
Message-Id: <1410512047-15547-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_io_add_watch function takes own reference so local one needs to
be dropped. Fix following Valgrind report:

126 (120 direct, 6 indirect) bytes in 1 blocks are definitely lost in
    loss record 146 of 158
at 0x4C2745D: malloc (in /usr/lib64/valgrind/
   vgpreload_memcheck-amd64-linux.so)
by 0x4E7FE6E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3800.2)
by 0x4EBC5B7: g_io_channel_unix_new (in /usr/lib64/
   libglib-2.0.so.0.3800.2)
by 0x4496B4: search_completed_cb (sdp-client.c:129)
by 0x45217B: sdp_process (sdp.c:4350)
by 0x449814: search_process_cb (sdp-client.c:228)
by 0x4E7A2A5: g_main_context_dispatch (in /usr/
   lib64/libglib-2.0.so.0.3800.2)
by 0x4E7A627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
by 0x4E7AA39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
by 0x404372: main (main.c:550)
---
 src/sdp-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index fbe266e..bca2496 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -130,6 +130,8 @@ static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 
 	cached->io_id = g_io_add_watch(chan, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 						disconnect_watch, cached);
+
+	g_io_channel_unref(chan);
 }
 
 struct search_context {
-- 
1.9.1

