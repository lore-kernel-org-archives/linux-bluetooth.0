Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 05/19] android/socket: Implement Android RFCOMM stack events
Date: Wed, 20 Nov 2013 12:24:23 +0200
Message-Id: <1384943077-5366-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle events from Android framework. Write everything to real RFCOMM
socket. Consider splice() in the future.
---
 android/socket.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 48afd4b..49b7413 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -133,10 +133,69 @@ static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
 	return NULL;
 }
 
+static int try_write_all(int fd, unsigned char *buf, int len)
+{
+	int sent = 0;
+
+	while (len > 0) {
+		int written;
+
+		written = write(fd, buf, len);
+		if (written < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return -1;
+		}
+
+		if (!written)
+			return 0;
+
+		len -= written; buf += written; sent += written;
+	}
+
+	return sent;
+}
+
 static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
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
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		goto fail;
+	}
+
+	len = read(rfsock->fd, buf, sizeof(buf));
+	if (len <= 0) {
+		error("read(): %s", strerror(errno));
+		/* Read again */
+		return TRUE;
+	}
+
+	DBG("read %d bytes write to %d", len, rfsock->real_sock);
+
+	sent = try_write_all(rfsock->real_sock, buf, len);
+	if (sent < 0) {
+		error("write(): %s", strerror(errno));
+		goto fail;
+	}
+
+	DBG("Written %d bytes", sent);
+
 	return TRUE;
+fail:
+	connections = g_list_remove(connections, rfsock);
+	cleanup_rfsock(rfsock);
+
+	return FALSE;
 }
 
 static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
-- 
1.7.10.4

