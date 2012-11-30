Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/8] rfkill: Fix memory leak in rfkill_exit
Date: Fri, 30 Nov 2012 12:24:58 +0100
Message-ID: <1354274703-15604-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_io_add_watch increase channel ref count but g_io_channel_shutdown
doesn't drop reference nor remove watch. Since close on unref is set
for channel and it is watch we are interested keep watch id and not
channel id and remove watch on exit.

120 bytes in 1 blocks are still reachable in loss record 181 of 235
    at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
    by 0x4EB66F4: g_io_channel_unix_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
    by 0x167B8D: rfkill_init (rfkill.c:157)
    by 0x1215E4: main (main.c:540)

6 bytes in 1 blocks are still reachable in loss record 12 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E942DD: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6CF95: g_io_channel_init (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB66FF: g_io_channel_unix_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x167B8D: rfkill_init (rfkill.c:157)
   by 0x1215E4: main (main.c:540)
---
 src/rfkill.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index b40c6e7..a6cd95c 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -139,11 +139,12 @@ static gboolean rfkill_event(GIOChannel *chan,
 	return TRUE;
 }
 
-static GIOChannel *channel = NULL;
+static guint watch = 0;
 
 void rfkill_init(void)
 {
 	int fd;
+	GIOChannel *channel;
 
 	if (!main_opts.remember_powered)
 		return;
@@ -157,17 +158,17 @@ void rfkill_init(void)
 	channel = g_io_channel_unix_new(fd);
 	g_io_channel_set_close_on_unref(channel, TRUE);
 
-	g_io_add_watch(channel, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+	watch = g_io_add_watch(channel, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
 							rfkill_event, NULL);
+
+	g_io_channel_unref(channel);
 }
 
 void rfkill_exit(void)
 {
-	if (!channel)
+	if (watch == 0)
 		return;
 
-	g_io_channel_shutdown(channel, TRUE, NULL);
-	g_io_channel_unref(channel);
-
-	channel = NULL;
+	g_source_remove(watch);
+	watch = 0;
 }
-- 
1.7.9.5

