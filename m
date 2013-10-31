Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 09/10] android/client: Add GATT server callbacks code
Date: Thu, 31 Oct 2013 11:45:14 +0100
Message-ID: <1383216315-30627-10-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds callbacks code for GATT server interface.
---
 android/client/if-gatt.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 3fe55e8..a262b90 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -583,6 +583,10 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 static void gatts_register_server_cb(int status, int server_if,
 							bt_uuid_t *app_uuid)
 {
+	char buf[MAX_UUID_STR_LEN];
+
+	haltest_info("%s: status=%d server_if=%d app_uuid=%s\n", __func__,
+			status, server_if, gatt_uuid_t2str(app_uuid, buf));
 }
 
 /*
@@ -592,12 +596,20 @@ static void gatts_register_server_cb(int status, int server_if,
 static void gatts_connection_cb(int conn_id, int server_if, int connected,
 							bt_bdaddr_t *bda)
 {
+	haltest_info("%s: conn_id=%d server_if=%d connected=%d bda=%s\n",
+					__func__, conn_id, server_if, connected,
+					bt_bdaddr_t2str(bda, last_addr));
 }
 
 /* Callback invoked in response to create_service */
 static void gatts_service_added_cb(int status, int server_if,
 				btgatt_srvc_id_t *srvc_id, int srvc_handle)
 {
+	char buf[MAX_SRVC_ID_STR_LEN];
+
+	haltest_info("%s: status=%d server_if=%d srvc_id=%s handle=%x\n",
+			__func__, status, server_if,
+			btgatt_srvc_id_t2str(srvc_id, buf), srvc_handle);
 }
 
 /* Callback indicating that an included service has been added to a service */
@@ -605,6 +617,9 @@ static void gatts_included_service_added_cb(int status, int server_if,
 							int srvc_handle,
 							int incl_srvc_handle)
 {
+	haltest_info("%s: status=%d server_if=%d srvc_handle=%x inc_srvc_handle=%x\n",
+						__func__, status, server_if,
+						srvc_handle, incl_srvc_handle);
 }
 
 /* Callback invoked when a characteristic has been added to a service */
@@ -613,6 +628,11 @@ static void gatts_characteristic_added_cb(int status, int server_if,
 								int srvc_handle,
 								int char_handle)
 {
+	char buf[MAX_SRVC_ID_STR_LEN];
+
+	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=%x char_handle=%x\n",
+			__func__, status, server_if, gatt_uuid_t2str(uuid, buf),
+			srvc_handle, char_handle);
 }
 
 /* Callback invoked when a descriptor has been added to a characteristic */
@@ -620,21 +640,32 @@ static void gatts_descriptor_added_cb(int status, int server_if,
 					bt_uuid_t *uuid, int srvc_handle,
 							int descr_handle)
 {
+	char buf[MAX_SRVC_ID_STR_LEN];
+
+	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=%x descr_handle=%x\n",
+			__func__, status, server_if, gatt_uuid_t2str(uuid, buf),
+			srvc_handle, descr_handle);
 }
 
 /* Callback invoked in response to start_service */
 static void gatts_service_started_cb(int status, int server_if, int srvc_handle)
 {
+	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+				__func__, status, server_if, srvc_handle);
 }
 
 /* Callback invoked in response to stop_service */
 static void gatts_service_stopped_cb(int status, int server_if, int srvc_handle)
 {
+	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+				__func__, status, server_if, srvc_handle);
 }
 
 /* Callback triggered when a service has been deleted */
 static void gatts_service_deleted_cb(int status, int server_if, int srvc_handle)
 {
+	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+				__func__, status, server_if, srvc_handle);
 }
 
 /*
@@ -645,6 +676,11 @@ static void gatts_request_read_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 						int attr_handle, int offset,
 						bool is_long)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=%x offset=%d is_long=%d\n",
+			__func__, conn_id, trans_id, bt_bdaddr_t2str(bda, buf),
+			attr_handle, offset, is_long);
 }
 
 /*
@@ -656,12 +692,24 @@ static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 					bool need_rsp, bool is_prep,
 					uint8_t *value)
 {
+	char buf[MAX_ADDR_STR_LEN];
+	char valbuf[100];
+
+	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=%x offset=%d length=%d need_rsp=%d is_prep=%d value=%s\n",
+			__func__, conn_id, trans_id, bt_bdaddr_t2str(bda, buf),
+			attr_handle, offset, length, need_rsp, is_prep,
+			array2str(value, length, valbuf, sizeof(valbuf)));
 }
 
 /* Callback invoked when a previously prepared write is to be executed */
 static void gatts_request_exec_write_cb(int conn_id, int trans_id,
 					bt_bdaddr_t *bda, int exec_write)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: conn_id=%d trans_id=%d bda=%s exec_write=%d\n",
+			__func__, conn_id, trans_id, bt_bdaddr_t2str(bda, buf),
+			exec_write);
 }
 
 /*
@@ -670,6 +718,7 @@ static void gatts_request_exec_write_cb(int conn_id, int trans_id,
  */
 static void gatts_response_confirmation_cb(int status, int handle)
 {
+	haltest_info("%s: status=%d handle=%x\n", __func__, status, handle);
 }
 
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
-- 
1.7.9.5

