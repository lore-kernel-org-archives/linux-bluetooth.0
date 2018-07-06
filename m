Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 5/8] mgmt-tester: Add extended advertising test cases
Date: Fri,  6 Jul 2018 16:58:02 +0530
Message-Id: <1530876485-17218-6-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 1788 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 1697 insertions(+), 91 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bc71791..0136b93 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -462,6 +462,25 @@ static void test_condition_complete(struct test_data *data)
 #define test_le(name, data, setup, func) \
 	test_le_full(name, data, setup, func, 2)
 
+#define test_bredrle50_full(name, data, setup, func, timeout) \
+	do { \
+		struct test_data *user; \
+		user = new0(struct test_data, 1); \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE50; \
+		user->test_setup = setup; \
+		user->test_data = data; \
+		user->expected_version = 0x09; \
+		user->expected_manufacturer = 0x003f; \
+		user->expected_supported_settings = 0x0001bfff; \
+		user->initial_settings = 0x00000080; \
+		tester_add_full(name, data, \
+				test_pre_setup, test_setup, func, NULL, \
+				test_post_teardown, timeout, user, free); \
+	} while (0)
+
+#define test_bredrle50(name, data, setup, func) \
+			test_bredrle50_full(name, data, setup, func, 2)
+
 static void controller_setup(const void *test_data)
 {
 	tester_test_passed();
@@ -6852,120 +6871,1465 @@ static const struct generic_data set_appearance_success = {
 	.expect_len = 0,
 };
 
-static bool power_off(uint16_t index)
-{
-	int sk, err;
-
-	sk = hci_open_dev(index);
-	if (sk < 0)
-		return false;
+static const uint8_t read_adv_features_rsp_3[] =  {
+	0xff, 0x03, 0x00, 0x00,	/* supported flags */
+	0x1f,			/* max_adv_data_len */
+	0x1f,			/* max_scan_rsp_len */
+	0x05,			/* max_instances */
+	0x00,			/* num_instances */
+};
 
-	err = ioctl(sk, HCIDEVDOWN, index);
+static const struct generic_data read_adv_features_success_3 = {
+	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
+	.expect_param = read_adv_features_rsp_3,
+	.expect_len = sizeof(read_adv_features_rsp_3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
 
-	hci_close_dev(sk);
+/* add advertising with multiple phy flags */
+static const uint8_t add_ext_advertising_invalid_param_1[] = {
+	0x01,			/* adv instance */
+	0x80, 0x01, 0x00, 0x00,	/* flags: 1m and 2m*/
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
 
-	if (err < 0)
-		return false;
+static const struct generic_data add_ext_advertising_fail_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_ext_advertising_invalid_param_1,
+	.send_len = sizeof(add_ext_advertising_invalid_param_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
 
-	return true;
-}
+/* add advertising with multiple phy flags */
+static const uint8_t add_ext_advertising_invalid_param_2[] = {
+	0x01,			/* adv instance */
+	0x00, 0x03, 0x00, 0x00,	/* flags: 2m and coded*/
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
 
-static void test_command_generic(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct generic_data *test = data->test_data;
-	const void *send_param = test->send_param;
-	uint16_t send_len = test->send_len;
-	unsigned int id;
-	uint16_t index;
+static const struct generic_data add_ext_advertising_fail_2 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_ext_advertising_invalid_param_2,
+	.send_len = sizeof(add_ext_advertising_invalid_param_2),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
 
-	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
+/* add advertising with multiple phy flags */
+static const uint8_t add_ext_advertising_invalid_param_3[] = {
+	0x01,			/* adv instance */
+	0x80, 0x02, 0x00, 0x00,	/* flags: 1m and coded*/
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
 
-	if (test->expect_settings_set || test->expect_settings_unset) {
-		tester_print("Registering new settings notification");
+static const struct generic_data add_ext_advertising_fail_3 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_ext_advertising_invalid_param_3,
+	.send_len = sizeof(add_ext_advertising_invalid_param_3),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
 
-		id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,
-				command_generic_new_settings, NULL, NULL);
-		data->mgmt_settings_id = id;
+/* add advertising with multiple phy flags */
+static const uint8_t add_ext_advertising_invalid_param_4[] = {
+	0x01,			/* adv instance */
+	0x80, 0x03, 0x00, 0x00,	/* flags: 1m, 2m and coded*/
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
 
-		id = mgmt_register(data->mgmt_alt, MGMT_EV_NEW_SETTINGS, index,
-				command_generic_new_settings_alt, NULL, NULL);
-		data->mgmt_alt_settings_id = id;
-		test_add_condition(data);
-	}
+static const struct generic_data add_ext_advertising_fail_4 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_ext_advertising_invalid_param_4,
+	.send_len = sizeof(add_ext_advertising_invalid_param_4),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
 
-	if (test->expect_alt_ev) {
-		tester_print("Registering %s notification",
-					mgmt_evstr(test->expect_alt_ev));
-		id = mgmt_register(data->mgmt_alt, test->expect_alt_ev, index,
-					command_generic_event_alt, NULL, NULL);
-		data->mgmt_alt_ev_id = id;
-		test_add_condition(data);
-	}
+static const uint8_t set_ext_adv_data_uuid[] = {
+	/* handle */
+	0x00,
+	/* complete data */
+	0x03,
+	/* controller should not fragment */
+	0x01,
+	/* adv data len */
+	0x09,
+	/* advertise heart rate monitor and manufacturer specific data */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00
+};
 
-	if (test->expect_hci_command) {
-		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
-						command_hci_callback, data);
-		test_add_condition(data);
-	}
+static const struct generic_data add_ext_advertising_success_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_uuid,
+	.expect_hci_len = sizeof(set_ext_adv_data_uuid),
+};
 
-	if (test->send_opcode == 0x0000) {
-		tester_print("Executing no-op test");
-		return;
-	}
+static const char set_powered_ext_adv_instance_settings_param[] = {
+	0x81, 0x02, 0x00, 0x00,
+};
 
-	tester_print("Sending %s (0x%04x)", mgmt_opstr(test->send_opcode),
-							test->send_opcode);
+static const uint8_t set_ext_adv_data_test1[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x07,				/* adv data len */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x31,	/* "test1" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
 
-	if (test->send_func)
-		send_param = test->send_func(&send_len);
+static const struct generic_data add_ext_advertising_success_pwron_data = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_test1,
+	.expect_hci_len = sizeof(set_ext_adv_data_test1),
+};
 
-	if (test->force_power_off) {
-		mgmt_send_nowait(data->mgmt, test->send_opcode, index,
-					send_len, send_param,
-					command_generic_callback, NULL, NULL);
-		power_off(data->mgmt_index);
-	} else {
-		mgmt_send(data->mgmt, test->send_opcode, index, send_len,
-					send_param, command_generic_callback,
-					NULL, NULL);
-	}
+static const char set_ext_adv_on_set_adv_enable_param[] = {
+	0x01,		/* Enable */
+	0x01,		/* No of sets */
+	0x00,		/* Handle */
+	0x00, 0x00,		/* Duration */
+	0x00,		/* Max events */
+};
 
-	test_add_condition(data);
-}
+static const struct generic_data add_ext_advertising_success_pwron_enabled = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_on_set_adv_enable_param,
+	.expect_hci_len = sizeof(set_ext_adv_on_set_adv_enable_param),
+};
 
-static void check_scan(void *user_data)
-{
-	struct test_data *data = tester_get_data();
+static const uint8_t set_ext_adv_data_txpwr[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x03,			/* adv data len */
+	0x02, 			/* AD len */
+	0x0a,			/* AD type: tx power */
+	0x00,			/* tx power */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
 
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
-		tester_warn("LE scan still enabled");
-		tester_test_failed();
-		return;
-	}
+static const struct generic_data add_ext_advertising_success_4 = {
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param,
+	.send_len = sizeof(set_adv_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_adv_settings_param_2,
+	.expect_len = sizeof(set_adv_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_txpwr,
+	.expect_hci_len = sizeof(set_ext_adv_data_txpwr),
+};
 
-	if (hciemu_get_master_scan_enable(data->hciemu)) {
-		tester_warn("BR/EDR scan still enabled");
-		tester_test_failed();
-		return;
-	}
+static const struct generic_data add_ext_advertising_success_5 = {
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_off_param,
+	.send_len = sizeof(set_adv_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_test1,
+	.expect_hci_len = sizeof(set_ext_adv_data_test1),
+};
 
-	test_condition_complete(data);
-}
+static const struct generic_data add_ext_advertising_success_6 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_uuid,
+	.expect_hci_len = sizeof(set_ext_adv_data_uuid),
+};
 
-static void test_remove_device(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
+static const uint8_t set_ext_scan_rsp_uuid[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0a,			/* scan rsp data len */
+	0x03,			/* AD len */
+	0x19,			/* AD type: external appearance */
+	0x40, 0x03,		/* some custom appearance */
+	0x05,			/* AD len */
+	0x03,			/* AD type: all 16 bit service class UUIDs */
+	0x0d, 0x18, 0x0f, 0x18,	/* heart rate monitor, battery service */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+};
 
-	test_command_generic(test_data);
-	tester_wait(1, check_scan, NULL);
-	test_add_condition(data);
-}
+static const struct generic_data add_ext_advertising_success_7 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = set_ext_scan_rsp_uuid,
+	.expect_hci_len = sizeof(set_ext_scan_rsp_uuid),
+};
+
+static uint8_t set_connectable_on_ext_adv_param[] = {
+	0x00,					/* Handle */
+	0x13, 0x00, 			/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08, 0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x00,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_8 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_connectable,
+	.send_len = sizeof(add_advertising_param_connectable),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_adv_param),
+};
 
-static void trigger_device_found(void *user_data)
-{
-	struct test_data *data = tester_get_data();
+static const uint8_t set_ext_adv_data_general_discov[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0c,			/* adv data len */
+	0x02,			/* AD len */
+	0x01,			/* AD type: flags */
+	0x02,			/* general discoverable */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_ext_adv_data_limited_discov[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0c,			/* adv data len */
+	0x02,			/* AD len */
+	0x01,			/* AD type: flags */
+	0x01,			/* limited discoverable */
+	/* rest: same as before */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_ext_adv_data_uuid_txpwr[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0c,			/* adv data len */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	0x02,			/* AD len */
+	0x0a,			/* AD type: tx power */
+	0x00,			/* tx power */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_success_9 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_general_discov,
+	.send_len = sizeof(add_advertising_param_general_discov),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_general_discov,
+	.expect_hci_len = sizeof(set_ext_adv_data_general_discov),
+};
+
+static const struct generic_data add_ext_advertising_success_10 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_limited_discov,
+	.send_len = sizeof(add_advertising_param_limited_discov),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_limited_discov,
+	.expect_hci_len = sizeof(set_ext_adv_data_limited_discov),
+};
+
+static const struct generic_data add_ext_advertising_success_11 = {
+	.setup_settings = settings_powered_le_discoverable,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_managed,
+	.send_len = sizeof(add_advertising_param_managed),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_general_discov,
+	.expect_hci_len = sizeof(set_ext_adv_data_general_discov),
+};
+
+static const struct generic_data add_ext_advertising_success_12 = {
+	.setup_settings = settings_powered_le_discoverable,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_txpwr,
+	.send_len = sizeof(add_advertising_param_txpwr),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_uuid_txpwr,
+	.expect_hci_len = sizeof(set_ext_adv_data_uuid_txpwr),
+};
+
+static uint8_t set_connectable_off_scan_ext_adv_param[] = {
+	0x00,					/* Handle */
+	0x12, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08,	0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_13 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_scan_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_scan_ext_adv_param),
+};
+
+static uint8_t set_connectable_off_ext_adv_param[] = {
+	0x00,					/* Handle */
+	0x10, 0x00, 			/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08, 0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_14 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_adv_param),
+};
+
+static const struct generic_data add_ext_advertising_success_15 = {
+	.setup_settings = settings_powered_le_connectable,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_adv_param),
+};
+
+static const struct generic_data add_ext_advertising_success_16 = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_on_param,
+	.send_len = sizeof(set_connectable_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_connectable_settings_param_3,
+	.expect_len = sizeof(set_connectable_settings_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_adv_param),
+};
+
+static const struct generic_data add_ext_advertising_success_17 = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_off_param,
+	.send_len = sizeof(set_connectable_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_2,
+	.expect_len = sizeof(set_le_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_adv_param),
+};
+
+static const struct generic_data add_ext_advertising_power_off = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_off_param,
+	.send_len = sizeof(set_powered_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_off_le_settings_param,
+	.expect_len = sizeof(set_powered_off_le_settings_param),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+};
+
+static const struct generic_data add_ext_advertising_le_off = {
+	.send_opcode = MGMT_OP_SET_LE,
+	.send_param = set_le_off_param,
+	.send_len = sizeof(set_le_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_off,
+	.expect_len = sizeof(set_le_settings_param_off),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+};
+
+static const struct generic_data add_ext_advertising_success_18 = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_uuid,
+	.expect_hci_len = sizeof(set_ext_adv_data_uuid),
+};
+
+static const char set_ext_adv_disable_param[] = {
+	0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_timeout_expired = {
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_disable_param,
+	.expect_hci_len = sizeof(set_ext_adv_disable_param),
+};
+
+static const struct generic_data remove_ext_advertising_fail_1 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_1,
+	.send_len = sizeof(remove_advertising_param_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data remove_ext_advertising_success_1 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_1,
+	.send_len = sizeof(remove_advertising_param_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = remove_advertising_param_1,
+	.expect_len = sizeof(remove_advertising_param_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_disable_param,
+	.expect_hci_len = sizeof(set_ext_adv_disable_param),
+};
+
+static const struct generic_data remove_ext_advertising_success_2 = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_2,
+	.send_len = sizeof(remove_advertising_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = remove_advertising_param_2,
+	.expect_len = sizeof(remove_advertising_param_2),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_disable_param,
+	.expect_hci_len = sizeof(set_ext_adv_disable_param),
+};
+
+static const uint8_t set_ext_adv_data_test2[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x07,				/* adv data len */
+	0x06,				/* AD len */
+	0x08,				/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data multi_ext_advertising_switch = {
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_test2,
+	.expect_hci_len = sizeof(set_ext_adv_data_test2),
+};
+
+static const struct generic_data multi_ext_advertising_add_second = {
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_test2,
+	.send_len = sizeof(add_advertising_param_test2),
+	.expect_param = advertising_instance2_param,
+	.expect_len = sizeof(advertising_instance2_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance2_param,
+	.expect_alt_ev_len = sizeof(advertising_instance2_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
+	.expect_hci_param = set_ext_adv_data_test2,
+	.expect_hci_len = sizeof(set_ext_adv_data_test2),
+};
+
+static const uint8_t add_ext_advertising_param_empty[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const struct generic_data add_ext_advertising_empty_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_empty,
+	.send_len = sizeof(add_advertising_param_empty),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_ext_advertising_param_scrsp_data_only_ok[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x1f,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+};
+
+static const struct generic_data add_ext_advertising_scrsp_data_only_ok = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_data_only_ok,
+	.send_len = sizeof(add_advertising_param_scrsp_data_only_ok),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_ext_advertising_param_scrsp_data_only_too_long[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x20,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_scrsp_data_only_too_long = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_data_only_too_long,
+	.send_len = sizeof(add_advertising_param_scrsp_data_only_too_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const uint8_t add_ext_advertising_param_scrsp_appear_data_ok[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x1b,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_scrsp_appear_data_ok = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_appear_data_ok,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_data_ok),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_ext_advertising_param_scrsp_appear_data_too_long[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x1c,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_scrsp_appear_data_too_long = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_appear_data_too_long,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_data_too_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const uint8_t add_ext_advertising_param_scrsp_appear_null[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x01,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00,
+};
+
+static const struct generic_data add_ext_advertising_scrsp_appear_null = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_appear_null,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_null),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_ext_advertising_empty_param[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name*/
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x01,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00,
+};
+
+static const uint8_t ext_scan_rsp_data_empty[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x01, /* scan rsp data len */
+	0x00, /* scan rsp data */
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_no_name_set = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_empty_param,
+	.send_len = sizeof(add_advertising_empty_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = ext_scan_rsp_data_empty,
+	.expect_hci_len = sizeof(ext_scan_rsp_data_empty),
+};
+
+static const uint8_t add_ext_advertising_param_name[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_ext_scan_rsp_data_name_fits_in_scrsp[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0c, /* Scan rsp data len */
+	0x0b, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_name_fits_in_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = set_ext_scan_rsp_data_name_fits_in_scrsp,
+	.expect_hci_len = sizeof(set_ext_scan_rsp_data_name_fits_in_scrsp),
+};
+
+static const uint8_t set_ext_scan_rsp_data_shortened_name_fits[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x0d, /* Scan rsp data len */
+	0x0c, /* Local name data len */
+	0x08, /* Short name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
+	/* "Test name1" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_ext_advertising_shortened_name_in_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_longer_cp,
+	.setup_send_len = sizeof(set_local_name_longer_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = set_ext_scan_rsp_data_shortened_name_fits,
+	.expect_hci_len = sizeof(set_ext_scan_rsp_data_shortened_name_fits),
+};
+
+static const uint8_t set_ext_scan_rsp_data_short_name_fits[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x07, /* Scan rsp data len */
+	0x06, /* Local name data len */
+	0x08, /* Short name */
+	0x54, 0x65, 0x73, 0x74,
+	/* "Test*/
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t add_ext_advertising_param_name_data_ok[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x12,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_ext_scan_rsp_data_param_name_data_ok[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x1e, /* Scan rsp data len */
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0b, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	/* "Test name" */
+	/* padding */
+	0x00,
+};
+
+static const struct generic_data add_ext_advertising_name_data_ok = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name_data_ok,
+	.send_len = sizeof(add_advertising_param_name_data_ok),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = set_ext_scan_rsp_data_param_name_data_ok,
+	.expect_hci_len = sizeof(set_ext_scan_rsp_data_param_name_data_ok),
+};
+
+static const uint8_t add_ext_advertising_param_name_data_inv[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x14,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct generic_data add_ext_advertising_name_data_inv = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name_data_inv,
+	.send_len = sizeof(add_advertising_param_name_data_inv),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const uint8_t add_ext_advertising_param_name_data_appear[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: local name + appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x0e,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct setup_mgmt_cmd add_ext_advertising_mgmt_cmd_arr[] = {
+	{
+		.send_opcode = MGMT_OP_SET_APPEARANCE,
+		.send_param = set_appearance_param,
+		.send_len = sizeof(set_appearance_param),
+	},
+	{
+		.send_opcode = MGMT_OP_SET_LOCAL_NAME,
+		.send_param = &set_local_name_cp,
+		.send_len = sizeof(set_local_name_cp),
+	},
+	{ /* last element should always have opcode 0x00 */
+		.send_opcode = 0x00,
+		.send_param = NULL,
+		.send_len = 0,
+	}
+};
+
+static const uint8_t set_ext_scan_rsp_data_name_data_appear[] = {
+	0x00,				/* handle */
+	0x03,				/* complete data */
+	0x01,				/* controller should not fragment */
+	0x1e, /* Scan rsp data len */
+	0x03, /* appearance len */
+	0x19, /* EIR_APPEARANCE */
+	0x54, 0x65, /* appearance value */
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x0b, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	/* "Test name" */
+	/* padding */
+	0x00,
+};
+
+static const struct generic_data add_ext_advertising_name_data_appear = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name_data_appear,
+	.send_len = sizeof(add_advertising_param_name_data_appear),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA,
+	.expect_hci_param = set_ext_scan_rsp_data_name_data_appear,
+	.expect_hci_len = sizeof(set_ext_scan_rsp_data_name_data_appear),
+};
+
+/* simple add advertising command */
+static const uint8_t add_advertising_1m_param_uuid[] = {
+	0x01,			/* adv instance */
+	0x80, 0x00, 0x00, 0x00,	/* flags: 1m */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x00,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+};
+
+static uint8_t set_connectable_off_ext_1m_adv_param[] = {
+	0x00,					/* Handle */
+	0x00, 0x00, 			/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08, 0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_1m = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_1m_param_uuid,
+	.send_len = sizeof(add_advertising_1m_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_1m_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_1m_adv_param),
+};
+
+/* simple add advertising command */
+static const uint8_t add_advertising_2m_param_uuid[] = {
+	0x01,			/* adv instance */
+	0x00, 0x01, 0x00, 0x00,	/* flags: 2m */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x00,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+};
+
+static uint8_t set_connectable_off_ext_2m_adv_param[] = {
+	0x00,					/* Handle */
+	0x00, 0x00, 			/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08, 0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x02,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_2m = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_2m_param_uuid,
+	.send_len = sizeof(add_advertising_2m_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_2m_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_2m_adv_param),
+};
+
+/* simple add advertising command */
+static const uint8_t add_advertising_coded_param_uuid[] = {
+	0x01,			/* adv instance */
+	0x00, 0x02, 0x00, 0x00,	/* flags: coded */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x00,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+};
+
+static uint8_t set_connectable_off_ext_coded_adv_param[] = {
+	0x00,					/* Handle */
+	0x00, 0x00, 			/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08, 0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x03,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x03,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_coded = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_coded_param_uuid,
+	.send_len = sizeof(add_advertising_coded_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_coded_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_coded_adv_param),
+};
+
+/* add advertising with scan response data */
+static const uint8_t add_advertising_param_scanrsp_1m[] = {
+	0x01,					/* Instance */
+	0x80, 0x00, 0x00, 0x00, /* Flags: 1m*/
+	0x00, 0x00,				/* Duration */
+	0x00, 0x00,				/* Timeout */
+	0x09,					/* Adv data len */
+	0x0a,			/* scan rsp len */
+	/* adv data: same as before */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* scan rsp data: */
+	0x03,			/* AD len */
+	0x19,			/* AD type: external appearance */
+	0x40, 0x03,		/* some custom appearance */
+	0x05,			/* AD len */
+	0x03,			/* AD type: all 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x0f, 0x18,		/* battery service */
+};
+
+static uint8_t set_connectable_off_scan_ext_pdu_adv_param[] = {
+	0x00,					/* Handle */
+	0x02, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08,	0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x01,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_scannable = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scanrsp_1m,
+	.send_len = sizeof(add_advertising_param_scanrsp_1m),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_scan_ext_pdu_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_scan_ext_pdu_adv_param),
+};
+
+static uint8_t set_connectable_on_ext_pdu_adv_param[] = {
+	0x00,					/* Handle */
+	0x01, 0x00,				/* Event type */
+	0x00, 0x08, 0x00,		/* min_interval */
+	0x00, 0x08,	0x00,		/* max_interval */
+	0x07,					/* channel_map */
+	0x00,					/* own_addr_type */
+	0x00,					/* peer_addr_type */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* peer_addr */
+	0x00,					/* filter_policy */
+	127,					/* Tx power */
+	0x01,					/* Primary PHY */
+	0x00,					/* primary adv max skip */
+	0x01,					/* Secondary PHY */
+	0x00,					/* adv sid*/
+	0x00,					/* Scan req notification */
+};
+
+static const struct generic_data add_ext_advertising_success_connectable = {
+	.setup_settings = settings_powered_le_connectable,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_1m_param_uuid,
+	.send_len = sizeof(add_advertising_1m_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_pdu_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_pdu_adv_param),
+};
+
+static const struct generic_data add_ext_advertising_success_conn_scan = {
+	.setup_settings = settings_powered_le_connectable,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scanrsp_1m,
+	.send_len = sizeof(add_advertising_param_scanrsp_1m),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_pdu_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_pdu_adv_param),
+};
+
+static void setup_add_adv_param_1m(struct mgmt_cp_add_advertising *cp,
+							uint8_t instance)
+{
+	memset(cp, 0, sizeof(*cp));
+	cp->instance = instance;
+	cp->flags = cpu_to_le32(MGMT_ADV_FLAG_SEC_1M);
+	cp->adv_data_len = TESTER_ADD_ADV_DATA_LEN;
+	cp->data[0] = TESTER_ADD_ADV_DATA_LEN - 1; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+	cp->data[6] = '0' + instance;
+}
+
+static void setup_add_advertising_1m(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while powered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param_1m(cp, 1);
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
+static const struct generic_data add_ext_advertising_conn_on_1m = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_on_param,
+	.send_len = sizeof(set_connectable_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_connectable_settings_param_3,
+	.expect_len = sizeof(set_connectable_settings_param_3),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_on_ext_pdu_adv_param,
+	.expect_hci_len = sizeof(set_connectable_on_ext_pdu_adv_param),
+};
+
+static void setup_add_advertising_connectable_1m(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while connectable");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param_1m(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
+static const struct generic_data add_ext_advertising_conn_off_1m = {
+	.send_opcode = MGMT_OP_SET_CONNECTABLE,
+	.send_param = set_connectable_off_param,
+	.send_len = sizeof(set_connectable_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_2,
+	.expect_len = sizeof(set_le_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+	.expect_hci_param = set_connectable_off_ext_1m_adv_param,
+	.expect_hci_len = sizeof(set_connectable_off_ext_1m_adv_param),
+};
+
+static bool power_off(uint16_t index)
+{
+	int sk, err;
+
+	sk = hci_open_dev(index);
+	if (sk < 0)
+		return false;
+
+	err = ioctl(sk, HCIDEVDOWN, index);
+
+	hci_close_dev(sk);
+
+	if (err < 0)
+		return false;
+
+	return true;
+}
+
+static void test_command_generic(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const void *send_param = test->send_param;
+	uint16_t send_len = test->send_len;
+	unsigned int id;
+	uint16_t index;
+
+	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
+
+	if (test->expect_settings_set || test->expect_settings_unset) {
+		tester_print("Registering new settings notification");
+
+		id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,
+				command_generic_new_settings, NULL, NULL);
+		data->mgmt_settings_id = id;
+
+		id = mgmt_register(data->mgmt_alt, MGMT_EV_NEW_SETTINGS, index,
+				command_generic_new_settings_alt, NULL, NULL);
+		data->mgmt_alt_settings_id = id;
+		test_add_condition(data);
+	}
+
+	if (test->expect_alt_ev) {
+		tester_print("Registering %s notification",
+					mgmt_evstr(test->expect_alt_ev));
+		id = mgmt_register(data->mgmt_alt, test->expect_alt_ev, index,
+					command_generic_event_alt, NULL, NULL);
+		data->mgmt_alt_ev_id = id;
+		test_add_condition(data);
+	}
+
+	if (test->expect_hci_command) {
+		tester_print("Registering HCI command callback");
+		hciemu_add_master_post_command_hook(data->hciemu,
+						command_hci_callback, data);
+		test_add_condition(data);
+	}
+
+	if (test->send_opcode == 0x0000) {
+		tester_print("Executing no-op test");
+		return;
+	}
+
+	tester_print("Sending %s (0x%04x)", mgmt_opstr(test->send_opcode),
+							test->send_opcode);
+
+	if (test->send_func)
+		send_param = test->send_func(&send_len);
+
+	if (test->force_power_off) {
+		mgmt_send_nowait(data->mgmt, test->send_opcode, index,
+					send_len, send_param,
+					command_generic_callback, NULL, NULL);
+		power_off(data->mgmt_index);
+	} else {
+		mgmt_send(data->mgmt, test->send_opcode, index, send_len,
+					send_param, command_generic_callback,
+					NULL, NULL);
+	}
+
+	test_add_condition(data);
+}
+
+static void check_scan(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+		tester_warn("LE scan still enabled");
+		tester_test_failed();
+		return;
+	}
+
+	if (hciemu_get_master_scan_enable(data->hciemu)) {
+		tester_warn("BR/EDR scan still enabled");
+		tester_test_failed();
+		return;
+	}
+
+	test_condition_complete(data);
+}
+
+static void test_remove_device(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_command_generic(test_data);
+	tester_wait(1, check_scan, NULL);
+	test_add_condition(data);
+}
+
+static void trigger_device_found(void *user_data)
+{
+	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
 
@@ -8352,5 +9716,247 @@ int main(int argc, char *argv[])
 				&device_found_invalid_field,
 				NULL, test_device_found);
 
+	test_bredrle50("Read Ext Advertising Features - Success 3 (PHY flags)",
+				&read_adv_features_success_3,
+				NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params 1 (Multiple Phys)",
+					&add_ext_advertising_fail_1,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params 2 (Multiple PHYs)",
+					&add_ext_advertising_fail_2,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params 3 (Multiple PHYs)",
+					&add_ext_advertising_fail_3,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params 4 (Multiple PHYs)",
+					&add_ext_advertising_fail_4,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 1 (Powered, Add Adv Inst)",
+						&add_ext_advertising_success_1,
+						NULL, test_command_generic);
+
+
+	test_bredrle50("Add Ext Advertising - Success 2 (!Powered, Add Adv Inst)",
+					&add_ext_advertising_success_pwron_data,
+					setup_add_advertising_not_powered,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 3 (!Powered, Adv Enable)",
+					&add_ext_advertising_success_pwron_enabled,
+					setup_add_advertising_not_powered,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 4 (Set Adv on override)",
+					&add_ext_advertising_success_4,
+					setup_add_advertising,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 5 (Set Adv off override)",
+					&add_ext_advertising_success_5,
+					setup_set_and_add_advertising,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok)",
+					&add_ext_advertising_success_6,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok) ",
+					&add_ext_advertising_success_7,
+					NULL, test_command_generic);
+	test_bredrle50("Add Ext Advertising - Success 8 (Connectable Flag)",
+					&add_ext_advertising_success_8,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 9 (General Discov Flag)",
+					&add_ext_advertising_success_9,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 10 (Limited Discov Flag)",
+					&add_ext_advertising_success_10,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 11 (Managed Flags)",
+					&add_ext_advertising_success_11,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 12 (TX Power Flag)",
+					&add_ext_advertising_success_12,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 13 (ADV_SCAN_IND)",
+					&add_ext_advertising_success_13,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 14 (ADV_NONCONN_IND)",
+					&add_ext_advertising_success_14,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 15 (ADV_IND)",
+					&add_ext_advertising_success_15,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 16 (Connectable -> on)",
+					&add_ext_advertising_success_16,
+					setup_add_advertising,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success 17 (Connectable -> off)",
+					&add_ext_advertising_success_17,
+					setup_add_advertising_connectable,
+					test_command_generic);
+
+	/* Changing an advertising instance while it is still being
+	 * advertised will immediately update the advertised data if
+	 * there is no other instance to switch to.
+	 */
+	test_bredrle50("Add Ext Advertising - Success 20 (Add Adv override)",
+					&add_ext_advertising_success_18,
+					setup_add_advertising,
+					test_command_generic);
+
+	/* An instance should be removed when its timeout has been reached.
+	 * Advertising will also be disabled if this was the last instance.
+	 */
+	test_bredrle50_full("Add Ext Advertising - Success 21 (Timeout expires)",
+					&add_ext_advertising_timeout_expired,
+					setup_add_advertising_timeout,
+					test_command_generic, 3);
+
+	/* LE off will clear (remove) all instances. */
+	test_bredrle50("Add Ext Advertising - Success 22 (LE -> off, Remove)",
+					&add_ext_advertising_le_off,
+					setup_add_advertising,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Empty ScRsp)",
+					 &add_ext_advertising_empty_scrsp,
+					 setup_command_generic,
+					 test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (ScRsp only)",
+					&add_ext_advertising_scrsp_data_only_ok,
+						NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params (ScRsp too long)",
+				&add_ext_advertising_scrsp_data_only_too_long,
+						NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (ScRsp appear)",
+					&add_ext_advertising_scrsp_appear_data_ok,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params (ScRsp appear long)",
+				&add_ext_advertising_scrsp_appear_data_too_long,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Appear is null)",
+					&add_ext_advertising_scrsp_appear_null,
+						NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Name is null)",
+					 &add_ext_advertising_no_name_set,
+					 NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Complete name)",
+					&add_ext_advertising_name_fits_in_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Shortened name)",
+				&add_ext_advertising_shortened_name_in_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Short name)",
+					&add_ext_advertising_shortened_name_in_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Name + data)",
+					 &add_ext_advertising_name_data_ok,
+					 setup_command_generic,
+					 test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Invalid Params (Name + data)",
+					 &add_ext_advertising_name_data_inv,
+					 setup_command_generic,
+					 test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Name+data+appear)",
+					 &add_ext_advertising_name_data_appear,
+					 setup_command_generic,
+					 test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (PHY -> 1M)",
+					&add_ext_advertising_success_1m,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (PHY -> 2M)",
+					&add_ext_advertising_success_2m,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (PHY -> Coded)",
+					&add_ext_advertising_success_coded,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Ext Pdu Scannable)",
+					&add_ext_advertising_success_scannable,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (Ext Pdu Connectable)",
+					&add_ext_advertising_success_connectable,
+					NULL, test_command_generic);
+
+	/* In Ext pdu it shall not be both scannable and connectable */
+	test_bredrle50("Add Ext Advertising - Success (Ext Pdu Conn Scan)",
+					&add_ext_advertising_success_conn_scan,
+					NULL, test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (1m Connectable -> on)",
+					&add_ext_advertising_conn_on_1m,
+					setup_add_advertising_1m,
+					test_command_generic);
+
+	test_bredrle50("Add Ext Advertising - Success (1m Connectable -> off)",
+					&add_ext_advertising_conn_off_1m,
+					setup_add_advertising_connectable_1m,
+					test_command_generic);
+
+	test_bredrle50("Remove Ext Advertising - Invalid Params 1",
+					&remove_ext_advertising_fail_1,
+					NULL, test_command_generic);
+
+	test_bredrle50("Remove Ext Advertising - Success 1",
+						&remove_ext_advertising_success_1,
+						setup_add_advertising,
+						test_command_generic);
+
+	test_bredrle50("Remove Ext Advertising - Success 2",
+						&remove_ext_advertising_success_2,
+						setup_add_advertising,
+						test_command_generic);
+
+	/* When advertising two instances, the instances should be
+	 * advertised in a round-robin fashion.
+	 */
+	test_bredrle50("Multi Ext Advertising - Success 1 (Instance Switch)",
+					&multi_ext_advertising_switch,
+					setup_multi_adv,
+					test_command_generic);
+
+	/* Adding a new instance when one is already being advertised
+	 * will switch to the new instance after the first has reached
+	 * its duration. A long timeout has been set to
+	 */
+	test_bredrle50_full("Multi Ext Advertising - Success 2 (Add Second Inst)",
+					&multi_ext_advertising_add_second,
+					setup_add_advertising_duration,
+					test_command_generic, 3);
+
 	return tester_run();
 }
-- 
2.7.4
