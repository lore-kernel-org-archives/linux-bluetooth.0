Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 1/8] android: Import Android HAL headers
Date: Thu, 17 Oct 2013 10:47:02 +0200
Message-ID: <1381999629-9589-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This imports BT HAL headers as of tag android-4.3_r3.1 from
https://android.googlesource.com/platform/hardware/libhardware

Only changes made compared to original files are trailing whitespace
cleanup to keep git happy and commenting out includes of
cutils/native_handle.h and system/graphics.h from hardware.h which are
not present on Linux.

Those files are needed for building HAL library and haltester tool on
Linux.
---
 android/hardware/bluetooth.h      | 468 ++++++++++++++++++++++++++++++++++++++
 android/hardware/bt_av.h          |  90 ++++++++
 android/hardware/bt_gatt.h        |  61 +++++
 android/hardware/bt_gatt_client.h | 275 ++++++++++++++++++++++
 android/hardware/bt_gatt_server.h | 175 ++++++++++++++
 android/hardware/bt_gatt_types.h  |  48 ++++
 android/hardware/bt_hf.h          | 284 +++++++++++++++++++++++
 android/hardware/bt_hh.h          | 179 +++++++++++++++
 android/hardware/bt_hl.h          | 123 ++++++++++
 android/hardware/bt_pan.h         |  87 +++++++
 android/hardware/bt_rc.h          | 234 +++++++++++++++++++
 android/hardware/bt_sock.h        |  58 +++++
 android/hardware/hardware.h       | 232 +++++++++++++++++++
 13 files changed, 2314 insertions(+)
 create mode 100644 android/hardware/bluetooth.h
 create mode 100644 android/hardware/bt_av.h
 create mode 100644 android/hardware/bt_gatt.h
 create mode 100644 android/hardware/bt_gatt_client.h
 create mode 100644 android/hardware/bt_gatt_server.h
 create mode 100644 android/hardware/bt_gatt_types.h
 create mode 100644 android/hardware/bt_hf.h
 create mode 100644 android/hardware/bt_hh.h
 create mode 100644 android/hardware/bt_hl.h
 create mode 100644 android/hardware/bt_pan.h
 create mode 100644 android/hardware/bt_rc.h
 create mode 100644 android/hardware/bt_sock.h
 create mode 100644 android/hardware/hardware.h

diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
new file mode 100644
index 0000000..2741332
--- /dev/null
+++ b/android/hardware/bluetooth.h
@@ -0,0 +1,468 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BLUETOOTH_H
+#define ANDROID_INCLUDE_BLUETOOTH_H
+
+#include <stdint.h>
+#include <sys/cdefs.h>
+#include <sys/types.h>
+
+#include <hardware/hardware.h>
+
+__BEGIN_DECLS
+
+/**
+ * The Bluetooth Hardware Module ID
+ */
+
+#define BT_HARDWARE_MODULE_ID "bluetooth"
+#define BT_STACK_MODULE_ID "bluetooth"
+#define BT_STACK_TEST_MODULE_ID "bluetooth_test"
+
+
+/* Bluetooth profile interface IDs */
+
+#define BT_PROFILE_HANDSFREE_ID "handsfree"
+#define BT_PROFILE_ADVANCED_AUDIO_ID "a2dp"
+#define BT_PROFILE_HEALTH_ID "health"
+#define BT_PROFILE_SOCKETS_ID "socket"
+#define BT_PROFILE_HIDHOST_ID "hidhost"
+#define BT_PROFILE_PAN_ID "pan"
+
+#define BT_PROFILE_GATT_ID "gatt"
+#define BT_PROFILE_AV_RC_ID "avrcp"
+
+/** Bluetooth Address */
+typedef struct {
+    uint8_t address[6];
+} __attribute__((packed))bt_bdaddr_t;
+
+/** Bluetooth Device Name */
+typedef struct {
+    uint8_t name[249];
+} __attribute__((packed))bt_bdname_t;
+
+/** Bluetooth Adapter Visibility Modes*/
+typedef enum {
+    BT_SCAN_MODE_NONE,
+    BT_SCAN_MODE_CONNECTABLE,
+    BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
+} bt_scan_mode_t;
+
+/** Bluetooth Adapter State */
+typedef enum {
+    BT_STATE_OFF,
+    BT_STATE_ON
+}   bt_state_t;
+
+/** Bluetooth Error Status */
+/** We need to build on this */
+
+typedef enum {
+    BT_STATUS_SUCCESS,
+    BT_STATUS_FAIL,
+    BT_STATUS_NOT_READY,
+    BT_STATUS_NOMEM,
+    BT_STATUS_BUSY,
+    BT_STATUS_DONE,        /* request already completed */
+    BT_STATUS_UNSUPPORTED,
+    BT_STATUS_PARM_INVALID,
+    BT_STATUS_UNHANDLED,
+    BT_STATUS_AUTH_FAILURE,
+    BT_STATUS_RMT_DEV_DOWN
+
+} bt_status_t;
+
+/** Bluetooth PinKey Code */
+typedef struct {
+    uint8_t pin[16];
+} __attribute__((packed))bt_pin_code_t;
+
+/** Bluetooth Adapter Discovery state */
+typedef enum {
+    BT_DISCOVERY_STOPPED,
+    BT_DISCOVERY_STARTED
+} bt_discovery_state_t;
+
+/** Bluetooth ACL connection state */
+typedef enum {
+    BT_ACL_STATE_CONNECTED,
+    BT_ACL_STATE_DISCONNECTED
+} bt_acl_state_t;
+
+/** Bluetooth 128-bit UUID */
+typedef struct {
+   uint8_t uu[16];
+} bt_uuid_t;
+
+/** Bluetooth SDP service record */
+typedef struct
+{
+   bt_uuid_t uuid;
+   uint16_t channel;
+   char name[256]; // what's the maximum length
+} bt_service_record_t;
+
+
+/** Bluetooth Remote Version info */
+typedef struct
+{
+   int version;
+   int sub_ver;
+   int manufacturer;
+} bt_remote_version_t;
+
+/* Bluetooth Adapter and Remote Device property types */
+typedef enum {
+    /* Properties common to both adapter and remote device */
+    /**
+     * Description - Bluetooth Device Name
+     * Access mode - Adapter name can be GET/SET. Remote device can be GET
+     * Data type   - bt_bdname_t
+     */
+    BT_PROPERTY_BDNAME = 0x1,
+    /**
+     * Description - Bluetooth Device Address
+     * Access mode - Only GET.
+     * Data type   - bt_bdaddr_t
+     */
+    BT_PROPERTY_BDADDR,
+    /**
+     * Description - Bluetooth Service 128-bit UUIDs
+     * Access mode - Only GET.
+     * Data type   - Array of bt_uuid_t (Array size inferred from property length).
+     */
+    BT_PROPERTY_UUIDS,
+    /**
+     * Description - Bluetooth Class of Device as found in Assigned Numbers
+     * Access mode - Only GET.
+     * Data type   - uint32_t.
+     */
+    BT_PROPERTY_CLASS_OF_DEVICE,
+    /**
+     * Description - Device Type - BREDR, BLE or DUAL Mode
+     * Access mode - Only GET.
+     * Data type   - bt_device_type_t
+     */
+    BT_PROPERTY_TYPE_OF_DEVICE,
+    /**
+     * Description - Bluetooth Service Record
+     * Access mode - Only GET.
+     * Data type   - bt_service_record_t
+     */
+    BT_PROPERTY_SERVICE_RECORD,
+
+    /* Properties unique to adapter */
+    /**
+     * Description - Bluetooth Adapter scan mode
+     * Access mode - GET and SET
+     * Data type   - bt_scan_mode_t.
+     */
+    BT_PROPERTY_ADAPTER_SCAN_MODE,
+    /**
+     * Description - List of bonded devices
+     * Access mode - Only GET.
+     * Data type   - Array of bt_bdaddr_t of the bonded remote devices
+     *               (Array size inferred from property length).
+     */
+    BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+    /**
+     * Description - Bluetooth Adapter Discovery timeout (in seconds)
+     * Access mode - GET and SET
+     * Data type   - uint32_t
+     */
+    BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+
+    /* Properties unique to remote device */
+    /**
+     * Description - User defined friendly name of the remote device
+     * Access mode - GET and SET
+     * Data type   - bt_bdname_t.
+     */
+    BT_PROPERTY_REMOTE_FRIENDLY_NAME,
+    /**
+     * Description - RSSI value of the inquired remote device
+     * Access mode - Only GET.
+     * Data type   - int32_t.
+     */
+    BT_PROPERTY_REMOTE_RSSI,
+    /**
+     * Description - Remote version info
+     * Access mode - SET/GET.
+     * Data type   - bt_remote_version_t.
+     */
+
+    BT_PROPERTY_REMOTE_VERSION_INFO,
+
+    BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP = 0xFF,
+} bt_property_type_t;
+
+/** Bluetooth Adapter Property data structure */
+typedef struct
+{
+    bt_property_type_t type;
+    int len;
+    void *val;
+} bt_property_t;
+
+/** Bluetooth Device Type */
+typedef enum {
+    BT_DEVICE_DEVTYPE_BREDR = 0x1,
+    BT_DEVICE_DEVTYPE_BLE,
+    BT_DEVICE_DEVTYPE_DUAL
+} bt_device_type_t;
+/** Bluetooth Bond state */
+typedef enum {
+    BT_BOND_STATE_NONE,
+    BT_BOND_STATE_BONDING,
+    BT_BOND_STATE_BONDED
+} bt_bond_state_t;
+
+/** Bluetooth SSP Bonding Variant */
+typedef enum {
+    BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+    BT_SSP_VARIANT_PASSKEY_ENTRY,
+    BT_SSP_VARIANT_CONSENT,
+    BT_SSP_VARIANT_PASSKEY_NOTIFICATION
+} bt_ssp_variant_t;
+
+#define BT_MAX_NUM_UUIDS 32
+
+/** Bluetooth Interface callbacks */
+
+/** Bluetooth Enable/Disable Callback. */
+typedef void (*adapter_state_changed_callback)(bt_state_t state);
+
+/** GET/SET Adapter Properties callback */
+/* TODO: For the GET/SET property APIs/callbacks, we may need a session
+ * identifier to associate the call with the callback. This would be needed
+ * whenever more than one simultaneous instance of the same adapter_type
+ * is get/set.
+ *
+ * If this is going to be handled in the Java framework, then we do not need
+ * to manage sessions here.
+ */
+typedef void (*adapter_properties_callback)(bt_status_t status,
+                                               int num_properties,
+                                               bt_property_t *properties);
+
+/** GET/SET Remote Device Properties callback */
+/** TODO: For remote device properties, do not see a need to get/set
+ * multiple properties - num_properties shall be 1
+ */
+typedef void (*remote_device_properties_callback)(bt_status_t status,
+                                                       bt_bdaddr_t *bd_addr,
+                                                       int num_properties,
+                                                       bt_property_t *properties);
+
+/** New device discovered callback */
+/** If EIR data is not present, then BD_NAME and RSSI shall be NULL and -1
+ * respectively */
+typedef void (*device_found_callback)(int num_properties,
+                                         bt_property_t *properties);
+
+/** Discovery state changed callback */
+typedef void (*discovery_state_changed_callback)(bt_discovery_state_t state);
+
+/** Bluetooth Legacy PinKey Request callback */
+typedef void (*pin_request_callback)(bt_bdaddr_t *remote_bd_addr,
+                                        bt_bdname_t *bd_name, uint32_t cod);
+
+/** Bluetooth SSP Request callback - Just Works & Numeric Comparison*/
+/** pass_key - Shall be 0 for BT_SSP_PAIRING_VARIANT_CONSENT &
+ *  BT_SSP_PAIRING_PASSKEY_ENTRY */
+/* TODO: Passkey request callback shall not be needed for devices with display
+ * capability. We still need support this in the stack for completeness */
+typedef void (*ssp_request_callback)(bt_bdaddr_t *remote_bd_addr,
+                                        bt_bdname_t *bd_name,
+                                        uint32_t cod,
+                                        bt_ssp_variant_t pairing_variant,
+                                     uint32_t pass_key);
+
+/** Bluetooth Bond state changed callback */
+/* Invoked in response to create_bond, cancel_bond or remove_bond */
+typedef void (*bond_state_changed_callback)(bt_status_t status,
+                                               bt_bdaddr_t *remote_bd_addr,
+                                               bt_bond_state_t state);
+
+/** Bluetooth ACL connection state changed callback */
+typedef void (*acl_state_changed_callback)(bt_status_t status, bt_bdaddr_t *remote_bd_addr,
+                                            bt_acl_state_t state);
+
+typedef enum {
+    ASSOCIATE_JVM,
+    DISASSOCIATE_JVM
+} bt_cb_thread_evt;
+
+/** Thread Associate/Disassociate JVM Callback */
+/* Callback that is invoked by the callback thread to allow upper layer to attach/detach to/from
+ * the JVM */
+typedef void (*callback_thread_event)(bt_cb_thread_evt evt);
+
+/** Bluetooth Test Mode Callback */
+/* Receive any HCI event from controller. Must be in DUT Mode for this callback to be received */
+typedef void (*dut_mode_recv_callback)(uint16_t opcode, uint8_t *buf, uint8_t len);
+
+/* LE Test mode callbacks
+* This callback shall be invoked whenever the le_tx_test, le_rx_test or le_test_end is invoked
+* The num_packets is valid only for le_test_end command */
+typedef void (*le_test_mode_callback)(bt_status_t status, uint16_t num_packets);
+/** TODO: Add callbacks for Link Up/Down and other generic
+  *  notifications/callbacks */
+
+/** Bluetooth DM callback structure. */
+typedef struct {
+    /** set to sizeof(bt_callbacks_t) */
+    size_t size;
+    adapter_state_changed_callback adapter_state_changed_cb;
+    adapter_properties_callback adapter_properties_cb;
+    remote_device_properties_callback remote_device_properties_cb;
+    device_found_callback device_found_cb;
+    discovery_state_changed_callback discovery_state_changed_cb;
+    pin_request_callback pin_request_cb;
+    ssp_request_callback ssp_request_cb;
+    bond_state_changed_callback bond_state_changed_cb;
+    acl_state_changed_callback acl_state_changed_cb;
+    callback_thread_event thread_evt_cb;
+    dut_mode_recv_callback dut_mode_recv_cb;
+    le_test_mode_callback le_test_mode_cb;
+} bt_callbacks_t;
+
+/** NOTE: By default, no profiles are initialized at the time of init/enable.
+ *  Whenever the application invokes the 'init' API of a profile, then one of
+ *  the following shall occur:
+ *
+ *    1.) If Bluetooth is not enabled, then the Bluetooth core shall mark the
+ *        profile as enabled. Subsequently, when the application invokes the
+ *        Bluetooth 'enable', as part of the enable sequence the profile that were
+ *        marked shall be enabled by calling appropriate stack APIs. The
+ *        'adapter_properties_cb' shall return the list of UUIDs of the
+ *        enabled profiles.
+ *
+ *    2.) If Bluetooth is enabled, then the Bluetooth core shall invoke the stack
+ *        profile API to initialize the profile and trigger a
+ *        'adapter_properties_cb' with the current list of UUIDs including the
+ *        newly added profile's UUID.
+ *
+ *   The reverse shall occur whenever the profile 'cleanup' APIs are invoked
+ */
+
+/** Represents the standard Bluetooth DM interface. */
+typedef struct {
+    /** set to sizeof(bt_interface_t) */
+    size_t size;
+    /**
+     * Opens the interface and provides the callback routines
+     * to the implemenation of this interface.
+     */
+    int (*init)(bt_callbacks_t* callbacks );
+
+    /** Enable Bluetooth. */
+    int (*enable)(void);
+
+    /** Disable Bluetooth. */
+    int (*disable)(void);
+
+    /** Closes the interface. */
+    void (*cleanup)(void);
+
+    /** Get all Bluetooth Adapter properties at init */
+    int (*get_adapter_properties)(void);
+
+    /** Get Bluetooth Adapter property of 'type' */
+    int (*get_adapter_property)(bt_property_type_t type);
+
+    /** Set Bluetooth Adapter property of 'type' */
+    /* Based on the type, val shall be one of
+     * bt_bdaddr_t or bt_bdname_t or bt_scanmode_t etc
+     */
+    int (*set_adapter_property)(const bt_property_t *property);
+
+    /** Get all Remote Device properties */
+    int (*get_remote_device_properties)(bt_bdaddr_t *remote_addr);
+
+    /** Get Remote Device property of 'type' */
+    int (*get_remote_device_property)(bt_bdaddr_t *remote_addr,
+                                      bt_property_type_t type);
+
+    /** Set Remote Device property of 'type' */
+    int (*set_remote_device_property)(bt_bdaddr_t *remote_addr,
+                                      const bt_property_t *property);
+
+    /** Get Remote Device's service record  for the given UUID */
+    int (*get_remote_service_record)(bt_bdaddr_t *remote_addr,
+                                     bt_uuid_t *uuid);
+
+    /** Start SDP to get remote services */
+    int (*get_remote_services)(bt_bdaddr_t *remote_addr);
+
+    /** Start Discovery */
+    int (*start_discovery)(void);
+
+    /** Cancel Discovery */
+    int (*cancel_discovery)(void);
+
+    /** Create Bluetooth Bonding */
+    int (*create_bond)(const bt_bdaddr_t *bd_addr);
+
+    /** Remove Bond */
+    int (*remove_bond)(const bt_bdaddr_t *bd_addr);
+
+    /** Cancel Bond */
+    int (*cancel_bond)(const bt_bdaddr_t *bd_addr);
+
+    /** BT Legacy PinKey Reply */
+    /** If accept==FALSE, then pin_len and pin_code shall be 0x0 */
+    int (*pin_reply)(const bt_bdaddr_t *bd_addr, uint8_t accept,
+                     uint8_t pin_len, bt_pin_code_t *pin_code);
+
+    /** BT SSP Reply - Just Works, Numeric Comparison and Passkey
+     * passkey shall be zero for BT_SSP_VARIANT_PASSKEY_COMPARISON &
+     * BT_SSP_VARIANT_CONSENT
+     * For BT_SSP_VARIANT_PASSKEY_ENTRY, if accept==FALSE, then passkey
+     * shall be zero */
+    int (*ssp_reply)(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
+                     uint8_t accept, uint32_t passkey);
+
+    /** Get Bluetooth profile interface */
+    const void* (*get_profile_interface) (const char *profile_id);
+
+    /** Bluetooth Test Mode APIs - Bluetooth must be enabled for these APIs */
+    /* Configure DUT Mode - Use this mode to enter/exit DUT mode */
+    int (*dut_mode_configure)(uint8_t enable);
+
+    /* Send any test HCI (vendor-specific) command to the controller. Must be in DUT Mode */
+    int (*dut_mode_send)(uint16_t opcode, uint8_t *buf, uint8_t len);
+    /** BLE Test Mode APIs */
+    /* opcode MUST be one of: LE_Receiver_Test, LE_Transmitter_Test, LE_Test_End */
+    int (*le_test_mode)(uint16_t opcode, uint8_t *buf, uint8_t len);
+
+} bt_interface_t;
+
+/** TODO: Need to add APIs for Service Discovery, Service authorization and
+  *       connection management. Also need to add APIs for configuring
+  *       properties of remote bonded devices such as name, UUID etc. */
+
+typedef struct {
+    struct hw_device_t common;
+    const bt_interface_t* (*get_bluetooth_interface)();
+} bluetooth_device_t;
+
+typedef bluetooth_device_t bluetooth_module_t;
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BLUETOOTH_H */
diff --git a/android/hardware/bt_av.h b/android/hardware/bt_av.h
new file mode 100644
index 0000000..6e3c52e
--- /dev/null
+++ b/android/hardware/bt_av.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_AV_H
+#define ANDROID_INCLUDE_BT_AV_H
+
+__BEGIN_DECLS
+
+/* Bluetooth AV connection states */
+typedef enum {
+    BTAV_CONNECTION_STATE_DISCONNECTED = 0,
+    BTAV_CONNECTION_STATE_CONNECTING,
+    BTAV_CONNECTION_STATE_CONNECTED,
+    BTAV_CONNECTION_STATE_DISCONNECTING
+} btav_connection_state_t;
+
+/* Bluetooth AV datapath states */
+typedef enum {
+    BTAV_AUDIO_STATE_REMOTE_SUSPEND = 0,
+    BTAV_AUDIO_STATE_STOPPED,
+    BTAV_AUDIO_STATE_STARTED,
+} btav_audio_state_t;
+
+
+/** Callback for connection state change.
+ *  state will have one of the values from btav_connection_state_t
+ */
+typedef void (* btav_connection_state_callback)(btav_connection_state_t state,
+                                                    bt_bdaddr_t *bd_addr);
+
+/** Callback for audiopath state change.
+ *  state will have one of the values from btav_audio_state_t
+ */
+typedef void (* btav_audio_state_callback)(btav_audio_state_t state,
+                                               bt_bdaddr_t *bd_addr);
+
+/** BT-AV callback structure. */
+typedef struct {
+    /** set to sizeof(btav_callbacks_t) */
+    size_t      size;
+    btav_connection_state_callback  connection_state_cb;
+    btav_audio_state_callback audio_state_cb;
+} btav_callbacks_t;
+
+/**
+ * NOTE:
+ *
+ * 1. AVRCP 1.0 shall be supported initially. AVRCP passthrough commands
+ *    shall be handled internally via uinput
+ *
+ * 2. A2DP data path shall be handled via a socket pipe between the AudioFlinger
+ *    android_audio_hw library and the Bluetooth stack.
+ *
+ */
+/** Represents the standard BT-AV interface. */
+typedef struct {
+
+    /** set to sizeof(btav_interface_t) */
+    size_t          size;
+    /**
+     * Register the BtAv callbacks
+     */
+    bt_status_t (*init)( btav_callbacks_t* callbacks );
+
+    /** connect to headset */
+    bt_status_t (*connect)( bt_bdaddr_t *bd_addr );
+
+    /** dis-connect from headset */
+    bt_status_t (*disconnect)( bt_bdaddr_t *bd_addr );
+
+    /** Closes the interface. */
+    void  (*cleanup)( void );
+} btav_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_AV_H */
diff --git a/android/hardware/bt_gatt.h b/android/hardware/bt_gatt.h
new file mode 100644
index 0000000..42e14c2
--- /dev/null
+++ b/android/hardware/bt_gatt.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2013 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+
+#ifndef ANDROID_INCLUDE_BT_GATT_H
+#define ANDROID_INCLUDE_BT_GATT_H
+
+#include <stdint.h>
+#include "bt_gatt_client.h"
+#include "bt_gatt_server.h"
+
+__BEGIN_DECLS
+
+/** BT-GATT callbacks */
+typedef struct {
+    /** Set to sizeof(btgatt_callbacks_t) */
+    size_t size;
+
+    /** GATT Client callbacks */
+    const btgatt_client_callbacks_t* client;
+
+    /** GATT Server callbacks */
+    const btgatt_server_callbacks_t* server;
+} btgatt_callbacks_t;
+
+/** Represents the standard Bluetooth GATT interface. */
+typedef struct {
+    /** Set to sizeof(btgatt_interface_t) */
+    size_t          size;
+
+    /**
+     * Initializes the interface and provides callback routines
+     */
+    bt_status_t (*init)( const btgatt_callbacks_t* callbacks );
+
+    /** Closes the interface */
+    void (*cleanup)( void );
+
+    /** Pointer to the GATT client interface methods.*/
+    const btgatt_client_interface_t* client;
+
+    /** Pointer to the GATT server interface methods.*/
+    const btgatt_server_interface_t* server;
+} btgatt_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_GATT_H */
diff --git a/android/hardware/bt_gatt_client.h b/android/hardware/bt_gatt_client.h
new file mode 100644
index 0000000..8b49f59
--- /dev/null
+++ b/android/hardware/bt_gatt_client.h
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2013 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+
+#ifndef ANDROID_INCLUDE_BT_GATT_CLIENT_H
+#define ANDROID_INCLUDE_BT_GATT_CLIENT_H
+
+#include <stdint.h>
+#include "bt_gatt_types.h"
+
+__BEGIN_DECLS
+
+/**
+ * Buffer sizes for maximum attribute length and maximum read/write
+ * operation buffer size.
+ */
+#define BTGATT_MAX_ATTR_LEN 600
+
+/** Buffer type for unformatted reads/writes */
+typedef struct
+{
+    uint8_t             value[BTGATT_MAX_ATTR_LEN];
+    uint16_t            len;
+} btgatt_unformatted_value_t;
+
+/** Parameters for GATT read operations */
+typedef struct
+{
+    btgatt_srvc_id_t    srvc_id;
+    btgatt_char_id_t    char_id;
+    bt_uuid_t           descr_id;
+    btgatt_unformatted_value_t value;
+    uint16_t            value_type;
+    uint8_t             status;
+} btgatt_read_params_t;
+
+/** Parameters for GATT write operations */
+typedef struct
+{
+    btgatt_srvc_id_t    srvc_id;
+    btgatt_char_id_t    char_id;
+    bt_uuid_t           descr_id;
+    uint8_t             status;
+} btgatt_write_params_t;
+
+/** Attribute change notification parameters */
+typedef struct
+{
+    uint8_t             value[BTGATT_MAX_ATTR_LEN];
+    bt_bdaddr_t         bda;
+    btgatt_srvc_id_t    srvc_id;
+    btgatt_char_id_t    char_id;
+    uint16_t            len;
+    uint8_t             is_notify;
+} btgatt_notify_params_t;
+
+typedef struct
+{
+    bt_bdaddr_t        *bda1;
+    bt_uuid_t          *uuid1;
+    uint16_t            u1;
+    uint16_t            u2;
+    uint16_t            u3;
+    uint16_t            u4;
+    uint16_t            u5;
+} btgatt_test_params_t;
+
+/** BT-GATT Client callback structure. */
+
+/** Callback invoked in response to register_client */
+typedef void (*register_client_callback)(int status, int client_if,
+                bt_uuid_t *app_uuid);
+
+/** Callback for scan results */
+typedef void (*scan_result_callback)(bt_bdaddr_t* bda, int rssi, uint8_t* adv_data);
+
+/** GATT open callback invoked in response to open */
+typedef void (*connect_callback)(int conn_id, int status, int client_if, bt_bdaddr_t* bda);
+
+/** Callback invoked in response to close */
+typedef void (*disconnect_callback)(int conn_id, int status,
+                int client_if, bt_bdaddr_t* bda);
+
+/**
+ * Invoked in response to search_service when the GATT service search
+ * has been completed.
+ */
+typedef void (*search_complete_callback)(int conn_id, int status);
+
+/** Reports GATT services on a remote device */
+typedef void (*search_result_callback)( int conn_id, btgatt_srvc_id_t *srvc_id);
+
+/** GATT characteristic enumeration result callback */
+typedef void (*get_characteristic_callback)(int conn_id, int status,
+                btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                int char_prop);
+
+/** GATT descriptor enumeration result callback */
+typedef void (*get_descriptor_callback)(int conn_id, int status,
+                btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                bt_uuid_t *descr_id);
+
+/** GATT included service enumeration result callback */
+typedef void (*get_included_service_callback)(int conn_id, int status,
+                btgatt_srvc_id_t *srvc_id, btgatt_srvc_id_t *incl_srvc_id);
+
+/** Callback invoked in response to [de]register_for_notification */
+typedef void (*register_for_notification_callback)(int conn_id,
+                int registered, int status, btgatt_srvc_id_t *srvc_id,
+                btgatt_char_id_t *char_id);
+
+/**
+ * Remote device notification callback, invoked when a remote device sends
+ * a notification or indication that a client has registered for.
+ */
+typedef void (*notify_callback)(int conn_id, btgatt_notify_params_t *p_data);
+
+/** Reports result of a GATT read operation */
+typedef void (*read_characteristic_callback)(int conn_id, int status,
+                btgatt_read_params_t *p_data);
+
+/** GATT write characteristic operation callback */
+typedef void (*write_characteristic_callback)(int conn_id, int status,
+                btgatt_write_params_t *p_data);
+
+/** GATT execute prepared write callback */
+typedef void (*execute_write_callback)(int conn_id, int status);
+
+/** Callback invoked in response to read_descriptor */
+typedef void (*read_descriptor_callback)(int conn_id, int status,
+                btgatt_read_params_t *p_data);
+
+/** Callback invoked in response to write_descriptor */
+typedef void (*write_descriptor_callback)(int conn_id, int status,
+                btgatt_write_params_t *p_data);
+
+/** Callback triggered in response to read_remote_rssi */
+typedef void (*read_remote_rssi_callback)(int client_if, bt_bdaddr_t* bda,
+                                          int rssi, int status);
+
+typedef struct {
+    register_client_callback            register_client_cb;
+    scan_result_callback                scan_result_cb;
+    connect_callback                    open_cb;
+    disconnect_callback                 close_cb;
+    search_complete_callback            search_complete_cb;
+    search_result_callback              search_result_cb;
+    get_characteristic_callback         get_characteristic_cb;
+    get_descriptor_callback             get_descriptor_cb;
+    get_included_service_callback       get_included_service_cb;
+    register_for_notification_callback  register_for_notification_cb;
+    notify_callback                     notify_cb;
+    read_characteristic_callback        read_characteristic_cb;
+    write_characteristic_callback       write_characteristic_cb;
+    read_descriptor_callback            read_descriptor_cb;
+    write_descriptor_callback           write_descriptor_cb;
+    execute_write_callback              execute_write_cb;
+    read_remote_rssi_callback           read_remote_rssi_cb;
+} btgatt_client_callbacks_t;
+
+/** Represents the standard BT-GATT client interface. */
+
+typedef struct {
+    /** Registers a GATT client application with the stack */
+    bt_status_t (*register_client)( bt_uuid_t *uuid );
+
+    /** Unregister a client application from the stack */
+    bt_status_t (*unregister_client)(int client_if );
+
+    /** Start or stop LE device scanning */
+    bt_status_t (*scan)( int client_if, bool start );
+
+    /** Create a connection to a remote LE or dual-mode device */
+    bt_status_t (*connect)( int client_if, const bt_bdaddr_t *bd_addr,
+                         bool is_direct );
+
+    /** Disconnect a remote device or cancel a pending connection */
+    bt_status_t (*disconnect)( int client_if, const bt_bdaddr_t *bd_addr,
+                    int conn_id);
+
+    /** Clear the attribute cache for a given device */
+    bt_status_t (*refresh)( int client_if, const bt_bdaddr_t *bd_addr );
+
+    /**
+     * Enumerate all GATT services on a connected device.
+     * Optionally, the results can be filtered for a given UUID.
+     */
+    bt_status_t (*search_service)(int conn_id, bt_uuid_t *filter_uuid );
+
+    /**
+     * Enumerate included services for a given service.
+     * Set start_incl_srvc_id to NULL to get the first included service.
+     */
+    bt_status_t (*get_included_service)( int conn_id, btgatt_srvc_id_t *srvc_id,
+                                         btgatt_srvc_id_t *start_incl_srvc_id);
+
+    /**
+     * Enumerate characteristics for a given service.
+     * Set start_char_id to NULL to get the first characteristic.
+     */
+    bt_status_t (*get_characteristic)( int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *start_char_id);
+
+    /**
+     * Enumerate descriptors for a given characteristic.
+     * Set start_descr_id to NULL to get the first descriptor.
+     */
+    bt_status_t (*get_descriptor)( int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                    bt_uuid_t *start_descr_id);
+
+    /** Read a characteristic on a remote device */
+    bt_status_t (*read_characteristic)( int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                    int auth_req );
+
+    /** Write a remote characteristic */
+    bt_status_t (*write_characteristic)(int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                    int write_type, int len, int auth_req,
+                    char* p_value);
+
+    /** Read the descriptor for a given characteristic */
+    bt_status_t (*read_descriptor)(int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                    bt_uuid_t *descr_id, int auth_req);
+
+    /** Write a remote descriptor for a given characteristic */
+    bt_status_t (*write_descriptor)( int conn_id,
+                    btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+                    bt_uuid_t *descr_id, int write_type, int len,
+                    int auth_req, char* p_value);
+
+    /** Execute a prepared write operation */
+    bt_status_t (*execute_write)(int conn_id, int execute);
+
+    /**
+     * Register to receive notifications or indications for a given
+     * characteristic
+     */
+    bt_status_t (*register_for_notification)( int client_if,
+                    const bt_bdaddr_t *bd_addr, btgatt_srvc_id_t *srvc_id,
+                    btgatt_char_id_t *char_id);
+
+    /** Deregister a previous request for notifications/indications */
+    bt_status_t (*deregister_for_notification)( int client_if,
+                    const bt_bdaddr_t *bd_addr, btgatt_srvc_id_t *srvc_id,
+                    btgatt_char_id_t *char_id);
+
+    /** Request RSSI for a given remote device */
+    bt_status_t (*read_remote_rssi)( int client_if, const bt_bdaddr_t *bd_addr);
+
+    /** Determine the type of the remote device (LE, BR/EDR, Dual-mode) */
+    int (*get_device_type)( const bt_bdaddr_t *bd_addr );
+
+    /** Test mode interface */
+    bt_status_t (*test_command)( int command, btgatt_test_params_t* params);
+} btgatt_client_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_GATT_CLIENT_H */
diff --git a/android/hardware/bt_gatt_server.h b/android/hardware/bt_gatt_server.h
new file mode 100644
index 0000000..1a5a400
--- /dev/null
+++ b/android/hardware/bt_gatt_server.h
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2013 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+
+#ifndef ANDROID_INCLUDE_BT_GATT_SERVER_H
+#define ANDROID_INCLUDE_BT_GATT_SERVER_H
+
+#include <stdint.h>
+
+#include "bt_gatt_types.h"
+
+__BEGIN_DECLS
+
+/** GATT value type used in response to remote read requests */
+typedef struct
+{
+    uint8_t           value[BTGATT_MAX_ATTR_LEN];
+    uint16_t          handle;
+    uint16_t          offset;
+    uint16_t          len;
+    uint8_t           auth_req;
+} btgatt_value_t;
+
+/** GATT remote read request response type */
+typedef union
+{
+    btgatt_value_t attr_value;
+    uint16_t            handle;
+} btgatt_response_t;
+
+/** BT-GATT Server callback structure. */
+
+/** Callback invoked in response to register_server */
+typedef void (*register_server_callback)(int status, int server_if,
+                bt_uuid_t *app_uuid);
+
+/** Callback indicating that a remote device has connected or been disconnected */
+typedef void (*connection_callback)(int conn_id, int server_if, int connected,
+                                    bt_bdaddr_t *bda);
+
+/** Callback invoked in response to create_service */
+typedef void (*service_added_callback)(int status, int server_if,
+                btgatt_srvc_id_t *srvc_id, int srvc_handle);
+
+/** Callback indicating that an included service has been added to a service */
+typedef void (*included_service_added_callback)(int status, int server_if,
+                int srvc_handle, int incl_srvc_handle);
+
+/** Callback invoked when a characteristic has been added to a service */
+typedef void (*characteristic_added_callback)(int status, int server_if,
+                bt_uuid_t *uuid, int srvc_handle, int char_handle);
+
+/** Callback invoked when a descriptor has been added to a characteristic */
+typedef void (*descriptor_added_callback)(int status, int server_if,
+                bt_uuid_t *uuid, int srvc_handle, int descr_handle);
+
+/** Callback invoked in response to start_service */
+typedef void (*service_started_callback)(int status, int server_if,
+                                         int srvc_handle);
+
+/** Callback invoked in response to stop_service */
+typedef void (*service_stopped_callback)(int status, int server_if,
+                                         int srvc_handle);
+
+/** Callback triggered when a service has been deleted */
+typedef void (*service_deleted_callback)(int status, int server_if,
+                                         int srvc_handle);
+
+/**
+ * Callback invoked when a remote device has requested to read a characteristic
+ * or descriptor. The application must respond by calling send_response
+ */
+typedef void (*request_read_callback)(int conn_id, int trans_id, bt_bdaddr_t *bda,
+                                      int attr_handle, int offset, bool is_long);
+
+/**
+ * Callback invoked when a remote device has requested to write to a
+ * characteristic or descriptor.
+ */
+typedef void (*request_write_callback)(int conn_id, int trans_id, bt_bdaddr_t *bda,
+                                       int attr_handle, int offset, int length,
+                                       bool need_rsp, bool is_prep, uint8_t* value);
+
+/** Callback invoked when a previously prepared write is to be executed */
+typedef void (*request_exec_write_callback)(int conn_id, int trans_id,
+                                            bt_bdaddr_t *bda, int exec_write);
+
+/**
+ * Callback triggered in response to send_response if the remote device
+ * sends a confirmation.
+ */
+typedef void (*response_confirmation_callback)(int status, int handle);
+
+typedef struct {
+    register_server_callback        register_server_cb;
+    connection_callback             connection_cb;
+    service_added_callback          service_added_cb;
+    included_service_added_callback included_service_added_cb;
+    characteristic_added_callback   characteristic_added_cb;
+    descriptor_added_callback       descriptor_added_cb;
+    service_started_callback        service_started_cb;
+    service_stopped_callback        service_stopped_cb;
+    service_deleted_callback        service_deleted_cb;
+    request_read_callback           request_read_cb;
+    request_write_callback          request_write_cb;
+    request_exec_write_callback     request_exec_write_cb;
+    response_confirmation_callback  response_confirmation_cb;
+} btgatt_server_callbacks_t;
+
+/** Represents the standard BT-GATT server interface. */
+typedef struct {
+    /** Registers a GATT server application with the stack */
+    bt_status_t (*register_server)( bt_uuid_t *uuid );
+
+    /** Unregister a server application from the stack */
+    bt_status_t (*unregister_server)(int server_if );
+
+    /** Create a connection to a remote peripheral */
+    bt_status_t (*connect)(int server_if, const bt_bdaddr_t *bd_addr, bool is_direct );
+
+    /** Disconnect an established connection or cancel a pending one */
+    bt_status_t (*disconnect)(int server_if, const bt_bdaddr_t *bd_addr,
+                    int conn_id );
+
+    /** Create a new service */
+    bt_status_t (*add_service)( int server_if, btgatt_srvc_id_t *srvc_id, int num_handles);
+
+    /** Assign an included service to it's parent service */
+    bt_status_t (*add_included_service)( int server_if, int service_handle, int included_handle);
+
+    /** Add a characteristic to a service */
+    bt_status_t (*add_characteristic)( int server_if,
+                    int service_handle, bt_uuid_t *uuid,
+                    int properties, int permissions);
+
+    /** Add a descriptor to a given service */
+    bt_status_t (*add_descriptor)(int server_if, int service_handle,
+                                  bt_uuid_t *uuid, int permissions);
+
+    /** Starts a local service */
+    bt_status_t (*start_service)(int server_if, int service_handle,
+                                 int transport);
+
+    /** Stops a local service */
+    bt_status_t (*stop_service)(int server_if, int service_handle);
+
+    /** Delete a local service */
+    bt_status_t (*delete_service)(int server_if, int service_handle);
+
+    /** Send value indication to a remote device */
+    bt_status_t (*send_indication)(int server_if, int attribute_handle,
+                                   int conn_id, int len, int confirm,
+                                   char* p_value);
+
+    /** Send a response to a read/write operation */
+    bt_status_t (*send_response)(int conn_id, int trans_id,
+                                 int status, btgatt_response_t *response);
+} btgatt_server_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_GATT_CLIENT_H */
diff --git a/android/hardware/bt_gatt_types.h b/android/hardware/bt_gatt_types.h
new file mode 100644
index 0000000..fee9bb5
--- /dev/null
+++ b/android/hardware/bt_gatt_types.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2013 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+
+#ifndef ANDROID_INCLUDE_BT_GATT_TYPES_H
+#define ANDROID_INCLUDE_BT_GATT_TYPES_H
+
+#include <stdint.h>
+#include <stdbool.h>
+
+__BEGIN_DECLS
+
+/**
+ * GATT Service types
+ */
+#define BTGATT_SERVICE_TYPE_PRIMARY 0
+#define BTGATT_SERVICE_TYPE_SECONDARY 1
+
+/** GATT Characteristic ID adding instance id tracking to the UUID */
+typedef struct
+{
+    bt_uuid_t           uuid;
+    uint8_t             inst_id;
+} btgatt_char_id_t;
+
+/** GATT Service ID also identifies the service type (primary/secondary) */
+typedef struct
+{
+    btgatt_char_id_t    id;
+    uint8_t             is_primary;
+} btgatt_srvc_id_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_GATT_TYPES_H */
diff --git a/android/hardware/bt_hf.h b/android/hardware/bt_hf.h
new file mode 100644
index 0000000..d31119e
--- /dev/null
+++ b/android/hardware/bt_hf.h
@@ -0,0 +1,284 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_HF_H
+#define ANDROID_INCLUDE_BT_HF_H
+
+__BEGIN_DECLS
+
+/* AT response code - OK/Error */
+typedef enum {
+    BTHF_AT_RESPONSE_ERROR = 0,
+    BTHF_AT_RESPONSE_OK
+} bthf_at_response_t;
+
+typedef enum {
+    BTHF_CONNECTION_STATE_DISCONNECTED = 0,
+    BTHF_CONNECTION_STATE_CONNECTING,
+    BTHF_CONNECTION_STATE_CONNECTED,
+    BTHF_CONNECTION_STATE_SLC_CONNECTED,
+    BTHF_CONNECTION_STATE_DISCONNECTING
+} bthf_connection_state_t;
+
+typedef enum {
+    BTHF_AUDIO_STATE_DISCONNECTED = 0,
+    BTHF_AUDIO_STATE_CONNECTING,
+    BTHF_AUDIO_STATE_CONNECTED,
+    BTHF_AUDIO_STATE_DISCONNECTING
+} bthf_audio_state_t;
+
+typedef enum {
+    BTHF_VR_STATE_STOPPED = 0,
+    BTHF_VR_STATE_STARTED
+} bthf_vr_state_t;
+
+typedef enum {
+    BTHF_VOLUME_TYPE_SPK = 0,
+    BTHF_VOLUME_TYPE_MIC
+} bthf_volume_type_t;
+
+/* Noise Reduction and Echo Cancellation */
+typedef enum
+{
+    BTHF_NREC_STOP,
+    BTHF_NREC_START
+} bthf_nrec_t;
+
+/* CHLD - Call held handling */
+typedef enum
+{
+    BTHF_CHLD_TYPE_RELEASEHELD,              // Terminate all held or set UDUB("busy") to a waiting call
+    BTHF_CHLD_TYPE_RELEASEACTIVE_ACCEPTHELD, // Terminate all active calls and accepts a waiting/held call
+    BTHF_CHLD_TYPE_HOLDACTIVE_ACCEPTHELD,    // Hold all active calls and accepts a waiting/held call
+    BTHF_CHLD_TYPE_ADDHELDTOCONF,            // Add all held calls to a conference
+} bthf_chld_type_t;
+
+/** Callback for connection state change.
+ *  state will have one of the values from BtHfConnectionState
+ */
+typedef void (* bthf_connection_state_callback)(bthf_connection_state_t state, bt_bdaddr_t *bd_addr);
+
+/** Callback for audio connection state change.
+ *  state will have one of the values from BtHfAudioState
+ */
+typedef void (* bthf_audio_state_callback)(bthf_audio_state_t state, bt_bdaddr_t *bd_addr);
+
+/** Callback for VR connection state change.
+ *  state will have one of the values from BtHfVRState
+ */
+typedef void (* bthf_vr_cmd_callback)(bthf_vr_state_t state);
+
+/** Callback for answer incoming call (ATA)
+ */
+typedef void (* bthf_answer_call_cmd_callback)();
+
+/** Callback for disconnect call (AT+CHUP)
+ */
+typedef void (* bthf_hangup_call_cmd_callback)();
+
+/** Callback for disconnect call (AT+CHUP)
+ *  type will denote Speaker/Mic gain (BtHfVolumeControl).
+ */
+typedef void (* bthf_volume_cmd_callback)(bthf_volume_type_t type, int volume);
+
+/** Callback for dialing an outgoing call
+ *  If number is NULL, redial
+ */
+typedef void (* bthf_dial_call_cmd_callback)(char *number);
+
+/** Callback for sending DTMF tones
+ *  tone contains the dtmf character to be sent
+ */
+typedef void (* bthf_dtmf_cmd_callback)(char tone);
+
+/** Callback for enabling/disabling noise reduction/echo cancellation
+ *  value will be 1 to enable, 0 to disable
+ */
+typedef void (* bthf_nrec_cmd_callback)(bthf_nrec_t nrec);
+
+/** Callback for call hold handling (AT+CHLD)
+ *  value will contain the call hold command (0, 1, 2, 3)
+ */
+typedef void (* bthf_chld_cmd_callback)(bthf_chld_type_t chld);
+
+/** Callback for CNUM (subscriber number)
+ */
+typedef void (* bthf_cnum_cmd_callback)();
+
+/** Callback for indicators (CIND)
+ */
+typedef void (* bthf_cind_cmd_callback)();
+
+/** Callback for operator selection (COPS)
+ */
+typedef void (* bthf_cops_cmd_callback)();
+
+/** Callback for call list (AT+CLCC)
+ */
+typedef void (* bthf_clcc_cmd_callback) ();
+
+/** Callback for unknown AT command recd from HF
+ *  at_string will contain the unparsed AT string
+ */
+typedef void (* bthf_unknown_at_cmd_callback)(char *at_string);
+
+/** Callback for keypressed (HSP) event.
+ */
+typedef void (* bthf_key_pressed_cmd_callback)();
+
+/** BT-HF callback structure. */
+typedef struct {
+    /** set to sizeof(BtHfCallbacks) */
+    size_t      size;
+    bthf_connection_state_callback  connection_state_cb;
+    bthf_audio_state_callback       audio_state_cb;
+    bthf_vr_cmd_callback            vr_cmd_cb;
+    bthf_answer_call_cmd_callback   answer_call_cmd_cb;
+    bthf_hangup_call_cmd_callback   hangup_call_cmd_cb;
+    bthf_volume_cmd_callback        volume_cmd_cb;
+    bthf_dial_call_cmd_callback     dial_call_cmd_cb;
+    bthf_dtmf_cmd_callback          dtmf_cmd_cb;
+    bthf_nrec_cmd_callback          nrec_cmd_cb;
+    bthf_chld_cmd_callback          chld_cmd_cb;
+    bthf_cnum_cmd_callback          cnum_cmd_cb;
+    bthf_cind_cmd_callback          cind_cmd_cb;
+    bthf_cops_cmd_callback          cops_cmd_cb;
+    bthf_clcc_cmd_callback          clcc_cmd_cb;
+    bthf_unknown_at_cmd_callback    unknown_at_cmd_cb;
+    bthf_key_pressed_cmd_callback   key_pressed_cmd_cb;
+} bthf_callbacks_t;
+
+/** Network Status */
+typedef enum
+{
+    BTHF_NETWORK_STATE_NOT_AVAILABLE = 0,
+    BTHF_NETWORK_STATE_AVAILABLE
+} bthf_network_state_t;
+
+/** Service type */
+typedef enum
+{
+    BTHF_SERVICE_TYPE_HOME = 0,
+    BTHF_SERVICE_TYPE_ROAMING
+} bthf_service_type_t;
+
+typedef enum {
+    BTHF_CALL_STATE_ACTIVE = 0,
+    BTHF_CALL_STATE_HELD,
+    BTHF_CALL_STATE_DIALING,
+    BTHF_CALL_STATE_ALERTING,
+    BTHF_CALL_STATE_INCOMING,
+    BTHF_CALL_STATE_WAITING,
+    BTHF_CALL_STATE_IDLE
+} bthf_call_state_t;
+
+typedef enum {
+    BTHF_CALL_DIRECTION_OUTGOING = 0,
+    BTHF_CALL_DIRECTION_INCOMING
+} bthf_call_direction_t;
+
+typedef enum {
+    BTHF_CALL_TYPE_VOICE = 0,
+    BTHF_CALL_TYPE_DATA,
+    BTHF_CALL_TYPE_FAX
+} bthf_call_mode_t;
+
+typedef enum {
+    BTHF_CALL_MPTY_TYPE_SINGLE = 0,
+    BTHF_CALL_MPTY_TYPE_MULTI
+} bthf_call_mpty_type_t;
+
+typedef enum {
+    BTHF_CALL_ADDRTYPE_UNKNOWN = 0x81,
+    BTHF_CALL_ADDRTYPE_INTERNATIONAL = 0x91
+} bthf_call_addrtype_t;
+/** Represents the standard BT-HF interface. */
+typedef struct {
+
+    /** set to sizeof(BtHfInterface) */
+    size_t          size;
+    /**
+     * Register the BtHf callbacks
+     */
+    bt_status_t (*init)( bthf_callbacks_t* callbacks );
+
+    /** connect to headset */
+    bt_status_t (*connect)( bt_bdaddr_t *bd_addr );
+
+    /** dis-connect from headset */
+    bt_status_t (*disconnect)( bt_bdaddr_t *bd_addr );
+
+    /** create an audio connection */
+    bt_status_t (*connect_audio)( bt_bdaddr_t *bd_addr );
+
+    /** close the audio connection */
+    bt_status_t (*disconnect_audio)( bt_bdaddr_t *bd_addr );
+
+    /** start voice recognition */
+    bt_status_t (*start_voice_recognition)();
+
+    /** stop voice recognition */
+    bt_status_t (*stop_voice_recognition)();
+
+    /** volume control */
+    bt_status_t (*volume_control) (bthf_volume_type_t type, int volume);
+
+    /** Combined device status change notification */
+    bt_status_t (*device_status_notification)(bthf_network_state_t ntk_state, bthf_service_type_t svc_type, int signal,
+                           int batt_chg);
+
+    /** Response for COPS command */
+    bt_status_t (*cops_response)(const char *cops);
+
+    /** Response for CIND command */
+    bt_status_t (*cind_response)(int svc, int num_active, int num_held, bthf_call_state_t call_setup_state,
+                                 int signal, int roam, int batt_chg);
+
+    /** Pre-formatted AT response, typically in response to unknown AT cmd */
+    bt_status_t (*formatted_at_response)(const char *rsp);
+
+    /** ok/error response
+     *  ERROR (0)
+     *  OK    (1)
+     */
+    bt_status_t (*at_response) (bthf_at_response_t response_code, int error_code);
+
+    /** response for CLCC command
+     *  Can be iteratively called for each call index
+     *  Call index of 0 will be treated as NULL termination (Completes response)
+     */
+    bt_status_t (*clcc_response) (int index, bthf_call_direction_t dir,
+                                bthf_call_state_t state, bthf_call_mode_t mode,
+                                bthf_call_mpty_type_t mpty, const char *number,
+                                bthf_call_addrtype_t type);
+
+    /** notify of a call state change
+     *  Each update notifies
+     *    1. Number of active/held/ringing calls
+     *    2. call_state: This denotes the state change that triggered this msg
+     *                   This will take one of the values from BtHfCallState
+     *    3. number & type: valid only for incoming & waiting call
+    */
+    bt_status_t (*phone_state_change) (int num_active, int num_held, bthf_call_state_t call_setup_state,
+                                       const char *number, bthf_call_addrtype_t type);
+
+    /** Closes the interface. */
+    void  (*cleanup)( void );
+} bthf_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_HF_H */
diff --git a/android/hardware/bt_hh.h b/android/hardware/bt_hh.h
new file mode 100644
index 0000000..09f547b
--- /dev/null
+++ b/android/hardware/bt_hh.h
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_HH_H
+#define ANDROID_INCLUDE_BT_HH_H
+
+#include <stdint.h>
+
+__BEGIN_DECLS
+
+#define BTHH_MAX_DSC_LEN   884
+
+/* HH connection states */
+typedef enum
+{
+    BTHH_CONN_STATE_CONNECTED              = 0,
+    BTHH_CONN_STATE_CONNECTING,
+    BTHH_CONN_STATE_DISCONNECTED,
+    BTHH_CONN_STATE_DISCONNECTING,
+    BTHH_CONN_STATE_FAILED_MOUSE_FROM_HOST,
+    BTHH_CONN_STATE_FAILED_KBD_FROM_HOST,
+    BTHH_CONN_STATE_FAILED_TOO_MANY_DEVICES,
+    BTHH_CONN_STATE_FAILED_NO_BTHID_DRIVER,
+    BTHH_CONN_STATE_FAILED_GENERIC,
+    BTHH_CONN_STATE_UNKNOWN
+} bthh_connection_state_t;
+
+typedef enum
+{
+    BTHH_OK                = 0,
+    BTHH_HS_HID_NOT_READY,        /* handshake error : device not ready */
+    BTHH_HS_INVALID_RPT_ID,       /* handshake error : invalid report ID */
+    BTHH_HS_TRANS_NOT_SPT,        /* handshake error : transaction not spt */
+    BTHH_HS_INVALID_PARAM,        /* handshake error : invalid paremter */
+    BTHH_HS_ERROR,                /* handshake error : unspecified HS error */
+    BTHH_ERR,                     /* general BTA HH error */
+    BTHH_ERR_SDP,                 /* SDP error */
+    BTHH_ERR_PROTO,               /* SET_Protocol error,
+                                                                only used in BTA_HH_OPEN_EVT callback */
+    BTHH_ERR_DB_FULL,             /* device database full error, used  */
+    BTHH_ERR_TOD_UNSPT,           /* type of device not supported */
+    BTHH_ERR_NO_RES,              /* out of system resources */
+    BTHH_ERR_AUTH_FAILED,         /* authentication fail */
+    BTHH_ERR_HDL
+}bthh_status_t;
+
+/* Protocol modes */
+typedef enum {
+    BTHH_REPORT_MODE       = 0x00,
+    BTHH_BOOT_MODE         = 0x01,
+    BTHH_UNSUPPORTED_MODE  = 0xff
+}bthh_protocol_mode_t;
+
+/* Report types */
+typedef enum {
+    BTHH_INPUT_REPORT      = 1,
+    BTHH_OUTPUT_REPORT,
+    BTHH_FEATURE_REPORT
+}bthh_report_type_t;
+
+typedef struct
+{
+    int         attr_mask;
+    uint8_t     sub_class;
+    uint8_t     app_id;
+    int         vendor_id;
+    int         product_id;
+    int         version;
+    uint8_t     ctry_code;
+    int         dl_len;
+    uint8_t     dsc_list[BTHH_MAX_DSC_LEN];
+} bthh_hid_info_t;
+
+/** Callback for connection state change.
+ *  state will have one of the values from bthh_connection_state_t
+ */
+typedef void (* bthh_connection_state_callback)(bt_bdaddr_t *bd_addr, bthh_connection_state_t state);
+
+/** Callback for vitual unplug api.
+ *  the status of the vitual unplug
+ */
+typedef void (* bthh_virtual_unplug_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status);
+
+/** Callback for get hid info
+ *  hid_info will contain attr_mask, sub_class, app_id, vendor_id, product_id, version, ctry_code, len
+ */
+typedef void (* bthh_hid_info_callback)(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info);
+
+/** Callback for get/set protocal api.
+ *  the protocol mode is one of the value from bthh_protocol_mode_t
+ */
+typedef void (* bthh_protocol_mode_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,bthh_protocol_mode_t mode);
+
+/** Callback for get/set_idle_time api.
+ */
+typedef void (* bthh_idle_time_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status, int idle_rate);
+
+
+/** Callback for get report api.
+ *  if staus is ok rpt_data contains the report data
+ */
+typedef void (* bthh_get_report_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status, uint8_t* rpt_data, int rpt_size);
+
+
+/** BT-HH callback structure. */
+typedef struct {
+    /** set to sizeof(BtHfCallbacks) */
+    size_t      size;
+    bthh_connection_state_callback  connection_state_cb;
+    bthh_hid_info_callback          hid_info_cb;
+    bthh_protocol_mode_callback     protocol_mode_cb;
+    bthh_idle_time_callback         idle_time_cb;
+    bthh_get_report_callback        get_report_cb;
+    bthh_virtual_unplug_callback    virtual_unplug_cb;
+
+} bthh_callbacks_t;
+
+
+
+/** Represents the standard BT-HH interface. */
+typedef struct {
+
+    /** set to sizeof(BtHhInterface) */
+    size_t          size;
+
+    /**
+     * Register the BtHh callbacks
+     */
+    bt_status_t (*init)( bthh_callbacks_t* callbacks );
+
+    /** connect to hid device */
+    bt_status_t (*connect)( bt_bdaddr_t *bd_addr);
+
+    /** dis-connect from hid device */
+    bt_status_t (*disconnect)( bt_bdaddr_t *bd_addr );
+
+    /** Virtual UnPlug (VUP) the specified HID device */
+    bt_status_t (*virtual_unplug)(bt_bdaddr_t *bd_addr);
+
+    /** Set the HID device descriptor for the specified HID device. */
+    bt_status_t (*set_info)(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info );
+
+    /** Get the HID proto mode. */
+    bt_status_t (*get_protocol) (bt_bdaddr_t *bd_addr, bthh_protocol_mode_t protocolMode);
+
+    /** Set the HID proto mode. */
+    bt_status_t (*set_protocol)(bt_bdaddr_t *bd_addr, bthh_protocol_mode_t protocolMode);
+
+    /** Send a GET_REPORT to HID device. */
+    bt_status_t (*get_report)(bt_bdaddr_t *bd_addr, bthh_report_type_t reportType, uint8_t reportId, int bufferSize);
+
+    /** Send a SET_REPORT to HID device. */
+    bt_status_t (*set_report)(bt_bdaddr_t *bd_addr, bthh_report_type_t reportType, char* report);
+
+    /** Send data to HID device. */
+    bt_status_t (*send_data)(bt_bdaddr_t *bd_addr, char* data);
+
+	/** Closes the interface. */
+    void  (*cleanup)( void );
+
+} bthh_interface_t;
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_HH_H */
+
+
diff --git a/android/hardware/bt_hl.h b/android/hardware/bt_hl.h
new file mode 100644
index 0000000..bd29e3a
--- /dev/null
+++ b/android/hardware/bt_hl.h
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_HL_H
+#define ANDROID_INCLUDE_BT_HL_H
+
+__BEGIN_DECLS
+
+/* HL connection states */
+
+typedef enum
+{
+    BTHL_MDEP_ROLE_SOURCE,
+    BTHL_MDEP_ROLE_SINK
+} bthl_mdep_role_t;
+
+typedef enum {
+    BTHL_APP_REG_STATE_REG_SUCCESS,
+    BTHL_APP_REG_STATE_REG_FAILED,
+    BTHL_APP_REG_STATE_DEREG_SUCCESS,
+    BTHL_APP_REG_STATE_DEREG_FAILED
+} bthl_app_reg_state_t;
+
+typedef enum
+{
+    BTHL_CHANNEL_TYPE_RELIABLE,
+    BTHL_CHANNEL_TYPE_STREAMING,
+    BTHL_CHANNEL_TYPE_ANY
+} bthl_channel_type_t;
+
+
+/* HL connection states */
+typedef enum {
+    BTHL_CONN_STATE_CONNECTING,
+    BTHL_CONN_STATE_CONNECTED,
+    BTHL_CONN_STATE_DISCONNECTING,
+    BTHL_CONN_STATE_DISCONNECTED,
+    BTHL_CONN_STATE_DESTROYED
+} bthl_channel_state_t;
+
+typedef struct
+{
+    bthl_mdep_role_t        mdep_role;
+    int                     data_type;
+    bthl_channel_type_t     channel_type;
+    const char                   *mdep_description; /* MDEP description to be used in the SDP (optional); null terminated */
+} bthl_mdep_cfg_t;
+
+typedef struct
+{
+    const char      *application_name;
+    const char      *provider_name;   /* provider name to be used in the SDP (optional); null terminated */
+    const char      *srv_name;        /* service name to be used in the SDP (optional); null terminated*/
+    const char      *srv_desp;        /* service description to be used in the SDP (optional); null terminated */
+    int             number_of_mdeps;
+    bthl_mdep_cfg_t *mdep_cfg;  /* Dynamic array */
+} bthl_reg_param_t;
+
+/** Callback for application registration status.
+ *  state will have one of the values from  bthl_app_reg_state_t
+ */
+typedef void (* bthl_app_reg_state_callback)(int app_id, bthl_app_reg_state_t state);
+
+/** Callback for channel connection state change.
+ *  state will have one of the values from
+ *  bthl_connection_state_t and fd (file descriptor)
+ */
+typedef void (* bthl_channel_state_callback)(int app_id, bt_bdaddr_t *bd_addr, int mdep_cfg_index, int channel_id, bthl_channel_state_t state, int fd);
+
+/** BT-HL callback structure. */
+typedef struct {
+    /** set to sizeof(bthl_callbacks_t) */
+    size_t      size;
+    bthl_app_reg_state_callback     app_reg_state_cb;
+    bthl_channel_state_callback     channel_state_cb;
+} bthl_callbacks_t;
+
+
+/** Represents the standard BT-HL interface. */
+typedef struct {
+
+    /** set to sizeof(bthl_interface_t)  */
+    size_t          size;
+
+    /**
+     * Register the Bthl callbacks
+     */
+    bt_status_t (*init)( bthl_callbacks_t* callbacks );
+
+    /** Register HL application */
+    bt_status_t (*register_application) ( bthl_reg_param_t *p_reg_param, int *app_id);
+
+    /** Unregister HL application */
+    bt_status_t (*unregister_application) (int app_id);
+
+    /** connect channel */
+    bt_status_t (*connect_channel)(int app_id, bt_bdaddr_t *bd_addr, int mdep_cfg_index, int *channel_id);
+
+    /** destroy channel */
+    bt_status_t (*destroy_channel)(int channel_id);
+
+    /** Close the  Bthl callback **/
+    void (*cleanup)(void);
+
+} bthl_interface_t;
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_HL_H */
+
+
diff --git a/android/hardware/bt_pan.h b/android/hardware/bt_pan.h
new file mode 100644
index 0000000..c8b36b4
--- /dev/null
+++ b/android/hardware/bt_pan.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_PAN_H
+#define ANDROID_INCLUDE_BT_PAN_H
+
+__BEGIN_DECLS
+
+#define BTPAN_ROLE_NONE      0
+#define BTPAN_ROLE_PANNAP    1
+#define BTPAN_ROLE_PANU      2
+
+typedef enum {
+    BTPAN_STATE_CONNECTED       = 0,
+    BTPAN_STATE_CONNECTING      = 1,
+    BTPAN_STATE_DISCONNECTED    = 2,
+    BTPAN_STATE_DISCONNECTING   = 3
+} btpan_connection_state_t;
+
+typedef enum {
+    BTPAN_STATE_ENABLED = 0,
+    BTPAN_STATE_DISABLED = 1
+} btpan_control_state_t;
+
+/**
+* Callback for pan connection state
+*/
+typedef void (*btpan_connection_state_callback)(btpan_connection_state_t state, bt_status_t error,
+                                                const bt_bdaddr_t *bd_addr, int local_role, int remote_role);
+typedef void (*btpan_control_state_callback)(btpan_control_state_t state, bt_status_t error,
+                                            int local_role, const char* ifname);
+
+typedef struct {
+    size_t size;
+    btpan_control_state_callback control_state_cb;
+    btpan_connection_state_callback connection_state_cb;
+} btpan_callbacks_t;
+typedef struct {
+    /** set to size of this struct*/
+    size_t          size;
+    /**
+     * Initialize the pan interface and register the btpan callbacks
+     */
+    bt_status_t (*init)(const btpan_callbacks_t* callbacks);
+    /*
+     * enable the pan service by specified role. The result state of
+     * enabl will be returned by btpan_control_state_callback. when pan-nap is enabled,
+     * the state of connecting panu device will be notified by btpan_connection_state_callback
+     */
+    bt_status_t (*enable)(int local_role);
+    /*
+     * get current pan local role
+     */
+    int (*get_local_role)(void);
+    /**
+     * start bluetooth pan connection to the remote device by specified pan role. The result state will be
+     * returned by btpan_connection_state_callback
+     */
+    bt_status_t (*connect)(const bt_bdaddr_t *bd_addr, int local_role, int remote_role);
+    /**
+     * stop bluetooth pan connection. The result state will be returned by btpan_connection_state_callback
+     */
+    bt_status_t (*disconnect)(const bt_bdaddr_t *bd_addr);
+
+    /**
+     * Cleanup the pan interface
+     */
+    void (*cleanup)(void);
+
+} btpan_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_PAN_H */
diff --git a/android/hardware/bt_rc.h b/android/hardware/bt_rc.h
new file mode 100644
index 0000000..952652e
--- /dev/null
+++ b/android/hardware/bt_rc.h
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_RC_H
+#define ANDROID_INCLUDE_BT_RC_H
+
+__BEGIN_DECLS
+
+/* Macros */
+#define BTRC_MAX_ATTR_STR_LEN       255
+#define BTRC_UID_SIZE               8
+#define BTRC_MAX_APP_SETTINGS       8
+#define BTRC_MAX_FOLDER_DEPTH       4
+#define BTRC_MAX_APP_ATTR_SIZE      16
+#define BTRC_MAX_ELEM_ATTR_SIZE     7
+
+typedef uint8_t btrc_uid_t[BTRC_UID_SIZE];
+
+typedef enum {
+    BTRC_PLAYSTATE_STOPPED = 0x00,    /* Stopped */
+    BTRC_PLAYSTATE_PLAYING = 0x01,    /* Playing */
+    BTRC_PLAYSTATE_PAUSED = 0x02,    /* Paused  */
+    BTRC_PLAYSTATE_FWD_SEEK = 0x03,    /* Fwd Seek*/
+    BTRC_PLAYSTATE_REV_SEEK = 0x04,    /* Rev Seek*/
+    BTRC_PLAYSTATE_ERROR = 0xFF,    /* Error   */
+} btrc_play_status_t;
+
+typedef enum {
+    BTRC_EVT_PLAY_STATUS_CHANGED = 0x01,
+    BTRC_EVT_TRACK_CHANGE = 0x02,
+    BTRC_EVT_TRACK_REACHED_END = 0x03,
+    BTRC_EVT_TRACK_REACHED_START = 0x04,
+    BTRC_EVT_PLAY_POS_CHANGED = 0x05,
+    BTRC_EVT_APP_SETTINGS_CHANGED = 0x08,
+} btrc_event_id_t;
+
+typedef enum {
+    BTRC_NOTIFICATION_TYPE_INTERIM = 0,
+    BTRC_NOTIFICATION_TYPE_CHANGED = 1,
+} btrc_notification_type_t;
+
+typedef enum {
+    BTRC_PLAYER_ATTR_EQUALIZER = 0x01,
+    BTRC_PLAYER_ATTR_REPEAT = 0x02,
+    BTRC_PLAYER_ATTR_SHUFFLE = 0x03,
+    BTRC_PLAYER_ATTR_SCAN = 0x04,
+} btrc_player_attr_t;
+
+typedef enum {
+    BTRC_MEDIA_ATTR_TITLE = 0x01,
+    BTRC_MEDIA_ATTR_ARTIST = 0x02,
+    BTRC_MEDIA_ATTR_ALBUM = 0x03,
+    BTRC_MEDIA_ATTR_TRACK_NUM = 0x04,
+    BTRC_MEDIA_ATTR_NUM_TRACKS = 0x05,
+    BTRC_MEDIA_ATTR_GENRE = 0x06,
+    BTRC_MEDIA_ATTR_PLAYING_TIME = 0x07,
+} btrc_media_attr_t;
+
+typedef enum {
+    BTRC_PLAYER_VAL_OFF_REPEAT = 0x01,
+    BTRC_PLAYER_VAL_SINGLE_REPEAT = 0x02,
+    BTRC_PLAYER_VAL_ALL_REPEAT = 0x03,
+    BTRC_PLAYER_VAL_GROUP_REPEAT = 0x04
+} btrc_player_repeat_val_t;
+
+typedef enum {
+    BTRC_PLAYER_VAL_OFF_SHUFFLE = 0x01,
+    BTRC_PLAYER_VAL_ALL_SHUFFLE = 0x02,
+    BTRC_PLAYER_VAL_GROUP_SHUFFLE = 0x03
+} btrc_player_shuffle_val_t;
+
+typedef enum {
+    BTRC_STS_BAD_CMD        = 0x00, /* Invalid command */
+    BTRC_STS_BAD_PARAM      = 0x01, /* Invalid parameter */
+    BTRC_STS_NOT_FOUND      = 0x02, /* Specified parameter is wrong or not found */
+    BTRC_STS_INTERNAL_ERR   = 0x03, /* Internal Error */
+    BTRC_STS_NO_ERROR       = 0x04  /* Operation Success */
+} btrc_status_t;
+
+typedef struct {
+    uint8_t num_attr;
+    uint8_t attr_ids[BTRC_MAX_APP_SETTINGS];
+    uint8_t attr_values[BTRC_MAX_APP_SETTINGS];
+} btrc_player_settings_t;
+
+typedef union
+{
+    btrc_play_status_t play_status;
+    btrc_uid_t track; /* queue position in NowPlaying */
+    uint32_t song_pos;
+    btrc_player_settings_t player_setting;
+} btrc_register_notification_t;
+
+typedef struct {
+    uint8_t id; /* can be attr_id or value_id */
+    uint8_t text[BTRC_MAX_ATTR_STR_LEN];
+} btrc_player_setting_text_t;
+
+typedef struct {
+    uint32_t attr_id;
+    uint8_t text[BTRC_MAX_ATTR_STR_LEN];
+} btrc_element_attr_val_t;
+
+/** Callback for play status request */
+typedef void (* btrc_get_play_status_callback)();
+
+/** Callback for list player application attributes (Shuffle, Repeat,...) */
+typedef void (* btrc_list_player_app_attr_callback)();
+
+/** Callback for list player application attributes (Shuffle, Repeat,...) */
+typedef void (* btrc_list_player_app_values_callback)(btrc_player_attr_t attr_id);
+
+/** Callback for getting the current player application settings value
+**  num_attr: specifies the number of attribute ids contained in p_attrs
+*/
+typedef void (* btrc_get_player_app_value_callback) (uint8_t num_attr, btrc_player_attr_t *p_attrs);
+
+/** Callback for getting the player application settings attributes' text
+**  num_attr: specifies the number of attribute ids contained in p_attrs
+*/
+typedef void (* btrc_get_player_app_attrs_text_callback) (uint8_t num_attr, btrc_player_attr_t *p_attrs);
+
+/** Callback for getting the player application settings values' text
+**  num_attr: specifies the number of value ids contained in p_vals
+*/
+typedef void (* btrc_get_player_app_values_text_callback) (uint8_t attr_id, uint8_t num_val, uint8_t *p_vals);
+
+/** Callback for setting the player application settings values */
+typedef void (* btrc_set_player_app_value_callback) (btrc_player_settings_t *p_vals);
+
+/** Callback to fetch the get element attributes of the current song
+**  num_attr: specifies the number of attributes requested in p_attrs
+*/
+typedef void (* btrc_get_element_attr_callback) (uint8_t num_attr, btrc_media_attr_t *p_attrs);
+
+/** Callback for register notification (Play state change/track change/...)
+**  param: Is only valid if event_id is BTRC_EVT_PLAY_POS_CHANGED
+*/
+typedef void (* btrc_register_notification_callback) (btrc_event_id_t event_id, uint32_t param);
+
+/** BT-RC callback structure. */
+typedef struct {
+    /** set to sizeof(BtRcCallbacks) */
+    size_t      size;
+    btrc_get_play_status_callback               get_play_status_cb;
+    btrc_list_player_app_attr_callback          list_player_app_attr_cb;
+    btrc_list_player_app_values_callback        list_player_app_values_cb;
+    btrc_get_player_app_value_callback          get_player_app_value_cb;
+    btrc_get_player_app_attrs_text_callback     get_player_app_attrs_text_cb;
+    btrc_get_player_app_values_text_callback    get_player_app_values_text_cb;
+    btrc_set_player_app_value_callback          set_player_app_value_cb;
+    btrc_get_element_attr_callback              get_element_attr_cb;
+    btrc_register_notification_callback         register_notification_cb;
+} btrc_callbacks_t;
+
+/** Represents the standard BT-RC interface. */
+typedef struct {
+
+    /** set to sizeof(BtRcInterface) */
+    size_t          size;
+    /**
+     * Register the BtRc callbacks
+     */
+    bt_status_t (*init)( btrc_callbacks_t* callbacks );
+
+    /** Respose to GetPlayStatus request. Contains the current
+    **  1. Play status
+    **  2. Song duration/length
+    **  3. Song position
+    */
+    bt_status_t (*get_play_status_rsp)( btrc_play_status_t play_status, uint32_t song_len, uint32_t song_pos);
+
+    /** Lists the support player application attributes (Shuffle/Repeat/...)
+    **  num_attr: Specifies the number of attributes contained in the pointer p_attrs
+    */
+    bt_status_t (*list_player_app_attr_rsp)( int num_attr, btrc_player_attr_t *p_attrs);
+
+    /** Lists the support player application attributes (Shuffle Off/On/Group)
+    **  num_val: Specifies the number of values contained in the pointer p_vals
+    */
+    bt_status_t (*list_player_app_value_rsp)( int num_val, uint8_t *p_vals);
+
+    /** Returns the current application attribute values for each of the specified attr_id */
+    bt_status_t (*get_player_app_value_rsp)( btrc_player_settings_t *p_vals);
+
+    /** Returns the application attributes text ("Shuffle"/"Repeat"/...)
+    **  num_attr: Specifies the number of attributes' text contained in the pointer p_attrs
+    */
+    bt_status_t (*get_player_app_attr_text_rsp)( int num_attr, btrc_player_setting_text_t *p_attrs);
+
+    /** Returns the application attributes text ("Shuffle"/"Repeat"/...)
+    **  num_attr: Specifies the number of attribute values' text contained in the pointer p_vals
+    */
+    bt_status_t (*get_player_app_value_text_rsp)( int num_val, btrc_player_setting_text_t *p_vals);
+
+    /** Returns the current songs' element attributes text ("Title"/"Album"/"Artist")
+    **  num_attr: Specifies the number of attributes' text contained in the pointer p_attrs
+    */
+    bt_status_t (*get_element_attr_rsp)( uint8_t num_attr, btrc_element_attr_val_t *p_attrs);
+
+    /** Response to set player attribute request ("Shuffle"/"Repeat")
+    **  rsp_status: Status of setting the player attributes for the current media player
+    */
+    bt_status_t (*set_player_app_value_rsp)(btrc_status_t rsp_status);
+
+    /* Response to the register notification request (Play state change/track change/...).
+    ** event_id: Refers to the event_id this notification change corresponds too
+    ** type: Response type - interim/changed
+    ** p_params: Based on the event_id, this parameter should be populated
+    */
+    bt_status_t (*register_notification_rsp)(btrc_event_id_t event_id,
+                                             btrc_notification_type_t type,
+                                             btrc_register_notification_t *p_param);
+
+    /** Closes the interface. */
+    void  (*cleanup)( void );
+} btrc_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_RC_H */
diff --git a/android/hardware/bt_sock.h b/android/hardware/bt_sock.h
new file mode 100644
index 0000000..a4aa046
--- /dev/null
+++ b/android/hardware/bt_sock.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_BT_SOCK_H
+#define ANDROID_INCLUDE_BT_SOCK_H
+
+__BEGIN_DECLS
+
+#define BTSOCK_FLAG_ENCRYPT 1
+#define BTSOCK_FLAG_AUTH (1 << 1)
+
+typedef enum {
+    BTSOCK_RFCOMM = 1,
+    BTSOCK_SCO = 2,
+    BTSOCK_L2CAP = 3
+} btsock_type_t;
+
+/** Represents the standard BT SOCKET interface. */
+typedef struct {
+    short size;
+    bt_bdaddr_t bd_addr;
+    int channel;
+    int status;
+} __attribute__((packed)) sock_connect_signal_t;
+
+typedef struct {
+
+    /** set to size of this struct*/
+    size_t          size;
+    /**
+     * listen to a rfcomm uuid or channel. It returns the socket fd from which
+     * btsock_connect_signal can be read out when a remote device connected
+     */
+    bt_status_t (*listen)(btsock_type_t type, const char* service_name, const uint8_t* service_uuid, int channel, int* sock_fd, int flags);
+    /*
+     * connect to a rfcomm uuid channel of remote device, It returns the socket fd from which
+     * the btsock_connect_signal and a new socket fd to be accepted can be read out when connected
+     */
+    bt_status_t (*connect)(const bt_bdaddr_t *bd_addr, btsock_type_t type, const uint8_t* uuid, int channel, int* sock_fd, int flags);
+
+} btsock_interface_t;
+
+__END_DECLS
+
+#endif /* ANDROID_INCLUDE_BT_SOCK_H */
diff --git a/android/hardware/hardware.h b/android/hardware/hardware.h
new file mode 100644
index 0000000..3ac20cd
--- /dev/null
+++ b/android/hardware/hardware.h
@@ -0,0 +1,232 @@
+/*
+ * Copyright (C) 2008 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#ifndef ANDROID_INCLUDE_HARDWARE_HARDWARE_H
+#define ANDROID_INCLUDE_HARDWARE_HARDWARE_H
+
+#include <stdint.h>
+#include <sys/cdefs.h>
+
+/* not present on Linux and not needed for BT HAL
+#include <cutils/native_handle.h>
+#include <system/graphics.h>
+*/
+
+__BEGIN_DECLS
+
+/*
+ * Value for the hw_module_t.tag field
+ */
+
+#define MAKE_TAG_CONSTANT(A,B,C,D) (((A) << 24) | ((B) << 16) | ((C) << 8) | (D))
+
+#define HARDWARE_MODULE_TAG MAKE_TAG_CONSTANT('H', 'W', 'M', 'T')
+#define HARDWARE_DEVICE_TAG MAKE_TAG_CONSTANT('H', 'W', 'D', 'T')
+
+#define HARDWARE_MAKE_API_VERSION(maj,min) \
+            ((((maj) & 0xff) << 8) | ((min) & 0xff))
+
+#define HARDWARE_MAKE_API_VERSION_2(maj,min,hdr) \
+            ((((maj) & 0xff) << 24) | (((min) & 0xff) << 16) | ((hdr) & 0xffff))
+#define HARDWARE_API_VERSION_2_MAJ_MIN_MASK 0xffff0000
+#define HARDWARE_API_VERSION_2_HEADER_MASK  0x0000ffff
+
+
+/*
+ * The current HAL API version.
+ *
+ * All module implementations must set the hw_module_t.hal_api_version field
+ * to this value when declaring the module with HAL_MODULE_INFO_SYM.
+ *
+ * Note that previous implementations have always set this field to 0.
+ * Therefore, libhardware HAL API will always consider versions 0.0 and 1.0
+ * to be 100% binary compatible.
+ *
+ */
+#define HARDWARE_HAL_API_VERSION HARDWARE_MAKE_API_VERSION(1, 0)
+
+/*
+ * Helper macros for module implementors.
+ *
+ * The derived modules should provide convenience macros for supported
+ * versions so that implementations can explicitly specify module/device
+ * versions at definition time.
+ *
+ * Use this macro to set the hw_module_t.module_api_version field.
+ */
+#define HARDWARE_MODULE_API_VERSION(maj,min) HARDWARE_MAKE_API_VERSION(maj,min)
+#define HARDWARE_MODULE_API_VERSION_2(maj,min,hdr) HARDWARE_MAKE_API_VERSION_2(maj,min,hdr)
+
+/*
+ * Use this macro to set the hw_device_t.version field
+ */
+#define HARDWARE_DEVICE_API_VERSION(maj,min) HARDWARE_MAKE_API_VERSION(maj,min)
+#define HARDWARE_DEVICE_API_VERSION_2(maj,min,hdr) HARDWARE_MAKE_API_VERSION_2(maj,min,hdr)
+
+struct hw_module_t;
+struct hw_module_methods_t;
+struct hw_device_t;
+
+/**
+ * Every hardware module must have a data structure named HAL_MODULE_INFO_SYM
+ * and the fields of this data structure must begin with hw_module_t
+ * followed by module specific information.
+ */
+typedef struct hw_module_t {
+    /** tag must be initialized to HARDWARE_MODULE_TAG */
+    uint32_t tag;
+
+    /**
+     * The API version of the implemented module. The module owner is
+     * responsible for updating the version when a module interface has
+     * changed.
+     *
+     * The derived modules such as gralloc and audio own and manage this field.
+     * The module user must interpret the version field to decide whether or
+     * not to inter-operate with the supplied module implementation.
+     * For example, SurfaceFlinger is responsible for making sure that
+     * it knows how to manage different versions of the gralloc-module API,
+     * and AudioFlinger must know how to do the same for audio-module API.
+     *
+     * The module API version should include a major and a minor component.
+     * For example, version 1.0 could be represented as 0x0100. This format
+     * implies that versions 0x0100-0x01ff are all API-compatible.
+     *
+     * In the future, libhardware will expose a hw_get_module_version()
+     * (or equivalent) function that will take minimum/maximum supported
+     * versions as arguments and would be able to reject modules with
+     * versions outside of the supplied range.
+     */
+    uint16_t module_api_version;
+#define version_major module_api_version
+    /**
+     * version_major/version_minor defines are supplied here for temporary
+     * source code compatibility. They will be removed in the next version.
+     * ALL clients must convert to the new version format.
+     */
+
+    /**
+     * The API version of the HAL module interface. This is meant to
+     * version the hw_module_t, hw_module_methods_t, and hw_device_t
+     * structures and definitions.
+     *
+     * The HAL interface owns this field. Module users/implementations
+     * must NOT rely on this value for version information.
+     *
+     * Presently, 0 is the only valid value.
+     */
+    uint16_t hal_api_version;
+#define version_minor hal_api_version
+
+    /** Identifier of module */
+    const char *id;
+
+    /** Name of this module */
+    const char *name;
+
+    /** Author/owner/implementor of the module */
+    const char *author;
+
+    /** Modules methods */
+    struct hw_module_methods_t* methods;
+
+    /** module's dso */
+    void* dso;
+
+    /** padding to 128 bytes, reserved for future use */
+    uint32_t reserved[32-7];
+
+} hw_module_t;
+
+typedef struct hw_module_methods_t {
+    /** Open a specific device */
+    int (*open)(const struct hw_module_t* module, const char* id,
+            struct hw_device_t** device);
+
+} hw_module_methods_t;
+
+/**
+ * Every device data structure must begin with hw_device_t
+ * followed by module specific public methods and attributes.
+ */
+typedef struct hw_device_t {
+    /** tag must be initialized to HARDWARE_DEVICE_TAG */
+    uint32_t tag;
+
+    /**
+     * Version of the module-specific device API. This value is used by
+     * the derived-module user to manage different device implementations.
+     *
+     * The module user is responsible for checking the module_api_version
+     * and device version fields to ensure that the user is capable of
+     * communicating with the specific module implementation.
+     *
+     * One module can support multiple devices with different versions. This
+     * can be useful when a device interface changes in an incompatible way
+     * but it is still necessary to support older implementations at the same
+     * time. One such example is the Camera 2.0 API.
+     *
+     * This field is interpreted by the module user and is ignored by the
+     * HAL interface itself.
+     */
+    uint32_t version;
+
+    /** reference to the module this device belongs to */
+    struct hw_module_t* module;
+
+    /** padding reserved for future use */
+    uint32_t reserved[12];
+
+    /** Close this device */
+    int (*close)(struct hw_device_t* device);
+
+} hw_device_t;
+
+/**
+ * Name of the hal_module_info
+ */
+#define HAL_MODULE_INFO_SYM         HMI
+
+/**
+ * Name of the hal_module_info as a string
+ */
+#define HAL_MODULE_INFO_SYM_AS_STR  "HMI"
+
+/**
+ * Get the module info associated with a module by id.
+ *
+ * @return: 0 == success, <0 == error and *module == NULL
+ */
+int hw_get_module(const char *id, const struct hw_module_t **module);
+
+/**
+ * Get the module info associated with a module instance by class 'class_id'
+ * and instance 'inst'.
+ *
+ * Some modules types necessitate multiple instances. For example audio supports
+ * multiple concurrent interfaces and thus 'audio' is the module class
+ * and 'primary' or 'a2dp' are module interfaces. This implies that the files
+ * providing these modules would be named audio.primary.<variant>.so and
+ * audio.a2dp.<variant>.so
+ *
+ * @return: 0 == success, <0 == error and *module == NULL
+ */
+int hw_get_module_by_class(const char *class_id, const char *inst,
+                           const struct hw_module_t **module);
+
+__END_DECLS
+
+#endif  /* ANDROID_INCLUDE_HARDWARE_HARDWARE_H */
-- 
1.8.4

