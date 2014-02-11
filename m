Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] shared: Add support for shutdown to IO
Date: Tue, 11 Feb 2014 17:49:04 +0100
Message-Id: <1392137346-26272-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to locally shutdown IO.
---
 src/shared/io-glib.c     | 9 +++++++++
 src/shared/io-mainloop.c | 9 +++++++++
 src/shared/io.h          | 2 ++
 3 files changed, 20 insertions(+)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index a4f982d..8290745 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -320,3 +320,12 @@ done:
 
 	return true;
 }
+
+bool io_shutdown(struct io *io)
+{
+	if (!io || !io->channel)
+		return false;
+
+	return g_io_channel_shutdown(io->channel, TRUE, NULL)
+							== G_IO_STATUS_NORMAL;
+}
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 14ab128..f1e3b3b 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <unistd.h>
+#include <sys/socket.h>
 
 #include "monitor/mainloop.h"
 #include "src/shared/util.h"
@@ -294,3 +295,11 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 
 	return true;
 }
+
+bool io_shutdown(struct io *io)
+{
+	if (!io || io->fd < 0)
+		return false;
+
+	return shutdown(io->fd, SHUT_RDWR) == 0;
+}
diff --git a/src/shared/io.h b/src/shared/io.h
index 2c47e39..2106240 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -33,6 +33,8 @@ void io_destroy(struct io *io);
 int io_get_fd(struct io *io);
 bool io_set_close_on_destroy(struct io *io, bool do_close);
 
+bool io_shutdown(struct io *io);
+
 typedef bool (*io_callback_func_t)(struct io *io, void *user_data);
 
 bool io_set_read_handler(struct io *io, io_callback_func_t callback,
-- 
1.8.5.3

