Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared: Add ref counting to struct io
Date: Thu,  9 Jan 2014 13:44:51 +0100
Message-Id: <1389271491-20388-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix use after free in watch_destroy callbacks after mgmt_unref.
Fix number of following valgrind reports:

Invalid read of size 8
   at 0x4088A1: read_watch_destroy (io-glib.c:116)
   by 0x4E794A7: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7C4C1: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B53C: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)
 Address 0x595f828 is 24 bytes inside a block of size 72 free'd
   at 0x4C2B60C: free (in /usr/lib/valgrind/
       vgpreload_memcheck-amd64-linux.so)
   by 0x40A079: mgmt_unref (mgmt.c:504)
   by 0x40D754: index_removed_callback (android-tester.c:329)
   by 0x408E67: queue_foreach (queue.c:180)
   by 0x40994E: can_read_data (mgmt.c:282)
   by 0x40893C: read_callback (io-glib.c:135)
   by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B53C: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)

Invalid write of size 4
   at 0x4088B3: read_watch_destroy (io-glib.c:119)
   by 0x4E794A7: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7C4C1: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B53C: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)
 Address 0x595f818 is 8 bytes inside a block of size 72 free'd
   at 0x4C2B60C: free (in /usr/lib/valgrind/
       vgpreload_memcheck-amd64-linux.so)
   by 0x40A079: mgmt_unref (mgmt.c:504)
   by 0x40D754: index_removed_callback (android-tester.c:329)
   by 0x408E67: queue_foreach (queue.c:180)
   by 0x40994E: can_read_data (mgmt.c:282)
   by 0x40893C: read_callback (io-glib.c:135)
   by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B53C: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)
---
 src/shared/io-glib.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index ea84a69..488b1a2 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -30,6 +30,7 @@
 #include "src/shared/io.h"
 
 struct io {
+	int ref_count;
 	GIOChannel *channel;
 	guint read_watch;
 	io_callback_func_t read_callback;
@@ -41,6 +42,27 @@ struct io {
 	void *write_data;
 };
 
+static struct io *io_ref(struct io *io)
+{
+	if (!io)
+		return NULL;
+
+	__sync_fetch_and_add(&io->ref_count, 1);
+
+	return io;
+}
+
+static void io_unref(struct io *io)
+{
+	if (!io)
+		return;
+
+	if (__sync_sub_and_fetch(&io->ref_count, 1))
+		return;
+
+	g_free(io);
+}
+
 struct io *io_new(int fd)
 {
 	struct io *io;
@@ -69,7 +91,7 @@ struct io *io_new(int fd)
 	io->write_destroy = NULL;
 	io->write_data = NULL;
 
-	return io;
+	return io_ref(io);
 }
 
 void io_destroy(struct io *io)
@@ -77,15 +99,20 @@ void io_destroy(struct io *io)
 	if (!io)
 		return;
 
-	if (io->read_watch > 0)
+	if (io->read_watch > 0) {
 		g_source_remove(io->read_watch);
+		io->read_watch = 0;
+	}
 
-	if (io->write_watch > 0)
+	if (io->write_watch > 0) {
 		g_source_remove(io->write_watch);
+		io->write_watch = 0;
+	}
 
 	g_io_channel_unref(io->channel);
+	io->channel = NULL;
 
-	g_free(io);
+	io_unref(io);
 }
 
 int io_get_fd(struct io *io)
@@ -120,6 +147,8 @@ static void read_watch_destroy(gpointer user_data)
 	io->read_callback = NULL;
 	io->read_destroy = NULL;
 	io->read_data = NULL;
+
+	io_unref(io);
 }
 
 static gboolean read_callback(GIOChannel *channel, GIOCondition cond,
@@ -155,7 +184,8 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 
 	io->read_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				read_callback, io, read_watch_destroy);
+				read_callback, io_ref(io),
+				read_watch_destroy);
 	if (io->read_watch == 0)
 		return false;
 
@@ -178,6 +208,8 @@ static void write_watch_destroy(gpointer user_data)
 	io->write_callback = NULL;
 	io->write_destroy = NULL;
 	io->write_data = NULL;
+
+	io_unref(io);
 }
 
 static gboolean write_callback(GIOChannel *channel, GIOCondition cond,
@@ -213,7 +245,8 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 
 	io->write_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
 				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				write_callback, io, write_watch_destroy);
+				write_callback, io_ref(io),
+				write_watch_destroy);
 	if (io->write_watch == 0)
 		return false;
 
-- 
1.8.3.2

