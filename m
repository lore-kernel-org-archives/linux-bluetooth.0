Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 01/15] android/hardware: Update bt_gatt_client.h header
Date: Thu,  6 Nov 2014 17:05:46 +0200
Message-Id: <1415286360-26268-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_gatt_client.h | 134 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 4 deletions(-)

diff --git a/android/hardware/bt_gatt_client.h b/android/hardware/bt_gatt_client.h
index cf4fabe..8073dd1 100644
--- a/android/hardware/bt_gatt_client.h
+++ b/android/hardware/bt_gatt_client.h
@@ -152,10 +152,59 @@ typedef void (*read_remote_rssi_callback)(int client_if, bt_bdaddr_t* bda,
                                           int rssi, int status);
 
 /**
- * Callback indicationg the status of a listen() operation
+ * Callback indicating the status of a listen() operation
  */
 typedef void (*listen_callback)(int status, int server_if);
 
+/** Callback invoked when the MTU for a given connection changes */
+typedef void (*configure_mtu_callback)(int conn_id, int status, int mtu);
+
+/** Callback invoked when a scan filter configuration command has completed */
+typedef void (*scan_filter_cfg_callback)(int action, int client_if, int status, int filt_type,
+                                         int avbl_space);
+
+/** Callback invoked when scan param has been added, cleared, or deleted */
+typedef void (*scan_filter_param_callback)(int action, int client_if, int status,
+                                         int avbl_space);
+
+/** Callback invoked when a scan filter configuration command has completed */
+typedef void (*scan_filter_status_callback)(int enable, int client_if, int status);
+
+/** Callback invoked when multi-adv enable operation has completed */
+typedef void (*multi_adv_enable_callback)(int client_if, int status);
+
+/** Callback invoked when multi-adv param update operation has completed */
+typedef void (*multi_adv_update_callback)(int client_if, int status);
+
+/** Callback invoked when multi-adv instance data set operation has completed */
+typedef void (*multi_adv_data_callback)(int client_if, int status);
+
+/** Callback invoked when multi-adv disable operation has completed */
+typedef void (*multi_adv_disable_callback)(int client_if, int status);
+
+/**
+ * Callback notifying an application that a remote device connection is currently congested
+ * and cannot receive any more data. An application should avoid sending more data until
+ * a further callback is received indicating the congestion status has been cleared.
+ */
+typedef void (*congestion_callback)(int conn_id, bool congested);
+/** Callback invoked when batchscan storage config operation has completed */
+typedef void (*batchscan_cfg_storage_callback)(int client_if, int status);
+
+/** Callback invoked when batchscan enable / disable operation has completed */
+typedef void (*batchscan_enable_disable_callback)(int action, int client_if, int status);
+
+/** Callback invoked when batchscan reports are obtained */
+typedef void (*batchscan_reports_callback)(int client_if, int status, int report_format,
+                                           int num_records, int data_len, uint8_t* rep_data);
+
+/** Callback invoked when batchscan storage threshold limit is crossed */
+typedef void (*batchscan_threshold_callback)(int client_if);
+
+/** Track ADV VSE callback invoked when tracked device is found or lost */
+typedef void (*track_adv_event_callback)(int client_if, int filt_index, int addr_type,
+                                             bt_bdaddr_t* bda, int adv_state);
+
 typedef struct {
     register_client_callback            register_client_cb;
     scan_result_callback                scan_result_cb;
@@ -175,6 +224,20 @@ typedef struct {
     execute_write_callback              execute_write_cb;
     read_remote_rssi_callback           read_remote_rssi_cb;
     listen_callback                     listen_cb;
+    configure_mtu_callback              configure_mtu_cb;
+    scan_filter_cfg_callback            scan_filter_cfg_cb;
+    scan_filter_param_callback          scan_filter_param_cb;
+    scan_filter_status_callback         scan_filter_status_cb;
+    multi_adv_enable_callback           multi_adv_enable_cb;
+    multi_adv_update_callback           multi_adv_update_cb;
+    multi_adv_data_callback             multi_adv_data_cb;
+    multi_adv_disable_callback          multi_adv_disable_cb;
+    congestion_callback                 congestion_cb;
+    batchscan_cfg_storage_callback      batchscan_cfg_storage_cb;
+    batchscan_enable_disable_callback   batchscan_enb_disable_cb;
+    batchscan_reports_callback          batchscan_reports_cb;
+    batchscan_threshold_callback        batchscan_threshold_cb;
+    track_adv_event_callback            track_adv_event_cb;
 } btgatt_client_callbacks_t;
 
 /** Represents the standard BT-GATT client interface. */
@@ -187,11 +250,11 @@ typedef struct {
     bt_status_t (*unregister_client)(int client_if );
 
     /** Start or stop LE device scanning */
-    bt_status_t (*scan)( int client_if, bool start );
+    bt_status_t (*scan)( bool start );
 
     /** Create a connection to a remote LE or dual-mode device */
     bt_status_t (*connect)( int client_if, const bt_bdaddr_t *bd_addr,
-                         bool is_direct );
+                         bool is_direct, int transport );
 
     /** Disconnect a remote device or cancel a pending connection */
     bt_status_t (*disconnect)( int client_if, const bt_bdaddr_t *bd_addr,
@@ -272,18 +335,81 @@ typedef struct {
     /** Request RSSI for a given remote device */
     bt_status_t (*read_remote_rssi)( int client_if, const bt_bdaddr_t *bd_addr);
 
+    /** Setup scan filter params */
+    bt_status_t (*scan_filter_param_setup)(int client_if, int action, int filt_index, int feat_seln,
+                                      int list_logic_type, int filt_logic_type, int rssi_high_thres,
+                                      int rssi_low_thres, int dely_mode, int found_timeout,
+                                      int lost_timeout, int found_timeout_cnt);
+
+
+    /** Configure a scan filter condition  */
+    bt_status_t (*scan_filter_add_remove)(int client_if, int action, int filt_type,
+                                   int filt_index, int company_id,
+                                   int company_id_mask, const bt_uuid_t *p_uuid,
+                                   const bt_uuid_t *p_uuid_mask, const bt_bdaddr_t *bd_addr,
+                                   char addr_type, int data_len, char* p_data, int mask_len,
+                                   char* p_mask);
+
+    /** Clear all scan filter conditions for specific filter index*/
+    bt_status_t (*scan_filter_clear)(int client_if, int filt_index);
+
+    /** Enable / disable scan filter feature*/
+    bt_status_t (*scan_filter_enable)(int client_if, bool enable);
+
     /** Determine the type of the remote device (LE, BR/EDR, Dual-mode) */
     int (*get_device_type)( const bt_bdaddr_t *bd_addr );
 
     /** Set the advertising data or scan response data */
-    bt_status_t (*set_adv_data)(int server_if, bool set_scan_rsp, bool include_name,
+    bt_status_t (*set_adv_data)(int client_if, bool set_scan_rsp, bool include_name,
                     bool include_txpower, int min_interval, int max_interval, int appearance,
                     uint16_t manufacturer_len, char* manufacturer_data,
                     uint16_t service_data_len, char* service_data,
                     uint16_t service_uuid_len, char* service_uuid);
 
+    /** Configure the MTU for a given connection */
+    bt_status_t (*configure_mtu)(int conn_id, int mtu);
+
+    /** Request a connection parameter update */
+    bt_status_t (*conn_parameter_update)(const bt_bdaddr_t *bd_addr, int min_interval,
+                    int max_interval, int latency, int timeout);
+
+    /** Sets the LE scan interval and window in units of N*0.625 msec */
+    bt_status_t (*set_scan_parameters)(int scan_interval, int scan_window);
+
+    /* Setup the parameters as per spec, user manual specified values and enable multi ADV */
+    bt_status_t (*multi_adv_enable)(int client_if, int min_interval,int max_interval,int adv_type,
+                 int chnl_map, int tx_power, int timeout_s);
+
+    /* Update the parameters as per spec, user manual specified values and restart multi ADV */
+    bt_status_t (*multi_adv_update)(int client_if, int min_interval,int max_interval,int adv_type,
+                 int chnl_map, int tx_power, int timeout_s);
+
+    /* Setup the data for the specified instance */
+    bt_status_t (*multi_adv_set_inst_data)(int client_if, bool set_scan_rsp, bool include_name,
+                    bool incl_txpower, int appearance, int manufacturer_len,
+                    char* manufacturer_data, int service_data_len,
+                    char* service_data, int service_uuid_len, char* service_uuid);
+
+    /* Disable the multi adv instance */
+    bt_status_t (*multi_adv_disable)(int client_if);
+
+    /* Configure the batchscan storage */
+    bt_status_t (*batchscan_cfg_storage)(int client_if, int batch_scan_full_max,
+        int batch_scan_trunc_max, int batch_scan_notify_threshold);
+
+    /* Enable batchscan */
+    bt_status_t (*batchscan_enb_batch_scan)(int client_if, int scan_mode,
+        int scan_interval, int scan_window, int addr_type, int discard_rule);
+
+    /* Disable batchscan */
+    bt_status_t (*batchscan_dis_batch_scan)(int client_if);
+
+    /* Read out batchscan reports */
+    bt_status_t (*batchscan_read_reports)(int client_if, int scan_mode);
+
     /** Test mode interface */
     bt_status_t (*test_command)( int command, btgatt_test_params_t* params);
+
 } btgatt_client_interface_t;
 
 __END_DECLS
-- 
1.9.1

