Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 2/3] tools/mgmt-tester: Test cases for connectable state change
Date: Sat, 28 Mar 2015 12:54:00 -0700
Message-Id: <1427572441-31225-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427572441-31225-1-git-send-email-armansito@chromium.org>
References: <1427572441-31225-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test cases for correctly updating the advertising type
when the global connectable setting changes.
---
 tools/mgmt-tester.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index b9be59e..5b11cb7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4289,6 +4289,33 @@ static const struct generic_data add_advertising_success_15 = {
 	.expect_hci_len = sizeof(set_connectable_on_adv_param),
 };
 
+static const char set_connectable_settings_param_3[] = {
+						0x83, 0x02, 0x00, 0x00 };
+
+static const struct generic_data add_advertising_success_16 = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_on_param,
+	.send_len = sizeof(set_connectable_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_connectable_settings_param_3,
+	.expect_len = sizeof(set_connectable_settings_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
+	.expect_hci_param = set_connectable_on_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_adv_param),
+};
+
+static const struct generic_data add_advertising_success_17 = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_off_param,
+	.send_len = sizeof(set_connectable_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_2,
+	.expect_len = sizeof(set_le_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
+	.expect_hci_param = set_connectable_off_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+};
+
 static const char set_powered_off_le_settings_param[] = {
 	0x80, 0x02, 0x00, 0x00
 };
@@ -4779,6 +4806,45 @@ static void setup_add_advertising(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_add_advertising_connectable(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05;
+	cp->data[1] = 0x08;
+	cp->data[2] = 't';
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
 static void setup_add_advertising_timeout(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -6265,6 +6331,14 @@ int main(int argc, char *argv[])
 	test_bredrle("Add Advertising - Success 12 - ADV_IND",
 					&add_advertising_success_15,
 					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Success 13 - connectable -> on",
+					&add_advertising_success_16,
+					setup_add_advertising,
+					test_command_generic);
+	test_bredrle("Add Advertising - Success 14 - connectable -> off",
+					&add_advertising_success_17,
+					setup_add_advertising_connectable,
+					test_command_generic);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
2.2.0.rc0.207.ga3a616c

