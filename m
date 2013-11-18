Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 04/17] android/socket: Define structs and implement listen
Date: Mon, 18 Nov 2013 15:20:41 +0200
Message-Id: <1384780854-20970-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This defines structures for socket HAL. We need to emulate Android
sockets by sending connect/accept signals over file descriptor.
Handle HAL socket listen call. Create RFCOMM socket and wait for events.
---
 android/socket.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 9c94c03..0731bd9 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,8 +27,12 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
+#include "btio/btio.h"
+#include "lib/sdp.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
@@ -40,6 +44,50 @@
 
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
 static struct {
 	uint8_t uuid[16];
 	uint8_t channel;
@@ -71,8 +119,16 @@ static int get_rfcomm_default_chan(const uint8_t *uuid)
 	return -ENOENT;
 }
 
+static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+}
+
 static int handle_listen(void *buf)
 {
+	struct hal_cmd_sock_listen *cmd = buf;
+	struct rfcomm_sock *rfsock;
+	GIOChannel *io;
+	GError *err = NULL;
 	int hal_fd;
 	int chan;
 
@@ -82,6 +138,29 @@ static int handle_listen(void *buf)
 	if (chan < 0)
 		return chan;
 
+	DBG("rfcomm channel %d", chan);
+
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
 	return hal_fd;
 }
 
-- 
1.7.10.4

