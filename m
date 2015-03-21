Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 5/6] tools/mgmt-tester: Add Advertising timeout test cases
Date: Fri, 20 Mar 2015 19:52:57 -0700
Message-Id: <1426906378-14804-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test cases for the Add Advertising command when a
timeout parameter has been given.
---
 tools/mgmt-tester.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index aebcd90..5de9967 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3794,6 +3794,12 @@ static const uint8_t add_advertising_param_2[] = {
 	0x05, 0x03, 0x0d, 0x18, 0x0f, 0x18,
 };
 
+static const uint8_t add_advertising_param_3[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18,
+	0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
 static const uint8_t advertising_instance_param[] = {
 	0x01,
 };
@@ -3989,6 +3995,14 @@ static const struct generic_data add_advertising_fail_11 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const struct generic_data add_advertising_fail_12 = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_3,
+	.send_len = sizeof(add_advertising_param_3),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
 static const struct generic_data add_advertising_success_1 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
@@ -4091,6 +4105,22 @@ static const struct generic_data add_advertising_success_7 = {
 	.expect_hci_len = sizeof(set_scan_rsp_1),
 };
 
+static const char set_powered_off_le_settings_param[] = {
+	0x80, 0x02, 0x00, 0x00
+};
+
+static const struct generic_data add_advertising_timeout_power_off = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_off_param,
+	.send_len = sizeof(set_powered_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_off_le_settings_param,
+	.expect_len = sizeof(set_powered_off_le_settings_param),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance_param,
+	.expect_alt_ev_len = sizeof(advertising_instance_param),
+};
+
 static const uint8_t remove_advertising_param_1[] = {
 	0x01,
 };
@@ -4565,6 +4595,42 @@ static void setup_add_advertising(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_add_advertising_timeout(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->timeout = 5;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05;
+	cp->data[1] = 0x08;
+	cp->data[2] = 't';
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
 static void setup_set_and_add_advertising(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -5959,6 +6025,13 @@ int main(int argc, char *argv[])
 	test_le("Add Advertising - Invalid Params 10 (ScRsp too long)",
 					&add_advertising_fail_11,
 					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Timeout Not Powered",
+					&add_advertising_fail_12,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Timeout Power off",
+					&add_advertising_timeout_power_off,
+					setup_add_advertising_timeout,
+					test_command_generic);
 	test_bredrle("Add Advertising - Success 1",
 					&add_advertising_success_1,
 					NULL, test_command_generic);
-- 
2.2.0.rc0.207.ga3a616c

