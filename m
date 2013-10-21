Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android:hal: Register adapter and socket interface on HAL init
Date: Mon, 21 Oct 2013 10:08:56 +0200
Message-Id: <1382342936-10331-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
References: <1382342936-10331-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After daemon is started HAL needs to register those two interfaces
to performe initialization procedure as described in IPC documentation.
---
 android/hal-bluetooth.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4174fcf..6af6a6b 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -46,7 +46,7 @@ static int notif_sk = -1;
 
 static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
-static int read_fd(int sk, void *buf, int size, int *fd)
+static int read_with_fd(int sk, void *buf, int size, int *fd)
 {
 	struct msghdr msg;
 	struct iovec iv;
@@ -72,11 +72,13 @@ static int read_fd(int sk, void *buf, int size, int *fd)
 	if(ret < 0)
 		return -EIO;
 
-	cmsg = CMSG_FIRSTHDR(&msg);
-	if (cmsg && cmsg->cmsg_level == SOL_SOCKET &&
-			cmsg->cmsg_type == SCM_RIGHTS &&
-			cmsg->cmsg_len == CMSG_LEN(sizeof(int)))
-		memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
+	/* Receive auxiliary data in msg */
+	for (cmsg = CMSG_FIRSTHDR(&msg); !cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg))
+		if (cmsg->cmsg_level == SOL_SOCKET
+				&& cmsg->cmsg_type == SCM_RIGHTS) {
+			memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
+			break;
+		}
 
 	return ret;
 }
@@ -113,7 +115,7 @@ int hal_send_msg(uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 
 	if (fd)
-		ret = read_fd(cmd_sk, &rsp, sizeof(rsp), fd);
+		ret = read_with_fd(cmd_sk, &rsp, sizeof(rsp), fd);
 	else
 		ret = read(cmd_sk, &rsp, sizeof(rsp));
 
@@ -241,6 +243,8 @@ static void stop_daemon(void)
 
 static int init(bt_callbacks_t *callbacks)
 {
+	struct hal_msg_cmd_register_module cmd;
+
 	DBG("");
 
 	if (interface_ready())
@@ -251,7 +255,25 @@ static int init(bt_callbacks_t *callbacks)
 
 	bt_hal_cbacks = callbacks;
 
+	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
+
+	if (hal_send_msg(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd, NULL) != 0 )
+		goto fail;
+
+	cmd.service_id = HAL_SERVICE_ID_SOCK;
+
+	if (hal_send_msg(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd, NULL) != 0)
+		goto fail;
+
 	return BT_STATUS_SUCCESS;
+
+fail:
+	stop_daemon();
+	bt_hal_cbacks = NULL;
+	return BT_STATUS_FAIL;
+
 }
 
 static int enable(void)
-- 
1.8.4

