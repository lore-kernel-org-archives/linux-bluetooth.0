Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 3/4] tools/mgmt-tester: Fix not updating scan rsp when adv off
Date: Wed,  5 Oct 2016 12:27:16 +0200
Message-Id: <1475663237-3070-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1475663237-3070-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1475663237-3070-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Scan response data should not be updated unless there
is an advertising instance. So set scan rsp data hci commands
wont be fired on setup.
---
 tools/mgmt-tester.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bc770b7..feef5f1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6221,9 +6221,6 @@ static const uint8_t set_scan_rsp_data_name[] = {
 
 static const struct generic_data add_advertising_name_in_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = set_local_name_param,
 	.setup_send_len = sizeof(set_local_name_param),
@@ -6253,9 +6250,6 @@ static const uint8_t set_scan_rsp_data_empty[] = {
 
 static const struct generic_data add_advertising_empty_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = set_local_name_param,
 	.setup_send_len = sizeof(set_local_name_param),
@@ -6265,9 +6259,6 @@ static const struct generic_data add_advertising_empty_scrsp = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_empty,
-	.expect_hci_len = sizeof(set_scan_rsp_data_empty),
 };
 
 static const uint8_t add_advertising_param_name_data_scrsp[] = {
@@ -6300,9 +6291,6 @@ static const uint8_t set_scan_rsp_data_name_data[] = {
 
 static const struct generic_data add_advertising_name_data_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = set_local_name_param,
 	.setup_send_len = sizeof(set_local_name_param),
@@ -6349,9 +6337,6 @@ static const uint8_t set_scan_rsp_data_shortened_name[] = {
 
 static const struct generic_data add_advertising_dta_name_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = set_local_name_param,
 	.setup_send_len = sizeof(set_local_name_param),
@@ -6392,9 +6377,6 @@ static const uint8_t set_scan_rsp_data_short_name[] = {
 
 static const struct generic_data add_advertising_dta_short_name_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = &set_local_name_cp,
 	.setup_send_len = sizeof(set_local_name_cp),
-- 
2.7.4

