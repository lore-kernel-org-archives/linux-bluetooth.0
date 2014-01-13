Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] android/ipc-tester: Add basic negative test cases for IPC's daemon site
Date: Mon, 13 Jan 2014 11:37:02 +0100
Message-Id: <1389609422-21200-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add first few test cases checking for proper daemon
termination in case of receiving invalid IPC data.

---
 android/ipc-negative-tester.c | 120 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 3 deletions(-)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 7b2bbf8..15701e8 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -540,22 +540,136 @@ static void ipc_send_tc(const void *data)
 							3, user, g_free); \
 	} while (0)
 
-static const struct generic_data dummy_data = {
+struct regmod_msg register_bt_msg = {
+		.header = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			.opcode = HAL_OP_REGISTER_MODULE,
+			.len = sizeof(struct hal_cmd_register_module),
+			},
+		.cmd = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			},
+	};
+
+static const struct generic_data to_small_data = {
 	.ipc_data = {
-		.buffer = "",
+		/* valid header and payload */
+		.buffer = &register_bt_msg,
+		/* but write only incomplete header */
 		.len = 1,
 	},
 	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
 	.num_services = 1,
 };
 
+struct regmod_msg register_bt_malformed_size_msg = {
+		.header = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			.opcode = HAL_OP_REGISTER_MODULE,
+			/* wrong payload size declared */
+			.len = sizeof(struct hal_cmd_register_module) - 1,
+			},
+		.cmd = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			},
+	};
+
+static const struct generic_data malformed_data = {
+	.ipc_data = {
+		/* use malformed msg - wrong size declared */
+		.buffer = &register_bt_malformed_size_msg,
+		/* but write proper size */
+		.len = sizeof(struct hal_cmd_register_module),
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
+struct hal_hdr enable_unknown_service_hdr = {
+	.service_id = HAL_SERVICE_ID_MAX + 1,
+	.opcode = HAL_OP_ENABLE,
+	.len = 0,
+};
+
+static const struct generic_data enable_unknown_service_data = {
+	.ipc_data = {
+		/* enable invalid service */
+		.buffer = &enable_unknown_service_hdr,
+		.len = sizeof(enable_unknown_service_hdr),
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
+struct hal_hdr enable_bt_service_hdr = {
+	.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.opcode = HAL_OP_ENABLE,
+	.len = 0,
+};
+
+static const struct generic_data enable_unregistered_service_data = {
+	.ipc_data = {
+		/* valid msg */
+		.buffer = &enable_bt_service_hdr,
+		/* send the whole thing */
+		.len = sizeof(enable_bt_service_hdr),
+	},
+	/* but don't register it before enabling */
+	.init_services = {},
+	.num_services = 0,
+};
+
+struct hal_hdr invalid_opcode_hdr = {
+	.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.opcode = 0x16,
+	.len = 0,
+};
+
+static const struct generic_data invalid_opcode_data = {
+	.ipc_data = {
+		/* valid msg */
+		.buffer = &invalid_opcode_hdr,
+		/* send the whole thing */
+		.len = sizeof(invalid_opcode_hdr),
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
+struct hal_hdr invalid_msg_size_hdr = {
+	.service_id = HAL_SERVICE_ID_BLUETOOTH,
+	.opcode = HAL_OP_CREATE_BOND,
+	.len = 0,
+};
+
+static const struct generic_data invalid_msg_size_data = {
+	.ipc_data = {
+		.buffer = &invalid_msg_size_hdr,
+		.len = sizeof(invalid_msg_size_hdr),
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Test Dummy", &dummy_data, setup, ipc_send_tc, teardown);
+	test_bredrle("To small data", &to_small_data,
+						setup, ipc_send_tc, teardown);
+	test_bredrle("Malformed data", &malformed_data,
+						setup, ipc_send_tc, teardown);
+	test_bredrle("Invalid service", &enable_unknown_service_data,
+						setup, ipc_send_tc, teardown);
+	test_bredrle("Enable unregistered service",
+					&enable_unregistered_service_data,
+					setup, ipc_send_tc, teardown);
+	test_bredrle("Invalid opcode", &invalid_opcode_data,
+						setup, ipc_send_tc, teardown);
+	test_bredrle("Invalid msg size for opcode", &invalid_msg_size_data,
+						setup, ipc_send_tc, teardown);
 
 	return tester_run();
 }
-- 
1.8.5

