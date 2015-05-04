Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/4] tools/mgmt-tester: Remove unused set_adv_data_2
Date: Mon,  4 May 2015 16:28:13 -0700
Message-Id: <1430782094-18396-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1430782094-18396-1-git-send-email-armansito@chromium.org>
References: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the unused variable "set_adv_data_2" from
tools/mgmt-tester.c. The remaining set_adv_data_* variables have also
been renamed to keep the numbering sequential.
---
 tools/mgmt-tester.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c0f58ce..fab8d35 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1865,7 +1865,6 @@ static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
 static const char stop_discovery_evt[] = { 0x07, 0x00 };
 static const char stop_discovery_bredr_param[] = { 0x01 };
 static const char stop_discovery_bredr_discovering[] = { 0x01, 0x00 };
-static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.setup_settings = settings_powered_le,
@@ -3946,48 +3945,41 @@ static const uint8_t set_adv_data_1[] = {
 };
 
 static const uint8_t set_adv_data_2[] = {
-	0x0c, 0x02, 0x01, 0x04, 0x03, 0x03, 0x0d, 0x18, 0x04, 0xff,
-	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-};
-
-static const uint8_t set_adv_data_3[] = {
 	0x06, 0x05, 0x08, 0x74, 0x65, 0x73, 0x74, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_4[] = {
+static const uint8_t set_adv_data_3[] = {
 	0x03, 0x02, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_5[] = {
+static const uint8_t set_adv_data_4[] = {
 	0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
 	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_6[] = {
+static const uint8_t set_adv_data_5[] = {
 	0x0c, 0x02, 0x01, 0x01, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
 	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_7[] = {
+static const uint8_t set_adv_data_6[] = {
 	0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
 	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_8[] = {
+static const uint8_t set_adv_data_7[] = {
 	0x0c, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
 	0x02, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -4193,8 +4185,8 @@ static const struct generic_data add_advertising_success_2 = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_3,
-	.expect_hci_len = sizeof(set_adv_data_3),
+	.expect_hci_param = set_adv_data_2,
+	.expect_hci_len = sizeof(set_adv_data_2),
 };
 
 static const struct generic_data add_advertising_success_3 = {
@@ -4217,8 +4209,8 @@ static const struct generic_data add_advertising_success_4 = {
 	.expect_param = set_adv_settings_param_2,
 	.expect_len = sizeof(set_adv_settings_param_2),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_4,
-	.expect_hci_len = sizeof(set_adv_data_4),
+	.expect_hci_param = set_adv_data_3,
+	.expect_hci_len = sizeof(set_adv_data_3),
 };
 
 static const char set_adv_off_param[] = { 0x00 };
@@ -4231,8 +4223,8 @@ static const struct generic_data add_advertising_success_5 = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_3,
-	.expect_hci_len = sizeof(set_adv_data_3),
+	.expect_hci_param = set_adv_data_2,
+	.expect_hci_len = sizeof(set_adv_data_2),
 };
 
 static const struct generic_data add_advertising_success_6 = {
@@ -4289,8 +4281,8 @@ static const struct generic_data add_advertising_success_9 = {
 	.expect_len = sizeof(advertising_instance_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_5,
-	.expect_hci_len = sizeof(set_adv_data_5),
+	.expect_hci_param = set_adv_data_4,
+	.expect_hci_len = sizeof(set_adv_data_4),
 };
 
 static const struct generic_data add_advertising_success_10 = {
@@ -4302,8 +4294,8 @@ static const struct generic_data add_advertising_success_10 = {
 	.expect_len = sizeof(advertising_instance_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_6,
-	.expect_hci_len = sizeof(set_adv_data_6),
+	.expect_hci_param = set_adv_data_5,
+	.expect_hci_len = sizeof(set_adv_data_5),
 };
 
 static const struct generic_data add_advertising_success_11 = {
@@ -4315,8 +4307,8 @@ static const struct generic_data add_advertising_success_11 = {
 	.expect_len = sizeof(advertising_instance_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_7,
-	.expect_hci_len = sizeof(set_adv_data_7),
+	.expect_hci_param = set_adv_data_6,
+	.expect_hci_len = sizeof(set_adv_data_6),
 };
 
 static const struct generic_data add_advertising_success_12 = {
@@ -4328,8 +4320,8 @@ static const struct generic_data add_advertising_success_12 = {
 	.expect_len = sizeof(advertising_instance_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_8,
-	.expect_hci_len = sizeof(set_adv_data_8),
+	.expect_hci_param = set_adv_data_7,
+	.expect_hci_len = sizeof(set_adv_data_7),
 };
 
 static uint16_t settings_powered_le_connectable[] = {
-- 
2.2.0.rc0.207.ga3a616c

