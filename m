Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/13] android/bluetooth: Add stubs for missing commands handlers
Date: Wed, 27 Nov 2013 12:54:58 +0100
Message-Id: <1385553305-5807-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unknown IPC command is now considered IPC error so all commands should
at least have stub implementation.
---
 android/bluetooth.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c7ec19b..81f9d79 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2373,6 +2373,30 @@ fail:
 					HAL_OP_CANCEL_DISCOVERY, status);
 }
 
+static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
+
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_DUT_MODE_CONF, HAL_STATUS_FAILED);
+}
+
+static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
+
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_DUT_MODE_SEND, HAL_STATUS_FAILED);
+}
+
+static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
+
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_LE_TEST_MODE, HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	{	/* HAL_OP_ENABLE */
 		.handler = handle_enable_cmd,
@@ -2459,6 +2483,21 @@ static const struct ipc_handler cmd_handlers[] = {
 		.var_len = false,
 		.data_len = sizeof(struct hal_cmd_ssp_reply)
 	},
+	{	/* HAL_OP_DUT_MODE_CONF */
+		.handler = handle_dut_mode_conf_cmd,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_dut_mode_conf)
+	},
+	{	/* HAL_OP_DUT_MODE_SEND */
+		.handler = handle_dut_mode_send_cmd,
+		.var_len = true,
+		.data_len = sizeof(struct hal_cmd_dut_mode_send)
+	},
+	{	/* HAL_OP_DUT_MODE_SEND */
+		.handler = handle_le_test_mode_cmd,
+		.var_len = true,
+		.data_len = sizeof(struct hal_cmd_le_test_mode)
+	},
 };
 
 bool bt_bluetooth_register(int cmd_sk, int notif_sk)
-- 
1.8.3.2

