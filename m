Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH 2/2] tools:  Add tests for stop discovery
Date: Tue,  2 Apr 2013 19:35:00 -0400
Message-Id: <1364945700-17156-2-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945700-17156-1-git-send-email-alvaro.silva@openbossa.org>
References: <1364945700-17156-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI test and discovering event test for stop discovery.
---
 tools/mgmt-tester.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3def64e..3f16e67 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1107,6 +1107,8 @@ static const struct generic_data start_discovery_valid_param_test_1 = {
 
 static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
+static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
+static const char stop_discovery_evt[] = { 0x07, 0x00 };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
@@ -1115,6 +1117,12 @@ static const struct generic_data stop_discovery_success_test_1 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = stop_discovery_bredrle_param,
 	.expect_len = sizeof(stop_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = stop_discovery_valid_hci,
+	.expect_hci_len = sizeof(stop_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = stop_discovery_evt,
+	.expect_alt_ev_len = sizeof(stop_discovery_evt),
 };
 
 static const struct generic_data stop_discovery_rejected_test_1 = {
-- 
1.7.9.5

