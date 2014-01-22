Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] android/ipc-tester: Add case for HIDHOST Set Report
Date: Wed, 22 Jan 2014 09:25:19 +0100
Message-Id: <1390379124-16426-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test for verifying data length inside
hal_cmd_hidhost_set_report struct.
---
 android/ipc-tester.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 641bc5b..ca4d9b9 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -685,6 +685,41 @@ static struct hidhost_set_info_data hidhost_set_info_data_unders = {
 	.buf = set_info_data,
 };
 
+struct hidhost_set_report_data {
+	struct hal_hdr hdr;
+	struct hal_cmd_hidhost_set_report report;
+
+	/* data placeholder for hal_cmd_hidhost_set_report.data[0] field */
+	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+				sizeof(struct hal_cmd_hidhost_set_report)];
+} __attribute__((packed));
+
+#define set_rep_data "1234567890"
+
+static struct hidhost_set_report_data hidhost_set_report_data_overs = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SET_REPORT,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_set_report) +
+							sizeof(set_rep_data),
+
+	/* declare wrong descriptor length */
+	.report.len = sizeof(set_rep_data) + 1,
+	/* init report.data[0] */
+	.buf = set_rep_data,
+};
+
+static struct hidhost_set_report_data hidhost_set_report_data_unders = {
+	.hdr.service_id = HAL_SERVICE_ID_HIDHOST,
+	.hdr.opcode = HAL_OP_HIDHOST_SET_REPORT,
+	.hdr.len = sizeof(struct hal_cmd_hidhost_set_report) +
+							sizeof(set_rep_data),
+
+	/* declare wrong descriptor length */
+	.report.len = sizeof(set_rep_data) - 1,
+	/* init report.data[0] */
+	.buf = set_rep_data,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -996,6 +1031,20 @@ int main(int argc, char *argv[])
 			HAL_OP_HIDHOST_SET_REPORT,
 			sizeof(struct hal_cmd_hidhost_set_report), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Set Report Vardata+",
+			ipc_send_tc, setup, teardown,
+			&hidhost_set_report_data_overs,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_set_report) +
+				sizeof(set_rep_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_generic("Data size HIDHOST Set Report Vardata-",
+			ipc_send_tc, setup, teardown,
+			&hidhost_set_report_data_unders,
+			(sizeof(struct hal_hdr) +
+				sizeof(struct hal_cmd_hidhost_set_report) +
+				sizeof(set_rep_data)),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 	test_datasize_valid("HIDHOST Send Data+", HAL_SERVICE_ID_HIDHOST,
 			HAL_OP_HIDHOST_SEND_DATA,
 			sizeof(struct hal_cmd_hidhost_send_data), 1,
-- 
1.8.5.2

