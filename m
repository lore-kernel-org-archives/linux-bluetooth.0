Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] android/ipc-tester: Add case for HIDHOST Set Info
Date: Wed, 22 Jan 2014 09:25:18 +0100
Message-Id: <1390379124-16426-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test for verifying data length inside
hal_cmd_hidhost_set_info struct.
---
 android/ipc-tester.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 2871587..641bc5b 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -650,6 +650,41 @@ struct hal_hdr enable_bt_service_hdr = {
 	.len = 0,
 };
 
+struct hidhost_set_info_data {
+	struct hal_hdr hdr;
+	struct hal_cmd_hidhost_set_info info;
+
+	/* data placeholder for hal_cmd_hidhost_set_info.descr[0] field */
+	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+				sizeof(struct hal_cmd_hidhost_set_info)];
+} __attribute__((packed));
+
+#define set_info_data "some descriptor"
+
+static struct hidhost_set_info_data hidhost_set_info_data_overs = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SET_INFO,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_set_info) +
+							sizeof(set_info_data),
+
+	/* declare wrong descriptor length */
+	.info.descr_len = sizeof(set_info_data) + 1,
+	/* init .info.descr[0] */
+	.buf = set_info_data,
+};
+
+static struct hidhost_set_info_data hidhost_set_info_data_unders = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SET_INFO,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_set_info) +
+							sizeof(set_info_data),
+
+	/* declare wrong descriptor length */
+	.info.descr_len = sizeof(set_info_data) - 1,
+	/* init .info.descr[0] */
+	.buf = set_info_data,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -915,6 +950,20 @@ int main(int argc, char *argv[])
 			HAL_OP_HIDHOST_SET_INFO,
 			sizeof(struct hal_cmd_hidhost_set_info), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Set Info Vardata+",
+			ipc_send_tc, setup, teardown,
+			&hidhost_set_info_data_overs,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_set_info) +
+				sizeof(set_info_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Set Info Vardata-",
+			ipc_send_tc, setup, teardown,
+			&hidhost_set_info_data_unders,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_set_info) +
+				sizeof(set_info_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 	test_datasize_valid("HIDHOST Get Protocol+", HAL_SERVICE_ID_HIDHOST,
 			HAL_OP_HIDHOST_GET_PROTOCOL,
 			sizeof(struct hal_cmd_hidhost_get_protocol), 1,
-- 
1.8.5.2

