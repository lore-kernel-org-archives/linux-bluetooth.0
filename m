Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared: Fix clearing of IO handlers
Date: Thu,  9 Jan 2014 11:31:48 +0100
Message-Id: <1389263508-7073-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If NULL callback is passed to io_set_read/write_handler don't add watch
for it and just clear struct io memebers. This was resulting in
write/read_callback being call in loop due to fd being never written
or read.
---
 src/shared/io-glib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 010dc71..443132e 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -142,8 +142,13 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 	if (!io)
 		return false;
 
-	if (io->read_watch > 0)
+	if (io->read_watch > 0) {
 		g_source_remove(io->read_watch);
+		io->read_watch = 0;
+	}
+
+	if (!callback)
+		goto done;
 
 	io->read_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -151,6 +156,7 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 	if (io->read_watch == 0)
 		return false;
 
+done:
 	io->read_callback = callback;
 	io->read_destroy = destroy;
 	io->read_data = user_data;
@@ -191,8 +197,13 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 	if (!io)
 		return false;
 
-	if (io->write_watch > 0)
+	if (io->write_watch > 0) {
 		g_source_remove(io->write_watch);
+		io->write_watch = 0;
+	}
+
+	if (!callback)
+		goto done;
 
 	io->write_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
 				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -200,6 +211,7 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 	if (io->write_watch == 0)
 		return false;
 
+done:
 	io->write_callback = callback;
 	io->write_destroy = destroy;
 	io->write_data = user_data;
-- 
1.8.3.2

