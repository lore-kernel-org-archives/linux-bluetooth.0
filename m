Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Improve hal_ipc_cmd helper
Date: Tue, 22 Oct 2013 09:17:28 +0200
Message-Id: <1382426248-10793-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle error response inside helper so that users don't expecting any
response don't need to provide dummy buffer only for error (which is
already return value of helper).
---
 android/hal-bluetooth.c | 7 ++-----
 android/hal-ipc.c       | 6 ++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index f408a7d..5b07070 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -40,7 +40,6 @@ static bool interface_ready(void)
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_msg_cmd_register_module cmd;
-	struct hal_msg_rsp_error rsp;
 
 	DBG("");
 
@@ -55,8 +54,7 @@ static int init(bt_callbacks_t *callbacks)
 	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
 
 	if (hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
-						sizeof(cmd), &cmd,
-						sizeof(rsp), &rsp, NULL) < 0) {
+				sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
 		error("Failed to register 'bluetooth' service");
 		goto fail;
 	}
@@ -64,8 +62,7 @@ static int init(bt_callbacks_t *callbacks)
 	cmd.service_id = HAL_SERVICE_ID_SOCK;
 
 	if (hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
-						sizeof(cmd), &cmd,
-						sizeof(rsp), &rsp, NULL) < 0) {
+				sizeof(cmd), &cmd, 0, NULL, NULL) < 0) {
 		error("Failed to register 'socket' service");
 		goto fail;
 	}
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 5b77adf..8d40271 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -146,10 +146,16 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	struct iovec iv[2];
 	struct hal_msg_hdr hal_msg;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	struct hal_msg_rsp_error err;
 
 	if (cmd_sk < 0)
 		return -EBADF;
 
+	if (!rsp || rsp_len == 0) {
+		memset(&err, 0, sizeof(err));
+		rsp = &err;
+	}
+
 	memset(&msg, 0, sizeof(msg));
 	memset(&hal_msg, 0, sizeof(hal_msg));
 
-- 
1.8.4

