Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [BlueZ 3/3] tools: add read adv features success tests
Date: Sun,  5 Apr 2015 20:39:25 +0200
Message-Id: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428259165-10021-1-git-send-email-fgrandel@gmail.com>
References: <1428259165-10021-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mgmt-tester did not yet contains tests for the happy path of the
MGMT_OP_READ_ADV_FEATURES command. This patch adds two tests: one
calling the command without an advertising instance and one with one
advertising instance added.
---
 doc/test-coverage.txt |  2 +-
 tools/mgmt-tester.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index fa8a04a..19bb73c 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 293	Kernel management interface testing
+mgmt-tester		 295	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 174c3b7..d9e1c6f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3862,6 +3862,28 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 	.expect_status = MGMT_STATUS_INVALID_INDEX,
 };
 
+static const uint8_t read_adv_features_rsp_1[] =  {
+			0x1f, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x00,
+};
+
+static const struct generic_data read_adv_features_success_1 = {
+	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
+	.expect_param = read_adv_features_rsp_1,
+	.expect_len = sizeof(read_adv_features_rsp_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const uint8_t read_adv_features_rsp_2[] =  {
+			0x1f, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x01, 0x01
+};
+
+static const struct generic_data read_adv_features_success_2 = {
+	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
+	.expect_param = read_adv_features_rsp_2,
+	.expect_len = sizeof(read_adv_features_rsp_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 static const uint8_t add_advertising_param_1[] = {
 	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
 	0x03, 0x02, 0x0d, 0x18,
@@ -6384,6 +6406,13 @@ int main(int argc, char *argv[])
 	test_bredrle("Read Advertising Features - Invalid index",
 				&read_adv_features_invalid_index_test,
 				NULL, test_command_generic);
+	test_bredrle("Read Advertising Features - Success 1 (No instance)",
+				&read_adv_features_success_1,
+				NULL, test_command_generic);
+	test_bredrle("Read Advertising Features - Success 2 (One instance)",
+				&read_adv_features_success_2,
+				setup_add_advertising,
+				test_command_generic);
 
 	test_bredrle("Add Advertising - Failure: LE off",
 					&add_advertising_fail_1,
-- 
1.9.1

