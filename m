Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/6] tools/mgmt-tester: Remove Advertising test cases
Date: Fri, 20 Mar 2015 19:52:55 -0700
Message-Id: <1426906378-14804-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test cases for the Remove Advertising command.
---
 tools/mgmt-tester.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6d334c6..1648dc8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3970,6 +3970,51 @@ static const struct generic_data add_advertising_success_5 = {
 	.expect_hci_len = sizeof(set_adv_data_3),
 };
 
+static const uint8_t remove_advertising_param_1[] = {
+	0x01,
+};
+
+static const uint8_t remove_advertising_param_2[] = {
+	0x00,
+};
+
+static const struct generic_data remove_advertising_fail_1 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_1,
+	.send_len = sizeof(remove_advertising_param_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data remove_advertising_success_1 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_1,
+	.send_len = sizeof(remove_advertising_param_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = remove_advertising_param_1,
+	.expect_len = sizeof(remove_advertising_param_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance_param,
+	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = set_adv_off_param,
+	.expect_hci_len = sizeof(set_adv_off_param),
+};
+
+static const struct generic_data remove_advertising_success_2 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_2,
+	.send_len = sizeof(remove_advertising_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = remove_advertising_param_1,
+	.expect_len = sizeof(remove_advertising_param_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance_param,
+	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = set_adv_off_param,
+	.expect_hci_len = sizeof(set_adv_off_param),
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -5798,5 +5843,17 @@ int main(int argc, char *argv[])
 					setup_set_and_add_advertising,
 					test_command_generic);
 
+	test_bredrle("Remove Advertising - Invalid Params 1",
+					&remove_advertising_fail_1,
+					NULL, test_command_generic);
+	test_bredrle("Remove Advertising - Success 1",
+						&remove_advertising_success_1,
+						setup_add_advertising,
+						test_command_generic);
+	test_bredrle("Remove Advertising - Success 2",
+						&remove_advertising_success_2,
+						setup_add_advertising,
+						test_command_generic);
+
 	return tester_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

