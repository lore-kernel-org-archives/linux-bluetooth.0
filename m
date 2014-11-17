Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] android/client: Add gatt client callbacks support for Android 5.0
Date: Mon, 17 Nov 2014 17:04:27 +0100
Message-Id: <1416240267-11215-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416240267-11215-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416240267-11215-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 301262b..49ccebf 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -608,6 +608,126 @@ static void gattc_listen_cb(int status, int client_if)
 								status);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+/* Callback invoked when the MTU for a given connection changes */
+static void gattc_configure_mtu_cb(int conn_id, int status, int mtu)
+{
+	haltest_info("%s: conn_id=%d, status=%d, mtu=%d", __func__, conn_id,
+								status, mtu);
+}
+
+/* Callback invoked when a scan filter configuration command has completed */
+static void gattc_scan_filter_cfg_cb(int action, int client_if, int status,
+						int filt_type, int avbl_space)
+{
+	haltest_info("%s: action=%d, client_if=%d, status=%d, filt_type=%d"
+			", avbl_space=%d", __func__, action, client_if, status,
+			filt_type, avbl_space);
+}
+
+/* Callback invoked when scan param has been added, cleared, or deleted */
+static void gattc_scan_filter_param_cb(int action, int client_if, int status,
+								int avbl_space)
+{
+	haltest_info("%s: action=%d, client_if=%d, status=%d, avbl_space=%d",
+			__func__, action, client_if, status, avbl_space);
+}
+
+/* Callback invoked when a scan filter configuration command has completed */
+static void gattc_scan_filter_status_cb(int enable, int client_if, int status)
+{
+	haltest_info("%s: enable=%d, client_if=%d, status=%d", __func__,
+						enable, client_if, status);
+}
+
+/* Callback invoked when multi-adv enable operation has completed */
+static void gattc_multi_adv_enable_cb(int client_if, int status)
+{
+	haltest_info("%s: client_if=%d, status=%d", __func__, client_if,
+									status);
+}
+
+/* Callback invoked when multi-adv param update operation has completed */
+static void gattc_multi_adv_update_cb(int client_if, int status)
+{
+	haltest_info("%s: client_if=%d, status=%d", __func__, client_if,
+									status);
+}
+
+/* Callback invoked when multi-adv instance data set operation has completed */
+static void gattc_multi_adv_data_cb(int client_if, int status)
+{
+	haltest_info("%s: client_if=%d, status=%d", __func__, client_if,
+									status);
+}
+
+/* Callback invoked when multi-adv disable operation has completed */
+static void gattc_multi_adv_disable_cb(int client_if, int status)
+{
+	haltest_info("%s: client_if=%d, status=%d", __func__, client_if,
+									status);
+}
+
+/*
+ * Callback notifying an application that a remote device connection is
+ * currently congested and cannot receive any more data. An application should
+ * avoid sending more data until a further callback is received indicating the
+ * congestion status has been cleared.
+ */
+static void gattc_congestion_cb(int conn_id, bool congested)
+{
+	haltest_info("%s: conn_id=%d, congested=%d", __func__, conn_id,
+								congested);
+}
+
+/* Callback invoked when batchscan storage config operation has completed */
+static void gattc_batchscan_cfg_storage_cb(int client_if, int status)
+{
+	haltest_info("%s: client_if=%d, status=%d", __func__, client_if,
+									status);
+}
+
+/* Callback invoked when batchscan enable / disable operation has completed */
+static void gattc_batchscan_enable_disable_cb(int action, int client_if,
+								int status)
+{
+	haltest_info("%s: action=%d, client_if=%d, status=%d", __func__, action,
+							client_if, status);
+}
+
+/* Callback invoked when batchscan reports are obtained */
+static void gattc_batchscan_reports_cb(int client_if, int status,
+					int report_format, int num_records,
+					int data_len, uint8_t* rep_data)
+{
+	/* BTGATT_MAX_ATTR_LEN = 600 */
+	char valbuf[600];
+
+	haltest_info("%s: client_if=%d, status=%d, report_format=%d"
+			", num_records=%d, data_len=%d, rep_data=%s", __func__,
+			client_if, status, report_format, num_records, data_len,
+			array2str(rep_data, data_len, valbuf, sizeof(valbuf)));
+}
+
+/* Callback invoked when batchscan storage threshold limit is crossed */
+static void gattc_batchscan_threshold_cb(int client_if)
+{
+	haltest_info("%s: client_if=%d", __func__, client_if);
+}
+
+/* Track ADV VSE callback invoked when tracked device is found or lost */
+static void gattc_track_adv_event_cb(int client_if, int filt_index,
+						int addr_type, bt_bdaddr_t* bda,
+						int adv_state)
+{
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s, client_if=%d, filt_index=%d, addr_type=%d, bda=%s"
+			", adv_state=%d", __func__, client_if, filt_index,
+			addr_type, bt_bdaddr_t2str(bda, buf), adv_state);
+}
+#endif
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
@@ -627,6 +747,22 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.execute_write_cb = gattc_execute_write_cb,
 	.read_remote_rssi_cb = gattc_read_remote_rssi_cb,
 	.listen_cb = gattc_listen_cb,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.configure_mtu_cb = gattc_configure_mtu_cb,
+	.scan_filter_cfg_cb = gattc_scan_filter_cfg_cb,
+	.scan_filter_param_cb = gattc_scan_filter_param_cb,
+	.scan_filter_status_cb = gattc_scan_filter_status_cb,
+	.multi_adv_enable_cb = gattc_multi_adv_enable_cb,
+	.multi_adv_update_cb = gattc_multi_adv_update_cb,
+	.multi_adv_data_cb = gattc_multi_adv_data_cb,
+	.multi_adv_disable_cb = gattc_multi_adv_disable_cb,
+	.congestion_cb = gattc_congestion_cb,
+	.batchscan_cfg_storage_cb = gattc_batchscan_cfg_storage_cb,
+	.batchscan_enb_disable_cb = gattc_batchscan_enable_disable_cb,
+	.batchscan_reports_cb = gattc_batchscan_reports_cb,
+	.batchscan_threshold_cb = gattc_batchscan_threshold_cb,
+	.track_adv_event_cb = gattc_track_adv_event_cb,
+#endif
 };
 
 /* BT-GATT Server callbacks */
-- 
1.9.3

