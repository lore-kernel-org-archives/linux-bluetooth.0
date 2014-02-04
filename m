Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/11] android/unit: Add test case for variable sized data
Date: Tue,  4 Feb 2014 15:39:04 +0100
Message-Id: <1391524749-2518-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if sending variable length data with proper msg size declared inside the
header succeeds.
---
 android/test-ipc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index a2d3085..523011e 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -461,6 +461,32 @@ static const struct test_data test_cmd_opcode_invalid_1 = {
 	.expected_signal = SIGTERM
 };
 
+#define VARDATA_EX1 "some data example"
+
+struct vardata {
+	struct hal_hdr hdr;
+	uint8_t data[BLUEZ_HAL_MTU - sizeof(struct hal_hdr)];
+} __attribute__((packed));
+
+static const struct vardata test_cmd_vardata = {
+	.hdr.service_id = 0,
+	.hdr.opcode = 1,
+	.hdr.len = sizeof(VARDATA_EX1),
+	.data = VARDATA_EX1,
+};
+
+static const struct ipc_handler cmd_vardata_handlers[] = {
+	{ test_cmd_handler_1, true, sizeof(VARDATA_EX1) }
+};
+
+static const struct test_data test_cmd_vardata_valid = {
+	.cmd = &test_cmd_vardata,
+	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.service = 0,
+	.handlers = cmd_vardata_handlers,
+	.handlers_size = 1,
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -482,6 +508,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_opcode_invalid_1",
 					&test_cmd_opcode_invalid_1,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_vardata_valid",
+					&test_cmd_vardata_valid,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

