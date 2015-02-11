Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/4] tools/mgmt-tester: Add test for pair on not enabled transport
Date: Wed, 11 Feb 2015 12:32:09 +0100
Message-Id: <1423654332-32424-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If transport is not enabled but controller is capable, kernel replies
with MGMT_STATUS_REJECTED
---
 tools/mgmt-tester.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3eb058a..3dff98f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -407,6 +407,8 @@ struct generic_data {
 	bool client_enable_sc;
 	bool expect_sc_key;
 	bool force_power_off;
+	bool addr_type_avail;
+	uint8_t addr_type;
 };
 
 static const char dummy_data[] = { 0x00 };
@@ -2396,7 +2398,10 @@ static const void *pair_device_send_param_func(uint16_t *len)
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
@@ -2410,10 +2415,14 @@ static const void *pair_device_send_param_func(uint16_t *len)
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
@@ -2502,6 +2511,32 @@ static const void *client_bdaddr_param_func(uint8_t *len)
 	return bdaddr;
 }
 
+static uint16_t settings_powered_bondable_le[] = { MGMT_OP_SET_LE,
+							MGMT_OP_SET_BONDABLE,
+							MGMT_OP_SET_POWERED,
+							0 };
+
+static const struct generic_data pair_device_reject_transport_not_enabled_1 = {
+	.setup_settings = settings_powered_bondable_le,
+	.setup_nobredr = true,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_func = pair_device_expect_param_func,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_BREDR,
+};
+
+static const struct generic_data pair_device_reject_transport_not_enabled_2 = {
+	.setup_settings = settings_powered_bondable,
+	.send_opcode = MGMT_OP_PAIR_DEVICE,
+	.send_func = pair_device_send_param_func,
+	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_func = pair_device_expect_param_func,
+	.addr_type_avail = true,
+	.addr_type = BDADDR_LE_PUBLIC,
+};
+
 static const struct generic_data pair_device_reject_test_1 = {
 	.setup_settings = settings_powered_bondable,
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
@@ -5064,6 +5099,12 @@ int main(int argc, char *argv[])
 	test_bredrle("Pair Device - Power off 1",
 				&pair_device_power_off_test_1,
 				NULL, test_command_generic);
+	test_bredrle("Pair Device - Reject on not enabled transport 1",
+				&pair_device_reject_transport_not_enabled_1,
+				NULL, test_command_generic);
+	test_bredrle("Pair Device - Reject on not enabled transport 2",
+				&pair_device_reject_transport_not_enabled_2,
+				NULL, test_command_generic);
 	test_bredrle("Pair Device - Invalid Parameters 1",
 				&pair_device_invalid_param_test_1,
 				NULL, test_command_generic);
-- 
1.8.4

