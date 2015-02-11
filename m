Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/4] tools/mgmt-tester: Add test for pair on not supported transport
Date: Wed, 11 Feb 2015 12:32:10 +0100
Message-Id: <1423654332-32424-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If controller is not capable for giver transport, kernel will reply on
pair request with MGMT_STATUS_NOT_SUPPORTED
---
 tools/mgmt-tester.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3dff98f..18a5335 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2511,6 +2511,26 @@ static const void *client_bdaddr_param_func(uint8_t *len)
 	return bdaddr;
 }
 
+static const struct generic_data pair_device_not_supported_test_1 = {
+	.setup_settings = settings_powered_bondable,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+	.expect_func = pair_device_expect_param_func,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_BREDR,
+};
+
+static const struct generic_data pair_device_not_supported_test_2 = {
+	.setup_settings = settings_powered_bondable,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+	.expect_func = pair_device_expect_param_func,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_LE_PUBLIC,
+};
+
 static uint16_t settings_powered_bondable_le[] = { MGMT_OP_SET_LE,
 							MGMT_OP_SET_BONDABLE,
 							MGMT_OP_SET_POWERED,
@@ -5099,6 +5119,12 @@ int main(int argc, char *argv[])
 	test_bredrle("Pair Device - Power off 1",
 				&pair_device_power_off_test_1,
 				NULL, test_command_generic);
+	test_le("Pair Device - Incorrect transport reject 1",
+				&pair_device_not_supported_test_1,
+				NULL, test_command_generic);
+	test_bredr("Pair Device - Incorrect transport reject 2",
+				&pair_device_not_supported_test_2,
+				NULL, test_command_generic);
 	test_bredrle("Pair Device - Reject on not enabled transport 1",
 				&pair_device_reject_transport_not_enabled_1,
 				NULL, test_command_generic);
-- 
1.8.4

