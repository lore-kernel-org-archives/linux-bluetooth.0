Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 03/19] android/socket: Define structs and implement listen
Date: Tue, 19 Nov 2013 15:29:53 +0200
Message-Id: <1384867809-18135-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This defines structures for socket HAL. We need to emulate Android
sockets by sending connect/accept signals over file descriptor.
Handle HAL socket listen call. Create RFCOMM socket and wait for events.
---
 android/socket.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index d4c7674..9e9acc9 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,6 +27,7 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include "lib/bluetooth.h"
@@ -43,6 +44,50 @@
 
 static bdaddr_t adapter_addr;
 
+/* Simple list of RFCOMM server sockets */
+GList *servers = NULL;
+
+/* Simple list of RFCOMM connected sockets */
+GList *connections = NULL;
+
+struct rfcomm_sock {
+	int fd;		/* descriptor for communication with Java framework */
+	int real_sock;	/* real RFCOMM socket */
+	int channel;	/* RFCOMM channel */
+};
+
+static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
+{
+	int fds[2] = {-1, -1};
+	struct rfcomm_sock *rfsock;
+
+	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
+		error("socketpair(): %s", strerror(errno));
+		*hal_fd = -1;
+		return NULL;
+	}
+
+	rfsock = g_new0(struct rfcomm_sock, 1);
+	rfsock->fd = fds[0];
+	*hal_fd = fds[1];
+	rfsock->real_sock = sock;
+
+	return rfsock;
+}
+
+static void cleanup_rfsock(struct rfcomm_sock *rfsock)
+{
+	DBG("rfsock: %p fd %d real_sock %d chan %u",
+		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
+
+	if (rfsock->fd > 0)
+		close(rfsock->fd);
+	if (rfsock->real_sock > 0)
+		close(rfsock->real_sock);
+
+	g_free(rfsock);
+}
+
 static struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
@@ -77,10 +122,18 @@ static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
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
+	struct rfcomm_sock *rfsock;
+	GIOChannel *io;
+	GError *err = NULL;
+	int hal_fd;
 	int chan;
 
 	DBG("");
@@ -93,7 +146,28 @@ static int handle_listen(void *buf)
 
 	DBG("rfcomm channel %d", chan);
 
-	return -1;
+	rfsock = create_rfsock(-1, &hal_fd);
+	if (!rfsock)
+		return -1;
+
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
+	DBG("real_sock %d fd %d hal_fd %d",
+				rfsock->real_sock, rfsock->fd, hal_fd);
+
+	return hal_fd;
 }
 
 static int handle_connect(void *buf)
-- 
1.7.10.4

