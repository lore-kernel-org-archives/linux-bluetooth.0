Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester-gatt: Minor coding style fix
Date: Fri, 12 Sep 2014 12:13:20 +0200
Message-Id: <1410516800-1984-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 69 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f22cdae..2292f87 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -21,8 +21,8 @@
 #include "tester-main.h"
 #include "src/shared/util.h"
 
-#define L2CAP_ATT_EXCHANGE_MTU_REQ		0x02
-#define L2CAP_ATT_EXCHANGE_MTU_RSP		0x03
+#define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
+#define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
 
 #define GATT_STATUS_SUCCESS	0x00000000
 #define GATT_STATUS_FAILURE	0x00000101
@@ -35,10 +35,9 @@
 
 #define data(args...) ((const unsigned char[]) { args })
 
-#define raw_pdu(args...)					\
-	{							\
-		.data = data(args),				\
-		.size = sizeof(data(args)),			\
+#define raw_pdu(args...) { \
+		.data = data(args), \
+		.size = sizeof(data(args)), \
 	}
 
 #define end_pdu { .data = NULL }
@@ -652,8 +651,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -673,8 +671,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -811,8 +808,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -836,8 +832,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -862,8 +857,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -886,8 +880,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -914,8 +907,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -924,7 +916,8 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(gatt_client_get_characteristic_action,
 							&get_char_data_2),
 		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_FAILURE,
-				CONN1_ID, &service_2, NULL, 0),
+							CONN1_ID, &service_2,
+							NULL, 0),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -942,8 +935,7 @@ static struct test_case test_cases[] = {
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -968,14 +960,12 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -984,13 +974,16 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
 							&get_char_data_1),
 		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
-				CONN1_ID, &service_1, &characteristic_1, 4),
+							CONN1_ID, &service_1,
+							&characteristic_1, 4),
 		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_1),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
-				&service_1, &characteristic_1, &desc_1),
+						&service_1, &characteristic_1,
+						&desc_1),
 		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_2),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
-					&service_1, &characteristic_1, &desc_2),
+						&service_1, &characteristic_1,
+						&desc_2),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1003,14 +996,12 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -1035,14 +1026,12 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -1063,14 +1052,12 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -1091,14 +1078,12 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action,
-							&client1_conn_req),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -1106,7 +1091,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_included, &get_incl_data_1),
 		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_FAILURE, CONN1_ID,
-						&service_1, NULL),
+							&service_1, NULL),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-- 
1.9.3

