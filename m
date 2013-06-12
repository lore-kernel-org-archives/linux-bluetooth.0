Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 30/35] tools/mgmt-tester: Add support to set emulator type
Date: Wed, 12 Jun 2013 08:57:16 -0400
Message-Id: <1371041841-21793-31-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was added a field in struct generic_data to let the tester chooses
the type of second emulator. The default value is a dual mode
controller.

Note: If the tester needs a specific controller type (value different of
dual mode) is mandatory to set hciemu_type_second value in test struct.
---
 tools/mgmt-tester.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index da05b4f..bfcf9b5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -62,6 +62,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	struct hciemu *hciemu_second;
+	enum hciemu_type hciemu_type_second;
 	uint16_t mgmt_index_second;
 	int unmet_conditions;
 };
@@ -276,7 +277,7 @@ static void setup_adv_powered_callback(uint8_t status, uint16_t length,
 
 	tester_print("Controller powered on");
 
-	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+	if (data->hciemu_type_second == HCIEMU_TYPE_BREDR) {
 		tester_setup_complete();
 		return;
 	}
@@ -289,7 +290,6 @@ static void second_powered_discoverable()
 {
 	struct test_data *data = tester_get_data();
 	unsigned char con_param[] = { 0x01 };
-	unsigned char discov_param[] = { 0x01, 0x00, 0x00 };
 
 	tester_print("Enabling connectable, discoverable and powered (second)");
 
@@ -297,9 +297,13 @@ static void second_powered_discoverable()
 					sizeof(con_param), con_param,
 					NULL, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_SET_DISCOVERABLE, data->mgmt_index_second,
-					sizeof(discov_param), discov_param,
-					NULL, NULL, NULL);
+	if (data->hciemu_type_second == HCIEMU_TYPE_BREDR) {
+		unsigned char discov_param[] = { 0x01, 0x00, 0x00 };
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_DISCOVERABLE,
+				data->mgmt_index_second, sizeof(discov_param),
+				discov_param, NULL, NULL, NULL);
+	}
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index_second,
 					sizeof(con_param), con_param,
@@ -515,6 +519,7 @@ struct generic_data {
 	const void *setup_expect_hci_param;
 	uint8_t setup_expect_hci_len;
 	uint16_t block_hci_command;
+	enum hciemu_type hciemu_type_second;
 	bool send_index_none;
 	uint16_t send_opcode;
 	const void *send_param;
@@ -1308,6 +1313,7 @@ static const struct generic_data start_discovery_valid_param_test_3 = {
 };
 
 static const struct generic_data start_discovery_valid_param_test_4 = {
+	.hciemu_type_second = HCIEMU_TYPE_LE,
 	.send_opcode = MGMT_OP_START_DISCOVERY,
 	.send_param = start_discovery_le_param,
 	.send_len = sizeof(start_discovery_le_param),
@@ -2091,11 +2097,13 @@ static void setup_le_powered_callback(uint8_t status, uint16_t length,
 static void setup_le_powered(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Powering on controller (with LE enabled)");
 
-	data->hciemu_second = hciemu_new(data->hciemu_type);
+	data->hciemu_type_second = test->hciemu_type_second;
+	data->hciemu_second = hciemu_new(data->hciemu_type_second);
 	if (!data->hciemu_second) {
 		tester_warn("Failed to setup second HCI emulation");
 		tester_setup_failed();
-- 
1.7.9.5

