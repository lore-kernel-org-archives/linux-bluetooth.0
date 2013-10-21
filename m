Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android:hal: Add support for receiving fd in command response
Date: Mon, 21 Oct 2013 10:08:55 +0200
Message-Id: <1382342936-10331-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
References: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If fd is expected together with response it will be stored into passed
pointer.
---
 android/hal-bluetooth.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 android/hal.h           |  2 +-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index de07108..4174fcf 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -46,8 +46,43 @@ static int notif_sk = -1;
 
 static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+static int read_fd(int sk, void *buf, int size, int *fd)
+{
+	struct msghdr msg;
+	struct iovec iv;
+	struct cmsghdr *cmsg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	int ret;
+
+	*fd = -1;
+
+	memset(&msg, 0, sizeof(msg));
+	memset(cmsgbuf, 0, sizeof(cmsgbuf));
+
+	iv.iov_base = buf;
+	iv.iov_len = size;
+
+	msg.msg_iov = &iv;
+	msg.msg_iovlen = 1;
+
+	msg.msg_control = cmsgbuf;
+	msg.msg_controllen = sizeof(cmsgbuf);
+
+	ret = recvmsg(sk, &msg, 0);
+	if(ret < 0)
+		return -EIO;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg && cmsg->cmsg_level == SOL_SOCKET &&
+			cmsg->cmsg_type == SCM_RIGHTS &&
+			cmsg->cmsg_len == CMSG_LEN(sizeof(int)))
+		memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
+
+	return ret;
+}
+
 int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
-							const void *param)
+						const void *param, int *fd)
 {
 	int ret;
 	int msg_len = sizeof(struct hal_msg_hdr) + len;
@@ -77,7 +112,10 @@ int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
 		return -EIO;
 	}
 
-	ret = read(cmd_sk, &rsp, sizeof(rsp));
+	if (fd)
+		ret = read_fd(cmd_sk, &rsp, sizeof(rsp), fd);
+	else
+		ret = read(cmd_sk, &rsp, sizeof(rsp));
 
 	pthread_mutex_unlock(&cmd_sk_mutex );
 
diff --git a/android/hal.h b/android/hal.h
index cf6e1f7..8062971 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -24,4 +24,4 @@ bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 
 int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
-							const void *param);
+						const void *param, int *fd);
-- 
1.8.4

