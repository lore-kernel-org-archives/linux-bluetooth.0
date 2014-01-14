Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/8] androi/ipc-tester: Add more cases for malformed data
Date: Tue, 14 Jan 2014 13:14:45 +0100
Message-Id: <1389701685-1861-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389701685-1861-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests for more types of possible data malformations.
---
 android/ipc-negative-tester.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 8ec3308..cac7f59 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -585,6 +585,48 @@ static const struct generic_data malformed_data = {
 	.num_services = 1,
 };
 
+static const struct generic_data malformed_data2 = {
+	.ipc_data = {
+		/* use proper msg */
+		.buffer = &register_bt_msg,
+		/* but write incomplete */
+		.len = sizeof(register_bt_msg) - 1,
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
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
+static const struct generic_data malformed_data3 = {
+	.ipc_data = {
+		/* use malformed msg */
+		.buffer = &malformed_data3_msg,
+		.len = sizeof(malformed_data3_msg),
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
 struct hal_hdr enable_unknown_service_hdr = {
 	.service_id = HAL_SERVICE_ID_MAX + 1,
 	.opcode = HAL_OP_REGISTER_MODULE,
@@ -661,6 +703,10 @@ int main(int argc, char *argv[])
 						setup, ipc_send_tc, teardown);
 	test_bredrle("Malformed data (wrong payload declared)", &malformed_data,
 						setup, ipc_send_tc, teardown);
+	test_bredrle("Malformed data2 (undersized msg)", &malformed_data2,
+						setup, ipc_send_tc, teardown);
+	test_bredrle("Malformed data3 (oversized msg)", &malformed_data3,
+						setup, ipc_send_tc, teardown);
 	test_bredrle("Invalid service", &enable_unknown_service_data,
 						setup, ipc_send_tc, teardown);
 	test_bredrle("Enable unregistered service",
-- 
1.8.5.2

