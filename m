Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 03/19] android/socket: Implement listen on RFCOMM socket
Date: Wed, 20 Nov 2013 12:24:21 +0200
Message-Id: <1384943077-5366-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle HAL socket listen call. Create RFCOMM socket and wait for events.
---
 android/socket.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index e19b2aa..b8d96f9 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -133,11 +133,17 @@ static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
 	return NULL;
 }
 
+static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+}
+
 static int handle_listen(void *buf)
 {
 	struct hal_cmd_sock_listen *cmd = buf;
 	struct profile_info *profile;
 	struct rfcomm_sock *rfsock;
+	GIOChannel *io;
+	GError *err = NULL;
 	int hal_fd;
 	int chan;
 
@@ -155,6 +161,27 @@ static int handle_listen(void *buf)
 	if (!rfsock)
 		return -1;
 
+	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_CHANNEL, chan,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("Failed listen: %s", err->message);
+		g_error_free(err);
+		cleanup_rfsock(rfsock);
+		return -1;
+	}
+
+	rfsock->real_sock = g_io_channel_unix_get_fd(io);
+	servers = g_list_append(servers, rfsock);
+
+	/* TODO: Add server watch */
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_unref(io);
+
+	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
+								hal_fd);
+
 	return hal_fd;
 }
 
-- 
1.7.10.4

