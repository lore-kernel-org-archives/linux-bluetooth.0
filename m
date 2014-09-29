Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] shared/io: Add io_send
Date: Mon, 29 Sep 2014 17:57:40 +0300
Message-Id: <1412002664-28253-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
References: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/io-glib.c     | 20 ++++++++++++++++++++
 src/shared/io-mainloop.c | 17 +++++++++++++++++
 src/shared/io.h          |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 882ebd6..a2ada66 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -326,6 +326,26 @@ done:
 	return true;
 }
 
+ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+{
+	int fd;
+	ssize_t ret;
+
+	if (!io || !io->channel)
+		return -ENOTCONN;
+
+	fd = io_get_fd(io);
+
+	do {
+		ret = writev(fd, iov, iovcnt);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
 bool io_shutdown(struct io *io)
 {
 	if (!io || !io->channel)
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index b7e0f5f..7f80d8f 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -301,6 +301,23 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return true;
 }
 
+ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+{
+	ssize_t ret;
+
+	if (!io || io->fd < 0)
+		return -ENOTCONN;
+
+	do {
+		ret = writev(io->fd, iov, iovcnt);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
 bool io_shutdown(struct io *io)
 {
 	if (!io || io->fd < 0)
diff --git a/src/shared/io.h b/src/shared/io.h
index 8897964..8bc1111 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -22,6 +22,7 @@
  */
 
 #include <stdbool.h>
+#include <sys/uio.h>
 
 typedef void (*io_destroy_func_t)(void *data);
 
@@ -33,6 +34,7 @@ void io_destroy(struct io *io);
 int io_get_fd(struct io *io);
 bool io_set_close_on_destroy(struct io *io, bool do_close);
 
+ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt);
 bool io_shutdown(struct io *io);
 
 typedef bool (*io_callback_func_t)(struct io *io, void *user_data);
-- 
1.9.3

