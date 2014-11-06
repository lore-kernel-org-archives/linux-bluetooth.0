Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 03/15] android/hardware: Update bluetooth.h header from Android 5.0
Date: Thu,  6 Nov 2014 17:05:48 +0200
Message-Id: <1415286360-26268-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bluetooth.h | 82 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
index b957c6f..74cd1fc 100644
--- a/android/hardware/bluetooth.h
+++ b/android/hardware/bluetooth.h
@@ -17,6 +17,7 @@
 #ifndef ANDROID_INCLUDE_BLUETOOTH_H
 #define ANDROID_INCLUDE_BLUETOOTH_H
 
+#include <stdbool.h>
 #include <stdint.h>
 #include <sys/cdefs.h>
 #include <sys/types.h>
@@ -39,6 +40,7 @@ __BEGIN_DECLS
 #define BT_PROFILE_HANDSFREE_ID "handsfree"
 #define BT_PROFILE_HANDSFREE_CLIENT_ID "handsfree_client"
 #define BT_PROFILE_ADVANCED_AUDIO_ID "a2dp"
+#define BT_PROFILE_ADVANCED_AUDIO_SINK_ID "a2dp_sink"
 #define BT_PROFILE_HEALTH_ID "health"
 #define BT_PROFILE_SOCKETS_ID "socket"
 #define BT_PROFILE_HIDHOST_ID "hidhost"
@@ -47,6 +49,7 @@ __BEGIN_DECLS
 
 #define BT_PROFILE_GATT_ID "gatt"
 #define BT_PROFILE_AV_RC_ID "avrcp"
+#define BT_PROFILE_AV_RC_CTRL_ID "avrcp_ctrl"
 
 /** Bluetooth Address */
 typedef struct {
@@ -85,7 +88,8 @@ typedef enum {
     BT_STATUS_PARM_INVALID,
     BT_STATUS_UNHANDLED,
     BT_STATUS_AUTH_FAILURE,
-    BT_STATUS_RMT_DEV_DOWN
+    BT_STATUS_RMT_DEV_DOWN,
+    BT_STATUS_AUTH_REJECTED
 
 } bt_status_t;
 
@@ -94,6 +98,15 @@ typedef struct {
     uint8_t pin[16];
 } __attribute__((packed))bt_pin_code_t;
 
+typedef struct {
+    uint8_t status;
+    uint8_t ctrl_state;     /* stack reported state */
+    uint64_t tx_time;       /* in ms */
+    uint64_t rx_time;       /* in ms */
+    uint64_t idle_time;     /* in ms */
+    uint64_t energy_used;   /* a product of mA, V and ms */
+} __attribute__((packed))bt_activity_energy_info;
+
 /** Bluetooth Adapter Discovery state */
 typedef enum {
     BT_DISCOVERY_STOPPED,
@@ -128,6 +141,18 @@ typedef struct
    int manufacturer;
 } bt_remote_version_t;
 
+typedef struct
+{
+    uint8_t local_privacy_enabled;
+    uint8_t max_adv_instance;
+    uint8_t rpa_offload_supported;
+    uint8_t max_irk_list_size;
+    uint8_t max_adv_filter_supported;
+    uint8_t scan_result_storage_size_lobyte;
+    uint8_t scan_result_storage_size_hibyte;
+    uint8_t activity_energy_info_supported;
+}bt_local_le_features_t;
+
 /* Bluetooth Adapter and Remote Device property types */
 typedef enum {
     /* Properties common to both adapter and remote device */
@@ -210,6 +235,13 @@ typedef enum {
 
     BT_PROPERTY_REMOTE_VERSION_INFO,
 
+    /**
+     * Description - Local LE features
+     * Access mode - GET.
+     * Data type   - bt_local_le_features_t.
+     */
+    BT_PROPERTY_LOCAL_LE_FEATURES,
+
     BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP = 0xFF,
 } bt_property_type_t;
 
@@ -221,6 +253,7 @@ typedef struct
     void *val;
 } bt_property_t;
 
+
 /** Bluetooth Device Type */
 typedef enum {
     BT_DEVICE_DEVTYPE_BREDR = 0x1,
@@ -323,6 +356,15 @@ typedef void (*dut_mode_recv_callback)(uint16_t opcode, uint8_t *buf, uint8_t le
 * This callback shall be invoked whenever the le_tx_test, le_rx_test or le_test_end is invoked
 * The num_packets is valid only for le_test_end command */
 typedef void (*le_test_mode_callback)(bt_status_t status, uint16_t num_packets);
+
+/** Callback invoked when energy details are obtained */
+/* Ctrl_state-Current controller state-Active-1,scan-2,or idle-3 state as defined by HCI spec.
+ * If the ctrl_state value is 0, it means the API call failed
+ * Time values-In milliseconds as returned by the controller
+ * Energy used-Value as returned by the controller
+ * Status-Provides the status of the read_energy_info API call */
+typedef void (*energy_info_callback)(bt_activity_energy_info *energy_info);
+
 /** TODO: Add callbacks for Link Up/Down and other generic
   *  notifications/callbacks */
 
@@ -342,8 +384,27 @@ typedef struct {
     callback_thread_event thread_evt_cb;
     dut_mode_recv_callback dut_mode_recv_cb;
     le_test_mode_callback le_test_mode_cb;
+    energy_info_callback energy_info_cb;
 } bt_callbacks_t;
 
+typedef void (*alarm_cb)(void *data);
+typedef bool (*set_wake_alarm_callout)(uint64_t delay_millis, bool should_wake, alarm_cb cb, void *data);
+typedef int (*acquire_wake_lock_callout)(const char *lock_name);
+typedef int (*release_wake_lock_callout)(const char *lock_name);
+
+/** The set of functions required by bluedroid to set wake alarms and
+  * grab wake locks. This struct is passed into the stack through the
+  * |set_os_callouts| function on |bt_interface_t|.
+  */
+typedef struct {
+  /* set to sizeof(bt_os_callouts_t) */
+  size_t size;
+
+  set_wake_alarm_callout set_wake_alarm;
+  acquire_wake_lock_callout acquire_wake_lock;
+  release_wake_lock_callout release_wake_lock;
+} bt_os_callouts_t;
+
 /** NOTE: By default, no profiles are initialized at the time of init/enable.
  *  Whenever the application invokes the 'init' API of a profile, then one of
  *  the following shall occur:
@@ -419,7 +480,7 @@ typedef struct {
     int (*cancel_discovery)(void);
 
     /** Create Bluetooth Bonding */
-    int (*create_bond)(const bt_bdaddr_t *bd_addr);
+    int (*create_bond)(const bt_bdaddr_t *bd_addr, int transport);
 
     /** Remove Bond */
     int (*remove_bond)(const bt_bdaddr_t *bd_addr);
@@ -427,6 +488,13 @@ typedef struct {
     /** Cancel Bond */
     int (*cancel_bond)(const bt_bdaddr_t *bd_addr);
 
+    /**
+     * Get the connection status for a given remote device.
+     * return value of 0 means the device is not connected,
+     * non-zero return status indicates an active connection.
+     */
+    int (*get_connection_state)(const bt_bdaddr_t *bd_addr);
+
     /** BT Legacy PinKey Reply */
     /** If accept==FALSE, then pin_len and pin_code shall be 0x0 */
     int (*pin_reply)(const bt_bdaddr_t *bd_addr, uint8_t accept,
@@ -455,6 +523,16 @@ typedef struct {
 
     /* enable or disable bluetooth HCI snoop log */
     int (*config_hci_snoop_log)(uint8_t enable);
+
+    /** Sets the OS call-out functions that bluedroid needs for alarms and wake locks.
+      * This should be called immediately after a successful |init|.
+      */
+    int (*set_os_callouts)(bt_os_callouts_t *callouts);
+
+    /** Read Energy info details - return value indicates BT_STATUS_SUCCESS or BT_STATUS_NOT_READY
+      * Success indicates that the VSC command was sent to controller
+      */
+    int (*read_energy_info)();
 } bt_interface_t;
 
 /** TODO: Need to add APIs for Service Discovery, Service authorization and
-- 
1.9.1

