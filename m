Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/a2dp: Add initial code for handling commands
Date: Mon,  4 Nov 2013 12:56:55 +0200
Message-Id: <1383562617-9029-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
References: <1383562617-9029-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 36 ++++++++++++++++++++++++++++++++++++
 android/a2dp.h |  3 +++
 android/main.c |  4 ++++
 3 files changed, 43 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 64e5278..28ab4b1 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -35,9 +35,45 @@
 #include "lib/bluetooth.h"
 #include "log.h"
 #include "a2dp.h"
+#include "hal-msg.h"
+#include "ipc.h"
 
 static GIOChannel *notification_io = NULL;
 
+static uint8_t bt_a2dp_connect(struct hal_cmd_av_connect *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_a2dp_disconnect(struct hal_cmd_av_connect *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+								uint16_t len)
+{
+	uint8_t status = HAL_STATUS_FAILED;
+
+	switch (opcode) {
+	case HAL_OP_AV_CONNECT:
+		status = bt_a2dp_connect(buf, len);
+		break;
+	case HAL_OP_AV_DISCONNECT:
+		status = bt_a2dp_disconnect(buf, len);
+		break;
+	default:
+		DBG("Unhandled command, opcode 0x%x", opcode);
+		break;
+	}
+
+	ipc_send_rsp(io, HAL_SERVICE_ID_A2DP, status);
+}
+
 bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr)
 {
 	DBG("");
diff --git a/android/a2dp.h b/android/a2dp.h
index b8b14bb..a5ac53e 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,5 +21,8 @@
  *
  */
 
+void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+								uint16_t len);
+
 bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
diff --git a/android/main.c b/android/main.c
index efa8c37..75ed4bb 100644
--- a/android/main.c
+++ b/android/main.c
@@ -259,6 +259,10 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
 								msg->len);
 		break;
+	case HAL_SERVICE_ID_A2DP:
+		bt_a2dp_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
+								msg->len);
+		break;
 	default:
 		ipc_send_rsp(hal_cmd_io, msg->service_id, HAL_STATUS_FAILED);
 		break;
-- 
1.8.3.1

