Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chih-Wei Huang <cwhuang@android-x86.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: [PATCH 3/3] android: fix building errors on Android 6.0
Date: Wed,  2 Dec 2015 21:19:05 +0800
Message-Id: <1449062345-31502-4-git-send-email-cwhuang@linux.org.tw>
In-Reply-To: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
References: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change libhal to match the new HAL headers.

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 android/client/if-gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c  |  4 ++++
 android/hal-gatt.c       | 34 +++++++++++++++++++++++++++++++++-
 android/hal-utils.c      |  4 ++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 3526783..626811c 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -783,6 +783,18 @@ static void gattc_batchscan_threshold_cb(int client_if)
 }
 
 /* Track ADV VSE callback invoked when tracked device is found or lost */
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+static void gattc_track_adv_event_cb(btgatt_track_adv_info_t *p_track_adv_info)
+{
+	char buf[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s, client_if=%d, filt_index=%d, addr_type=%d, bda=%s"
+			", adv_state=%d", __func__, p_track_adv_info->client_if,
+			p_track_adv_info->filt_index, p_track_adv_info->addr_type,
+			bt_bdaddr_t2str(&p_track_adv_info->bd_addr, buf),
+			p_track_adv_info->advertiser_state);
+}
+#else
 static void gattc_track_adv_event_cb(int client_if, int filt_index,
 						int addr_type, bt_bdaddr_t* bda,
 						int adv_state)
@@ -794,6 +806,7 @@ static void gattc_track_adv_event_cb(int client_if, int filt_index,
 			addr_type, bt_bdaddr_t2str(bda, buf), adv_state);
 }
 #endif
+#endif
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
@@ -1677,6 +1690,25 @@ static void scan_filter_param_setup_c(int argc, const char **argv,
 
 static void scan_filter_param_setup_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+	btgatt_filt_param_setup_t filt_param;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, filt_param.client_if);
+	VERIFY_ACTION(3, filt_param.action);
+	VERIFY_FILT_INDEX(4, filt_param.filt_index);
+	VERIFY_FEAT_SELN(5, filt_param.feat_seln);
+	VERIFY_LIST_LOGIC_TYPE(6, filt_param.list_logic_type);
+	VERIFY_FILT_LOGIC_TYPE(7, filt_param.filt_logic_type);
+	VERIFY_RSSI_HI_THR(8, filt_param.rssi_high_thres);
+	VERIFY_RSSI_LOW_THR(9, filt_param.rssi_low_thres);
+	VERIFY_DELY_MODE(10, filt_param.dely_mode);
+	VERIFY_FND_TIME(11, filt_param.found_timeout);
+	VERIFY_LOST_TIME(12, filt_param.lost_timeout);
+	VERIFY_FND_TIME_CNT(13, filt_param.found_timeout_cnt);
+
+	EXEC(if_gatt->client->scan_filter_param_setup, filt_param);
+#else
 	int client_if;
 	int action;
 	int filt_index;
@@ -1704,6 +1736,7 @@ static void scan_filter_param_setup_p(int argc, const char **argv)
 		filt_index, feat_seln, list_logic_type, filt_logic_type,
 		rssi_high_thres, rssi_low_thres, dely_mode, found_timeout,
 		lost_timeout, found_timeout_cnt);
+#endif
 }
 
 /* scan filter add remove */
@@ -1916,6 +1949,18 @@ static void conn_parameter_update_p(int argc, const char **argv)
 /* set scan parameters */
 static void set_scan_parameters_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+	int client_if;
+	int scan_interval;
+	int scan_window;
+
+	RETURN_IF_NULL(if_gatt);
+	VERIFY_CLIENT_IF(2, client_if);
+	VERIFY_SCAN_INTERVAL(3, scan_interval);
+	VERIFY_SCAN_WINDOW(4, scan_window);
+
+	EXEC(if_gatt->client->set_scan_parameters, client_if, scan_interval, scan_window);
+#else
 	int scan_interval;
 	int scan_window;
 
@@ -1924,6 +1969,7 @@ static void set_scan_parameters_p(int argc, const char **argv)
 	VERIFY_SCAN_WINDOW(3, scan_window);
 
 	EXEC(if_gatt->client->set_scan_parameters, scan_interval, scan_window);
+#endif
 }
 
 /* enable multi advertising */
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 66f4a37..c39e632 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -249,7 +249,11 @@ static void handle_pin_request(void *buf, uint16_t len, int fd)
 	DBG("");
 
 	if (bt_hal_cbacks->pin_request_cb)
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev, false);
+#else
 		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
+#endif
 }
 
 static void handle_ssp_request(void *buf, uint16_t len, int fd)
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index f7217c7..37c30c4 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -610,9 +610,21 @@ static void handle_batchscan_threshold(void *buf, uint16_t len, int fd)
 
 static void handle_track_adv(void *buf, uint16_t len, int fd)
 {
-#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	struct hal_ev_gatt_client_track_adv *ev = buf;
 
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+	if (cbs->client->track_adv_event_cb) {
+		btgatt_track_adv_info_t info_t = {
+			.client_if = ev->client_if,
+			.filt_index = ev->filetr_index,
+			.advertiser_state = ev->state,
+			.addr_type = ev->address_type,
+			.bd_addr = *(bt_bdaddr_t *) ev->address,
+		};
+
+		cbs->client->track_adv_event_cb(&info_t);
+	}
+#elif ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	if (cbs->client->track_adv_event_cb)
 		cbs->client->track_adv_event_cb(ev->client_if, ev->filetr_index,
 						ev->address_type,
@@ -1341,6 +1353,20 @@ static bt_status_t test_command(int command, btgatt_test_params_t *params)
 }
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+static bt_status_t scan_filter_param_setup(btgatt_filt_param_setup_t filt_param)
+{
+	struct hal_cmd_gatt_client_scan_filter_setup *cmd;
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd = (struct hal_cmd_gatt_client_scan_filter_setup *)&filt_param;
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP,
+					sizeof(*cmd), cmd, NULL, NULL, NULL);
+}
+#else
 static bt_status_t scan_filter_param_setup(int client_if, int action,
 						int filt_index, int feat_seln,
 						int list_logic_type,
@@ -1374,6 +1400,7 @@ static bt_status_t scan_filter_param_setup(int client_if, int action,
 					HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
+#endif
 
 static bt_status_t scan_filter_add_remove(int client_if, int action,
 						int filt_type, int filt_index,
@@ -1491,7 +1518,12 @@ static bt_status_t conn_parameter_update(const bt_bdaddr_t *bd_addr,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+static bt_status_t set_scan_parameters(int client_if, int scan_interval,
+					int scan_window)
+#else
 static bt_status_t set_scan_parameters(int scan_interval, int scan_window)
+#endif
 {
 	struct hal_cmd_gatt_client_set_scan_param cmd;
 
diff --git a/android/hal-utils.c b/android/hal-utils.c
index e45f6e4..5579f63 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -314,8 +314,12 @@ static void local_le_feat2string(char *str, const bt_local_le_features_t *f)
 	str += sprintf(str, "Num of offloaded scan filters: %u,\n",
 						f->max_adv_filter_supported);
 
+#if ANDROID_VERSION >= PLATFORM_VER(6, 0, 0)
+	scan_num = f->scan_result_storage_size;
+#else
 	scan_num = (f->scan_result_storage_size_hibyte << 8) +
 					f->scan_result_storage_size_lobyte;
+#endif
 
 	str += sprintf(str, "Num of offloaded scan results: %u,\n", scan_num);
 
-- 
1.9.1

