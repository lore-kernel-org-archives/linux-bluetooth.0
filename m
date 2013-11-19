Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/10] android/hal-bluetooth: Add support for dut mode send command
Date: Tue, 19 Nov 2013 16:51:50 +0100
Message-Id: <1384876314-31347-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used to send test HCI commands when DUT mode is enabled.
---
 android/hal-bluetooth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index bd7d257..4689bf2 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -761,12 +761,20 @@ static int dut_mode_configure(uint8_t enable)
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 {
-	DBG("");
+	uint8_t cmd_buf[sizeof(struct hal_cmd_dut_mode_send) + len];
+	struct hal_cmd_dut_mode_send *cmd = (void *) cmd_buf;
+
+	DBG("opcode %u len %u", opcode, len);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd->opcode = opcode;
+	cmd->len = len;
+	memcpy(cmd->data, buf, cmd->len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
+					sizeof(cmd_buf), cmd, 0, NULL, NULL);
 }
 
 static const bt_interface_t bluetooth_if = {
-- 
1.8.4.3

