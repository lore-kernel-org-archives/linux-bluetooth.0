Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 35/35] tools/mgmt-tester: Interleaved Stop discovery (Name Resolving)
Date: Wed, 12 Jun 2013 08:57:21 -0400
Message-Id: <1371041841-21793-36-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will check the stop interleaved discovery during name
resolving operation. For this, it verifies the following:
- LE Set Scan Enable HCI command is received,
- Device found event (with BR/EDR device) is received,
- Remote name request cancel is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index b995076..f001240 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1459,6 +1459,26 @@ static const struct generic_data stop_discovery_bredrle_success_test_6 = {
 	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
 };
 
+static const struct generic_data stop_discovery_bredr_success_test_7 = {
+	.hciemu_type_second = HCIEMU_TYPE_BREDR,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.setup_expect_hci_param = start_discovery_valid_hci,
+	.setup_expect_hci_len = sizeof(start_discovery_valid_hci),
+	.block_hci_command = BT_HCI_EVT_INQUIRY_COMPLETE,
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_param,
+	.send_len = sizeof(stop_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredrle_param,
+	.expect_len = sizeof(stop_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL,
+	.expect_hci_param = stop_remote_name_valid_hci,
+	.expect_hci_len = sizeof(stop_remote_name_valid_hci),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = stop_device_found_bredr_evt,
+	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -3258,6 +3278,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Stop discovery (Device Found) - Success 6",
 				&stop_discovery_bredrle_success_test_6,
 				setup_le_powered, test_command_start_discovery);
+	test_bredrle("Stop Discovery (Name Resolving) - Success 7",
+				&stop_discovery_bredr_success_test_7,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

