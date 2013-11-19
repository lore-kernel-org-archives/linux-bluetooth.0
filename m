Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 06/19] android/socket: Implement RFCOMM events
Date: Tue, 19 Nov 2013 15:29:56 +0200
Message-Id: <1384867809-18135-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Copy data from RFCOMM socket to Android framework. Consider splice
in the future.
---
 android/socket.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 45f6e5c..5e77c66 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -191,6 +191,43 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
+	struct rfcomm_sock *rfsock = data;
+	unsigned char buf[1024];
+	int len, sent;
+
+	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
+		rfsock->fd, rfsock->real_sock, rfsock->channel,
+		g_io_channel_unix_get_fd(io));
+
+	if (!g_list_find(connections, rfsock)) {
+		error("rfsock %p not found in the list", rfsock);
+		return FALSE;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		connections = g_list_remove(connections, rfsock);
+		cleanup_rfsock(rfsock);
+		return FALSE;
+	}
+
+	len = read(rfsock->real_sock, buf, sizeof(buf));
+	if (len <= 0) {
+		error("read(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("read %d bytes, write to fd %d", len, rfsock->fd);
+
+	sent = try_write_all(rfsock->fd, buf, len);
+	if (sent < 0) {
+		error("write(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("Written %d bytes", sent);
+
 	return TRUE;
 }
 
-- 
1.7.10.4

