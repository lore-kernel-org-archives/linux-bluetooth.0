Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 08/11] android/ipc-tester: Add more cases for malformed data
Date: Mon, 20 Jan 2014 10:36:07 +0100
Message-Id: <1390210570-28260-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests for more types of possible data malformations.
---
 android/ipc-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index c8bc9b8..db0a30a 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -581,6 +581,27 @@ struct regmod_msg register_bt_malformed_size_msg = {
 		},
 };
 
+struct malformed_data3_struct {
+	struct regmod_msg valid_msg;
+	int redundant_data;
+}  __attribute__((packed));
+
+static struct malformed_data3_struct malformed_data3_msg = {
+	/* valid register service message */
+	.valid_msg = {
+		.header = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			.opcode = HAL_OP_REGISTER_MODULE,
+			.len = sizeof(struct hal_cmd_register_module),
+			},
+		.cmd = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			},
+	},
+	/* plus redundant data */
+	. redundant_data = 666,
+};
+
 struct hal_hdr enable_unknown_service_hdr = {
 	.service_id = HAL_SERVICE_ID_MAX + 1,
 	.opcode = HAL_OP_REGISTER_MODULE,
@@ -610,6 +631,18 @@ int main(int argc, char *argv[])
 				sizeof(register_bt_malformed_size_msg),
 				HAL_SERVICE_ID_BLUETOOTH);
 
+	test_generic("Malformed data2 (undersized msg)",
+				ipc_send_tc, setup, teardown,
+				&register_bt_msg,
+				sizeof(register_bt_msg) - 1,
+				HAL_SERVICE_ID_BLUETOOTH);
+
+	test_generic("Malformed data3 (oversized msg)",
+				ipc_send_tc, setup, teardown,
+				&malformed_data3_msg,
+				sizeof(malformed_data3_msg),
+				HAL_SERVICE_ID_BLUETOOTH);
+
 	test_generic("Invalid service",
 				ipc_send_tc, setup, teardown,
 				&enable_unknown_service_hdr,
-- 
1.8.5.2

