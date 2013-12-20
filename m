Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/hal-bluetooth: Add support for sending LE_TEST_MODE command
Date: Fri, 20 Dec 2013 11:25:36 +0100
Message-Id: <1387535140-6223-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to send LE_TEST_MODE command introduced in Android 4.3.
---
 android/hal-bluetooth.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 7cac15c..11f2a9f 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -307,6 +307,18 @@ static void handle_dut_mode_receive(void *buf, uint16_t len)
 		bt_hal_cbacks->dut_mode_recv_cb(ev->opcode, ev->data, ev->len);
 }
 
+#if PLATFORM_SDK_VERSION > 17
+static void handle_le_test_mode(void *buf, uint16_t len)
+{
+	struct hal_ev_le_test_mode *ev = buf;
+
+	DBG("");
+
+	if (bt_hal_cbacks->le_test_mode_cb)
+		bt_hal_cbacks->le_test_mode_cb(ev->status, ev->num_packets);
+}
+#endif
+
 /* handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
 static const struct hal_ipc_handler ev_handlers[] = {
@@ -363,6 +375,13 @@ static const struct hal_ipc_handler ev_handlers[] = {
 		.var_len = true,
 		.data_len = sizeof(struct hal_ev_dut_mode_receive),
 	},
+#if PLATFORM_SDK_VERSION > 17
+	{	/* HAL_EV_LE_TEST_MODE */
+		.handler = handle_le_test_mode,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_le_test_mode),
+	}
+#endif
 };
 
 static int init(bt_callbacks_t *callbacks)
@@ -752,6 +771,26 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 					sizeof(cmd_buf), cmd, 0, NULL, NULL);
 }
 
+#if PLATFORM_SDK_VERSION > 17
+static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
+{
+	uint8_t cmd_buf[sizeof(struct hal_cmd_dut_mode_send) + len];
+	struct hal_cmd_le_test_mode *cmd = (void *) cmd_buf;
+
+	DBG("opcode %u len %u", opcode, len);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd->opcode = opcode;
+	cmd->len = len;
+	memcpy(cmd->data, buf, cmd->len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
+					sizeof(cmd_buf), cmd, 0, NULL, NULL);
+}
+#endif
+
 static const bt_interface_t bluetooth_if = {
 	.size = sizeof(bt_interface_t),
 	.init = init,
@@ -775,7 +814,10 @@ static const bt_interface_t bluetooth_if = {
 	.ssp_reply = ssp_reply,
 	.get_profile_interface = get_profile_interface,
 	.dut_mode_configure = dut_mode_configure,
-	.dut_mode_send = dut_mode_send
+	.dut_mode_send = dut_mode_send,
+#if PLATFORM_SDK_VERSION > 17
+	.le_test_mode = le_test_mode,
+#endif
 };
 
 static const bt_interface_t *get_bluetooth_interface(void)
-- 
1.8.3.2

