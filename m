Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] android/ipc-tester: Add case for BT Set adapter prop
Date: Wed, 22 Jan 2014 09:25:23 +0100
Message-Id: <1390379124-16426-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test for verifying data length inside
hal_cmd_set_adapter_prop struct.
---
 android/ipc-tester.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index c621167..e44afb3 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -650,6 +650,43 @@ struct hal_hdr enable_bt_service_hdr = {
 	.len = 0,
 };
 
+struct bt_set_adapter_prop_data {
+	struct hal_hdr hdr;
+	struct hal_cmd_set_adapter_prop prop;
+
+	/* data placeholder for hal_cmd_set_adapter_prop.val[0] */
+	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+				sizeof(struct hal_cmd_set_adapter_prop)];
+} __attribute__((packed));
+
+#define set_name "new name"
+
+static struct bt_set_adapter_prop_data bt_set_adapter_prop_data_overs = {
+	.hdr.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.hdr.opcode = HAL_OP_SET_ADAPTER_PROP,
+	.hdr.len = sizeof(struct hal_cmd_set_adapter_prop) +
+						sizeof(set_name),
+
+	.prop.type = HAL_PROP_ADAPTER_NAME,
+	/* declare wrong descriptor length */
+	.prop.len = sizeof(set_name) + 1,
+	/* init prop.val[0] */
+	.buf = set_name,
+};
+
+static struct bt_set_adapter_prop_data bt_set_adapter_prop_data_unders = {
+	.hdr.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.hdr.opcode = HAL_OP_SET_ADAPTER_PROP,
+	.hdr.len = sizeof(struct hal_cmd_set_adapter_prop) +
+						sizeof(set_name),
+
+	.prop.type = HAL_PROP_ADAPTER_NAME,
+	/* declare wrong descriptor length */
+	.prop.len = sizeof(set_name) - 1,
+	/* init prop.val[0] */
+	.buf = set_name,
+};
+
 struct hidhost_set_info_data {
 	struct hal_hdr hdr;
 	struct hal_cmd_hidhost_set_info info;
@@ -856,6 +893,20 @@ int main(int argc, char *argv[])
 			HAL_OP_SET_ADAPTER_PROP,
 			sizeof(struct hal_cmd_set_adapter_prop), -1,
 			HAL_SERVICE_ID_BLUETOOTH);
+	test_generic("Data size BT Set Adapter Prop Vardata+",
+			ipc_send_tc, setup, teardown,
+			&bt_set_adapter_prop_data_overs,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_set_adapter_prop) +
+				sizeof(set_name)),
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_generic("Data size BT Set Adapter Prop Vardata+",
+			ipc_send_tc, setup, teardown,
+			&bt_set_adapter_prop_data_unders,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_set_adapter_prop) +
+				sizeof(set_name)),
+			HAL_SERVICE_ID_BLUETOOTH);
 	test_datasize_valid("BT Get Remote Props+", HAL_SERVICE_ID_BLUETOOTH,
 			HAL_OP_GET_REMOTE_DEVICE_PROPS,
 			sizeof(struct hal_cmd_get_remote_device_props), 1,
-- 
1.8.5.2

