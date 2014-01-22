Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] android/ipc-tester: Add case for HIDHOST Send Data
Date: Wed, 22 Jan 2014 09:25:20 +0100
Message-Id: <1390379124-16426-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds test for verifying data length inside
hal_cmd_hidhost_send_data struct.
---
 android/ipc-tester.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index ca4d9b9..b161049 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -720,6 +720,41 @@ static struct hidhost_set_report_data hidhost_set_report_data_unders = {
 	.buf = set_rep_data,
 };
 
+struct hidhost_send_data_data {
+	struct hal_hdr hdr;
+	struct hal_cmd_hidhost_send_data hiddata;
+
+	/* data placeholder for hal_cmd_hidhost_send_data.data[0] field */
+	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+				sizeof(struct hal_cmd_hidhost_send_data)];
+} __attribute__((packed));
+
+#define send_data_data "1234567890"
+
+static struct hidhost_send_data_data hidhost_send_data_overs = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SEND_DATA,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_send_data) +
+							sizeof(send_data_data),
+
+	/* declare wrong descriptor length */
+	.hiddata.len = sizeof(send_data_data) + 1,
+	/* init .hiddata.data[0] */
+	.buf = send_data_data,
+};
+
+static struct hidhost_send_data_data hidhost_send_data_unders = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SEND_DATA,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_send_data) +
+							sizeof(send_data_data),
+
+	/* declare wrong descriptor length */
+	.hiddata.len = sizeof(send_data_data) - 1,
+	/* init .hiddata.data[0] */
+	.buf = send_data_data,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -1053,6 +1088,20 @@ int main(int argc, char *argv[])
 			HAL_OP_HIDHOST_SEND_DATA,
 			sizeof(struct hal_cmd_hidhost_send_data), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Send Vardata+",
+			ipc_send_tc, setup, teardown,
+			&hidhost_send_data_overs,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_send_data) +
+				sizeof(send_data_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Send Vardata-",
+			ipc_send_tc, setup, teardown,
+			&hidhost_send_data_unders,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_send_data) +
+				sizeof(send_data_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 
 	return tester_run();
 }
-- 
1.8.5.2

