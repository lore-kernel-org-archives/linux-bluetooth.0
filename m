Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 09/16] tools/mgmt-tester: keep instances on power cycle
Date: Thu, 18 Jun 2015 03:17:39 +0200
Message-Id: <1434590266-26744-10-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tests that instances that do not have a timeout will survive a power
cycle.
---
 doc/test-coverage.txt |  4 +--
 tools/mgmt-tester.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 6 deletions(-)

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
index ddf82c1..0100f51 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4262,7 +4262,7 @@ static const char set_powered_adv_instance_settings_param[] = {
 	0x81, 0x02, 0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_success_2 = {
+static const struct generic_data add_advertising_success_pwron_data = {
 	.send_opcode = MGMT_OP_SET_POWERED,
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
@@ -4274,7 +4274,7 @@ static const struct generic_data add_advertising_success_2 = {
 	.expect_hci_len = sizeof(set_adv_data_test),
 };
 
-static const struct generic_data add_advertising_success_3 = {
+static const struct generic_data add_advertising_success_pwron_enabled = {
 	.send_opcode = MGMT_OP_SET_POWERED,
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
@@ -5123,6 +5123,59 @@ static void setup_add_advertising_timeout(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_power_cycle_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param_off[] = { 0x00 };
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param_off), &param_off,
+						NULL, NULL, NULL);
+
+	setup_bthost();
+}
+
+static void setup_add_advertising_power_cycle(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param_on[] = { 0x01 };
+
+	tester_print("Adding instance without timeout and power cycle");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param_on), &param_on,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param_on), &param_on,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_power_cycle_callback,
+						NULL, NULL);
+}
+
 static void setup_set_and_add_advertising(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -6583,11 +6636,11 @@ int main(int argc, char *argv[])
 					&add_advertising_success_1,
 					NULL, test_command_generic);
 	test_bredrle("Add Advertising - Success 2 (!Powered, Add Adv Inst)",
-					&add_advertising_success_2,
+					&add_advertising_success_pwron_data,
 					setup_add_advertising_not_powered,
 					test_command_generic);
 	test_bredrle("Add Advertising - Success 3 (!Powered, Adv Enable)",
-					&add_advertising_success_3,
+					&add_advertising_success_pwron_enabled,
 					setup_add_advertising_not_powered,
 					test_command_generic);
 	test_bredrle("Add Advertising - Success 4 (Set Adv on override)",
@@ -6636,10 +6689,16 @@ int main(int argc, char *argv[])
 					&add_advertising_success_17,
 					setup_add_advertising_connectable,
 					test_command_generic);
+	/* Adv instances with a timeout do NOT survive a power cycle. */
 	test_bredrle("Add Advertising - Success 18 (Power -> off, Remove)",
 					&add_advertising_power_off,
 					setup_add_advertising_timeout,
 					test_command_generic);
+	/* Adv instances without timeout survive a power cycle. */
+	test_bredrle("Add Advertising - Success 19 (Power -> off, Keep)",
+					&add_advertising_success_pwron_data,
+					setup_add_advertising_power_cycle,
+					test_command_generic);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
1.9.1

