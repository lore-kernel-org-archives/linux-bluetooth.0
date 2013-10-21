Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/3] android/hal: Add initial code for sending commands
Date: Mon, 21 Oct 2013 14:56:50 +0200
Message-Id: <1382360211-3565-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382360211-3565-1-git-send-email-szymon.janc@tieto.com>
References: <1382360211-3565-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used by all HAL modules to send commands and get response
from daemon. In case of any protocol error abort.

If non-null fd pointer is passed auxiliary data with passed FD will be
received as part of response.
---
 android/hal-bluetooth.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       |   3 ++
 2 files changed, 111 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 589cb1b..3d3023f 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -23,6 +23,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <poll.h>
+#include <pthread.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
@@ -43,6 +44,113 @@ bt_callbacks_t *bt_hal_cbacks = NULL;
 static int cmd_sk = -1;
 static int notif_sk = -1;
 
+static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
+					size_t rsp_len, void *rsp, int *fd)
+{
+	ssize_t ret;
+	struct msghdr msg;
+	struct iovec iv[2];
+	struct hal_msg_hdr hal_msg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+
+	if (cmd_sk < 0)
+		return -EBADF;
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&hal_msg, 0, sizeof(hal_msg));
+
+	hal_msg.service_id = service_id;
+	hal_msg.opcode = opcode;
+	hal_msg.len = len;
+
+	iv[0].iov_base = &hal_msg;
+	iv[0].iov_len = sizeof(hal_msg);
+
+	iv[1].iov_base = param;
+	iv[1].iov_len = len;
+
+	msg.msg_iov = iv;
+	msg.msg_iovlen = 2;
+
+	pthread_mutex_lock(&cmd_sk_mutex);
+
+	ret = sendmsg(cmd_sk, &msg, 0);
+	if (ret < 0) {
+		error("Sending command failed, aborting :%s", strerror(errno));
+		pthread_mutex_unlock(&cmd_sk_mutex);
+		abort();
+	}
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&hal_msg, 0, sizeof(hal_msg));
+
+	iv[0].iov_base = &hal_msg;
+	iv[0].iov_len = sizeof(hal_msg);
+
+	iv[1].iov_base = rsp;
+	iv[1].iov_len = rsp_len;
+
+	msg.msg_iov = iv;
+	msg.msg_iovlen = 2;
+
+	if (fd) {
+		memset(cmsgbuf, 0, sizeof(cmsgbuf));
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+	}
+
+	ret = recvmsg(cmd_sk, &msg, 0);
+	if (ret < 0) {
+		error("Receiving command response failed, aborting :%s",
+							strerror(errno));
+		pthread_mutex_unlock(&cmd_sk_mutex);
+		abort();
+	}
+
+	pthread_mutex_unlock(&cmd_sk_mutex);
+
+	if (ret < (ssize_t)sizeof(hal_msg)) {
+		error("Too small response received(%zd bytes), aborting", ret);
+		abort();
+	}
+
+	if (ret != (ssize_t)(sizeof(hal_msg) + hal_msg.len)) {
+		error("Malformed response received(%zd bytes), aborting", ret);
+		abort();
+	}
+
+	if (hal_msg.opcode != opcode && hal_msg.opcode != HAL_MSG_OP_ERROR) {
+		error("Invalid opcode received (%u vs %u), aborting",
+						hal_msg.opcode, opcode);
+		abort();
+	}
+
+	if (hal_msg.opcode == HAL_MSG_OP_ERROR) {
+		struct hal_msg_rsp_error *err = rsp;
+		return -err->status;
+	}
+
+	/* Receive auxiliary data in msg */
+	if (fd) {
+		struct cmsghdr *cmsg;
+
+		*fd = -1;
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); !cmsg;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level == SOL_SOCKET
+					&& cmsg->cmsg_type == SCM_RIGHTS) {
+				memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
+				break;
+			}
+		}
+	}
+
+	return hal_msg.len;
+}
+
 static bool interface_ready(void)
 {
 	return bt_hal_cbacks != NULL;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4440fc8..a33df96 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -246,3 +246,6 @@ struct hal_msg_ev_bt_le_test_mode {
 	uint8_t  status;
 	uint16_t num_packets;
 } __attribute__((packed));
+
+int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
+					size_t rsp_len, void *rsp, int *fd);
-- 
1.8.4

