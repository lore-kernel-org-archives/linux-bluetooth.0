Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/9] android/tester-ng: Use action and callback defining macros
Date: Thu, 17 Jul 2014 10:29:48 +0200
Message-Id: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This significantly shortens the action definitions.
---
 android/tester-bluetooth.c | 460 +++++++++------------------------------------
 android/tester-gatt.c      |   4 +-
 android/tester-hidhost.c   |   4 +-
 android/tester-main.h      |  23 +++
 android/tester-socket.c    |   4 +-
 5 files changed, 112 insertions(+), 383 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 78a27f7..75df62d 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -20,9 +20,7 @@
 static struct queue *list; /* List of bluetooth test cases */
 
 static struct step dummy_steps[] = {
-	{
-		.action = dummy_action,
-	},
+	ACTION_SUCCESS(dummy_action, NULL),
 };
 static struct test_case bluetooth_init = {
 	.step = dummy_steps,
@@ -63,19 +61,9 @@ static bt_property_t enable_props[] = {
 };
 
 static struct step bluetooth_enable_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = enable_props,
-		.callback_result.num_properties = 8,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_ADAPTER_PROPS(enable_props, 8),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 };
 static struct test_case bluetooth_enable_success_tc = {
 	.step = bluetooth_enable_success_steps,
@@ -84,23 +72,10 @@ static struct test_case bluetooth_enable_success_tc = {
 };
 
 static struct step bluetooth_enable_success2_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = enable_props,
-		.callback_result.num_properties = 8,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_ADAPTER_PROPS(enable_props, 8),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
 };
 static struct test_case bluetooth_enable_success2_tc = {
 	.step = bluetooth_enable_success2_steps,
@@ -109,22 +84,10 @@ static struct test_case bluetooth_enable_success2_tc = {
 };
 
 static struct step bluetooth_disable_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_disable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_OFF,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bluetooth_disable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 };
 static struct test_case bluetooth_disable_success_tc = {
 	.step = bluetooth_disable_success_steps,
@@ -141,24 +104,10 @@ static bt_property_t setprop_bdname_prop = {
 };
 
 static struct step bluetooth_setprop_bdname_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &setprop_bdname_prop,
-		.action = bt_set_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &setprop_bdname_prop,
-		.callback_result.num_properties = 1,
-	}
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_set_property_action, &setprop_bdname_prop),
+	CALLBACK_ADAPTER_PROPS(&setprop_bdname_prop, 1),
 };
 static struct test_case bluetooth_setprop_bdname_success_tc = {
 	.step = bluetooth_setprop_bdname_success_steps,
@@ -177,24 +126,10 @@ static bt_property_t setprop_scanmode_prop = {
 };
 
 static struct step bluetooth_setprop_scanmode_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &setprop_scanmode_prop,
-		.action = bt_set_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &setprop_scanmode_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_set_property_action, &setprop_scanmode_prop),
+	CALLBACK_ADAPTER_PROPS(&setprop_scanmode_prop, 1),
 };
 static struct test_case bluetooth_setprop_scanmode_success_tc = {
 	.step = bluetooth_setprop_scanmode_success_steps,
@@ -212,23 +147,10 @@ static bt_property_t setprop_disctimeout_prop = {
 };
 
 static struct step bluetooth_setprop_disctimeout_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &setprop_disctimeout_prop,
-		.action = bt_set_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = NULL,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_set_property_action, &setprop_disctimeout_prop),
+	CALLBACK_ADAPTER_PROPS(&setprop_disctimeout_prop, 1),
 };
 static struct test_case bluetooth_setprop_disctimeout_success_tc = {
 	.step = bluetooth_setprop_disctimeout_success_steps,
@@ -248,24 +170,10 @@ static bt_property_t getprop_bdaddr_prop = {
 };
 
 static struct step bluetooth_getprop_bdaddr_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_bdaddr_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_bdaddr_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_bdaddr_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_bdaddr_prop, 1),
 };
 static struct test_case bluetooth_getprop_bdaddr_success_tc = {
 	.step = bluetooth_getprop_bdaddr_success_steps,
@@ -283,24 +191,10 @@ static bt_property_t getprop_bdname_prop = {
 };
 
 static struct step bluetooth_getprop_bdname_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_bdname_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_bdname_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_bdname_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_bdname_prop, 1),
 };
 static struct test_case bluetooth_getprop_bdname_success_tc = {
 	.step = bluetooth_getprop_bdname_success_steps,
@@ -321,19 +215,9 @@ static bt_property_t setprop_uuid_prop = {
 };
 
 static struct step bluetooth_setprop_uuid_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_uuid_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_uuid_prop),
 };
 static struct test_case bluetooth_setprop_uuid_fail_tc = {
 	.step = bluetooth_setprop_uuid_fail_steps,
@@ -350,19 +234,9 @@ static bt_property_t setprop_cod_prop = {
 };
 
 static struct step bluetooth_setprop_cod_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_cod_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_cod_prop),
 };
 static struct test_case bluetooth_setprop_cod_fail_tc = {
 	.step = bluetooth_setprop_cod_fail_steps,
@@ -379,19 +253,9 @@ static bt_property_t setprop_tod_prop = {
 };
 
 static struct step bluetooth_setprop_tod_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_tod_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_tod_prop),
 };
 static struct test_case bluetooth_setprop_tod_fail_tc = {
 	.step = bluetooth_setprop_tod_fail_steps,
@@ -408,19 +272,9 @@ static bt_property_t setprop_remote_rssi_prop = {
 };
 
 static struct step bluetooth_setprop_remote_rssi_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_remote_rssi_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_remote_rssi_prop),
 };
 static struct test_case bluetooth_setprop_remote_rssi_fail_tc = {
 	.step = bluetooth_setprop_remote_rssi_fail_steps,
@@ -442,19 +296,9 @@ static bt_property_t setprop_srvc_record_prop = {
 };
 
 static struct step bluetooth_setprop_srvc_record_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_srvc_record_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_srvc_record_prop),
 };
 static struct test_case bluetooth_setprop_srvc_record_fail_tc = {
 	.step = bluetooth_setprop_srvc_record_fail_steps,
@@ -474,19 +318,9 @@ static bt_property_t setprop_bdaddr_prop = {
 };
 
 static struct step bluetooth_setprop_bdaddr_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_bdaddr_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_bdaddr_prop),
 };
 static struct test_case bluetooth_setprop_bdaddr_fail_tc = {
 	.step = bluetooth_setprop_bdaddr_fail_steps,
@@ -506,19 +340,9 @@ static bt_property_t setprop_bonded_dev_prop = {
 };
 
 static struct step bluetooth_setprop_bonded_dev_fail_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_FAIL,
-		.set_data = &setprop_bonded_dev_prop,
-		.action = bt_set_property_action,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_FAIL(bt_set_property_action, &setprop_bonded_dev_prop),
 };
 static struct test_case bluetooth_setprop_bonded_dev_fail_tc = {
 	.step = bluetooth_setprop_bonded_dev_fail_steps,
@@ -536,24 +360,10 @@ static bt_property_t setprop_scan_mode_conn_prop = {
 };
 
 static struct step bluetooth_setprop_scan_mode_conn_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &setprop_scan_mode_conn_prop,
-		.action = bt_set_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &setprop_scan_mode_conn_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode_conn_prop),
+	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode_conn_prop, 1),
 };
 static struct test_case bluetooth_setprop_scan_mode_conn_success_tc = {
 	.step = bluetooth_setprop_scan_mode_conn_success_steps,
@@ -571,24 +381,10 @@ static bt_property_t getprop_cod_prop = {
 };
 
 static struct step bluetooth_getprop_cod_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_cod_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_cod_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_cod_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_cod_prop, 1),
 };
 static struct test_case bluetooth_getprop_cod_success_tc = {
 	.step = bluetooth_getprop_cod_success_steps,
@@ -605,24 +401,10 @@ static bt_property_t getprop_tod_prop = {
 };
 
 static struct step bluetooth_getprop_tod_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_tod_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_tod_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_tod_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_tod_prop, 1),
 };
 static struct test_case bluetooth_getprop_tod_success_tc = {
 	.step = bluetooth_getprop_tod_success_steps,
@@ -639,24 +421,10 @@ static bt_property_t getprop_scan_mode_prop = {
 };
 
 static struct step bluetooth_getprop_scan_mode_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_scan_mode_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_scan_mode_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_scan_mode_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_scan_mode_prop, 1),
 };
 static struct test_case bluetooth_getprop_scan_mode_success_tc = {
 	.step = bluetooth_getprop_scan_mode_success_steps,
@@ -674,24 +442,10 @@ static bt_property_t getprop_disc_timeout_prop = {
 };
 
 static struct step bluetooth_getprop_disc_timeout_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_disc_timeout_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_disc_timeout_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_disc_timeout_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_disc_timeout_prop, 1),
 };
 static struct test_case bluetooth_getprop_disc_timeout_success_tc = {
 	.step = bluetooth_getprop_disc_timeout_success_steps,
@@ -716,24 +470,10 @@ static bt_property_t getprop_uuids_prop = {
 };
 
 static struct step bluetooth_getprop_uuids_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_uuids_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_uuids_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_uuids_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_uuids_prop, 1),
 };
 static struct test_case bluetooth_getprop_uuids_success_tc = {
 	.step = bluetooth_getprop_uuids_success_steps,
@@ -749,24 +489,10 @@ static bt_property_t getprop_bonded_devs_prop = {
 };
 
 static struct step bluetooth_getprop_bonded_devs_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &getprop_bonded_devs_prop,
-		.action = bt_get_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &getprop_bonded_devs_prop,
-		.callback_result.num_properties = 1,
-	},
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_get_property_action, &getprop_bonded_devs_prop),
+	CALLBACK_ADAPTER_PROPS(&getprop_bonded_devs_prop, 1),
 };
 static struct test_case bluetooth_getprop_bonded_devs_success_tc = {
 	.step = bluetooth_getprop_bonded_devs_success_steps,
@@ -784,28 +510,14 @@ static bt_property_t setprop_scan_mode2_prop = {
 };
 
 static struct step bluetooth_setprop_scan_mode2_success_steps[] = {
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.action = bluetooth_enable_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_STATE_CHANGED,
-		.callback_result.state = BT_STATE_ON,
-	},
-	{
-		.action_result.status = BT_STATUS_SUCCESS,
-		.set_data = &setprop_scan_mode2_prop,
-		.action = bt_set_property_action,
-	},
-	{
-		.callback = CB_BT_ADAPTER_PROPERTIES,
-		.callback_result.properties = &setprop_scan_mode2_prop,
-		.callback_result.num_properties = 1,
-	}
+	ACTION_SUCCESS(bluetooth_enable_action, NULL),
+	CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+	ACTION_SUCCESS(bt_set_property_action, &setprop_scan_mode2_prop),
+	CALLBACK_ADAPTER_PROPS(&setprop_scan_mode2_prop, 1),
 };
 static struct test_case bluetooth_setprop_scan_mode2_success_tc = {
 	.step = bluetooth_setprop_scan_mode2_success_steps,
-	.title = "Bluetooth Set SCAN_MODE - Success",
+	.title = "Bluetooth Set SCAN_MODE - Success 2",
 	.step_num = get_test_case_step_num(
 				bluetooth_setprop_scan_mode2_success_steps),
 };
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 4a7c9b1..db2ed27 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -20,9 +20,7 @@
 static struct queue *list; /* List of gatt test cases */
 
 static struct step dummy_steps[] = {
-	{
-		.action = dummy_action,
-	},
+	ACTION_SUCCESS(dummy_action, NULL),
 };
 static struct test_case gatt_init = {
 	.step = dummy_steps,
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 413c6b8..49c34bd 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -20,9 +20,7 @@
 static struct queue *list; /* List of hidhost test cases */
 
 static struct step dummy_steps[] = {
-	{
-		.action = dummy_action,
-	},
+	ACTION_SUCCESS(dummy_action, NULL),
 };
 static struct test_case hidhost_init = {
 	.step = dummy_steps,
diff --git a/android/tester-main.h b/android/tester-main.h
index c10513e..d8c2986 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -52,6 +52,29 @@
 
 #define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
 
+#define ACTION_SUCCESS(act_fun, data_set) { \
+		.action_result.status = BT_STATUS_SUCCESS, \
+		.action = act_fun, \
+		.set_data = data_set, \
+	}
+
+#define ACTION_FAIL(act_fun, data_set) { \
+		.action_result.status = BT_STATUS_FAIL, \
+		.action = act_fun, \
+		.set_data = data_set, \
+	}
+
+#define CALLBACK_STATE(cb, cb_res) { \
+		.callback = cb, \
+		.callback_result.state = cb_res, \
+	}
+
+#define CALLBACK_ADAPTER_PROPS(props, prop_cnt) { \
+		.callback = CB_BT_ADAPTER_PROPERTIES, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+	}
+
 /*
  * NOTICE:
  * Callback enum sections should be
diff --git a/android/tester-socket.c b/android/tester-socket.c
index a57b324..0afab4a 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -20,9 +20,7 @@
 static struct queue *list; /* List of socket test cases */
 
 static struct step dummy_steps[] = {
-	{
-		.action = dummy_action,
-	},
+	ACTION_SUCCESS(dummy_action, NULL),
 };
 static struct test_case socket_init = {
 	.step = dummy_steps,
-- 
1.9.1

