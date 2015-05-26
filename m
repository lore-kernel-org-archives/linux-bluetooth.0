Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v7 4/4] tools/mgmt-tester: add an additional add adv test
Date: Tue, 26 May 2015 03:22:09 +0200
Message-Id: <1432603329-12846-5-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600555-8008-1-git-send-email-fgrandel@gmail.com>
References: <1432600555-8008-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test covers a use case that had not been tested before: When an
advertising instance has already been added and is then added again with
different advertising data, the new advertising data should be
advertised.
---
 doc/test-coverage.txt |  4 ++--
 tools/mgmt-tester.c   | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 26e5855..89d9991 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 296	Kernel management interface testing
+mgmt-tester		 297	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
@@ -49,7 +49,7 @@ gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 userchan-tester		   3	Kernel HCI User Channel testting
 			-----
-			 365
+			 368
 
 
 Android end-to-end testing
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 474d258..675c35c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4510,6 +4510,18 @@ static const struct generic_data add_advertising_timeout_power_off = {
 	.expect_alt_ev_len = sizeof(advertising_instance_param),
 };
 
+static const struct generic_data add_advertising_success_18 = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_1,
+	.send_len = sizeof(add_advertising_param_1),
+	.expect_param = advertising_instance_param,
+	.expect_len = sizeof(advertising_instance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_1,
+	.expect_hci_len = sizeof(set_adv_data_1),
+};
+
 static const uint8_t remove_advertising_param_1[] = {
 	0x01,
 };
@@ -6641,6 +6653,10 @@ int main(int argc, char *argv[])
 					&add_advertising_success_17,
 					setup_add_advertising_connectable,
 					test_command_generic);
+	test_bredrle("Add Advertising - Success 19 (Add Adv override)",
+					&add_advertising_success_18,
+					setup_add_advertising,
+					test_command_generic);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
1.9.1

