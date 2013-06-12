Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 31/35] tools/mgmt-tester: LE Stop discovery (Device Found)
Date: Wed, 12 Jun 2013 08:57:17 -0400
Message-Id: <1371041841-21793-32-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

This test will check the stop LE discovery (scan enable). For this, it
verifies the following:
- LE Set Scan Enable HCI command is received,
- Device found event is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bfcf9b5..46ab3b0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1333,6 +1333,7 @@ static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
 static const char stop_discovery_evt[] = { 0x07, 0x00 };
 static const char stop_discovery_bredr_param[] = { 0x01 };
+static const char stop_discovery_le_param[] = { 0x06 };
 static const char stop_discovery_bredr_discovering[] = { 0x01, 0x00 };
 static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
 static const char stop_device_found_bredr_evt[] = { 0x00, 0x00, 0x02, 0x01,
@@ -1408,6 +1409,22 @@ static const struct generic_data stop_discovery_bredr_success_test_3 = {
 	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
 };
 
+static const struct generic_data stop_discovery_le_sucess_test_4 = {
+	.hciemu_type_second = HCIEMU_TYPE_LE,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.setup_expect_hci_param = start_discovery_valid_hci,
+	.setup_expect_hci_len = sizeof(start_discovery_valid_hci),
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_le_param,
+	.send_len = sizeof(stop_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_le_param,
+	.expect_len = sizeof(stop_discovery_le_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = start_le_device_found_evt,
+	.expect_alt_ev_len = sizeof(start_le_device_found_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -3175,6 +3192,9 @@ int main(int argc, char *argv[])
 	test_bredr("Stop Discovery (Name Resolving) - Success 3",
 				&stop_discovery_bredr_success_test_3,
 				setup_le_powered, test_command_start_discovery);
+	test_le("Stop Discovery (Device Found) - Success 4",
+				&stop_discovery_le_sucess_test_4,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

