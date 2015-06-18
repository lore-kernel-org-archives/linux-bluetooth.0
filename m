Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 16/16] tools/mgmt-tester: test multi-adv
Date: Thu, 18 Jun 2015 03:17:46 +0200
Message-Id: <1434590266-26744-17-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests and required test infrastructure for multi
advertising tests.
---
 doc/test-coverage.txt |   4 +-
 tools/mgmt-tester.c   | 215 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 190 insertions(+), 29 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 3e1c759..819ac50 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 300	Kernel management interface testing
+mgmt-tester		 302	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
@@ -49,7 +49,7 @@ gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 userchan-tester		   3	Kernel HCI User Channel testting
 			-----
-			 371
+			 373
 
 
 Android end-to-end testing
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e8333de..46b088c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3990,10 +3990,28 @@ static const uint8_t add_advertising_param_txpwr[] = {
 	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
 };
 
+/* add advertising command for a second instance */
+static const uint8_t add_advertising_param_test2[] = {
+	0x02,				/* adv instance */
+	0x00, 0x00, 0x00, 0x00,		/* flags: none */
+	0x00, 0x00,			/* duration: default */
+	0x01, 0x00,			/* timeout: 1 second */
+	0x07,				/* adv data len */
+	0x00,				/* scan rsp len */
+	/* adv data: */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
+};
+
 static const uint8_t advertising_instance1_param[] = {
 	0x01,
 };
 
+static const uint8_t advertising_instance2_param[] = {
+	0x02,
+};
+
 static const uint8_t set_adv_data_uuid[] = {
 	/* adv data len */
 	0x09,
@@ -4005,15 +4023,26 @@ static const uint8_t set_adv_data_uuid[] = {
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_test[] = {
-	0x06,			/* adv data len */
-	0x05,			/* AD len */
-	0x08,			/* AD type: shortened local name */
-	0x74, 0x65, 0x73, 0x74,	/* "test" */
+static const uint8_t set_adv_data_test1[] = {
+	0x07,				/* adv data len */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x31,	/* "test1" */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_test2[] = {
+	0x07,				/* adv data len */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
 };
 
 static const uint8_t set_adv_data_txpwr[] = {
@@ -4277,8 +4306,8 @@ static const struct generic_data add_advertising_success_pwron_data = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_test,
-	.expect_hci_len = sizeof(set_adv_data_test),
+	.expect_hci_param = set_adv_data_test1,
+	.expect_hci_len = sizeof(set_adv_data_test1),
 };
 
 static const struct generic_data add_advertising_success_pwron_enabled = {
@@ -4315,8 +4344,8 @@ static const struct generic_data add_advertising_success_5 = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_test,
-	.expect_hci_len = sizeof(set_adv_data_test),
+	.expect_hci_param = set_adv_data_test1,
+	.expect_hci_len = sizeof(set_adv_data_test1),
 };
 
 static const struct generic_data add_advertising_success_6 = {
@@ -4595,6 +4624,31 @@ static const struct generic_data remove_advertising_success_2 = {
 	.expect_hci_len = sizeof(set_adv_off_param),
 };
 
+static const struct generic_data multi_advertising_switch = {
+	.send_opcode = TESTER_NOOP_OPCODE,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_test2,
+	.expect_hci_len = sizeof(set_adv_data_test2),
+};
+
+static const struct generic_data multi_advertising_add_second = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_test2,
+	.send_len = sizeof(add_advertising_param_test2),
+	.expect_param = advertising_instance2_param,
+	.expect_len = sizeof(advertising_instance2_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance2_param,
+	.expect_alt_ev_len = sizeof(advertising_instance2_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_test2,
+	.expect_hci_len = sizeof(set_adv_data_test2),
+};
+
 /* based on G-Tag ADV_DATA */
 static const uint8_t adv_data_invalid_significant_len[] = { 0x02, 0x01, 0x06,
 		0x0d, 0xff, 0x80, 0x01, 0x02, 0x15, 0x12, 0x34, 0x80, 0x91,
@@ -5015,40 +5069,48 @@ static void setup_add_device(const void *test_data)
 static void setup_add_advertising_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
+	struct mgmt_rp_add_advertising *rp =
+				(struct mgmt_rp_add_advertising *) param;
+
 	if (status != MGMT_STATUS_SUCCESS) {
 		tester_setup_failed();
 		return;
 	}
 
-	tester_print("Add Advertising setup complete");
+	tester_print("Add Advertising setup complete (instance %d)",
+								rp->instance);
 
 	setup_bthost();
 }
 
-static void setup_add_adv_param(struct mgmt_cp_add_advertising *cp)
+#define TESTER_ADD_ADV_DATA_LEN 7
+
+static void setup_add_adv_param(struct mgmt_cp_add_advertising *cp,
+							uint8_t instance)
 {
 	memset(cp, 0, sizeof(*cp));
-	cp->instance = 1;
-	cp->adv_data_len = 6;
-	cp->data[0] = 0x05; /* AD len */
+	cp->instance = instance;
+	cp->adv_data_len = TESTER_ADD_ADV_DATA_LEN;
+	cp->data[0] = TESTER_ADD_ADV_DATA_LEN - 1; /* AD len */
 	cp->data[1] = 0x08; /* AD type: shortened local name */
 	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
+	cp->data[6] = '0' + instance;
 }
 
 static void setup_add_advertising_not_powered(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Adding advertising instance while unpowered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5064,13 +5126,13 @@ static void setup_add_advertising(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5090,13 +5152,13 @@ static void setup_add_advertising_connectable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Adding advertising instance while connectable");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5120,13 +5182,13 @@ static void setup_add_advertising_timeout(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Adding advertising instance with timeout");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 	cp->timeout = 1;
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
@@ -5143,6 +5205,34 @@ static void setup_add_advertising_timeout(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_add_advertising_duration(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding instance with long timeout/short duration");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+	cp->duration = 1;
+	cp->timeout = 30;
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
 static void setup_power_cycle_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -5165,13 +5255,13 @@ static void setup_add_advertising_power_cycle(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param_on[] = { 0x01 };
 
 	tester_print("Adding instance without timeout and power cycle");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param_on), &param_on,
@@ -5191,13 +5281,13 @@ static void setup_set_and_add_advertising(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
-	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Set and add advertising instance");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp);
+	setup_add_adv_param(cp, 1);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -5217,6 +5307,61 @@ static void setup_set_and_add_advertising(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_multi_adv_second_instance(uint8_t status, uint16_t length,
+		const void *param, void *user_data) {
+	struct mgmt_rp_add_advertising *rp =
+				(struct mgmt_rp_add_advertising *) param;
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Add Advertising setup complete (instance %d)",
+								rp->instance);
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 2);
+	cp->timeout = 1;
+	cp->duration = 1;
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
+static void setup_multi_adv(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding two instances with timeout 1 and duration 1");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+	cp->timeout = 1;
+	cp->duration = 1;
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
+						setup_multi_adv_second_instance,
+						NULL, NULL);
+}
+
 static void setup_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6740,6 +6885,22 @@ int main(int argc, char *argv[])
 						setup_add_advertising,
 						test_command_generic);
 
+	/* When advertising two instances, the instances should be
+	 * advertised in a round-robin fashion.
+	 */
+	test_bredrle("Multi Advertising - Success 1 (Instance Switch)",
+					&multi_advertising_switch,
+					setup_multi_adv,
+					test_command_generic);
+	/* Adding a new instance when one is already being advertised
+	 * will switch to the new instance after the first has reached
+	 * its duration. A long timeout has been set to
+	 */
+	test_bredrle_full("Multi Advertising - Success 2 (Add Second Inst)",
+					&multi_advertising_add_second,
+					setup_add_advertising_duration,
+					test_command_generic, 3);
+
 	test_bredrle("Read Local OOB Data - Not powered",
 				&read_local_oob_not_powered_test,
 				NULL, test_command_generic);
-- 
1.9.1

