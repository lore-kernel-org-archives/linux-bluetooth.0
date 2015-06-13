Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 12/15] tools/mgmt-tester: test advertising timeout
Date: Sat, 13 Jun 2015 05:42:56 +0200
Message-Id: <1434166979-21824-13-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The change introduces an additional test that waits for an advertising
timeout to occur and checks whether the timed out advertising instance
is correctly being removed and - if it was the last instance -
advertising disabled.
---
 doc/test-coverage.txt |  4 ++--
 tools/mgmt-tester.c   | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 89d9991..9c8b9bc 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 297	Kernel management interface testing
+mgmt-tester		 298	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
@@ -49,7 +49,7 @@ gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 userchan-tester		   3	Kernel HCI User Channel testting
 			-----
-			 368
+			 369
 
 
 Android end-to-end testing
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f612836..581fde6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1628,6 +1628,7 @@ static const char set_adv_on_param[] = { 0x01 };
 static const char set_adv_settings_param_1[] = { 0x80, 0x06, 0x00, 0x00 };
 static const char set_adv_settings_param_2[] = { 0x81, 0x06, 0x00, 0x00 };
 static const char set_adv_on_set_adv_enable_param[] = { 0x01 };
+static const char set_adv_on_set_adv_disable_param[] = { 0x00 };
 
 static const struct generic_data set_adv_on_success_test_1 = {
 	.setup_settings = settings_le,
@@ -4524,6 +4525,16 @@ static const struct generic_data add_advertising_success_18 = {
 	.expect_hci_len = sizeof(set_adv_data_uuid),
 };
 
+static const struct generic_data add_advertising_timeout_expired = {
+	.send_opcode = TESTER_NOOP_OPCODE,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = set_adv_on_set_adv_disable_param,
+	.expect_hci_len = sizeof(set_adv_on_set_adv_disable_param),
+};
+
 static const uint8_t remove_advertising_param_1[] = {
 	0x01,
 };
@@ -5117,7 +5128,7 @@ static void setup_add_advertising_timeout(const void *test_data)
 	memset(cp, 0, sizeof(*cp));
 
 	cp->instance = 1;
-	cp->timeout = 5;
+	cp->timeout = 1;
 	cp->adv_data_len = 6;
 	cp->data[0] = 0x05; /* AD len */
 	cp->data[1] = 0x08; /* AD type: shortened local name */
@@ -6669,6 +6680,13 @@ int main(int argc, char *argv[])
 					&add_advertising_success_18,
 					setup_add_advertising,
 					test_command_generic);
+	/* An instance should be removed and advertising disabled once
+	 * the timeout for all instances has been reached.
+	 */
+	test_bredrle_full("Add Advertising - Success 20 (Timeout expires)",
+					&add_advertising_timeout_expired,
+					setup_add_advertising_timeout,
+					test_command_generic, 3);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
1.9.1

