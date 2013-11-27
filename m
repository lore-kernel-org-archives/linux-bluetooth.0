Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/13] android/pan: Use generic IPC message handling for commands
Date: Wed, 27 Nov 2013 12:55:01 +0100
Message-Id: <1385553305-5807-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/pan.c | 71 ++++++++++++++++++++++++++++++++---------------------------
 android/pan.h |  2 --
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 35d5608..5a605d2 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -38,59 +38,60 @@
 static int notification_sk = -1;
 static int command_sk = -1;
 
-static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+static void bt_pan_enable(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
+							HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+static void bt_pan_get_role(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE,
+							HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+static void bt_pan_connect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT,
+							HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
-								uint16_t len)
+static void bt_pan_disconnect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT,
+							HAL_STATUS_FAILED);
 }
 
-void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-{
-	uint8_t status = HAL_STATUS_FAILED;
-
-	switch (opcode) {
-	case HAL_OP_PAN_ENABLE:
-		status = bt_pan_enable(buf, len);
-		break;
-	case HAL_OP_PAN_GET_ROLE:
-		status = bt_pan_get_role(buf, len);
-		break;
-	case HAL_OP_PAN_CONNECT:
-		status = bt_pan_connect(buf, len);
-		break;
-	case HAL_OP_PAN_DISCONNECT:
-		status = bt_pan_disconnect(buf, len);
-		break;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
-	}
-
-	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, opcode, status);
-}
+static const struct ipc_handler cmd_handlers[] = {
+	{	/* HAL_OP_PAN_ENABLE */
+		.handler = bt_pan_enable,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_pan_enable)
+	},
+	{	/* HAL_OP_PAN_GET_ROLE */
+		.handler = bt_pan_get_role,
+		.var_len = false,
+		.data_len = 0
+	},
+	{	/* HAL_OP_PAN_CONNECT */
+		.handler = bt_pan_connect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_pan_connect)
+	},
+	{	/* HAL_OP_PAN_DISCONNECT */
+		.handler = bt_pan_disconnect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_pan_disconnect)
+	},
+};
 
 bool bt_pan_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
@@ -102,6 +103,8 @@ bool bt_pan_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 	notification_sk = notif_sk;
 	command_sk = cmd_sk;
 
+	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
 
 	return true;
 }
@@ -115,4 +118,6 @@ void bt_pan_unregister(void)
 
 	notification_sk = -1;
 	command_sk = -1;
+
+	ipc_unregister(HAL_SERVICE_ID_PAN);
 }
diff --git a/android/pan.h b/android/pan.h
index 9ceebe5..91799f2 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_pan_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_pan_unregister(void);
-- 
1.8.3.2

