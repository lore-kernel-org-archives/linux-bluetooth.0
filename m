Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] shared: Add support for disonnect handler to GLib based IO handling
Date: Tue, 11 Feb 2014 17:49:01 +0100
Message-Id: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/io-glib.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 77ba19e..a4f982d 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -40,6 +40,10 @@ struct io {
 	io_callback_func_t write_callback;
 	io_destroy_func_t write_destroy;
 	void *write_data;
+	guint disconnect_watch;
+	io_callback_func_t disconnect_callback;
+	io_destroy_func_t disconnect_destroy;
+	void *disconnect_data;
 };
 
 static struct io *io_ref(struct io *io)
@@ -258,8 +262,61 @@ done:
 	return true;
 }
 
+static void disconnect_watch_destroy(gpointer user_data)
+{
+	struct io *io = user_data;
+
+	if (io->disconnect_destroy)
+		io->disconnect_destroy(io->disconnect_data);
+
+	io->disconnect_watch = 0;
+	io->disconnect_callback = NULL;
+	io->disconnect_destroy = NULL;
+	io->disconnect_data = NULL;
+
+	io_unref(io);
+}
+
+static gboolean disconnect_callback(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct io *io = user_data;
+	bool result;
+
+	if (io->disconnect_callback)
+		result = io->disconnect_callback(io, io->disconnect_data);
+	else
+		result = false;
+
+	return result ? TRUE : FALSE;
+}
+
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
-	return false;
+	if (!io)
+		return false;
+
+	if (io->disconnect_watch > 0) {
+		g_source_remove(io->disconnect_watch);
+		io->disconnect_watch = 0;
+	}
+
+	if (!callback)
+		goto done;
+
+	io->disconnect_watch = g_io_add_watch_full(io->channel,
+				G_PRIORITY_DEFAULT,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				disconnect_callback, io_ref(io),
+				disconnect_watch_destroy);
+	if (io->disconnect_watch == 0)
+		return false;
+
+	io->disconnect_destroy = destroy;
+	io->disconnect_data = user_data;
+done:
+	io->disconnect_callback = callback;
+
+	return true;
 }
-- 
1.8.5.3

