Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 09/10] tools/mgmt-tester: Refactor setup_start_discovery function
Date: Thu, 20 Mar 2014 12:25:12 +0100
Message-ID: <1395314713-13104-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes handling hook register from this
function and its callback as this is no longer necessary for any stop
discovery tests.

This patch also adds setup_send_param and setup_send_len  parameters to
test data so it is easy to control start discovery command parameters.
It is useful for tests:
Stop Discovery - Invalid parameters 1
Stop Discovery - BR/EDR (Inquiry) Success 1
---
 tools/mgmt-tester.c | 62 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a711d0d..64188f1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -362,6 +362,9 @@ struct generic_data {
 	uint16_t setup_expect_hci_command;
 	const void *setup_expect_hci_param;
 	uint8_t setup_expect_hci_len;
+	uint16_t setup_send_opcode;
+	const void *setup_send_param;
+	uint16_t setup_send_len;
 	bool send_index_none;
 	uint16_t send_opcode;
 	const void *send_param;
@@ -1734,6 +1737,8 @@ static const struct generic_data stop_discovery_success_test_1 = {
 
 static const struct generic_data stop_discovery_bredr_success_test_1 = {
 	.setup_settings = settings_powered,
+	.setup_send_param = start_discovery_bredr_param,
+	.setup_send_len = sizeof(start_discovery_bredr_param),
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredr_param,
 	.send_len = sizeof(stop_discovery_bredr_param),
@@ -1758,6 +1763,8 @@ static const struct generic_data stop_discovery_rejected_test_1 = {
 
 static const struct generic_data stop_discovery_invalid_param_test_1 = {
 	.setup_settings = settings_powered_le,
+	.setup_send_param = start_discovery_bredrle_param,
+	.setup_send_len = sizeof(start_discovery_bredrle_param),
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_invalid_param,
 	.send_len = sizeof(stop_discovery_bredrle_invalid_param),
@@ -2824,59 +2831,22 @@ static void setup_discovery_callback(uint8_t status, uint16_t length,
 	tester_setup_complete();
 }
 
-static bool setup_command_hci_callback(const void *data, uint16_t len,
-								void *user_data)
-{
-	struct test_data *tdata = tester_get_data();
-	const struct generic_data *test = tdata->test_data;
-
-	tester_print("HCI Command 0x%04x length %u (setup)",
-					test->setup_expect_hci_command, len);
-
-	if (len != test->setup_expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command (setup)");
-		tester_setup_failed();
-		goto done;
-	}
-
-	if (memcmp(data, test->setup_expect_hci_param, len) != 0) {
-		tester_warn("Unexpected HCI command parameter value (setup)");
-		tester_setup_failed();
-		goto done;
-	}
-
-	tester_setup_complete();
-
-done:
-	hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_PRE_EVT,
-			test->setup_expect_hci_command);
-
-	return false;
-}
-
 static void setup_start_discovery(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
-	const void *send_param = test->send_param;
-	uint16_t send_len = test->send_len;
-
-	if (test->setup_expect_hci_command) {
-		tester_print("Registering HCI command callback (setup)");
-		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
-				test->setup_expect_hci_command,
-				setup_command_hci_callback,
-				NULL);
+	const void *send_param = test->setup_send_param;
+	uint16_t send_len = test->setup_send_len;
+	unsigned char disc_param[] = { 0x07 };
 
-		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
-				send_len, send_param, NULL, NULL, NULL);
-	} else {
-		unsigned char disc_param[] = { 0x07 };
+	if (!send_param) {
+		send_param = disc_param;
+		send_len = 1;
+	}
 
-		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
-					sizeof(disc_param), disc_param,
+	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+					send_len, send_param,
 					setup_discovery_callback, NULL, NULL);
-	}
 }
 
 static void setup_multi_uuid32(const void *test_data)
-- 
1.8.4

