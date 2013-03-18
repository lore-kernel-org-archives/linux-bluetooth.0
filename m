Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 2/4] tools: Add basic success test for stop discovery
Date: Mon, 18 Mar 2013 16:53:04 -0400
Message-Id: <1363639986-16231-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
References: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1ecac5a..ce6f75f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1097,6 +1097,17 @@ static const struct generic_data start_discovery_valid_param_test_1 = {
 	.expect_len = sizeof(start_discovery_bredr_param),
 };
 
+static const char stop_discovery_bredrle_param[] = { 0x07 };
+
+static const struct generic_data stop_discovery_success_test_1 = {
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_param,
+	.send_len = sizeof(stop_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredrle_param,
+	.expect_len = sizeof(stop_discovery_bredrle_param),
+};
+
 static const char set_dev_class_valid_param[] = { 0x01, 0x0c };
 static const char set_dev_class_zero_rsp[] = { 0x00, 0x00, 0x00 };
 static const char set_dev_class_valid_rsp[] = { 0x0c, 0x01, 0x00 };
@@ -1759,6 +1770,54 @@ static void setup_le_powered(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_discovery_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Discovery started");
+	tester_setup_complete();
+}
+
+static void setup_start_discovery_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char disc_param[] = { 0x07 };
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Controller powered on");
+
+	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+					sizeof(disc_param), disc_param,
+					setup_discovery_callback, NULL, NULL);
+
+	if (option_wait_powered)
+		tester_wait(1, NULL, NULL);
+}
+
+static void setup_start_discovery(const void *test_data)
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
+				sizeof(param), param,
+				setup_start_discovery_callback, NULL, NULL);
+}
+
 static void setup_ssp_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -2537,6 +2596,10 @@ int main(int argc, char *argv[])
 				&start_discovery_valid_param_test_1,
 				setup_le_powered, test_command_generic);
 
+	test_bredrle("Stop Discovery - Success 1",
+				&stop_discovery_success_test_1,
+				setup_start_discovery, test_command_generic);
+
 	test_bredrle("Set Device Class - Success 1",
 				&set_dev_class_valid_param_test_1,
 				NULL, test_command_generic);
-- 
1.7.9.5

