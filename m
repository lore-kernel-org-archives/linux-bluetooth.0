Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 1/6] tools/mgmt-tester: Add RPA Add Device test case
Date: Fri, 17 Jul 2015 22:51:35 +0200
Message-Id: <1437166300-14633-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test verify if kernel correctly responds with error to
Add Device command with Resolvable Private Address.
---
 tools/mgmt-tester.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 46b088c..9b71156 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3665,6 +3665,24 @@ static const struct generic_data add_device_fail_3 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const uint8_t add_device_nval_4[] = {
+					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
+					0x02,
+					0x02,
+};
+static const uint8_t add_device_rsp_4[] =  {
+					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
+					0x02,
+};
+static const struct generic_data add_device_fail_4 = {
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_param = add_device_nval_4,
+	.send_len = sizeof(add_device_nval_4),
+	.expect_param = add_device_rsp_4,
+	.expect_len = sizeof(add_device_rsp_4),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static const uint8_t add_device_success_param_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0x00,
@@ -6696,6 +6714,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Add Device - Invalid Params 3",
 				&add_device_fail_3,
 				NULL, test_command_generic);
+	test_bredrle("Add Device - Invalid Params 4",
+				&add_device_fail_4,
+				NULL, test_command_generic);
 	test_bredrle("Add Device - Success 1",
 				&add_device_success_1,
 				NULL, test_command_generic);
-- 
2.1.4

