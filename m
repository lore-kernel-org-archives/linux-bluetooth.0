Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/11] android/unit: Add test cases for proper handler calls
Date: Tue,  4 Feb 2014 15:39:01 +0100
Message-Id: <1391524749-2518-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests for calling proper opcode handler. Two handlers
are registered, but one always results in failure. No failure means that
proper opcode <-> handler maching is done by the ipc mechanism.
---
 android/test-ipc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 8e31507..1e027fa 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -368,6 +368,16 @@ static void test_cmd_handler_1(const void *buf, uint16_t len)
 	ipc_send_rsp(0, 1, 0);
 }
 
+static void test_cmd_handler_2(const void *buf, uint16_t len)
+{
+	ipc_send_rsp(0, 2, 0);
+}
+
+static void test_cmd_handler_invalid(const void *buf, uint16_t len)
+{
+	raise(SIGTERM);
+}
+
 static const struct test_data test_init_1 = {};
 
 static const struct hal_hdr test_cmd_1_hdr = {
@@ -376,6 +386,12 @@ static const struct hal_hdr test_cmd_1_hdr = {
 	.len = 0
 };
 
+static const struct hal_hdr test_cmd_2_hdr = {
+	.service_id = 0,
+	.opcode = 2,
+	.len = 0
+};
+
 static const struct test_data test_cmd_service_invalid_1 = {
 	.cmd = &test_cmd_1_hdr,
 	.cmd_size = sizeof(test_cmd_1_hdr),
@@ -403,6 +419,32 @@ static const struct test_data test_cmd_service_invalid_2 = {
 	.expected_signal = SIGTERM
 };
 
+static const struct ipc_handler cmd_handlers_invalid_2[] = {
+	{ test_cmd_handler_1, false, 0 },
+	{ test_cmd_handler_invalid, false, 0 }
+};
+
+static const struct ipc_handler cmd_handlers_invalid_1[] = {
+	{ test_cmd_handler_invalid, false, 0 },
+	{ test_cmd_handler_2, false, 0 },
+};
+
+static const struct test_data test_cmd_opcode_valid_1 = {
+	.cmd = &test_cmd_1_hdr,
+	.cmd_size = sizeof(test_cmd_1_hdr),
+	.service = 0,
+	.handlers = cmd_handlers_invalid_2,
+	.handlers_size = 2,
+};
+
+static const struct test_data test_cmd_opcode_valid_2 = {
+	.cmd = &test_cmd_2_hdr,
+	.cmd_size = sizeof(test_cmd_2_hdr),
+	.service = 0,
+	.handlers = cmd_handlers_invalid_1,
+	.handlers_size = 2,
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -417,6 +459,10 @@ int main(int argc, char *argv[])
 					&test_cmd_service_valid_1, test_cmd_reg);
 	g_test_add_data_func("/android_ipc/test_cmd_service_invalid_2",
 					&test_cmd_service_invalid_2, test_cmd_reg_1);
+	g_test_add_data_func("/android_ipc/test_cmd_opcode_valid_1",
+					&test_cmd_opcode_valid_1, test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_opcode_valid_2",
+					&test_cmd_opcode_valid_2, test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

