Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 05/17] android/socket: Implement socket accepted event
Date: Mon, 18 Nov 2013 15:20:42 +0200
Message-Id: <1384780854-20970-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we get accepted event we create rfcomm slot and start listening
for events from Android framework and from RFCOMM real socket.
---
 android/socket.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 0731bd9..12c3687 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -119,8 +119,59 @@ static int get_rfcomm_default_chan(const uint8_t *uuid)
 	return -ENOENT;
 }
 
+static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	return TRUE;
+}
+
+static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	return TRUE;
+}
+
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
+	struct rfcomm_sock *rfsock = user_data;
+	struct rfcomm_sock *rfsock_acc;
+	GIOChannel *io_stack;
+	bdaddr_t dst;
+	char address[18];
+	int sock_acc;
+	int hal_fd = -1;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s rfsock %p", address, rfsock);
+
+	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
+		rfsock->fd, rfsock->real_sock, rfsock->channel,
+		g_io_channel_unix_get_fd(io));
+
+	sock_acc = g_io_channel_unix_get_fd(io);
+	rfsock_acc = create_rfsock(sock_acc, &hal_fd);
+	connections = g_list_append(connections, rfsock_acc);
+
+	/* Handle events from Android */
+	io_stack = g_io_channel_unix_new(rfsock_acc->fd);
+	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					sock_stack_event_cb, rfsock_acc);
+	g_io_channel_unref(io_stack);
+
+	/* Handle rfcomm events */
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sock_rfcomm_event_cb, rfsock_acc);
+
+	DBG("rfsock %p rfsock_acc %p", rfsock, rfsock_acc);
 }
 
 static int handle_listen(void *buf)
-- 
1.7.10.4

