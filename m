Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 07/19] android/socket: Send accept signal to Android framework
Date: Wed, 20 Nov 2013 12:24:25 +0200
Message-Id: <1384943077-5366-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android expects to get accept signal over file descriptor which was
set during listen HAL call.
---
 android/socket.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 3e738a4..5901d45 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -37,6 +37,7 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "ipc.h"
+#include "utils.h"
 #include "socket.h"
 
 #define OPP_DEFAULT_CHANNEL	9
@@ -121,6 +122,45 @@ static struct profile_info {
 	}
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
 static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
 {
 	unsigned int i;
@@ -240,6 +280,28 @@ fail:
 	return FALSE;
 }
 
+static bool sock_send_accept(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr,
+							int fd_accepted)
+{
+	struct hal_sock_connect_signal cmd;
+	int len;
+
+	DBG("");
+
+	cmd.size = sizeof(cmd);
+	bdaddr2android(bdaddr, cmd.bdaddr);
+	cmd.channel = rfsock->channel;
+	cmd.status = 0;
+
+	len = bt_sock_send_fd(rfsock->fd, &cmd, sizeof(cmd), fd_accepted);
+	if (len != sizeof(cmd)) {
+		error("Error sending accept signal");
+		return false;
+	}
+
+	return true;
+}
+
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
@@ -279,6 +341,11 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		rfsock->fd, rfsock->real_sock, rfsock->channel,
 		sock_acc);
 
+	if (!sock_send_accept(rfsock, &dst, hal_fd)) {
+		cleanup_rfsock(rfsock_acc);
+		return;
+	}
+
 	/* Handle events from Android */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_stack = g_io_channel_unix_new(rfsock_acc->fd);
-- 
1.7.10.4

