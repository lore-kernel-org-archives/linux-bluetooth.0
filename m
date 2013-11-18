Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/16] android/socket: Implement HAL connect call
Date: Mon, 18 Nov 2013 10:26:15 +0200
Message-Id: <1384763179-2218-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

HAL connect uses similar event handlers like listen call.
---
 android/socket.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index dde000d..063681e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -377,8 +377,49 @@ static int handle_listen(void *buf)
 	return hal_fd;
 }
 
-static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+static void connect_cb(GIOChannel *io, GError *conn_err, gpointer user_data)
 {
+	struct rfcomm_slot *rfslot = user_data;
+	GIOChannel *io_stack;
+	GError *io_err = NULL;
+	bdaddr_t dst;
+	char address[18];
+	int chan = -1;
+
+	bt_io_get(io, &io_err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (io_err) {
+		error("%s", io_err->message);
+		g_error_free(io_err);
+		goto fail;
+	}
+
+	if (conn_err) {
+		error("%s", conn_err->message);
+		goto fail;
+	}
+
+	ba2str(&dst, address);
+	DBG("Connected to %s rfslot %p chan %d", address, rfslot, chan);
+
+	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
+		rfslot->fd, rfslot->real_sock, rfslot->channel,
+		g_io_channel_unix_get_fd(io));
+
+	/* Handle events from Android */
+	io_stack = g_io_channel_unix_new(rfslot->fd);
+	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						sock_stack_event_cb, rfslot);
+	g_io_channel_unref(io_stack);
+
+	/* Handle rfcomm events */
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sock_rfcomm_event_cb, rfslot);
+
+	return;
+fail:
+	cleanup_rfslot(rfslot);
 }
 
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
-- 
1.7.10.4

