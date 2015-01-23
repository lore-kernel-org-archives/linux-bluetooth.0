Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] tools/mgmt-tester: Add test for LE pair reject on BREDR controller
Date: Fri, 23 Jan 2015 12:54:33 +0100
Message-Id: <1422014075-6897-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1422014075-6897-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422014075-6897-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this test we make sure that on dual mode controllers, le pairing is
possible only when LE support is enabled on the HOST.
---
 tools/mgmt-tester.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 92351e4..9c986a3 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -406,6 +406,8 @@ struct generic_data {
 	bool client_enable_sc;
 	bool expect_sc_key;
 	bool force_power_off;
+	bool addr_type_avail;
+	uint8_t addr_type;
 };
 
 static const char dummy_data[] = { 0x00 };
@@ -2395,7 +2397,10 @@ static const void *pair_device_send_param_func(uint16_t *len)
 	static uint8_t param[8];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+
+	if (test->addr_type_avail)
+		param[6] = test->addr_type;
+	else if (data->hciemu_type == HCIEMU_TYPE_LE)
 		param[6] = 0x01; /* Address type */
 	else
 		param[6] = 0x00; /* Address type */
@@ -2409,10 +2414,14 @@ static const void *pair_device_send_param_func(uint16_t *len)
 static const void *pair_device_expect_param_func(uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 	static uint8_t param[7];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+
+	if (test->addr_type_avail)
+		param[6] = test->addr_type;
+	else if (data->hciemu_type == HCIEMU_TYPE_LE)
 		param[6] = 0x01; /* Address type */
 	else
 		param[6] = 0x00; /* Address type */
@@ -2865,6 +2874,16 @@ static const struct generic_data pair_device_le_reject_test_1 = {
 	.reject_confirm = true,
 };
 
+static const struct generic_data pair_device_le_reject_test_2 = {
+	.setup_settings = settings_powered_bondable,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_func = pair_device_expect_param_func,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_LE_PUBLIC,
+};
+
 static uint16_t settings_powered_sc_bondable[] = { MGMT_OP_SET_BONDABLE,
 						MGMT_OP_SET_SECURE_CONN,
 						MGMT_OP_SET_POWERED, 0 };
@@ -5132,6 +5151,9 @@ int main(int argc, char *argv[])
 	test_le("Pair Device - LE Reject 1",
 				&pair_device_le_reject_test_1,
 				NULL, test_command_generic);
+	test_bredrle("Pair Device - LE Reject 2",
+				&pair_device_le_reject_test_2,
+				NULL, test_command_generic);
 	test_le("Pair Device - LE SC Legacy 1",
 				&pair_device_le_sc_legacy_test_1,
 				NULL, test_command_generic);
-- 
1.8.4

