Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 2/2] tools/mgmt-tester: Add RPA Remove Device test case
Date: Mon, 13 Jul 2015 14:41:17 +0200
Message-Id: <1436791277-3386-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1436791277-3386-1-git-send-email-jpawlowski@google.com>
References: <1436791277-3386-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test verify if kernel correctly responds with error to
Remove Device command with Resolvable Private Address.
---
 tools/mgmt-tester.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9b71156..9ace20a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3797,6 +3797,19 @@ static const struct generic_data remove_device_fail_2 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const uint8_t remove_device_param_3[] = {
+					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
+					0x02,
+};
+static const struct generic_data remove_device_fail_3 = {
+	.send_opcode = MGMT_OP_REMOVE_DEVICE,
+	.send_param = remove_device_param_3,
+	.send_len = sizeof(remove_device_param_3),
+	.expect_param = remove_device_param_3,
+	.expect_len = sizeof(remove_device_param_3),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static const struct generic_data remove_device_success_1 = {
 	.send_opcode = MGMT_OP_REMOVE_DEVICE,
 	.send_param = remove_device_param_1,
@@ -6739,6 +6752,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Remove Device - Invalid Params 2",
 				&remove_device_fail_2,
 				NULL, test_command_generic);
+	test_bredrle("Remove Device - Invalid Params 3",
+				&remove_device_fail_3,
+				NULL, test_command_generic);
 	test_bredrle("Remove Device - Success 1",
 				&remove_device_success_1,
 				setup_add_device, test_command_generic);
-- 
2.1.4

