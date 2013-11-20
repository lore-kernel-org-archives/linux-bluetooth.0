Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 04/19] android/socket: Implement socket accepted event
Date: Wed, 20 Nov 2013 12:24:22 +0200
Message-Id: <1384943077-5366-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we get accepted event we create rfcomm slot and start listening
for events from Android framework and from RFCOMM real socket.
---
 android/socket.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index b8d96f9..48afd4b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -133,8 +133,74 @@ static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
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
+	guint id;
+	GIOCondition cond;
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
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_stack = g_io_channel_unix_new(rfsock_acc->fd);
+	id = g_io_add_watch(io_stack, cond, sock_stack_event_cb, rfsock_acc);
+	g_io_channel_unref(io_stack);
+
+	rfsock_acc->stack_watch = id;
+
+	/* Handle rfcomm events */
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock_acc);
+
+	rfsock_acc->rfcomm_watch = id;
+
+	DBG("rfsock %p rfsock_acc %p stack_watch %d rfcomm_watch %d",
+		rfsock, rfsock_acc, rfsock_acc->stack_watch,
+		rfsock_acc->rfcomm_watch);
 }
 
 static int handle_listen(void *buf)
-- 
1.7.10.4

