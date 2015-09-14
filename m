Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] tools/tester: Add Device Found test with invalid field length
Date: Mon, 14 Sep 2015 22:03:16 +0200
Message-Id: <1442260996-15843-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test verify if kernel correctly terminates EIR when invalid
advertising data (field length too big) was received from
remote device.
---
 tools/mgmt-tester.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9ace20a..0a1a7c2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4707,6 +4707,30 @@ static const struct generic_data device_found_gtag = {
 	.adv_data = adv_data_invalid_significant_len,
 };
 
+static const uint8_t adv_data_invalid_field_len[] = { 0x02, 0x01, 0x01,
+		0x05, 0x09, 0x74, 0x65, 0x73, 0x74,
+		0xa0, 0xff, 0x01, 0x02, 0x03, 0x04, 0x05};
+
+static const char device_found_valid2[] = { 0x00, 0x00, 0x01, 0x01, 0xaa, 0x00,
+		0x01, 0x7f, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x02, 0x01,
+		0x01, 0x05, 0x09, 0x74, 0x65, 0x73, 0x74};
+
+static const struct generic_data device_found_invalid_field = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = device_found_valid2,
+	.expect_alt_ev_len = sizeof(device_found_valid2),
+	.set_adv = true,
+	.adv_data_len = sizeof(adv_data_invalid_field_len),
+	.adv_data = adv_data_invalid_field_len,
+};
+
 static const struct generic_data read_local_oob_not_powered_test = {
 	.send_opcode = MGMT_OP_READ_LOCAL_OOB_DATA,
 	.expect_status = MGMT_STATUS_NOT_POWERED,
@@ -6957,9 +6981,12 @@ int main(int argc, char *argv[])
 				&read_local_oob_success_sc_test,
 				NULL, test_command_generic);
 
-	test_bredrle("Device Found - Invalid remote ADV_DATA",
+	test_bredrle("Device Found - Advertising data - Zero padded",
 				&device_found_gtag,
 				NULL, test_device_found);
+	test_bredrle("Device Found - Advertising data - Invalid field",
+				&device_found_invalid_field,
+				NULL, test_device_found);
 
 	return tester_run();
 }
-- 
2.5.0

