Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/6] android/socket: Handle Android events for server socket
Date: Fri, 22 Nov 2013 17:49:36 +0200
Message-Id: <1385135376-21057-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385135376-21057-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385135376-21057-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add watch for tracking events from Android framework for server socket.
---
 android/socket.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index a2996c2..890d91b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -578,6 +578,24 @@ static bool sock_send_accept(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr,
 	return true;
 }
 
+static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	struct rfcomm_sock *rfsock = data;
+
+	DBG("");
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		error("Socket error: sock %d cond %d",
+					g_io_channel_unix_get_fd(io), cond);
+		cleanup_rfsock(rfsock);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
@@ -647,7 +665,8 @@ static int handle_listen(void *buf)
 	struct profile_info *profile;
 	struct rfcomm_sock *rfsock;
 	BtIOSecLevel sec_level;
-	GIOChannel *io;
+	GIOChannel *io, *io_stack;
+	GIOCondition cond;
 	GError *err = NULL;
 	int hal_fd;
 	int chan;
@@ -690,6 +709,12 @@ static int handle_listen(void *buf)
 
 	rfsock->srv_io = io;
 
+	/* Handle events from Android */
+	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+	io_stack = g_io_channel_unix_new(rfsock->fd);
+	g_io_add_watch(io_stack, cond, sock_server_stack_event_cb, rfsock);
+	g_io_channel_unref(io_stack);
+
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
 								hal_fd);
 
-- 
1.8.3.2

