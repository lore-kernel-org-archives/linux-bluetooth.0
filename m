Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 13/15] tools/mgmt-tester: test le off
Date: Sat, 13 Jun 2015 05:42:57 +0200
Message-Id: <1434166979-21824-14-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test that advertising instances will be removed when disabling the le
capability of a brle bluetooth device.
---
 doc/test-coverage.txt |  4 ++--
 tools/mgmt-tester.c   | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 9c8b9bc..50e29b5 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 298	Kernel management interface testing
+mgmt-tester		 299	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
@@ -49,7 +49,7 @@ gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 userchan-tester		   3	Kernel HCI User Channel testting
 			-----
-			 369
+			 370
 
 
 Android end-to-end testing
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 581fde6..315c326 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1550,6 +1550,7 @@ static const struct generic_data set_hs_on_invalid_index_test = {
 static uint16_t settings_le[] = { MGMT_OP_SET_LE, 0 };
 
 static const char set_le_on_param[] = { 0x01 };
+static const char set_le_off_param[] = { 0x00 };
 static const char set_le_invalid_param[] = { 0x02 };
 static const char set_le_garbage_param[] = { 0x01, 0x00 };
 static const char set_le_settings_param_1[] = { 0x80, 0x02, 0x00, 0x00 };
@@ -4513,6 +4514,20 @@ static const struct generic_data add_advertising_power_off = {
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 };
 
+static const char set_le_settings_param_off[] = { 0x81, 0x00, 0x00, 0x00 };
+
+static const struct generic_data add_advertising_le_off = {
+	.send_opcode = MGMT_OP_SET_LE,
+	.send_param = set_le_off_param,
+	.send_len = sizeof(set_le_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_off,
+	.expect_len = sizeof(set_le_settings_param_off),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+};
+
 static const struct generic_data add_advertising_success_18 = {
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
 	.send_param = add_advertising_param_uuid,
@@ -6687,6 +6702,12 @@ int main(int argc, char *argv[])
 					&add_advertising_timeout_expired,
 					setup_add_advertising_timeout,
 					test_command_generic, 3);
+	/* Test that le off will clear (remove) all instances */
+	test_bredrle("Add Advertising - Success 21 (LE -> off, Remove)",
+					&add_advertising_le_off,
+					setup_add_advertising,
+					test_command_generic);
+
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
1.9.1

