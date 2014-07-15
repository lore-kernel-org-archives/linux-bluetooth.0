Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 08/10] android/tester-bluetooth: Add get properties success cases
Date: Tue, 15 Jul 2014 10:24:57 +0200
Message-Id: <1405412699-6358-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 219 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index a8eecb6..d69134b 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -562,6 +562,219 @@ static struct test_case bluetooth_setprop_scan_mode_conn_success_tc = {
 				bluetooth_setprop_scan_mode_conn_success_steps),
 };
 
+static uint32_t test_getprop_cod_val = 0x00020c;
+
+static bt_property_t getprop_cod_prop = {
+	.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.val = &test_getprop_cod_val,
+	.len = sizeof(test_getprop_cod_val),
+};
+
+static struct step bluetooth_getprop_cod_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_cod_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_cod_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_cod_success_tc = {
+	.step = bluetooth_getprop_cod_success_steps,
+	.title = "Bluetooth Get CLASS_OF_DEVICE - Success",
+	.step_num = get_test_case_step_num(bluetooth_getprop_cod_success_steps),
+};
+
+static bt_device_type_t test_getprop_tod_val = BT_DEVICE_DEVTYPE_DUAL;
+
+static bt_property_t getprop_tod_prop = {
+	.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.val = &test_getprop_tod_val,
+	.len = sizeof(test_getprop_tod_val),
+};
+
+static struct step bluetooth_getprop_tod_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_tod_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_tod_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_tod_success_tc = {
+	.step = bluetooth_getprop_tod_success_steps,
+	.title = "Bluetooth Get TYPE_OF_DEVICE - Success",
+	.step_num = get_test_case_step_num(bluetooth_getprop_tod_success_steps),
+};
+
+static bt_scan_mode_t test_getprop_scan_mode_val = BT_SCAN_MODE_NONE;
+
+static bt_property_t getprop_scan_mode_prop = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &test_getprop_scan_mode_val,
+	.len = sizeof(test_getprop_scan_mode_val),
+};
+
+static struct step bluetooth_getprop_scan_mode_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_scan_mode_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_scan_mode_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_scan_mode_success_tc = {
+	.step = bluetooth_getprop_scan_mode_success_steps,
+	.title = "Bluetooth Get SCAN_MODE - Success",
+	.step_num = get_test_case_step_num(
+				bluetooth_getprop_scan_mode_success_steps),
+};
+
+static uint32_t test_getprop_disc_timeout_val = 120;
+
+static bt_property_t getprop_disc_timeout_prop = {
+	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.val = &test_getprop_disc_timeout_val,
+	.len = sizeof(test_getprop_disc_timeout_val),
+};
+
+static struct step bluetooth_getprop_disc_timeout_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_disc_timeout_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_disc_timeout_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_disc_timeout_success_tc = {
+	.step = bluetooth_getprop_disc_timeout_success_steps,
+	.title = "Bluetooth Get DISCOVERY_TIMEOUT - Success",
+	.step_num = get_test_case_step_num(
+				bluetooth_getprop_disc_timeout_success_steps),
+};
+
+static const char test_getprop_uuids_val[] = {
+	/* Multi profile UUID */
+	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
+	/* Device identification profile UUID */
+	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
+};
+
+static bt_property_t getprop_uuids_prop = {
+	.type = BT_PROPERTY_UUIDS,
+	.val = &test_getprop_uuids_val,
+	.len = sizeof(test_getprop_uuids_val),
+};
+
+static struct step bluetooth_getprop_uuids_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_uuids_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_uuids_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_uuids_success_tc = {
+	.step = bluetooth_getprop_uuids_success_steps,
+	.title = "Bluetooth Get UUIDS - Success",
+	.step_num = get_test_case_step_num(
+					bluetooth_getprop_uuids_success_steps),
+};
+
+static bt_property_t getprop_bonded_devs_prop = {
+	.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.val = NULL,
+	.len = 0,
+};
+
+static struct step bluetooth_getprop_bonded_devs_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &getprop_bonded_devs_prop,
+		.action = bt_get_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &getprop_bonded_devs_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_getprop_bonded_devs_success_tc = {
+	.step = bluetooth_getprop_bonded_devs_success_steps,
+	.title = "Bluetooth Get BONDED_DEVICES - Success",
+	.step_num = get_test_case_step_num(
+				bluetooth_getprop_bonded_devs_success_steps),
+};
+
 static struct test_case *test_cases[] = {
 	&bluetooth_init,
 	&bluetooth_enable_success_tc,
@@ -580,6 +793,12 @@ static struct test_case *test_cases[] = {
 	&bluetooth_setprop_bdaddr_fail_tc,
 	&bluetooth_setprop_bonded_dev_fail_tc,
 	&bluetooth_setprop_scan_mode_conn_success_tc,
+	&bluetooth_getprop_cod_success_tc,
+	&bluetooth_getprop_tod_success_tc,
+	&bluetooth_getprop_scan_mode_success_tc,
+	&bluetooth_getprop_disc_timeout_success_tc,
+	&bluetooth_getprop_uuids_success_tc,
+	&bluetooth_getprop_bonded_devs_success_tc,
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.9.1

