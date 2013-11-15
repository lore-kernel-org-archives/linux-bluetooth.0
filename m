Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/16] android/hal-sock: Implement Android RFCOMM stack events
Date: Fri, 15 Nov 2013 16:37:48 +0200
Message-Id: <1384526278-26260-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle events from Android framework. Write everything to real RFCOMM
socket. Consider splice() in the future.
---
 android/socket.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index c9ee32f..af14ef6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -115,9 +115,66 @@ static int get_rfcomm_default_chan(const uint8_t *uuid)
 	return -1;
 }
 
+static inline int write_n(int fd, unsigned char *buf, int len)
+{
+	int t = 0, w;
+
+	while (len > 0) {
+		if ((w = write(fd, buf, len)) < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return -1;
+		}
+
+		if (!w)
+			return 0;
+
+		len -= w; buf += w; t += w;
+	}
+
+	return t;
+}
+
 static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
+	struct rfcomm_slot *rfslot = data;
+	unsigned char buf[1024];
+	int len, sent;
+
+	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
+		rfslot->fd, rfslot->real_sock, rfslot->channel,
+		g_io_channel_unix_get_fd(io));
+
+	if (!g_list_find(rfcomm_connected_list, rfslot)) {
+		error("rfslot %p not found in the list", rfslot);
+		return FALSE;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		rfcomm_connected_list = g_list_remove(rfcomm_connected_list,
+								rfslot);
+		cleanup_rfslot(rfslot);
+		return FALSE;
+	}
+
+	len = recv(rfslot->fd, buf, sizeof(buf), 0);
+	if (len <= 0) {
+		error("recv(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("read %d bytes write to %d", len, rfslot->real_sock);
+
+	if ((sent = write_n(rfslot->real_sock, buf, len)) < 0) {
+		error("send(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("Written %d bytes", sent);
+
 	return TRUE;
 }
 
-- 
1.7.10.4

