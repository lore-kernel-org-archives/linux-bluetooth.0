Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 7/9] android/hal-sock: Implement RFCOMM events
Date: Mon, 11 Nov 2013 16:03:45 +0200
Message-Id: <1384178627-25991-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Copy data from RFCOMM socket to Android framework.
---
 android/socket.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index dfad9da..a962cdc 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -129,6 +129,35 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
+	struct rfcomm_slot *rfslot = data;
+	unsigned char buf[1024] = { 0 };
+	int len;
+
+	DBG("rfslot: fd %d hal_fd %d real_sock %d chan %u sock %d",
+		rfslot->fd, rfslot->hal_fd, rfslot->real_sock, rfslot->channel,
+		g_io_channel_unix_get_fd(io));
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return FALSE;
+	}
+
+	/* FIXME check real_sock vs sock(io) */
+	len = recv(rfslot->real_sock, buf, sizeof(buf), 0);
+	if (len <= 0) {
+		error("recv(): %s sock %d", strerror(errno), rfslot->real_sock);
+		return FALSE;
+	}
+
+	DBG("read %d bytes, write to fd %d", len, rfslot->fd);
+
+	if (send(rfslot->fd, buf, len, MSG_DONTWAIT) < 0) {
+		error("send(): %s sock %d", strerror(errno), rfslot->fd);
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
-- 
1.7.10.4

