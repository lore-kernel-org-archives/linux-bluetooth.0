Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] android/ipc-tester: Add case for BT Set remote prop
Date: Wed, 22 Jan 2014 09:25:24 +0100
Message-Id: <1390379124-16426-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test for verifying data length inside
hal_cmd_set_remote_device_prop struct.
---
 android/ipc-tester.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index e44afb3..e1aeb2e 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -687,6 +687,41 @@ static struct bt_set_adapter_prop_data bt_set_adapter_prop_data_unders = {
 	.buf = set_name,
 };
 
+struct bt_set_remote_prop_data {
+	struct hal_hdr hdr;
+	struct hal_cmd_set_remote_device_prop prop;
+
+	/* data placeholder for hal_cmd_set_remote_device_prop.val[0] */
+	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+				sizeof(struct hal_cmd_set_remote_device_prop)];
+} __attribute__((packed));
+
+static struct bt_set_remote_prop_data bt_set_remote_prop_data_overs = {
+	.hdr.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.hdr.opcode = HAL_OP_SET_REMOTE_DEVICE_PROP,
+	.hdr.len = sizeof(struct hal_cmd_set_remote_device_prop) +
+						sizeof(set_name),
+
+	.prop.bdaddr = {},
+	.prop.type = HAL_PROP_DEVICE_NAME,
+	/* declare wrong descriptor length */
+	.prop.len = sizeof(set_name) + 1,
+	.buf = set_name,
+};
+
+static struct bt_set_remote_prop_data bt_set_remote_prop_data_unders = {
+	.hdr.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.hdr.opcode = HAL_OP_SET_REMOTE_DEVICE_PROP,
+	.hdr.len = sizeof(struct hal_cmd_set_remote_device_prop) +
+						sizeof(set_name),
+
+	.prop.bdaddr = {},
+	.prop.type = HAL_PROP_DEVICE_NAME,
+	/* declare wrong descriptor length */
+	.prop.len = sizeof(set_name) - 1,
+	.buf = set_name,
+};
+
 struct hidhost_set_info_data {
 	struct hal_hdr hdr;
 	struct hal_cmd_hidhost_set_info info;
@@ -931,6 +966,20 @@ int main(int argc, char *argv[])
 			HAL_OP_SET_REMOTE_DEVICE_PROP,
 			sizeof(struct hal_cmd_set_remote_device_prop), -1,
 			HAL_SERVICE_ID_BLUETOOTH);
+	test_generic("Data size BT Set Remote Prop Vardata+",
+			ipc_send_tc, setup, teardown,
+			&bt_set_remote_prop_data_overs,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_set_remote_device_prop) +
+				sizeof(set_name)),
+			HAL_SERVICE_ID_BLUETOOTH);
+	test_generic("Data size BT Set Remote Prop Vardata-",
+			ipc_send_tc, setup, teardown,
+			&bt_set_remote_prop_data_unders,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_set_remote_device_prop) +
+				sizeof(set_name)),
+			HAL_SERVICE_ID_BLUETOOTH);
 	test_datasize_valid("BT Get Remote SV Rec+", HAL_SERVICE_ID_BLUETOOTH,
 			HAL_OP_GET_REMOTE_SERVICE_REC,
 			sizeof(struct hal_cmd_get_remote_service_rec), 1,
-- 
1.8.5.2

