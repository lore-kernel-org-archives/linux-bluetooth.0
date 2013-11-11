Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 8/9] android/hal-sock: Implement accept signal over Android fd
Date: Mon, 11 Nov 2013 16:03:46 +0200
Message-Id: <1384178627-25991-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android expects to get accept signal over file descriptor which was
set during listen HAL call.
---
 android/socket.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index a962cdc..20f4e38 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -36,6 +36,7 @@
 #include "hal-ipc.h"
 #include "ipc.h"
 #include "adapter.h"
+#include "utils.h"
 #include "socket.h"
 
 /* Simple list of RFCOMM server sockets */
@@ -68,6 +69,45 @@ static struct rfcomm_slot *create_rfslot(int sock)
 	return rfslot;
 }
 
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
 static const uint8_t UUID_PBAP[] = {
 	0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
 	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
@@ -161,6 +201,21 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 }
 
+static void socket_send_accept(struct rfcomm_slot *rfslot, bdaddr_t *bdaddr,
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
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_slot *rfslot = user_data;
@@ -190,6 +245,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	rfslot_acc = create_rfslot(sock_acc);
 	rfcomm_accepted_list = g_list_append(rfcomm_accepted_list, rfslot_acc);
 
+	socket_send_accept(rfslot, &dst, rfslot_acc->hal_fd);
+
 	/* Handle events from Android */
 	io_stack = g_io_channel_unix_new(rfslot_acc->fd);
 	g_io_add_watch(io_stack, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-- 
1.7.10.4

