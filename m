Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] shared/io: Do not return -1
Date: Mon, 29 Sep 2014 17:57:39 +0300
Message-Id: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Returning -1 normally is used when errno is set which is not case so
instead return -ENOTCONN.
---
 src/shared/io-glib.c     | 4 +++-
 src/shared/io-mainloop.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 6316037..882ebd6 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include <glib.h>
 
 #include "src/shared/io.h"
@@ -122,7 +124,7 @@ void io_destroy(struct io *io)
 int io_get_fd(struct io *io)
 {
 	if (!io)
-		return -1;
+		return -ENOTCONN;
 
 	return g_io_channel_unix_get_fd(io->channel);
 }
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 1563ce5..b7e0f5f 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <unistd.h>
+#include <errno.h>
 #include <sys/socket.h>
 
 #include "monitor/mainloop.h"
@@ -192,7 +193,7 @@ void io_destroy(struct io *io)
 int io_get_fd(struct io *io)
 {
 	if (!io)
-		return -1;
+		return -ENOTCONN;
 
 	return io->fd;
 }
-- 
1.9.3

