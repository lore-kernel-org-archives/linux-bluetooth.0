Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 13/19] android/socket: Send connect signal to Android framework
Date: Wed, 20 Nov 2013 12:24:31 +0200
Message-Id: <1384943077-5366-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android framework expects connect signal to be sent when
remote device is connected.
---
 android/socket.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 1d16bc7..d8e922d 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -424,6 +424,33 @@ static int handle_listen(void *buf)
 	return hal_fd;
 }
 
+static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
+{
+	struct hal_sock_connect_signal cmd;
+	int len;
+
+	DBG("");
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.size = sizeof(cmd);
+	bdaddr2android(bdaddr, cmd.bdaddr);
+	cmd.channel = rfsock->channel;
+	cmd.status = 0;
+
+	len = write(rfsock->fd, &cmd, sizeof(cmd));
+	if (len < 0) {
+		error("%s", strerror(errno));
+		return false;
+	}
+
+	if (len != sizeof(cmd)) {
+		error("Error sending connect signal");
+		false;
+	}
+
+	return true;
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
@@ -456,6 +483,9 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		rfsock->fd, rfsock->real_sock, rfsock->channel,
 		g_io_channel_unix_get_fd(io));
 
+	if (!sock_send_connect(rfsock, &dst))
+		goto fail;
+
 	/* Handle events from Android */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_stack = g_io_channel_unix_new(rfsock->fd);
-- 
1.7.10.4

