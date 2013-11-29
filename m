Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 7/9] android/pan: Use generic IPC message handling for commands
Date: Fri, 29 Nov 2013 12:08:49 +0100
Message-Id: <1385723331-15603-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385723331-15603-1-git-send-email-szymon.janc@tieto.com>
References: <1385723331-15603-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/pan.c | 57 ++++++++++++++++++++++++---------------------------------
 android/pan.h |  2 --
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index ea15637..e15235d 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -35,68 +35,59 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
-static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+static void bt_pan_enable(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+static void bt_pan_get_role(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE,
+							HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+static void bt_pan_connect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT, HAL_STATUS_FAILED);
 }
 
-static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
-								uint16_t len)
+static void bt_pan_disconnect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
 
-	return HAL_STATUS_FAILED;
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT,
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
-	ipc_send_rsp(HAL_SERVICE_ID_PAN, opcode, status);
-}
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_PAN_ENABLE */
+	{ bt_pan_enable, false, sizeof(struct hal_cmd_pan_enable) },
+	/* HAL_OP_PAN_GET_ROLE */
+	{ bt_pan_get_role, false, 0 },
+	/* HAL_OP_PAN_CONNECT */
+	{ bt_pan_connect, false, sizeof(struct hal_cmd_pan_connect) },
+	/* HAL_OP_PAN_DISCONNECT */
+	{ bt_pan_disconnect, false, sizeof(struct hal_cmd_pan_disconnect) },
+};
 
 bool bt_pan_register(const bdaddr_t *addr)
 {
 	DBG("");
 
+	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
 	return true;
 }
 
 void bt_pan_unregister(void)
 {
 	DBG("");
+
+	ipc_unregister(HAL_SERVICE_ID_PAN);
 }
diff --git a/android/pan.h b/android/pan.h
index dd18f68..3178d88 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_pan_register(const bdaddr_t *addr);
 void bt_pan_unregister(void);
-- 
1.8.3.2

