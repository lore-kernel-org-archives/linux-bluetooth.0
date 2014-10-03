Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] android/tester: Add GATT server multiple connect succesful test case
Date: Fri,  3 Oct 2014 10:44:52 +0200
Message-Id: <1412325892-25013-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412325892-25013-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412325892-25013-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will connect to powered on and visible device multiple time then
disconnects.
---
 android/tester-gatt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f7f7417..6827995 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -2238,6 +2238,40 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - LE Multiple Server Conn./Disc",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_register_action, &app2_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(gatt_server_connect_action, &app2_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN2_ID, APP2_ID),
+		ACTION_SUCCESS(gatt_server_disconnect_action, &app2_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_DISCONNECTED,
+						prop_emu_remotes_default_set,
+						CONN2_ID, APP2_ID),
+		ACTION_SUCCESS(gatt_server_disconnect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_DISCONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

