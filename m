Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 6/9] android/hal-sock: Implement Android RFCOMM stack events
Date: Mon, 11 Nov 2013 14:37:15 +0200
Message-Id: <1384173438-21708-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle events from Android framework. Write everything to real RFCOMM
socket.
---
 android/socket.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 0ee53ba..dfad9da 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -94,6 +94,35 @@ static int get_rfcomm_chan(const uint8_t *uuid)
 static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
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
+	/* FIXME check fd vs sock(io) */
+	len = recv(rfslot->fd, buf, sizeof(buf), 0);
+	if (len <= 0) {
+		error("recv(): %s", strerror(errno));
+		return FALSE;
+	}
+
+	DBG("read %d bytes write to %d", len, rfslot->real_sock);
+
+	if (send(rfslot->real_sock, buf, len, 0) < 0) {
+		error("send(): %s", strerror(errno));
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
-- 
1.7.10.4

