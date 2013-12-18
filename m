Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/socket: Handle Android events for server socket
Date: Wed, 18 Dec 2013 17:15:17 +0200
Message-Id: <1387379717-1457-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add watch for tracking events from Android framework for server socket.
Android might want to close server connection, in this case we close
our listening socket and cleaning up rfsock structure. Glib watch is
added with high priority to avoid races.
---
 android/socket.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 7bc5b0b..de98ae4 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -622,6 +622,24 @@ static bool sock_send_accept(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr,
 	return true;
 }
 
+static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	struct rfcomm_sock *rfsock = data;
+
+	DBG("sock %d cond %d", g_io_channel_unix_get_fd(io), cond);
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_ERR | G_IO_HUP )) {
+		servers = g_list_remove(servers, rfsock);
+		cleanup_rfsock(rfsock);
+	}
+
+	return FALSE;
+}
+
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
@@ -697,10 +715,12 @@ static void handle_listen(const void *buf, uint16_t len)
 	const struct profile_info *profile;
 	struct rfcomm_sock *rfsock = NULL;
 	BtIOSecLevel sec_level;
-	GIOChannel *io;
+	GIOChannel *io, *io_stack;
+	GIOCondition cond;
 	GError *err = NULL;
 	int hal_fd = -1;
 	int chan;
+	guint id;
 
 	DBG("");
 
@@ -738,6 +758,16 @@ static void handle_listen(const void *buf, uint16_t len)
 	g_io_channel_set_close_on_unref(io, FALSE);
 	g_io_channel_unref(io);
 
+	/* Handle events from Android */
+	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_stack = g_io_channel_unix_new(rfsock->fd);
+	id = g_io_add_watch_full(io_stack, G_PRIORITY_HIGH, cond,
+					sock_server_stack_event_cb, rfsock,
+					NULL);
+	g_io_channel_unref(io_stack);
+
+	rfsock->stack_watch = id;
+
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
 								hal_fd);
 
-- 
1.8.3.2

