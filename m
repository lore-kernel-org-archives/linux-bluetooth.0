Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 22/35] tools/mgmt-tester: BR/EDR Start discovery (Device Found)
Date: Wed, 12 Jun 2013 08:57:08 -0400
Message-Id: <1371041841-21793-23-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will start an BR/EDR discovery (inquiry) and verifies the
following:
- Inquiry HCI command is received, and
- Device found event is received.
---
 tools/mgmt-tester.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a27b2e2..d36b50c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1116,6 +1116,11 @@ static const char start_discovery_bredrle_param[] = { 0x07 };
 static const char start_discovery_valid_hci[] = { 0x01, 0x01 };
 static const char start_discovery_evt[] = { 0x07, 0x01 };
 static const char start_discovery_le_evt[] = { 0x06, 0x01 };
+static const char start_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08,
+									0x00 };
+static const char start_device_found_evt[] = { 0x00, 0x00, 0x02, 0x01, 0xaa,
+			0x00, 0x00, 0xc4, 0x03, 0x00, 0x00, 0x00, 0x05, 0x00,
+			0x04, 0x0d, 0x00, 0x00, 0x00, };
 
 static const struct generic_data start_discovery_not_powered_test_1 = {
 	.send_opcode = MGMT_OP_START_DISCOVERY,
@@ -1168,6 +1173,21 @@ static const struct generic_data start_discovery_valid_param_test_2 = {
 	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
 };
 
+static const struct generic_data start_discovery_valid_param_test_3 = {
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredr_param,
+	.send_len = sizeof(start_discovery_bredr_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredr_param,
+	.expect_len = sizeof(start_discovery_bredr_param),
+	.expect_hci_command = BT_HCI_CMD_INQUIRY,
+	.expect_hci_param = start_discovery_inq_param,
+	.expect_hci_len = sizeof(start_discovery_inq_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = start_device_found_evt,
+	.expect_alt_ev_len = sizeof(start_device_found_evt),
+};
+
 static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
@@ -2788,6 +2808,9 @@ int main(int argc, char *argv[])
 	test_le("Start Discovery - Success 2",
 				&start_discovery_valid_param_test_2,
 				setup_powered, test_command_generic);
+	test_bredr("Start Discovery (Device Found) - Success 3",
+				&start_discovery_valid_param_test_3,
+				setup_le_powered, test_command_generic);
 
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
-- 
1.7.9.5

