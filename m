Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/io-glib: Reduce duplicated code
Date: Thu, 13 Nov 2014 18:21:39 +0200
Message-Id: <1415895699-19124-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1415895699-19124-1-git-send-email-luiz.dentz@gmail.com>
References: <1415895699-19124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/io-glib.c | 264 ++++++++++++++++++---------------------------------
 1 file changed, 94 insertions(+), 170 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 5ebde3d..af2ba4e 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -31,21 +31,20 @@
 
 #include "src/shared/io.h"
 
+struct io_watch {
+	struct io *io;
+	guint id;
+	io_callback_func_t callback;
+	io_destroy_func_t destroy;
+	void *user_data;
+};
+
 struct io {
 	int ref_count;
 	GIOChannel *channel;
-	guint read_watch;
-	io_callback_func_t read_callback;
-	io_destroy_func_t read_destroy;
-	void *read_data;
-	guint write_watch;
-	io_callback_func_t write_callback;
-	io_destroy_func_t write_destroy;
-	void *write_data;
-	guint disconnect_watch;
-	io_callback_func_t disconnect_callback;
-	io_destroy_func_t disconnect_destroy;
-	void *disconnect_data;
+	struct io_watch *read_watch;
+	struct io_watch *write_watch;
+	struct io_watch *disconnect_watch;
 };
 
 static struct io *io_ref(struct io *io)
@@ -87,17 +86,26 @@ struct io *io_new(int fd)
 
 	g_io_channel_set_close_on_unref(io->channel, FALSE);
 
-	io->read_watch = 0;
-	io->read_callback = NULL;
-	io->read_destroy = NULL;
-	io->read_data = NULL;
+	return io_ref(io);
+}
 
-	io->write_watch = 0;
-	io->write_callback = NULL;
-	io->write_destroy = NULL;
-	io->write_data = NULL;
+static void watch_destroy(void *user_data)
+{
+	struct io_watch *watch = user_data;
+	struct io *io = watch->io;
 
-	return io_ref(io);
+	if (watch == io->read_watch)
+		io->read_watch = NULL;
+	else if (watch == io->write_watch)
+		io->write_watch = NULL;
+	else if (watch == io->disconnect_watch)
+		io->disconnect_watch = NULL;
+
+	if (watch->destroy)
+		watch->destroy(watch->user_data);
+
+	io_unref(watch->io);
+	g_free(watch);
 }
 
 void io_destroy(struct io *io)
@@ -105,19 +113,19 @@ void io_destroy(struct io *io)
 	if (!io)
 		return;
 
-	if (io->read_watch > 0) {
-		g_source_remove(io->read_watch);
-		io->read_watch = 0;
+	if (io->read_watch) {
+		g_source_remove(io->read_watch->id);
+		io->read_watch = NULL;
 	}
 
-	if (io->write_watch > 0) {
-		g_source_remove(io->write_watch);
-		io->write_watch = 0;
+	if (io->write_watch) {
+		g_source_remove(io->write_watch->id);
+		io->write_watch = NULL;
 	}
 
-	if (io->disconnect_watch > 0) {
-		g_source_remove(io->disconnect_watch);
-		io->disconnect_watch = 0;
+	if (io->disconnect_watch) {
+		g_source_remove(io->disconnect_watch->id);
+		io->disconnect_watch = NULL;
 	}
 
 	g_io_channel_unref(io->channel);
@@ -147,188 +155,104 @@ bool io_set_close_on_destroy(struct io *io, bool do_close)
 	return true;
 }
 
-static void read_watch_destroy(gpointer user_data)
-{
-	struct io *io = user_data;
-
-	if (io->read_destroy)
-		io->read_destroy(io->read_data);
-
-	io->read_watch = 0;
-	io->read_callback = NULL;
-	io->read_destroy = NULL;
-	io->read_data = NULL;
-
-	io_unref(io);
-}
-
-static gboolean read_callback(GIOChannel *channel, GIOCondition cond,
+static gboolean watch_callback(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-	struct io *io = user_data;
+	struct io_watch *watch = user_data;
 	bool result;
 
 	if (cond & (G_IO_ERR | G_IO_NVAL))
 		return FALSE;
 
-	if (io->read_callback)
-		result = io->read_callback(io, io->read_data);
+	if (watch->callback)
+		result = watch->callback(watch->io, watch->user_data);
 	else
 		result = false;
 
 	return result ? TRUE : FALSE;
 }
 
-bool io_set_read_handler(struct io *io, io_callback_func_t callback,
-				void *user_data, io_destroy_func_t destroy)
+static struct io_watch *watch_new(struct io *io, GIOCondition cond,
+				io_callback_func_t callback, void *user_data,
+				io_destroy_func_t destroy)
 {
-	if (!io)
-		return false;
+	struct io_watch *watch;
 
-	if (io->read_watch > 0) {
-		g_source_remove(io->read_watch);
-		io->read_watch = 0;
-	}
-
-	if (!callback)
-		goto done;
-
-	io->read_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
-						G_IO_IN | G_IO_ERR | G_IO_NVAL,
-						read_callback, io_ref(io),
-						read_watch_destroy);
-	if (io->read_watch == 0)
-		return false;
-
-	io->read_destroy = destroy;
-	io->read_data = user_data;
-
-done:
-	io->read_callback = callback;
-
-	return true;
-}
-
-static void write_watch_destroy(gpointer user_data)
-{
-	struct io *io = user_data;
-
-	if (io->write_destroy)
-		io->write_destroy(io->write_data);
+	watch = g_try_new0(struct io_watch, 1);
+	if (!watch)
+		return NULL;
 
-	io->write_watch = 0;
-	io->write_callback = NULL;
-	io->write_destroy = NULL;
-	io->write_data = NULL;
+	watch->io = io_ref(io);
+	watch->callback = callback;
+	watch->destroy = destroy;
+	watch->user_data = user_data;
+
+	watch->id = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
+						cond | G_IO_ERR | G_IO_NVAL,
+						watch_callback, watch,
+						watch_destroy);
+	if (watch->id == 0) {
+		watch_destroy(watch);
+		return NULL;
+	}
 
-	io_unref(io);
+	return watch;
 }
 
-static gboolean write_callback(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static bool io_set_handler(struct io *io, GIOCondition cond,
+				io_callback_func_t callback, void *user_data,
+				io_destroy_func_t destroy)
 {
-	struct io *io = user_data;
-	bool result;
-
-	if (cond & (G_IO_ERR | G_IO_NVAL))
-		return FALSE;
-
-	if (io->write_callback)
-		result = io->write_callback(io, io->write_data);
-	else
-		result = false;
+	struct io_watch **watch;
 
-	return result ? TRUE : FALSE;
-}
-
-bool io_set_write_handler(struct io *io, io_callback_func_t callback,
-				void *user_data, io_destroy_func_t destroy)
-{
 	if (!io)
 		return false;
 
-	if (io->write_watch > 0) {
-		g_source_remove(io->write_watch);
-		io->write_watch = 0;
+	switch (cond) {
+	case G_IO_IN:
+		watch = &io->read_watch;
+		break;
+	case G_IO_OUT:
+		watch = &io->write_watch;
+		break;
+	case G_IO_HUP:
+		watch = &io->disconnect_watch;
+		break;
+	default:
+		return false;
+	}
+
+	if (*watch) {
+		g_source_remove((*watch)->id);
+		*watch = NULL;
 	}
 
 	if (!callback)
-		goto done;
+		return true;
 
-	io->write_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
-						G_IO_OUT | G_IO_ERR | G_IO_NVAL,
-						write_callback, io_ref(io),
-						write_watch_destroy);
-	if (io->write_watch == 0)
+	*watch = watch_new(io, cond, callback, user_data, destroy);
+	if (!*watch)
 		return false;
 
-	io->write_destroy = destroy;
-	io->write_data = user_data;
-
-done:
-	io->write_callback = callback;
-
 	return true;
 }
 
-static void disconnect_watch_destroy(gpointer user_data)
+bool io_set_read_handler(struct io *io, io_callback_func_t callback,
+				void *user_data, io_destroy_func_t destroy)
 {
-	struct io *io = user_data;
-
-	if (io->disconnect_destroy)
-		io->disconnect_destroy(io->disconnect_data);
-
-	io->disconnect_watch = 0;
-	io->disconnect_callback = NULL;
-	io->disconnect_destroy = NULL;
-	io->disconnect_data = NULL;
-
-	io_unref(io);
+	return io_set_handler(io, G_IO_IN, callback, user_data, destroy);
 }
 
-static gboolean disconnect_callback(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+bool io_set_write_handler(struct io *io, io_callback_func_t callback,
+				void *user_data, io_destroy_func_t destroy)
 {
-	struct io *io = user_data;
-	bool result;
-
-	if (io->disconnect_callback)
-		result = io->disconnect_callback(io, io->disconnect_data);
-	else
-		result = false;
-
-	return result ? TRUE : FALSE;
+	return io_set_handler(io, G_IO_OUT, callback, user_data, destroy);
 }
 
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
-	if (!io)
-		return false;
-
-	if (io->disconnect_watch > 0) {
-		g_source_remove(io->disconnect_watch);
-		io->disconnect_watch = 0;
-	}
-
-	if (!callback)
-		goto done;
-
-	io->disconnect_watch = g_io_add_watch_full(io->channel,
-						G_PRIORITY_DEFAULT,
-						G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						disconnect_callback, io_ref(io),
-						disconnect_watch_destroy);
-	if (io->disconnect_watch == 0)
-		return false;
-
-	io->disconnect_destroy = destroy;
-	io->disconnect_data = user_data;
-
-done:
-	io->disconnect_callback = callback;
-
-	return true;
+	return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
 }
 
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
-- 
1.9.3

