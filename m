Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] tools: Add mgmt test case for pair device while powered off
Date: Fri, 18 Jan 2013 12:51:34 +0100
Message-ID: <1358509895-7460-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tests if kernel is responding with proper command complete event.
---
 tools/mgmt-tester.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index cb02480..5c72d00 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -916,6 +916,20 @@ static const struct generic_data add_uuid32_test_1 = {
 	.expect_hci_len = sizeof(write_eir_uuid32_hci),
 };
 
+static const char pair_device_param[] = {
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x00, 0x00 };
+static const char pair_device_rsp[] = {
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x00 };
+
+static const struct generic_data pair_device_not_powered_test_1 = {
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_param = pair_device_param,
+	.send_len = sizeof(pair_device_param),
+	.expect_status = MGMT_STATUS_NOT_POWERED,
+	.expect_param = pair_device_rsp,
+	.expect_len = sizeof(pair_device_rsp),
+};
+
 static void setup_powered_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1414,5 +1428,8 @@ int main(int argc, char *argv[])
 	test_bredr("Add UUID - UUID-32 1", &add_uuid32_test_1, setup_ssp,
 				test_command_generic);
 
+	test_bredr("Pair Device - Not Powered 1",
+				&pair_device_not_powered_test_1, NULL,
+				test_command_generic);
 	return tester_run();
 }
-- 
1.8.0.3

