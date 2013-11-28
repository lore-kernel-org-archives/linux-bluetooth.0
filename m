Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] android/socket: Strip extra log messages
Date: Thu, 28 Nov 2013 16:38:04 +0200
Message-Id: <1385649486-19978-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove debug messages when sending data, debug still exist for connection
establishment. Do not print error when connection hang up, print debug
instead.
---
 android/socket.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 3f07dc6..45ff90e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -488,11 +488,12 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 	unsigned char buf[1024];
 	int len, sent;
 
-	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
-		rfsock->fd, rfsock->real_sock, rfsock->channel,
-		g_io_channel_unix_get_fd(io));
+	if (cond & G_IO_HUP) {
+		DBG("Socket %d hang up", g_io_channel_unix_get_fd(io));
+		goto fail;
+	}
 
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+	if (cond & (G_IO_ERR | G_IO_NVAL)) {
 		error("Socket error: sock %d cond %d",
 					g_io_channel_unix_get_fd(io), cond);
 		goto fail;
@@ -505,16 +506,12 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	}
 
-	DBG("read %d bytes write to %d", len, rfsock->real_sock);
-
 	sent = try_write_all(rfsock->real_sock, buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
 	}
 
-	DBG("Written %d bytes", sent);
-
 	return TRUE;
 fail:
 	connections = g_list_remove(connections, rfsock);
@@ -530,11 +527,12 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 	unsigned char buf[1024];
 	int len, sent;
 
-	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
-		rfsock->fd, rfsock->real_sock, rfsock->channel,
-		g_io_channel_unix_get_fd(io));
+	if (cond & G_IO_HUP) {
+		DBG("Socket %d hang up", g_io_channel_unix_get_fd(io));
+		goto fail;
+	}
 
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+	if (cond & (G_IO_ERR | G_IO_NVAL)) {
 		error("Socket error: sock %d cond %d",
 					g_io_channel_unix_get_fd(io), cond);
 		goto fail;
@@ -547,16 +545,12 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	}
 
-	DBG("read %d bytes, write to fd %d", len, rfsock->fd);
-
 	sent = try_write_all(rfsock->fd, buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
 	}
 
-	DBG("Written %d bytes", sent);
-
 	return TRUE;
 fail:
 	connections = g_list_remove(connections, rfsock);
-- 
1.8.3.2

