Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH 1/2] tools: Add tests for start discovery
Date: Tue,  2 Apr 2013 19:34:59 -0400
Message-Id: <1364945700-17156-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI command test and discovering event test for start discovery.
---
 tools/mgmt-tester.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ac7c01a..3def64e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1066,6 +1066,8 @@ static const char start_discovery_invalid_param[] = { 0x00 };
 static const char start_discovery_bredr_param[] = { 0x01 };
 static const char start_discovery_le_param[] = { 0x06 };
 static const char start_discovery_bredrle_param[] = { 0x07 };
+static const char start_discovery_valid_hci[] = { 0x01, 0x01 };
+static const char start_discovery_evt[] = { 0x07, 0x01 };
 
 static const struct generic_data start_discovery_not_powered_test_1 = {
 	.send_opcode = MGMT_OP_START_DISCOVERY,
@@ -1095,6 +1097,12 @@ static const struct generic_data start_discovery_valid_param_test_1 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = start_discovery_bredrle_param,
 	.expect_len = sizeof(start_discovery_bredr_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_hci,
+	.expect_hci_len = sizeof(start_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_evt),
 };
 
 static const char stop_discovery_bredrle_param[] = { 0x07 };
-- 
1.7.9.5

