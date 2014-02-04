Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/11] android/unit: Add negative case for msg size verification
Date: Tue,  4 Feb 2014 15:39:07 +0100
Message-Id: <1391524749-2518-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Case for checking message size declared inside the header against the
amount of data sent for variable sized message.
---
 android/test-ipc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 6bb6cd6..e4463eb 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -499,6 +499,15 @@ static const struct test_data test_cmd_vardata_valid_2 = {
 	.handlers_size = 1,
 };
 
+static const struct test_data test_cmd_vardata_invalid_1 = {
+	.cmd = &test_cmd_vardata,
+	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1) - 1,
+	.service = 0,
+	.handlers = cmd_vardata_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 static const struct hal_hdr test_cmd_service_offrange_hdr = {
 	.service_id = HAL_SERVICE_ID_MAX + 1,
 	.opcode = 1,
@@ -541,6 +550,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_vardata_valid_2",
 					&test_cmd_vardata_valid_2,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_vardata_invalid_1",
+					&test_cmd_vardata_invalid_1,
+					test_cmd_reg);
 	g_test_add_data_func("/android_ipc/test_cmd_service_offrange",
 					&test_cmd_service_offrange,
 					test_cmd_reg);
-- 
1.8.5.2

