Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 11/19] android/socket: Implement HAL connect call
Date: Tue, 19 Nov 2013 15:30:01 +0200
Message-Id: <1384867809-18135-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

HAL connect uses similar event handlers like listen call.
---
 android/socket.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 6d9c69e..ad09a2c 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -395,6 +395,47 @@ static int handle_listen(void *buf)
 
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
+	struct rfcomm_sock *rfsock = user_data;
+	GIOChannel *io_stack;
+	GError *gerr = NULL;
+	bdaddr_t dst;
+	char address[18];
+	int chan = -1;
+
+	if (err) {
+		error("%s", err->message);
+		goto fail;
+	}
+
+	bt_io_get(io, &gerr,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
+	ba2str(&dst, address);
+	DBG("Connected to %s rfsock %p chan %d", address, rfsock, chan);
+
+	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
+		rfsock->fd, rfsock->real_sock, rfsock->channel,
+		g_io_channel_unix_get_fd(io));
+
+	/* Handle events from Android */
+	io_stack = g_io_channel_unix_new(rfsock->fd);
+	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						sock_stack_event_cb, rfsock);
+	g_io_channel_unref(io_stack);
+
+	/* Handle rfcomm events */
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sock_rfcomm_event_cb, rfsock);
+
+	return;
+fail:
+	cleanup_rfsock(rfsock);
 }
 
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
-- 
1.7.10.4

