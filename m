Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] android:hal: Add initial code for sending commands
Date: Mon, 21 Oct 2013 10:08:54 +0200
Message-Id: <1382342936-10331-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
References: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used by all HAL modules to send commands and get response
from daemon. In case of any protocol error negative value is returned.
---
 android/hal-bluetooth.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal.h           |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 589cb1b..de07108 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -23,6 +23,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <poll.h>
+#include <pthread.h>
 
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
@@ -43,6 +44,59 @@ bt_callbacks_t *bt_hal_cbacks = NULL;
 static int cmd_sk = -1;
 static int notif_sk = -1;
 
+static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
+							const void *param)
+{
+	int ret;
+	int msg_len = sizeof(struct hal_msg_hdr) + len;
+	char buf[msg_len];
+	struct hal_msg_hdr *msg = (struct hal_msg_hdr *)buf;
+	struct {
+		struct hal_msg_hdr hdr;
+		struct hal_msg_rsp_error error;
+	} __attribute__((packed)) rsp;
+
+	if (cmd_sk < 0)
+		return -EBADF;
+
+	msg->service_id = service_id;
+	msg->opcode = opcode;
+	msg->len = len;
+
+	if (len > 0)
+		memcpy(msg + sizeof(msg), param, len);
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	pthread_mutex_lock(&cmd_sk_mutex );
+
+	if (write(cmd_sk, msg, msg_len) != msg_len) {
+		pthread_mutex_unlock(&cmd_sk_mutex );
+		return -EIO;
+	}
+
+	ret = read(cmd_sk, &rsp, sizeof(rsp));
+
+	pthread_mutex_unlock(&cmd_sk_mutex );
+
+	if (ret < (int)sizeof(rsp.hdr))
+		return -EIO;
+
+	ret -= sizeof(rsp.hdr);
+
+	if (rsp.hdr.opcode == opcode && ret == 0)
+		return 0;
+
+	if (ret != sizeof(rsp.error))
+		return -EIO;
+
+	ret = rsp.error.status;
+
+	return ret;
+}
+
 static bool interface_ready(void)
 {
 	return bt_hal_cbacks != NULL;
diff --git a/android/hal.h b/android/hal.h
index a548e48..cf6e1f7 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -22,3 +22,6 @@
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
+
+int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
+							const void *param);
-- 
1.8.4

