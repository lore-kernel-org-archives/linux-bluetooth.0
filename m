Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [[RFC] 2/2] android/avrcp-ctrl: Add support for Send Pass Through command in daemon
Date: Tue, 23 Dec 2014 15:48:06 +0100
Message-Id: <1419346086-26687-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1419346086-26687-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1419346086-26687-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-ctrl.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-ctrl.c b/android/avrcp-ctrl.c
index 31a9d7f..1dd9d84 100644
--- a/android/avrcp-ctrl.c
+++ b/android/avrcp-ctrl.c
@@ -34,6 +34,7 @@
 
 #include "avctp.h"
 #include "avrcp-common.h"
+#include "avrcp-lib.h"
 #include "avrcp-ctrl.h"
 #include "bluetooth.h"
 
@@ -42,10 +43,35 @@ static struct ipc *hal_ipc = NULL;
 
 static void handle_send_passthrough(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_avrcp_ctrl_send_passthrough *cmd = buf;
+	struct avrcp_device *dev;
+	uint8_t status;
+	bdaddr_t *addr;
+
 	DBG("");
 
+	dev = get_avrcp_device(strtoba((char *)cmd->bdaddr));
+	if (!dev) {
+		error("RC device not connected");
+		status = HAL_STATUS_NOT_READY;
+		goto done;
+	}
+
+	/* TODO check if ctrl is supported - since we check if service is
+	 * registered before accesing it from hal? */
+
+	if (avrcp_send_passthrough(dev->session, cmd->key_state,
+						cmd->key_code) < 0) {
+		error("RC cannot send passthrough");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL,
-			HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH, HAL_STATUS_FAILED);
+				HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.9.3

