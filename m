Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 09/16] android/hal-sock: Implement accept signal over Android fd
Date: Thu, 14 Nov 2013 17:11:48 +0200
Message-Id: <1384441915-23966-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android expects to get accept signal over file descriptor which was
set during listen HAL call.
---
 android/socket.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 01c73db..7d1ada8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -37,6 +37,7 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "ipc.h"
+#include "utils.h"
 #include "socket.h"
 
 static bdaddr_t adapter_addr;
@@ -103,6 +104,45 @@ static struct {
 	{ {0} }
 };
 
+static int bt_sock_send_fd(int sock_fd, const void *buf, int len, int send_fd)
+{
+	ssize_t ret;
+	struct msghdr msg;
+	struct cmsghdr *cmsg;
+	struct iovec iv;
+	char msgbuf[CMSG_SPACE(1)];
+
+	DBG("len %d sock_fd %d send_fd %d", len, sock_fd, send_fd);
+
+	if (sock_fd == -1 || send_fd == -1)
+		return -1;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_control = msgbuf;
+	msg.msg_controllen = sizeof(msgbuf);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(send_fd));
+	memcpy(CMSG_DATA(cmsg), &send_fd, sizeof(send_fd));
+
+	iv.iov_base = (unsigned char *) buf;
+	iv.iov_len = len;
+
+	msg.msg_iov = &iv;
+	msg.msg_iovlen = 1;
+
+	ret = sendmsg(sock_fd, &msg, MSG_NOSIGNAL);
+	if (ret < 0) {
+		error("sendmsg(): sock_fd %d send_fd %d: %s",
+					sock_fd, send_fd, strerror(errno));
+		return ret;
+	}
+
+	return ret;
+}
+
 static int get_rfcomm_default_chan(const uint8_t *uuid)
 {
 	int i;
@@ -211,6 +251,21 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 }
 
+static void sock_send_accept(struct rfcomm_slot *rfslot, bdaddr_t *bdaddr,
+							int fd_accepted)
+{
+	struct hal_sock_connect_signal cmd;
+
+	DBG("");
+
+	cmd.size = sizeof(cmd);
+	bdaddr2android(bdaddr, cmd.bdaddr);
+	cmd.channel = rfslot->channel;
+	cmd.status = 0;
+
+	bt_sock_send_fd(rfslot->fd, &cmd, sizeof(cmd), fd_accepted);
+}
+
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_slot *rfslot = user_data;
@@ -242,6 +297,8 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	rfcomm_connected_list =
 			g_list_append(rfcomm_connected_list, rfslot_acc);
 
+	sock_send_accept(rfslot, &dst, hal_fd);
+
 	/* Handle events from Android */
 	io_stack = g_io_channel_unix_new(rfslot_acc->fd);
 	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-- 
1.7.10.4

