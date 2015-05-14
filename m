Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] tools/mgmt-tester: Add Device Found test with invalid ADV_DATA
Date: Thu, 14 May 2015 12:50:29 +0200
Message-Id: <1431600630-8568-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
References: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test verify if kernel correctly terminates EIR when invalid
ADV_DATA (length includes non-significant part) was received from
 remote device.
---
 tools/mgmt-tester.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fd5ef7d..3ecddab 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -429,6 +429,9 @@ struct generic_data {
 	bool force_power_off;
 	bool addr_type_avail;
 	uint8_t addr_type;
+	bool set_adv;
+	const uint8_t *adv_data;
+	uint8_t adv_data_len;
 };
 
 static const char dummy_data[] = { 0x00 };
@@ -4467,6 +4470,33 @@ static const struct generic_data remove_advertising_success_2 = {
 	.expect_hci_len = sizeof(set_adv_off_param),
 };
 
+/* based on G-Tag ADV_DATA */
+static const uint8_t adv_data_invalid_significant_len[] = { 0x02, 0x01, 0x06,
+		0x0d, 0xff, 0x80, 0x01, 0x02, 0x15, 0x12, 0x34, 0x80, 0x91,
+		0xd0, 0xf2, 0xbb, 0xc5, 0x03, 0x02, 0x0f, 0x18, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
+static const char device_found_valid[] = { 0x00, 0x00, 0x01, 0x01, 0xaa, 0x00,
+		0x01, 0x7f, 0x00, 0x00, 0x00, 0x00, 0x15, 0x00, 0x02, 0x01,
+		0x06, 0x0d, 0xff, 0x80, 0x01, 0x02, 0x15, 0x12, 0x34, 0x80,
+		0x91, 0xd0, 0xf2, 0xbb, 0xc5, 0x03, 0x02, 0x0f, 0x18 };
+
+static const struct generic_data device_found_gtag = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = device_found_valid,
+	.expect_alt_ev_len = sizeof(device_found_valid),
+	.set_adv = true,
+	.adv_data_len = sizeof(adv_data_invalid_significant_len),
+	.adv_data = adv_data_invalid_significant_len,
+};
+
 static const struct generic_data read_local_oob_not_powered_test = {
 	.send_opcode = MGMT_OP_READ_LOCAL_OOB_DATA,
 	.expect_status = MGMT_STATUS_NOT_POWERED,
@@ -5481,6 +5511,29 @@ static void test_command_generic(const void *test_data)
 	test_add_condition(data);
 }
 
+static void test_device_found(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct bthost *bthost;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	if ((data->hciemu_type == HCIEMU_TYPE_LE) ||
+				(data->hciemu_type == HCIEMU_TYPE_BREDRLE)) {
+		if (test->set_adv)
+			bthost_set_adv_data(bthost, test->adv_data,
+							test->adv_data_len);
+
+		bthost_set_adv_enable(bthost, 0x01);
+	}
+
+	if (data->hciemu_type != HCIEMU_TYPE_LE)
+		bthost_write_scan_enable(bthost, 0x03);
+
+	test_command_generic(test_data);
+}
+
 static void pairing_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -6535,5 +6588,9 @@ int main(int argc, char *argv[])
 				&read_local_oob_success_sc_test,
 				NULL, test_command_generic);
 
+	test_bredrle("Device Found - Invalid remote ADV_DATA",
+				&device_found_gtag,
+				NULL, test_device_found);
+
 	return tester_run();
 }
-- 
1.9.3

