Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 02/10] android/client: Add GATT client callbacks code
Date: Thu, 31 Oct 2013 11:45:07 +0100
Message-ID: <1383216315-30627-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds callbacks code, mostly printing.
Complex formating function not implemented yet.
---
 android/client/if-gatt.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 09e2a49..8f3dc3c 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -21,29 +21,84 @@
 
 const btgatt_interface_t *if_gatt = NULL;
 
+#define MAX_CHAR_ID_STR_LEN (MAX_UUID_STR_LEN + 3 + 11)
+#define MAX_SRVC_ID_STR_LEN (MAX_UUID_STR_LEN + 3 + 11 + 1 + 11)
+/* How man characters print from binary objects (arbitrary) */
+#define MAX_HEX_VAL_STR_LEN 100
+#define MAX_NOTIFY_PARAMS_STR_LEN (MAX_SRVC_ID_STR_LEN + MAX_CHAR_ID_STR_LEN \
+		+ MAX_ADDR_STR_LEN + MAX_HEX_VAL_STR_LEN + 60)
+#define MAX_READ_PARAMS_STR_LEN (MAX_SRVC_ID_STR_LEN + MAX_CHAR_ID_STR_LEN \
+		+ MAX_UUID_STR_LEN + MAX_HEX_VAL_STR_LEN + 80)
+
+static char *gatt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
+{
+	return buf;
+}
+
+static char *btgatt_char_id_t2str(const btgatt_char_id_t *char_id, char *buf)
+{
+	return buf;
+}
+
+static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
+{
+	return buf;
+}
+
+static char *btgatt_notify_params_t2str(const btgatt_notify_params_t *data,
+								char *buf)
+{
+	return buf;
+}
+
+static char *btgatt_read_params_t2str(const btgatt_read_params_t *data,
+								char *buf)
+{
+	return buf;
+}
+
 /* BT-GATT Client callbacks. */
 
 /* Callback invoked in response to register_client */
 static void gattc_register_client_cb(int status, int client_if,
 							bt_uuid_t *app_uuid)
 {
+	char buf[MAX_UUID_STR_LEN];
+
+	haltest_info("%s: status=%d client_if=%d app_uuid=%s\n", __func__,
+						status, client_if,
+						gatt_uuid_t2str(app_uuid, buf));
 }
 
 /* Callback for scan results */
 static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: bda=%s rssi=%d adv_data=%p\n", __func__,
+				bt_bdaddr_t2str(bda, buf), rssi, adv_data);
 }
 
 /* GATT open callback invoked in response to open */
 static void gattc_connect_cb(int conn_id, int status, int client_if,
 							bt_bdaddr_t *bda)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d, client_if=%d bda=%s\n",
+					__func__, conn_id, status, client_if,
+					bt_bdaddr_t2str(bda, buf));
 }
 
 /* Callback invoked in response to close */
 static void gattc_disconnect_cb(int conn_id, int status, int client_if,
 							bt_bdaddr_t *bda)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d, client_if=%d bda=%s\n",
+					__func__, conn_id, status, client_if,
+					bt_bdaddr_t2str(bda, buf));
 }
 
 /*
@@ -52,11 +107,16 @@ static void gattc_disconnect_cb(int conn_id, int status, int client_if,
  */
 static void gattc_search_complete_cb(int conn_id, int status)
 {
+	haltest_info("%s: conn_id=%d status=%s\n", __func__, conn_id, status);
 }
 
 /* Reports GATT services on a remote device */
 static void gattc_search_result_cb(int conn_id, btgatt_srvc_id_t *srvc_id)
 {
+	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+
+	haltest_info("%s: conn_id=%d srvc_id=%s\n", __func__, conn_id,
+				btgatt_srvc_id_t2str(srvc_id, srvc_id_buf));
 }
 
 /* GATT characteristic enumeration result callback */
@@ -65,6 +125,18 @@ static void gattc_get_characteristic_cb(int conn_id, int status,
 					btgatt_char_id_t *char_id,
 					int char_prop)
 {
+	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+	char char_id_buf[MAX_CHAR_ID_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d srvc_id=%s char_id=%s, char_prop=%x\n",
+			__func__, conn_id, status,
+			btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
+			btgatt_char_id_t2str(char_id, char_id_buf), char_prop);
+
+	/* enumerate next characteristic */
+	if (status == 0)
+		EXEC(if_gatt->client->get_characteristic, conn_id, srvc_id,
+								char_id);
 }
 
 /* GATT descriptor enumeration result callback */
@@ -72,6 +144,19 @@ static void gattc_get_descriptor_cb(int conn_id, int status,
 		btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
 		bt_uuid_t *descr_id)
 {
+	char buf[MAX_UUID_STR_LEN];
+	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+	char char_id_buf[MAX_CHAR_ID_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d srvc_id=%s char_id=%s, descr_id=%s\n",
+				__func__, conn_id, status,
+				btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
+				btgatt_char_id_t2str(char_id, char_id_buf),
+				gatt_uuid_t2str(descr_id, buf));
+
+	if (status == 0)
+		EXEC(if_gatt->client->get_descriptor, conn_id, srvc_id, char_id,
+								descr_id);
 }
 
 /* GATT included service enumeration result callback */
@@ -79,6 +164,17 @@ static void gattc_get_included_service_cb(int conn_id, int status,
 						btgatt_srvc_id_t *srvc_id,
 						btgatt_srvc_id_t *incl_srvc_id)
 {
+	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+	char incl_srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d srvc_id=%s incl_srvc_id=%s)\n",
+			__func__, conn_id, status,
+			btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
+			btgatt_srvc_id_t2str(incl_srvc_id, incl_srvc_id_buf));
+
+	if (status == 0)
+		EXEC(if_gatt->client->get_included_service, conn_id, srvc_id,
+								incl_srvc_id);
 }
 
 /* Callback invoked in response to [de]register_for_notification */
@@ -87,6 +183,13 @@ static void gattc_register_for_notification_cb(int conn_id, int registered,
 						btgatt_srvc_id_t *srvc_id,
 						btgatt_char_id_t *char_id)
 {
+	char srvc_id_buf[MAX_SRVC_ID_STR_LEN];
+	char char_id_buf[MAX_CHAR_ID_STR_LEN];
+
+	haltest_info("%s: conn_id=%d registered=%d status=%d srvc_id=%s char_id=%s\n",
+				__func__, conn_id, registered, status,
+				btgatt_srvc_id_t2str(srvc_id, srvc_id_buf),
+				btgatt_char_id_t2str(char_id, char_id_buf));
 }
 
 /*
@@ -95,41 +198,60 @@ static void gattc_register_for_notification_cb(int conn_id, int registered,
  */
 static void gattc_notify_cb(int conn_id, btgatt_notify_params_t *p_data)
 {
+	char buf[MAX_NOTIFY_PARAMS_STR_LEN];
+
+	haltest_info("%s: conn_id=%d data=%s\n", __func__, conn_id,
+				btgatt_notify_params_t2str(p_data, buf));
 }
 
 /* Reports result of a GATT read operation */
 static void gattc_read_characteristic_cb(int conn_id, int status,
 						btgatt_read_params_t *p_data)
 {
+	char buf[MAX_READ_PARAMS_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d data=%s\n", __func__, conn_id,
+				status, btgatt_read_params_t2str(p_data, buf));
 }
 
 /* GATT write characteristic operation callback */
 static void gattc_write_characteristic_cb(int conn_id, int status,
 						btgatt_write_params_t *p_data)
 {
+	haltest_info("%s: conn_id=%d status=%d\n", __func__, conn_id, status);
 }
 
 /* GATT execute prepared write callback */
 static void gattc_execute_write_cb(int conn_id, int status)
 {
+	haltest_info("%s: conn_id=%d status=%d\n", __func__, conn_id, status);
 }
 
 /* Callback invoked in response to read_descriptor */
 static void gattc_read_descriptor_cb(int conn_id, int status,
 						btgatt_read_params_t *p_data)
 {
+	char buf[MAX_READ_PARAMS_STR_LEN];
+
+	haltest_info("%s: conn_id=%d status=%d data=%s\n", __func__, conn_id,
+				status, btgatt_read_params_t2str(p_data, buf));
 }
 
 /* Callback invoked in response to write_descriptor */
 static void gattc_write_descriptor_cb(int conn_id, int status,
 						btgatt_write_params_t *p_data)
 {
+	haltest_info("%s: conn_id=%d status=%d\n", __func__, conn_id, status);
 }
 
 /* Callback triggered in response to read_remote_rssi */
 static void gattc_read_remote_rssi_cb(int client_if, bt_bdaddr_t *bda, int rssi,
 								int status)
 {
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: client_if=%d bda=%s rssi=%d satus=%d\n", __func__,
+			client_if, bt_bdaddr_t2str(bda, buf), rssi, status);
 }
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
-- 
1.7.9.5

