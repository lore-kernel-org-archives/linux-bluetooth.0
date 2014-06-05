Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/client: Add properly print prefix for hex values
Date: Thu,  5 Jun 2014 13:08:39 +0200
Message-Id: <1401966521-32270-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix print hex values by adding "0x" prefix.
---
 android/client/if-gatt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 0375126..f6e6327 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -454,7 +454,7 @@ static void gattc_get_characteristic_cb(int conn_id, int status,
 	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
 	char char_id_buf[MAX_CHAR_ID_STR_LEN];
 
-	haltest_info("%s: conn_id=%d status=%d srvc_id=%s char_id=%s, char_prop=%x\n",
+	haltest_info("%s: conn_id=%d status=%d srvc_id=%s char_id=%s, char_prop=0x%x\n",
 			__func__, conn_id, status,
 			btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
 			btgatt_gatt_id_t2str(char_id, char_id_buf), char_prop);
@@ -644,7 +644,7 @@ static void gatts_service_added_cb(int status, int server_if,
 
 	snprintf(server_if_str, sizeof(server_if_str), "%d", server_if);
 
-	haltest_info("%s: status=%d server_if=%d srvc_id=%s handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d srvc_id=%s handle=0x%x\n",
 			__func__, status, server_if,
 			btgatt_srvc_id_t2str(srvc_id, buf), srvc_handle);
 }
@@ -654,7 +654,7 @@ static void gatts_included_service_added_cb(int status, int server_if,
 							int srvc_handle,
 							int incl_srvc_handle)
 {
-	haltest_info("%s: status=%d server_if=%d srvc_handle=%x inc_srvc_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d srvc_handle=0x%x inc_srvc_handle=0x%x\n",
 						__func__, status, server_if,
 						srvc_handle, incl_srvc_handle);
 }
@@ -667,7 +667,7 @@ static void gatts_characteristic_added_cb(int status, int server_if,
 {
 	char buf[MAX_SRVC_ID_STR_LEN];
 
-	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=%x char_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=0x%x char_handle=0x%x\n",
 			__func__, status, server_if, gatt_uuid_t2str(uuid, buf),
 			srvc_handle, char_handle);
 }
@@ -679,7 +679,7 @@ static void gatts_descriptor_added_cb(int status, int server_if,
 {
 	char buf[MAX_SRVC_ID_STR_LEN];
 
-	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=%x descr_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d uuid=%s srvc_handle=0x%x descr_handle=0x%x\n",
 			__func__, status, server_if, gatt_uuid_t2str(uuid, buf),
 			srvc_handle, descr_handle);
 }
@@ -687,21 +687,21 @@ static void gatts_descriptor_added_cb(int status, int server_if,
 /* Callback invoked in response to start_service */
 static void gatts_service_started_cb(int status, int server_if, int srvc_handle)
 {
-	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d srvc_handle=0x%x\n",
 				__func__, status, server_if, srvc_handle);
 }
 
 /* Callback invoked in response to stop_service */
 static void gatts_service_stopped_cb(int status, int server_if, int srvc_handle)
 {
-	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d srvc_handle=0x%x\n",
 				__func__, status, server_if, srvc_handle);
 }
 
 /* Callback triggered when a service has been deleted */
 static void gatts_service_deleted_cb(int status, int server_if, int srvc_handle)
 {
-	haltest_info("%s: status=%d server_if=%d srvc_handle=%x\n",
+	haltest_info("%s: status=%d server_if=%d srvc_handle=0x%x\n",
 				__func__, status, server_if, srvc_handle);
 }
 
@@ -715,7 +715,7 @@ static void gatts_request_read_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 {
 	char buf[MAX_ADDR_STR_LEN];
 
-	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=%x offset=%d is_long=%d\n",
+	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=0x%x offset=%d is_long=%d\n",
 			__func__, conn_id, trans_id, bt_bdaddr_t2str(bda, buf),
 			attr_handle, offset, is_long);
 }
@@ -732,7 +732,7 @@ static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 	char buf[MAX_ADDR_STR_LEN];
 	char valbuf[100];
 
-	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=%x offset=%d length=%d need_rsp=%d is_prep=%d value=%s\n",
+	haltest_info("%s: conn_id=%d trans_id=%d bda=%s attr_handle=0x%x offset=%d length=%d need_rsp=%d is_prep=%d value=%s\n",
 			__func__, conn_id, trans_id, bt_bdaddr_t2str(bda, buf),
 			attr_handle, offset, length, need_rsp, is_prep,
 			array2str(value, length, valbuf, sizeof(valbuf)));
@@ -755,7 +755,7 @@ static void gatts_request_exec_write_cb(int conn_id, int trans_id,
  */
 static void gatts_response_confirmation_cb(int status, int handle)
 {
-	haltest_info("%s: status=%d handle=%x\n", __func__, status, handle);
+	haltest_info("%s: status=%d handle=0x%x\n", __func__, status, handle);
 }
 
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
-- 
1.9.2

