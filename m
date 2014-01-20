Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 07/11] android/ipc-tester: Add basic test cases for IPC's daemon site
Date: Mon, 20 Jan 2014 10:36:06 +0100
Message-Id: <1390210570-28260-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds first few test cases checking for proper daemon
termination in case of receiving invalid IPC data.
---
 android/ipc-tester.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 816719c..c8bc9b8 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -569,15 +569,57 @@ struct regmod_msg register_bt_msg = {
 		},
 };
 
+struct regmod_msg register_bt_malformed_size_msg = {
+	.header = {
+		.service_id = HAL_SERVICE_ID_CORE,
+		.opcode = HAL_OP_REGISTER_MODULE,
+		/* wrong payload size declared */
+		.len = sizeof(struct hal_cmd_register_module) - 1,
+		},
+	.cmd = {
+		.service_id = HAL_SERVICE_ID_CORE,
+		},
+};
+
+struct hal_hdr enable_unknown_service_hdr = {
+	.service_id = HAL_SERVICE_ID_MAX + 1,
+	.opcode = HAL_OP_REGISTER_MODULE,
+	.len = 0,
+};
+
+struct hal_hdr enable_bt_service_hdr = {
+	.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.opcode = HAL_OP_ENABLE,
+	.len = 0,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
 
 	tester_init(&argc, &argv);
 
+	/* check general IPC errors */
 	test_generic("Too small data",
 				ipc_send_tc, setup, teardown,
 				&register_bt_msg, 1);
 
+	test_generic("Malformed data (wrong payload declared)",
+				ipc_send_tc, setup, teardown,
+				&register_bt_malformed_size_msg,
+				sizeof(register_bt_malformed_size_msg),
+				HAL_SERVICE_ID_BLUETOOTH);
+
+	test_generic("Invalid service",
+				ipc_send_tc, setup, teardown,
+				&enable_unknown_service_hdr,
+				sizeof(enable_unknown_service_hdr),
+				HAL_SERVICE_ID_BLUETOOTH);
+
+	test_generic("Enable unregistered service",
+				ipc_send_tc, setup, teardown,
+				&enable_bt_service_hdr,
+				sizeof(enable_bt_service_hdr));
+
 	return tester_run();
 }
-- 
1.8.5.2

