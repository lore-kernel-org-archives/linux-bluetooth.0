Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/8] hog: Fix memory leak in suspend-dummy
Date: Fri, 30 Nov 2012 12:24:59 +0100
Message-ID: <1354274703-15604-4-git-send-email-szymon.janc@tieto.com>
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

6 bytes in 1 blocks are still reachable in loss record 11 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E942DD: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6CF95: g_io_channel_init (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB66FF: g_io_channel_unix_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDC5: fifo_open (suspend.c:109)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

16 bytes in 1 blocks are still reachable in loss record 45 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93ABD: g_slist_prepend (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78350: g_source_add_poll (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5E32: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDF3: fifo_open (suspend.c:112)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

18 bytes in 1 blocks are still reachable in loss record 63 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E942DD: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78A69: g_source_set_name (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5E0B: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDF3: fifo_open (suspend.c:112)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

32 bytes in 1 blocks are still reachable in loss record 93 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78722: g_source_set_callback (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0DB: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDF3: fifo_open (suspend.c:112)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

32 bytes in 1 blocks are still reachable in loss record 94 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E77285: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E775AF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78115: g_source_attach (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0E5: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDF3: fifo_open (suspend.c:112)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

120 bytes in 1 blocks are still reachable in loss record 177 of 235
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB66F4: g_io_channel_unix_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDC5: fifo_open (suspend.c:109)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)

120 bytes in 1 blocks are still reachable in loss record 178 of 235
   at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FAE0: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78044: g_source_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5DF9: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x18DDF3: fifo_open (suspend.c:112)
   by 0x18DF95: suspend_init (suspend.c:131)
   by 0x140B53: hog_init (hog_manager.c:133)
   by 0x17127B: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:532)
---
 profiles/input/suspend-dummy.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 58f7b9c..97636ae 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -44,7 +44,7 @@
 
 static suspend_event suspend_cb = NULL;
 static resume_event resume_cb = NULL;
-static GIOChannel *fifoio = NULL;
+static guint watch = 0;
 
 static int fifo_open(void);
 
@@ -54,8 +54,15 @@ static gboolean read_fifo(GIOChannel *io, GIOCondition cond, gpointer user_data)
 	gsize offset, left, bread;
 	GIOStatus iostatus;
 
-	if (cond & (G_IO_ERR | G_IO_HUP))
-		goto failed;
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		/*
+		 * Both ends needs to be open simultaneously before proceeding
+		 * any input or output operation. When the remote closes the
+		 * channel, hup signal is received on this end.
+		 */
+		fifo_open();
+		return FALSE;
+	}
 
 	offset = 0;
 	left = sizeof(buffer) - 1;
@@ -77,25 +84,12 @@ static gboolean read_fifo(GIOChannel *io, GIOCondition cond, gpointer user_data)
 		resume_cb();
 
 	return TRUE;
-
-failed:
-	/*
-	 * Both ends needs to be open simultaneously before proceeding
-	 * any input or output operation. When the remote closes the
-	 * channel, hup signal is received on this end.
-	 */
-
-	g_io_channel_unref(fifoio);
-	fifoio = NULL;
-
-	fifo_open();
-
-	return FALSE;
 }
 
 static int fifo_open(void)
 {
 	GIOCondition condition = G_IO_IN | G_IO_ERR | G_IO_HUP;
+	GIOChannel *fifoio;
 	int fd;
 
 	fd = open(HOG_SUSPEND_FIFO, O_RDONLY | O_NONBLOCK);
@@ -109,7 +103,9 @@ static int fifo_open(void)
 	fifoio = g_io_channel_unix_new(fd);
 	g_io_channel_set_close_on_unref(fifoio, TRUE);
 
-	g_io_add_watch(fifoio, condition, read_fifo, NULL);
+	watch = g_io_add_watch(fifoio, condition, read_fifo, NULL);
+
+	g_io_channel_unref(fifoio);
 
 	return 0;
 }
@@ -137,9 +133,9 @@ int suspend_init(suspend_event suspend, resume_event resume)
 
 void suspend_exit(void)
 {
-	if (fifoio) {
-		g_io_channel_shutdown(fifoio, FALSE, NULL);
-		g_io_channel_unref(fifoio);
+	if (watch) {
+		g_source_remove(watch);
+		watch = 0;
 	}
 
 	remove(HOG_SUSPEND_FIFO);
-- 
1.7.9.5

