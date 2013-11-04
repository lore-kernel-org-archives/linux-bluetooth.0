Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/pan: Add initial code for handling commands
Date: Mon,  4 Nov 2013 12:56:57 +0200
Message-Id: <1383562617-9029-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
References: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/main.c |  4 ++++
 android/pan.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pan.h  |  2 ++
 3 files changed, 62 insertions(+)

diff --git a/android/main.c b/android/main.c
index 29b3882..7d36976 100644
--- a/android/main.c
+++ b/android/main.c
@@ -272,6 +272,10 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_a2dp_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
 								msg->len);
 		break;
+	case HAL_SERVICE_ID_PAN:
+		bt_pan_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
+								msg->len);
+		break;
 	default:
 		ipc_send_rsp(hal_cmd_io, msg->service_id, HAL_STATUS_FAILED);
 		break;
diff --git a/android/pan.c b/android/pan.c
index 4b988ac..0cc3590 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -32,9 +32,65 @@
 #include "lib/bluetooth.h"
 #include "log.h"
 #include "pan.h"
+#include "hal-msg.h"
+#include "ipc.h"
 
 static GIOChannel *notification_io = NULL;
 
+static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_pan_disconnect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+								uint16_t len)
+{
+	uint8_t status = HAL_STATUS_FAILED;
+
+	switch (opcode) {
+	case HAL_OP_PAN_ENABLE:
+		status = bt_pan_enable(buf, len);
+		break;
+	case HAL_OP_PAN_GET_ROLE:
+		status = bt_pan_get_role(buf, len);
+		break;
+	case HAL_OP_PAN_CONNECT:
+		status = bt_pan_connect(buf, len);
+		break;
+	case HAL_OP_PAN_DISCONNECT:
+		status = bt_pan_disconnect(buf, len);
+		break;
+	default:
+		DBG("Unhandled command, opcode 0x%x", opcode);
+		break;
+	}
+
+	ipc_send_rsp(io, HAL_SERVICE_ID_A2DP, status);
+}
+
 bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr)
 {
 	DBG("");
diff --git a/android/pan.h b/android/pan.h
index 318f318..1ffba9d 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,5 +21,7 @@
  *
  */
 
+void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len);
+
 bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr);
 void bt_pan_unregister(void);
-- 
1.8.3.1

