Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 32/35] tools/mgmt-tester: Interleaved stop discovery (LE dev. found)
Date: Wed, 12 Jun 2013 08:57:18 -0400
Message-Id: <1371041841-21793-33-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will check the stop interleaved discovery during LE scanning.
For this, it it verifies the following:
- LE Set Scan Enable HCI command is received,
- Device found event (with LE device) is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 46ab3b0..150c76f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1425,6 +1425,22 @@ static const struct generic_data stop_discovery_le_sucess_test_4 = {
 	.expect_alt_ev_len = sizeof(start_le_device_found_evt),
 };
 
+static const struct generic_data stop_discovery_bredrle_success_test_5 = {
+	.hciemu_type_second = HCIEMU_TYPE_LE,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.setup_expect_hci_param = start_discovery_valid_hci,
+	.setup_expect_hci_len = sizeof(start_discovery_valid_hci),
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_param,
+	.send_len = sizeof(stop_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredrle_param,
+	.expect_len = sizeof(stop_discovery_bredrle_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = start_le_device_found_evt,
+	.expect_alt_ev_len = sizeof(start_le_device_found_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -3195,6 +3211,9 @@ int main(int argc, char *argv[])
 	test_le("Stop Discovery (Device Found) - Success 4",
 				&stop_discovery_le_sucess_test_4,
 				setup_le_powered, test_command_start_discovery);
+	test_bredrle("Stop discovery (Device Found) - Success 5",
+				&stop_discovery_bredrle_success_test_5,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

