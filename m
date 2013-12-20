Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/bluetooth: Add stubs for missing commands
Date: Fri, 20 Dec 2013 11:25:40 +0100
Message-Id: <1387535140-6223-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stubs for commands that were introduced by BT HAL changes
in Android 4.3+.
---
 android/bluetooth.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index efaa424..6bfe786 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2567,6 +2567,54 @@ failed:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY, status);
 }
 
+static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_dut_mode_conf *cmd = buf;
+
+	DBG("enable %u", cmd->enable);
+
+	/* TODO */
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_dut_mode_send *cmd = buf;
+
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid dut mode send cmd, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("opcode %u", cmd->opcode);
+
+	/* TODO */
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_le_test_mode *cmd = buf;
+
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid le test mode cmd, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("opcode %u", cmd->opcode);
+
+	/* TODO */
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_ENABLE */
 	{ handle_enable_cmd, false, 0 },
@@ -2609,6 +2657,14 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_pin_reply_cmd, false, sizeof(struct hal_cmd_pin_reply) },
 	/* HAL_OP_SSP_REPLY */
 	{ handle_ssp_reply_cmd, false, sizeof(struct hal_cmd_ssp_reply) },
+	/* HAL_OP_DUT_MODE_CONF */
+	{ handle_dut_mode_conf_cmd, false,
+					sizeof(struct hal_cmd_dut_mode_conf) },
+	/* HAL_OP_DUT_MODE_SEND */
+	{ handle_dut_mode_send_cmd, true,
+					sizeof(struct hal_cmd_dut_mode_send) },
+	/* HAL_OP_LE_TEST_MODE */
+	{ handle_le_test_mode_cmd, true, sizeof(struct hal_cmd_le_test_mode) },
 };
 
 void bt_bluetooth_register(void)
-- 
1.8.3.2

