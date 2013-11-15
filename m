Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 05/16] android/hal-sock: Implement socket accepted event
Date: Fri, 15 Nov 2013 16:37:47 +0200
Message-Id: <1384526278-26260-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we get accepted event we create rfcomm slot and start listening
for events from Android framework and from RFCOMM real socket.
---
 android/socket.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 276c78c..c9ee32f 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -115,8 +115,60 @@ static int get_rfcomm_default_chan(const uint8_t *uuid)
 	return -1;
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
+	struct rfcomm_slot *rfslot = user_data;
+	struct rfcomm_slot *rfslot_acc;
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
+	DBG("Incoming connection from %s rfslot %p", address, rfslot);
+
+	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
+		rfslot->fd, rfslot->real_sock, rfslot->channel,
+		g_io_channel_unix_get_fd(io));
+
+	sock_acc = g_io_channel_unix_get_fd(io);
+	rfslot_acc = create_rfslot(sock_acc, &hal_fd);
+	rfcomm_connected_list =
+			g_list_append(rfcomm_connected_list, rfslot_acc);
+
+	/* Handle events from Android */
+	io_stack = g_io_channel_unix_new(rfslot_acc->fd);
+	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					sock_stack_event_cb, rfslot_acc);
+	g_io_channel_unref(io_stack);
+
+	/* Handle rfcomm events */
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sock_rfcomm_event_cb, rfslot_acc);
+
+	DBG("rfslot %p rfslot_acc %p", rfslot, rfslot_acc);
 }
 
 static int handle_listen(void *buf)
-- 
1.7.10.4

