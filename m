Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/hal: Add initial code for notification handling
Date: Tue, 22 Oct 2013 12:59:08 +0200
Message-Id: <1382439549-18281-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a dedicated thread that will read from notification sockets
and dispatch it to appropriate service notification function.
---
 Makefile.android  |   2 +
 android/hal-ipc.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/Makefile.android b/Makefile.android
index aebc715..889b36e 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -54,6 +54,8 @@ android_haltest_LDADD = android/libhal-internal.la
 
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
+android_haltest_LDFLAGS = -pthread
+
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c android/device.c \
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 8d40271..ef58a7c 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -39,6 +39,95 @@ static int notif_sk = -1;
 
 static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+static pthread_t notif_th = 0;
+
+static void notification_dispatch(struct hal_msg_hdr *msg, int fd)
+{
+	switch (msg->service_id) {
+	default:
+		DBG("Unhandled notification service=%d opcode=0x%x",
+						msg->service_id, msg->opcode);
+		break;
+	}
+}
+
+static void *notification_handler(void *data)
+{
+	struct msghdr msg;
+	struct iovec iv;
+	struct cmsghdr *cmsg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_msg_hdr *hal_msg = (void *) buf;
+	ssize_t ret;
+	int fd;
+
+	while (true) {
+		memset(&msg, 0, sizeof(msg));
+		memset(buf, 0, sizeof(buf));
+		memset(cmsgbuf, 0, sizeof(cmsgbuf));
+
+		iv.iov_base = hal_msg;
+		iv.iov_len = sizeof(buf);
+
+		msg.msg_iov = &iv;
+		msg.msg_iovlen = 1;
+
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+
+		ret = recvmsg(notif_sk, &msg, 0);
+		if (ret < 0) {
+			error("Receiving notifications failed, aborting :%s",
+							strerror(errno));
+			exit(EXIT_FAILURE);
+		}
+
+		/* socket was shutdown */
+		if (ret == 0)
+			break;
+
+		if (ret < (ssize_t) sizeof(*hal_msg)) {
+			error("Too small notification (%zd bytes), aborting",
+									ret);
+			exit(EXIT_FAILURE);
+		}
+
+		if (hal_msg->opcode < HAL_MSG_EV_BT_ERROR) {
+			error("Invalid notification (0x%x), aborting",
+							hal_msg->opcode);
+			exit(EXIT_FAILURE);
+		}
+
+		if (ret != (ssize_t) (sizeof(*hal_msg) + hal_msg->len)) {
+			error("Malformed notification(%zd bytes), aborting",
+									ret);
+			exit(EXIT_FAILURE);
+		}
+
+		fd = -1;
+
+		/* Receive auxiliary data in msg */
+		for (cmsg = CMSG_FIRSTHDR(&msg); !cmsg;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level == SOL_SOCKET
+					&& cmsg->cmsg_type == SCM_RIGHTS) {
+				memcpy(&fd, CMSG_DATA(cmsg), sizeof(int));
+				break;
+			}
+		}
+
+		notification_dispatch(hal_msg, fd);
+	}
+
+	close(notif_sk);
+	notif_sk = -1;
+
+	DBG("exit");
+
+	return NULL;
+}
+
 static int accept_connection(int sk)
 {
 	int err;
@@ -126,6 +215,18 @@ bool hal_ipc_init(void)
 
 	close(sk);
 
+	err = pthread_create(&notif_th, NULL, notification_handler, NULL);
+	if (err < 0) {
+		notif_th = 0;
+		error("Failed to start notification thread: %d (%s)", -err,
+							strerror(-err));
+		close(cmd_sk);
+		cmd_sk = -1;
+		close(notif_sk);
+		notif_sk = -1;
+		return false;
+	}
+
 	return true;
 }
 
@@ -134,8 +235,10 @@ void hal_ipc_cleanup(void)
 	close(cmd_sk);
 	cmd_sk = -1;
 
-	close(notif_sk);
-	notif_sk = -1;
+	shutdown(notif_sk, SHUT_RD);
+
+	pthread_join(notif_th, NULL);
+	notif_th = 0;
 }
 
 int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
-- 
1.8.4

