Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 1/4] tools: Add basic success test for start discovery
Date: Mon, 18 Mar 2013 16:53:03 -0400
Message-Id: <1363639986-16231-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
References: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6343221..1ecac5a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1065,6 +1065,7 @@ static const struct generic_data set_local_name_test_3 = {
 static const char start_discovery_invalid_param[] = { 0x00 };
 static const char start_discovery_bredr_param[] = { 0x01 };
 static const char start_discovery_le_param[] = { 0x06 };
+static const char start_discovery_bredrle_param[] = { 0x07 };
 
 static const struct generic_data start_discovery_not_powered_test_1 = {
 	.send_opcode = MGMT_OP_START_DISCOVERY,
@@ -1087,6 +1088,15 @@ static const struct generic_data start_discovery_not_supported_test_1 = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
+static const struct generic_data start_discovery_valid_param_test_1 = {
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredrle_param,
+	.send_len = sizeof(start_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredrle_param,
+	.expect_len = sizeof(start_discovery_bredr_param),
+};
+
 static const char set_dev_class_valid_param[] = { 0x01, 0x0c };
 static const char set_dev_class_zero_rsp[] = { 0x00, 0x00, 0x00 };
 static const char set_dev_class_valid_rsp[] = { 0x0c, 0x01, 0x00 };
@@ -1734,6 +1744,21 @@ static void setup_ssp_powered(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_le_powered(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Powering on controller (with LE enabled)");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
 static void setup_ssp_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -2508,6 +2533,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Start Discovery - Not supported 1",
 				&start_discovery_not_supported_test_1,
 				setup_powered, test_command_generic);
+	test_bredrle("Start Discovery - Success 1",
+				&start_discovery_valid_param_test_1,
+				setup_le_powered, test_command_generic);
 
 	test_bredrle("Set Device Class - Success 1",
 				&set_dev_class_valid_param_test_1,
-- 
1.7.9.5

