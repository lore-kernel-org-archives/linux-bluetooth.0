Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/10] android/tester-bluetooth: Add various property set fail cases
Date: Tue, 15 Jul 2014 10:24:55 +0200
Message-Id: <1405412699-6358-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These cases should fail as they are read only props.
---
 android/tester-bluetooth.c | 225 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 6c05620..ce777b0 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -309,6 +309,224 @@ static struct test_case bluetooth_getprop_bdname_success_tc = {
 					bluetooth_getprop_bdname_success_steps),
 };
 
+
+static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
+			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00 };
+
+static bt_property_t setprop_uuid_prop = {
+	.type = BT_PROPERTY_UUIDS,
+	.val = &setprop_uuids,
+	.len = sizeof(setprop_uuids),
+};
+
+static struct step bluetooth_setprop_uuid_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_uuid_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_uuid_fail_tc = {
+	.step = bluetooth_setprop_uuid_fail_steps,
+	.title = "Bluetooth Set UUID - Fail",
+	.step_num = get_test_case_step_num(bluetooth_setprop_uuid_fail_steps),
+};
+
+static uint32_t setprop_cod_val = 0;
+
+static bt_property_t setprop_cod_prop = {
+	.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.val = &setprop_cod_val,
+	.len = sizeof(setprop_cod_val),
+};
+
+static struct step bluetooth_setprop_cod_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_cod_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_cod_fail_tc = {
+	.step = bluetooth_setprop_cod_fail_steps,
+	.title = "Bluetooth Set CLASS_OF_DEVICE - Fail",
+	.step_num = get_test_case_step_num(bluetooth_setprop_cod_fail_steps),
+};
+
+static uint32_t setprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
+
+static bt_property_t setprop_tod_prop = {
+	.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.val = &setprop_tod_val,
+	.len = sizeof(setprop_tod_val),
+};
+
+static struct step bluetooth_setprop_tod_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_tod_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_tod_fail_tc = {
+	.step = bluetooth_setprop_tod_fail_steps,
+	.title = "Bluetooth Set TYPE_OF_DEVICE - Fail",
+	.step_num = get_test_case_step_num(bluetooth_setprop_tod_fail_steps),
+};
+
+static int32_t setprop_remote_rssi_val = -9;
+
+static bt_property_t setprop_remote_rssi_prop = {
+	.type = BT_PROPERTY_REMOTE_RSSI,
+	.val = &setprop_remote_rssi_val,
+	.len = sizeof(setprop_remote_rssi_val),
+};
+
+static struct step bluetooth_setprop_remote_rssi_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_remote_rssi_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_remote_rssi_fail_tc = {
+	.step = bluetooth_setprop_remote_rssi_fail_steps,
+	.title = "Bluetooth Set REMOTE_RSSI - Fail",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_remote_rssi_fail_steps),
+};
+
+static bt_service_record_t setprop_srvc_record_val =  {
+	.uuid = { {0x00} },
+	.channel = 12,
+	.name = "bt_name",
+};
+
+static bt_property_t setprop_srvc_record_prop = {
+	.type = BT_PROPERTY_SERVICE_RECORD,
+	.val = &setprop_srvc_record_val,
+	.len = sizeof(setprop_srvc_record_val),
+};
+
+static struct step bluetooth_setprop_srvc_record_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_srvc_record_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_srvc_record_fail_tc = {
+	.step = bluetooth_setprop_srvc_record_fail_steps,
+	.title = "Bluetooth Set SERVICE_RECORD - Fail",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_srvc_record_fail_steps),
+};
+
+static bt_bdaddr_t setprop_bdaddr_val = {
+	.address = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static bt_property_t setprop_bdaddr_prop = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &setprop_bdaddr_val,
+	.len = sizeof(setprop_bdaddr_val),
+};
+
+static struct step bluetooth_setprop_bdaddr_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_bdaddr_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_bdaddr_fail_tc = {
+	.step = bluetooth_setprop_bdaddr_fail_steps,
+	.title = "Bluetooth Set BDADDR - Fail",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_bdaddr_fail_steps),
+};
+
+static bt_bdaddr_t setprop_bonded_dev_val = {
+	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
+};
+
+static bt_property_t setprop_bonded_dev_prop = {
+	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.val = &setprop_bonded_dev_val,
+	.len = sizeof(setprop_bonded_dev_val),
+};
+
+static struct step bluetooth_setprop_bonded_dev_fail_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_FAIL,
+		.set_data = &setprop_bonded_dev_prop,
+		.action = bt_set_property_action,
+	},
+};
+static struct test_case bluetooth_setprop_bonded_dev_fail_tc = {
+	.step = bluetooth_setprop_bonded_dev_fail_steps,
+	.title = "Bluetooth Set BONDED_DEVICES - Fail",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_bonded_dev_fail_steps),
+};
+
 static struct test_case *test_cases[] = {
 	&bluetooth_init,
 	&bluetooth_enable_success_tc,
@@ -319,6 +537,13 @@ static struct test_case *test_cases[] = {
 	&bluetooth_setprop_disctimeout_success_tc,
 	&bluetooth_getprop_bdaddr_success_tc,
 	&bluetooth_getprop_bdname_success_tc,
+	&bluetooth_setprop_uuid_fail_tc,
+	&bluetooth_setprop_cod_fail_tc,
+	&bluetooth_setprop_tod_fail_tc,
+	&bluetooth_setprop_remote_rssi_fail_tc,
+	&bluetooth_setprop_srvc_record_fail_tc,
+	&bluetooth_setprop_bdaddr_fail_tc,
+	&bluetooth_setprop_bonded_dev_fail_tc,
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.9.1

