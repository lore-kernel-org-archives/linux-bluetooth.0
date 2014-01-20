Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 11/11] android/ipc-tester: Add cases for BT message data size
Date: Mon, 20 Jan 2014 10:36:10 +0100
Message-Id: <1390210570-28260-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds sending invalid size data for each of
Bluetooth service opcodes.
---
 android/ipc-tester.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 3d1561d..ed0dd10 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -721,5 +721,148 @@ int main(int argc, char *argv[])
 	test_datasize_valid("CORE Unregister-", HAL_SERVICE_ID_CORE,
 			HAL_OP_UNREGISTER_MODULE,
 			sizeof(struct hal_cmd_register_module), -1);
+
+	/* check for valid data size for BLUETOOTH */
+	test_datasize_valid("BT Enable+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_ENABLE,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Disable+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_DISABLE,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Adapter Props+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_ADAPTER_PROPS,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Adapter Prop+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_ADAPTER_PROP,
+			sizeof(struct hal_cmd_get_adapter_prop), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Adapter Prop-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_ADAPTER_PROP,
+			sizeof(struct hal_cmd_get_adapter_prop), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Set Adapter Prop+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SET_ADAPTER_PROP,
+			sizeof(struct hal_cmd_set_adapter_prop), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Set Adapter Prop-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SET_ADAPTER_PROP,
+			sizeof(struct hal_cmd_set_adapter_prop), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Props+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_DEVICE_PROPS,
+			sizeof(struct hal_cmd_get_remote_device_props), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Props-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_DEVICE_PROPS,
+			sizeof(struct hal_cmd_get_remote_device_props), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Prop+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_DEVICE_PROP,
+			sizeof(struct hal_cmd_get_remote_device_prop), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Prop-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_DEVICE_PROP,
+			sizeof(struct hal_cmd_get_remote_device_prop), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Set Remote Prop+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SET_REMOTE_DEVICE_PROP,
+			sizeof(struct hal_cmd_set_remote_device_prop), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Set Remote Prop-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SET_REMOTE_DEVICE_PROP,
+			sizeof(struct hal_cmd_set_remote_device_prop), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote SV Rec+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICE_REC,
+			sizeof(struct hal_cmd_get_remote_service_rec), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote SV Rec-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICE_REC,
+			sizeof(struct hal_cmd_get_remote_service_rec), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Services+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICES,
+			sizeof(struct hal_cmd_get_remote_services), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Get Remote Services-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICES,
+			sizeof(struct hal_cmd_get_remote_services), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Start Discovery+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_START_DISCOVERY,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Cancel Discovery+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_CANCEL_DISCOVERY,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Create Bond+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_CREATE_BOND,
+			sizeof(struct hal_cmd_create_bond), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Create Bond-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_CREATE_BOND,
+			sizeof(struct hal_cmd_create_bond), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Remove Bond+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_REMOVE_BOND,
+			sizeof(struct hal_cmd_remove_bond), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Remove Bond-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_REMOVE_BOND,
+			sizeof(struct hal_cmd_remove_bond), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Cancel Bond+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_CANCEL_BOND,
+			sizeof(struct hal_cmd_cancel_bond), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Cancel Bond-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_CANCEL_BOND,
+			sizeof(struct hal_cmd_cancel_bond), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Pin Reply+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_PIN_REPLY,
+			sizeof(struct hal_cmd_pin_reply), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT Pin Reply-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_PIN_REPLY,
+			sizeof(struct hal_cmd_pin_reply), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT SSP Reply+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SSP_REPLY,
+			sizeof(struct hal_cmd_ssp_reply), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT SSP Reply-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_SSP_REPLY,
+			sizeof(struct hal_cmd_ssp_reply), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT DUT Mode Conf+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_DUT_MODE_CONF,
+			sizeof(struct hal_cmd_dut_mode_conf), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT DUT Mode Conf-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_DUT_MODE_CONF,
+			sizeof(struct hal_cmd_dut_mode_conf), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT DUT Mode Send+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_DUT_MODE_SEND,
+			sizeof(struct hal_cmd_dut_mode_send), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT DUT Mode Send-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_DUT_MODE_SEND,
+			sizeof(struct hal_cmd_dut_mode_send), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT LE Test+", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_LE_TEST_MODE,
+			sizeof(struct hal_cmd_le_test_mode), 1,
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_datasize_valid("BT LE Test-", HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_LE_TEST_MODE,
+			sizeof(struct hal_cmd_le_test_mode), -1,
+			HAL_SERVICE_ID_BLUETOOTH);
+
 	return tester_run();
 }
-- 
1.8.5.2

