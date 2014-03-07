Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/avrcp: Add support to set volume command
Date: Fri,  7 Mar 2014 14:15:43 +0200
Message-Id: <1394194543-3095-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
References: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 978e6c0..11a2614 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -332,10 +332,35 @@ done:
 
 static void handle_set_volume(const void *buf, uint16_t len)
 {
+	struct hal_cmd_avrcp_set_volume *cmd = (void *) buf;
+	struct avrcp_device *dev;
+	uint8_t status;
+	int ret;
+
 	DBG("");
 
+	if (!devices) {
+		error("AVRCP: No device found to set volume");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	/* Peek the first device since the HAL cannot really address a specific
+	 * device it might mean there could only be one connected.
+	 */
+	dev = devices->data;
+
+	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f, NULL, NULL);
+	if (ret < 0) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
-							HAL_STATUS_FAILED);
+								status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.5.3

