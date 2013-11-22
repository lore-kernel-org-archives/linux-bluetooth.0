Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv7 02/14] android/socket: Implement HAL connect call
Date: Fri, 22 Nov 2013 10:34:43 +0200
Message-Id: <1385109295-11445-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

HAL connect uses similar event handlers like listen call.
---
 android/socket.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 59cba67..37864e5 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -426,6 +426,42 @@ static int handle_listen(void *buf)
 
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
+	struct rfcomm_sock *rfsock = user_data;
+	bdaddr_t *dst = &rfsock->dst;
+	GIOChannel *io_stack;
+	char address[18];
+	guint id;
+	GIOCondition cond;
+
+	if (err) {
+		error("%s", err->message);
+		goto fail;
+	}
+
+	ba2str(dst, address);
+	DBG("Connected to %s", address);
+
+	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
+		rfsock->fd, rfsock->real_sock, rfsock->channel,
+		g_io_channel_unix_get_fd(io));
+
+	/* Handle events from Android */
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_stack = g_io_channel_unix_new(rfsock->fd);
+	id = g_io_add_watch(io_stack, cond, sock_stack_event_cb, rfsock);
+	g_io_channel_unref(io_stack);
+
+	rfsock->stack_watch = id;
+
+	/* Handle rfcomm events */
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock);
+
+	rfsock->rfcomm_watch = id;
+
+	return;
+fail:
+	cleanup_rfsock(rfsock);
 }
 
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
-- 
1.8.3.2

