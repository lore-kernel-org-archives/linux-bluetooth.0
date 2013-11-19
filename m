Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 04/19] android/socket: Implement socket accepted event
Date: Tue, 19 Nov 2013 15:29:54 +0200
Message-Id: <1384867809-18135-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we get accepted event we create rfcomm slot and start listening
for events from Android framework and from RFCOMM real socket.
---
 android/socket.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 9e9acc9..04f0a7b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -122,8 +122,66 @@ static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
 	return NULL;
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
+	GError *gerr = NULL;
+	bdaddr_t dst;
+	char address[18];
+	int sock_acc;
+	int hal_fd;
+
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(io, &gerr,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s rfsock %p", address, rfsock);
+
+	sock_acc = g_io_channel_unix_get_fd(io);
+	rfsock_acc = create_rfsock(sock_acc, &hal_fd);
+	connections = g_list_append(connections, rfsock_acc);
+
+	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
+		rfsock->fd, rfsock->real_sock, rfsock->channel,
+		sock_acc);
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

