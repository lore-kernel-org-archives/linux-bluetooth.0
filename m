Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 7/9] android/pan: Use generic IPC message handling for commands
Date: Mon,  2 Dec 2013 13:20:46 +0100
Message-Id: <1385986848-8023-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.

This also fix sending two IPC responses for get pan role command.
---
 android/pan.c | 87 +++++++++++++++++++++++++++++------------------------------
 android/pan.h |  2 --
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 9e388c3..3270aa4 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -188,9 +188,11 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 }
 
-static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+static void bt_pan_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_pan_connect *cmd = buf;
 	struct pan_device *dev;
+	uint8_t status;
 	bdaddr_t dst;
 	char addr[18];
 	GSList *l;
@@ -198,14 +200,13 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (l)
-		return HAL_STATUS_FAILED;
+	if (l) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	dev = g_new0(struct pan_device, 1);
 	bacpy(&dev->dst, &dst);
@@ -227,32 +228,36 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 		error("%s", gerr->message);
 		g_error_free(gerr);
 		g_free(dev);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	devices = g_slist_append(devices, dev);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status =  HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT, status);
 }
 
-static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
-								uint16_t len)
+static void bt_pan_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_pan_disconnect *cmd = buf;
 	struct pan_device *dev;
+	uint8_t status;
 	GSList *l;
 	bdaddr_t dst;
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	dev = l->data;
 
@@ -267,17 +272,20 @@ static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 	pan_device_free(dev);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT, status);
 }
 
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
 	struct hal_rsp_pan_get_role rsp;
 
@@ -286,34 +294,18 @@ static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
 	rsp.local_role = local_role;
 	ipc_send_rsp_full(HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE, sizeof(rsp),
 								&rsp, -1);
-
-	return HAL_STATUS_SUCCESS;
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
@@ -329,6 +321,9 @@ bool bt_pan_register(const bdaddr_t *addr)
 		return false;
 	}
 
+	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
@@ -337,4 +332,6 @@ void bt_pan_unregister(void)
 	DBG("");
 
 	bnep_cleanup();
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

