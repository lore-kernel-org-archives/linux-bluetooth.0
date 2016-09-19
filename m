Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 2/2] tools/mgmt-tester: Test Set Appearance support in different modes
Date: Mon, 19 Sep 2016 14:33:35 +0200
Message-Id: <1474288415-16308-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474288415-16308-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474288415-16308-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 91b5aa7..75736bf 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6351,6 +6351,24 @@ static const uint8_t set_scan_rsp_data_appearance1[] = {
 
 static const uint8_t set_appearance_param[2] = { 0x54, 0x65 };
 
+static const struct generic_data set_appearance_not_supported = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const struct generic_data set_appearance_success = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
 static const struct generic_data add_advertising_with_appearance1 = {
 	.setup_settings = settings_powered_le,
 	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
@@ -7872,6 +7890,21 @@ int main(int argc, char *argv[])
 					setup_add_advertising_duration,
 					test_command_generic, 3);
 
+	test_bredr("Set appearance - BR/EDR only",
+					&set_appearance_not_supported,
+					NULL,
+					test_command_generic);
+
+	test_bredrle("Set appearance - BR/EDR LE",
+					&set_appearance_success,
+					NULL,
+					test_command_generic);
+
+	test_le("Set appearance - LE only",
+					&set_appearance_success,
+					NULL,
+					test_command_generic);
+
 	test_bredrle("Add Advertising - Scan rsp flags 1",
 					&add_advertising_with_local_name1,
 					setup_set_local_name,
-- 
2.7.4

