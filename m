Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/11] android/unit: Add case for out of range service
Date: Tue,  4 Feb 2014 15:39:06 +0100
Message-Id: <1391524749-2518-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check reaction for sending message to services not listed inside
hal-msg.h
---
 android/test-ipc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 2120d15..6bb6cd6 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -499,6 +499,21 @@ static const struct test_data test_cmd_vardata_valid_2 = {
 	.handlers_size = 1,
 };
 
+static const struct hal_hdr test_cmd_service_offrange_hdr = {
+	.service_id = HAL_SERVICE_ID_MAX + 1,
+	.opcode = 1,
+	.len = 0
+};
+
+static const struct test_data test_cmd_service_offrange = {
+	.cmd = &test_cmd_service_offrange_hdr,
+	.cmd_size = sizeof(struct hal_hdr),
+	.service = HAL_SERVICE_ID_MAX + 1,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -526,6 +541,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_vardata_valid_2",
 					&test_cmd_vardata_valid_2,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_service_offrange",
+					&test_cmd_service_offrange,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

