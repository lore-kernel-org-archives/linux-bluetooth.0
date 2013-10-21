Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 5/6] android: Add helper to send fd using SCM_RIGHTS
Date: Mon, 21 Oct 2013 14:28:36 +0300
Message-Id: <1382354917-8632-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is used in accept message to Android framework.
---
 android/Android.mk |    1 +
 android/bt-sock.c  |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 android/bt-sock.c

diff --git a/android/Android.mk b/android/Android.mk
index 4bd4116..786c9fb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -57,6 +57,7 @@ LOCAL_SRC_FILES := \
 	hal-hidhost.c \
 	hal-pan.c \
 	hal-msg-client.c \
+	bt-sock.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/bt-sock.c b/android/bt-sock.c
new file mode 100644
index 0000000..68dbe32
--- /dev/null
+++ b/android/bt-sock.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <errno.h>
+
+#include <cutils/log.h>
+
+int bt_sock_send_acc_fd(int sock_fd, const unsigned char *buf, int len,
+								int send_fd)
+{
+	ssize_t ret;
+	struct msghdr msg;
+	struct cmsghdr *cmsg;
+	struct iovec iv;
+	char msgbuf[CMSG_SPACE(1)];
+
+	ALOGD("%s: len %d sock_fd %d send_fd %d", __func__, len, sock_fd,
+								send_fd);
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
+		ALOGE("%s: sock_fd %d send_fd %d sendmsg ret %d errno %d %s",
+				__func__, sock_fd, send_fd, (int)ret, errno,
+				strerror(errno));
+		return ret;
+	}
+
+	return ret;
+}
-- 
1.7.10.4

