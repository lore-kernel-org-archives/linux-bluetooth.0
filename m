Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android: Refactor IPC init
Date: Fri, 28 Feb 2014 14:09:24 +0100
Message-Id: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to pass socket path and max service ID while initializaing
IPC. This is first step to allow use it both for BT and Audio HALs.
---
 android/a2dp.c      |  27 +++++++----
 android/a2dp.h      |   2 +-
 android/avrcp.c     |  52 +++++++++++----------
 android/avrcp.h     |   2 +-
 android/bluetooth.c | 113 +++++++++++++++++++++++++-------------------
 android/bluetooth.h |   2 +-
 android/handsfree.c |  65 ++++++++++++++------------
 android/handsfree.h |   2 +-
 android/hidhost.c   |  61 +++++++++++++-----------
 android/hidhost.h   |   2 +-
 android/ipc.c       | 132 +++++++++++++++++++++++++++++++++-------------------
 android/ipc.h       |  24 ++++++----
 android/main.c      |  41 +++++++++-------
 android/pan.c       |  32 +++++++------
 android/pan.h       |   2 +-
 android/socket.c    |  26 +++++++----
 android/socket.h    |   2 +-
 android/test-ipc.c  |  44 ++++++++++++------
 18 files changed, 374 insertions(+), 257 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 5d7dc78..b05d4bd 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -39,9 +39,9 @@
 #include "lib/sdp_lib.h"
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/log.h"
-#include "a2dp.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "a2dp.h"
 #include "utils.h"
 #include "bluetooth.h"
 #include "avdtp.h"
@@ -63,6 +63,8 @@ static uint32_t record_id = 0;
 static guint audio_retry_id = 0;
 static bool audio_retrying = false;
 
+static struct ipc *hal_ipc = NULL;
+
 struct a2dp_preset {
 	void *data;
 	int8_t len;
@@ -226,8 +228,8 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send_notif(HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_CONN_STATE, sizeof(ev),
-									&ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_CONN_STATE,
+							sizeof(ev), &ev);
 
 	if (state != HAL_A2DP_STATE_DISCONNECTED)
 		return;
@@ -253,8 +255,8 @@ static void bt_audio_notify_state(struct a2dp_setup *setup, uint8_t state)
 	bdaddr2android(&setup->dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send_notif(HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_AUDIO_STATE, sizeof(ev),
-									&ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_AUDIO_STATE,
+							sizeof(ev), &ev);
 }
 
 static void disconnect_cb(void *user_data)
@@ -597,7 +599,7 @@ static void bt_a2dp_connect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT, status);
 }
 
 static void bt_a2dp_disconnect(const void *buf, uint16_t len)
@@ -631,7 +633,8 @@ static void bt_a2dp_disconnect(const void *buf, uint16_t len)
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTING);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT,
+									status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
@@ -1540,7 +1543,7 @@ retry:
 						audio_disconnected);
 }
 
-bool bt_a2dp_register(const bdaddr_t *addr)
+bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
@@ -1573,7 +1576,9 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
-	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_A2DP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	bt_audio_register(audio_disconnected);
@@ -1600,7 +1605,9 @@ void bt_a2dp_unregister(void)
 	g_slist_free_full(devices, a2dp_device_free);
 	devices = NULL;
 
-	ipc_unregister(HAL_SERVICE_ID_A2DP);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_A2DP);
+	hal_ipc = NULL;
+
 	audio_ipc_unregister();
 
 	bt_adapter_remove_record(record_id);
diff --git a/android/a2dp.h b/android/a2dp.h
index e626e41..b41a178 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_a2dp_register(const bdaddr_t *addr);
+bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
diff --git a/android/avrcp.c b/android/avrcp.c
index 8ff70b4..678c321 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -33,12 +33,12 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/log.h"
-#include "bluetooth.h"
 #include "avctp.h"
-#include "avrcp.h"
 #include "avrcp-lib.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "bluetooth.h"
+#include "avrcp.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
@@ -51,6 +51,7 @@ static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
 static GSList *devices = NULL;
 static GIOChannel *server = NULL;
+static struct ipc *hal_ipc = NULL;
 
 struct avrcp_device {
 	bdaddr_t	dst;
@@ -62,79 +63,79 @@ static void handle_get_play_status(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAY_STATUS,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_GET_PLAY_STATUS, HAL_STATUS_FAILED);
 }
 
 static void handle_list_player_attrs(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_LIST_PLAYER_ATTRS,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_LIST_PLAYER_ATTRS, HAL_STATUS_FAILED);
 }
 
 static void handle_list_player_values(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_LIST_PLAYER_VALUES,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_LIST_PLAYER_VALUES, HAL_STATUS_FAILED);
 }
 
 static void handle_get_player_attrs(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_ATTRS,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_GET_PLAYER_ATTRS, HAL_STATUS_FAILED);
 }
 
 static void handle_get_player_attrs_text(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT, HAL_STATUS_FAILED);
 }
 
 static void handle_get_player_values_text(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT, HAL_STATUS_FAILED);
 }
 
 static void handle_get_element_attrs_text(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT, HAL_STATUS_FAILED);
 }
 
 static void handle_set_player_attrs_value(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE, HAL_STATUS_FAILED);
 }
 
 static void handle_register_notification(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_OP_AVRCP_REGISTER_NOTIFICATION, HAL_STATUS_FAILED);
 }
 
 static void handle_set_volume(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
 							HAL_STATUS_FAILED);
 }
 
@@ -363,7 +364,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	DBG("%s connected", address);
 }
 
-bool bt_avrcp_register(const bdaddr_t *addr)
+bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
@@ -396,7 +397,9 @@ bool bt_avrcp_register(const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
-	ipc_register(HAL_SERVICE_ID_AVRCP, cmd_handlers,
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
@@ -415,7 +418,8 @@ void bt_avrcp_unregister(void)
 	g_slist_free_full(devices, avrcp_device_free);
 	devices = NULL;
 
-	ipc_unregister(HAL_SERVICE_ID_AVRCP);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP);
+	hal_ipc = NULL;
 
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
diff --git a/android/avrcp.h b/android/avrcp.h
index 1fcd953..3dcffeb 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -21,7 +21,7 @@
  *
  */
 
-bool bt_avrcp_register(const bdaddr_t *addr);
+bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_avrcp_unregister(void);
 
 void bt_avrcp_connect(const bdaddr_t *dst);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index ac4c213..26493f7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -145,6 +145,8 @@ static GSList *cached_devices = NULL;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
+static struct ipc *hal_ipc = NULL;
+
 static void store_adapter_config(void)
 {
 	GKeyFile *key_file;
@@ -390,8 +392,8 @@ static  void send_adapter_property(uint8_t type, uint16_t len, const void *val)
 	ev->props[0].len = len;
 	memcpy(ev->props[0].val, val, len);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), buf);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf);
 }
 
 static void adapter_name_changed(const uint8_t *name)
@@ -440,8 +442,8 @@ static void powered_changed(void)
 
 	DBG("%u", ev.state);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_STATE_CHANGED,
-							sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev);
 }
 
 static uint8_t settings2scan_mode(void)
@@ -594,8 +596,8 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 	ev.state = state;
 	bdaddr2android(addr, ev.bdaddr);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_BOND_STATE_CHANGED,
-							sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev);
 }
 
 static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
@@ -647,8 +649,8 @@ static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
 	ev->props[0].len = len;
 	memcpy(ev->props[0].val, val, len);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
-							sizeof(buf), buf);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_REMOTE_DEVICE_PROPS, sizeof(buf), buf);
 }
 
 static void send_device_uuids_notif(struct device *dev)
@@ -883,7 +885,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 	hal_ev.class_of_dev = dev->class;
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
 						sizeof(hal_ev), &hal_ev);
 }
 
@@ -901,7 +903,7 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
 	ev.pairing_variant = variant;
 	ev.passkey = passkey;
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
 							sizeof(ev), &ev);
 }
 
@@ -1010,7 +1012,7 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
@@ -1106,8 +1108,8 @@ static void update_new_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND, size,
-									buf);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND,
+								size, buf);
 }
 
 static void update_device(struct device *dev, int8_t rssi,
@@ -1147,7 +1149,7 @@ static void update_device(struct device *dev, int8_t rssi,
 	}
 
 	if (ev->num_props)
-		ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
 }
 
@@ -1259,8 +1261,8 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ACL_STATE_CHANGED,
-						sizeof(hal_ev), &hal_ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
 }
 
 static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
@@ -1279,8 +1281,8 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ACL_STATE_CHANGED,
-						sizeof(hal_ev), &hal_ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
 }
 
 static uint8_t status_mgmt2hal(uint8_t mgmt)
@@ -1502,8 +1504,8 @@ static uint8_t get_adapter_uuids(void)
 		p += sizeof(uint128_t);
 	}
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -2387,7 +2389,8 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 		error("Failed to get adapter property (type %u status %u)",
 							cmd->type, status);
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP,
+									status);
 }
 
 static void get_adapter_properties(void)
@@ -2538,7 +2541,8 @@ static void handle_set_adapter_prop_cmd(const void *buf, uint16_t len)
 		error("Failed to set adapter property (type %u status %u)",
 							cmd->type, status);
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
+									status);
 }
 
 static void pair_device_complete(uint8_t status, uint16_t length,
@@ -2579,7 +2583,8 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 						HAL_BOND_STATE_BONDING);
 
 fail:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
+									status);
 }
 
 static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
@@ -2597,7 +2602,8 @@ static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 	else
 		status = HAL_STATUS_FAILED;
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND,
+									status);
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
@@ -2631,7 +2637,8 @@ static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 	else
 		status = HAL_STATUS_FAILED;
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND,
+									status);
 }
 
 static void handle_pin_reply_cmd(const void *buf, uint16_t len)
@@ -2682,7 +2689,8 @@ static void handle_pin_reply_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_PIN_REPLY, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_PIN_REPLY,
+									status);
 }
 
 static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
@@ -2770,7 +2778,8 @@ static void handle_ssp_reply_cmd(const void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SSP_REPLY, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SSP_REPLY,
+									status);
 }
 
 static void handle_get_remote_services_cmd(const void *buf, uint16_t len)
@@ -2783,8 +2792,8 @@ static void handle_get_remote_services_cmd(const void *buf, uint16_t len)
 
 	status = browse_remote_sdp(&addr);
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICES,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_SERVICES, status);
 }
 
 static uint8_t get_device_uuids(struct device *dev)
@@ -2907,7 +2916,7 @@ static void handle_enable_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 reply:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, status);
 }
 
 static void handle_disable_cmd(const void *buf, uint16_t len)
@@ -2929,15 +2938,15 @@ static void handle_disable_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 reply:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, status);
 }
 
 static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
 {
 	get_adapter_properties();
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
-							HAL_STATUS_SUCCESS);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_OP_GET_ADAPTER_PROPS, HAL_STATUS_SUCCESS);
 }
 
 static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
@@ -2960,8 +2969,8 @@ static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROPS,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_DEVICE_PROPS, status);
 }
 
 static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
@@ -3017,8 +3026,8 @@ static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
 							cmd->type, status);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROP,
-								status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_GET_REMOTE_DEVICE_PROP, status);
 }
 
 static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
@@ -3088,8 +3097,8 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 							cmd->type, status);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_REMOTE_DEVICE_PROP,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_OP_SET_REMOTE_DEVICE_PROP, status);
 }
 
 static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
@@ -3098,8 +3107,8 @@ static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
 
 	error("get_remote_service_record not supported");
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICE_REC,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_OP_GET_REMOTE_SERVICE_REC, HAL_STATUS_FAILED);
 }
 
 static void handle_start_discovery_cmd(const void *buf, uint16_t len)
@@ -3123,7 +3132,8 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 reply:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY,
+									status);
 }
 
 static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
@@ -3148,7 +3158,8 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 reply:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY,
+									status);
 }
 
 static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
@@ -3181,7 +3192,8 @@ static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
 	close(fd);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
+									status);
 }
 
 static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
@@ -3198,7 +3210,7 @@ static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
 
 	/* TODO */
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
 							HAL_STATUS_FAILED);
 }
 
@@ -3216,7 +3228,7 @@ static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
 
 	/* TODO */
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
 							HAL_STATUS_FAILED);
 }
 
@@ -3272,11 +3284,13 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_le_test_mode_cmd, true, sizeof(struct hal_cmd_le_test_mode) },
 };
 
-void bt_bluetooth_register(void)
+void bt_bluetooth_register(struct ipc *ipc)
 {
 	DBG("");
 
-	ipc_register(HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 }
 
@@ -3290,5 +3304,6 @@ void bt_bluetooth_unregister(void)
 	g_slist_free_full(cached_devices, (GDestroyNotify) free_device);
 	cached_devices = NULL;
 
-	ipc_unregister(HAL_SERVICE_ID_CORE);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
+	hal_ipc = NULL;
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8ab34f6..fbc850d 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -31,7 +31,7 @@ void bt_bluetooth_cleanup(void);
 
 void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-void bt_bluetooth_register(void);
+void bt_bluetooth_register(struct ipc *ipc);
 void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
diff --git a/android/handsfree.c b/android/handsfree.c
index 60bff91..ef8c776 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -38,11 +38,11 @@
 #include "src/uuid-helper.h"
 #include "src/shared/hfp.h"
 #include "btio/btio.h"
+#include "hal-msg.h"
+#include "ipc.h"
 #include "handsfree.h"
 #include "bluetooth.h"
 #include "src/log.h"
-#include "hal-msg.h"
-#include "ipc.h"
 #include "utils.h"
 
 #define HFP_AG_CHANNEL 13
@@ -56,6 +56,7 @@ static struct {
 
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
+static struct ipc *hal_ipc = NULL;
 
 static GIOChannel *server = NULL;
 
@@ -75,8 +76,8 @@ static void device_set_state(uint8_t state)
 	bdaddr2android(&device.bdaddr, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send_notif(HAL_SERVICE_ID_HANDSFREE, HAL_EV_HANDSFREE_CONN_STATE,
-							sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+				HAL_EV_HANDSFREE_CONN_STATE, sizeof(ev), &ev);
 }
 
 static void device_init(const bdaddr_t *bdaddr)
@@ -281,8 +282,8 @@ static void handle_connect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_CONNECT, status);
 }
 
 static void handle_disconnect(const void *buf, uint16_t len)
@@ -317,23 +318,23 @@ static void handle_disconnect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_DISCONNECT,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_DISCONNECT, status);
 }
 
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT_AUDIO,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_CONNECT_AUDIO, HAL_STATUS_FAILED);
 }
 
 static void handle_disconnect_audio(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 			HAL_OP_HANDSFREE_DISCONNECT_AUDIO, HAL_STATUS_FAILED);
 }
 
@@ -341,31 +342,31 @@ static void handle_start_vr(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_START_VR,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_START_VR, HAL_STATUS_FAILED);
 }
 
 static void handle_stop_vr(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_STOP_VR, HAL_STATUS_FAILED);
 }
 
 static void handle_volume_control(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_VOLUME_CONTROL,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_VOLUME_CONTROL, HAL_STATUS_FAILED);
 }
 
 static void handle_device_status_notif(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
 					HAL_STATUS_FAILED);
 }
@@ -374,23 +375,23 @@ static void handle_cops(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_COPS_RESPONSE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_COPS_RESPONSE, HAL_STATUS_FAILED);
 }
 
 static void handle_cind(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CIND_RESPONSE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_CIND_RESPONSE, HAL_STATUS_FAILED);
 }
 
 static void handle_formatted_at_resp(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
 					HAL_STATUS_FAILED);
 }
@@ -399,23 +400,23 @@ static void handle_at_resp(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_AT_RESPONSE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_AT_RESPONSE, HAL_STATUS_FAILED);
 }
 
 static void handle_clcc_resp(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CLCC_RESPONSE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_CLCC_RESPONSE, HAL_STATUS_FAILED);
 }
 
 static void handle_phone_state_change(const void *buf, uint16_t len)
 {
 	DBG("");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
 					HAL_STATUS_FAILED);
 }
@@ -530,7 +531,7 @@ static sdp_record_t *handsfree_ag_record(void)
 	return record;
 }
 
-bool bt_handsfree_register(const bdaddr_t *addr)
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	sdp_record_t *rec;
 	GError *err = NULL;
@@ -563,7 +564,8 @@ bool bt_handsfree_register(const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
-	ipc_register(HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
@@ -580,7 +582,8 @@ void bt_handsfree_unregister(void)
 {
 	DBG("");
 
-	ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
+	hal_ipc = NULL;
 
 	if (server) {
 		g_io_channel_shutdown(server, TRUE, NULL);
diff --git a/android/handsfree.h b/android/handsfree.h
index e3fdd70..3ede819 100644
--- a/android/handsfree.h
+++ b/android/handsfree.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_handsfree_register(const bdaddr_t *addr);
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_handsfree_unregister(void);
diff --git a/android/hidhost.c b/android/hidhost.c
index fd5ea4d..0c6eb7d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -81,6 +81,8 @@ static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
 
+static struct ipc *hal_ipc = NULL;
+
 struct hid_device {
 	bdaddr_t	dst;
 	uint8_t		state;
@@ -303,8 +305,8 @@ static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_CONN_STATE,
-							sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HIDHOST_CONN_STATE, sizeof(ev), &ev);
 }
 
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
@@ -362,8 +364,8 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 		ev.mode = HAL_HIDHOST_UNSUPPORTED_PROTOCOL;
 	}
 
-	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_PROTO_MODE,
-							sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HIDHOST_PROTO_MODE, sizeof(ev), &ev);
 }
 
 static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
@@ -405,8 +407,8 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 send:
-	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_GET_REPORT,
-								ev_len, ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HIDHOST_GET_REPORT, ev_len, ev);
 	g_free(ev);
 }
 
@@ -430,9 +432,8 @@ static void bt_hid_notify_virtual_unplug(struct hid_device *dev,
 		ev.status = HAL_HIDHOST_STATUS_OK;
 	}
 
-	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_VIRTUAL_UNPLUG,
-							sizeof(ev), &ev);
-
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HIDHOST_VIRTUAL_UNPLUG, sizeof(ev), &ev);
 }
 
 static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
@@ -515,8 +516,8 @@ static void bt_hid_set_info(struct hid_device *dev)
 	memset(ev.descr, 0, sizeof(ev.descr));
 	memcpy(ev.descr, dev->rd_data, ev.descr_len);
 
-	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_INFO, sizeof(ev),
-									&ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_INFO,
+							sizeof(ev), &ev);
 }
 
 static int uhid_create(struct hid_device *dev)
@@ -806,7 +807,8 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_CONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_CONNECT,
+									status);
 }
 
 static void bt_hid_disconnect(const void *buf, uint16_t len)
@@ -841,7 +843,8 @@ static void bt_hid_disconnect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_DISCONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_DISCONNECT,
+									status);
 }
 
 static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
@@ -894,8 +897,8 @@ static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_VIRTUAL_UNPLUG, status);
 }
 
 static void bt_hid_info(const void *buf, uint16_t len)
@@ -914,7 +917,7 @@ static void bt_hid_info(const void *buf, uint16_t len)
 	 * once device is created with HID internals. */
 	DBG("Not supported");
 
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_INFO,
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_INFO,
 							HAL_STATUS_UNSUPPORTED);
 }
 
@@ -964,8 +967,8 @@ static void bt_hid_get_protocol(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_PROTOCOL,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_GET_PROTOCOL, status);
 }
 
 static void bt_hid_set_protocol(const void *buf, uint16_t len)
@@ -1014,8 +1017,8 @@ static void bt_hid_set_protocol(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_PROTOCOL,
-									status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_SET_PROTOCOL, status);
 }
 
 static void bt_hid_get_report(const void *buf, uint16_t len)
@@ -1081,7 +1084,8 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT,
+									status);
 }
 
 static void bt_hid_set_report(const void *buf, uint16_t len)
@@ -1158,7 +1162,8 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
+									status);
 }
 
 static void bt_hid_send_data(const void *buf, uint16_t len)
@@ -1224,7 +1229,8 @@ static void bt_hid_send_data(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
+									status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
@@ -1323,7 +1329,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-bool bt_hid_register(const bdaddr_t *addr)
+bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 
@@ -1358,7 +1364,9 @@ bool bt_hid_register(const bdaddr_t *addr)
 		return false;
 	}
 
-	ipc_register(HAL_SERVICE_ID_HIDHOST, cmd_handlers,
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_HIDHOST, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
@@ -1383,5 +1391,6 @@ void bt_hid_unregister(void)
 		intr_io = NULL;
 	}
 
-	ipc_unregister(HAL_SERVICE_ID_HIDHOST);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HIDHOST);
+	hal_ipc = NULL;
 }
diff --git a/android/hidhost.h b/android/hidhost.h
index 5c3c801..1017195 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_hid_register(const bdaddr_t *addr);
+bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_hid_unregister(void);
diff --git a/android/ipc.c b/android/ipc.c
index 4a3a60d..3d6e2a3 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -40,13 +40,19 @@
 #include "ipc.h"
 #include "src/log.h"
 
-static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+struct ipc {
+	struct service_handler *services;
+	int service_max;
 
-static GIOChannel *cmd_io = NULL;
-static GIOChannel *notif_io = NULL;
+	const char *path;
+	size_t size;
 
-static guint cmd_watch = 0;
-static guint notif_watch = 0;
+	GIOChannel *cmd_io;
+	guint cmd_watch;
+
+	GIOChannel *notif_io;
+	guint notif_watch;
+};
 
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
@@ -103,6 +109,8 @@ int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct ipc *ipc = user_data;
+
 	char buf[BLUEZ_HAL_MTU];
 	ssize_t ret;
 	int fd, err;
@@ -121,7 +129,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	err = ipc_handle_msg(services, HAL_SERVICE_ID_MAX, buf, ret);
+	err = ipc_handle_msg(ipc->services, ipc->service_max, buf, ret);
 	if (err < 0) {
 		error("IPC: failed to handle message, terminating (%s)",
 							strerror(-err));
@@ -181,6 +189,8 @@ GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
 static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct ipc *ipc = user_data;
+
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -191,11 +201,11 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	notif_watch = g_io_add_watch(io, cond, notif_watch_cb, NULL);
+	ipc->notif_watch = g_io_add_watch(io, cond, notif_watch_cb, ipc);
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	cmd_watch = g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
+	ipc->cmd_watch = g_io_add_watch(ipc->cmd_io, cond, cmd_watch_cb, ipc);
 
 	info("IPC: successfully connected");
 
@@ -205,6 +215,8 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct ipc *ipc = user_data;
+
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -213,45 +225,62 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	notif_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-						notif_connect_cb, NULL);
-	if (!notif_io)
+	ipc->notif_io = ipc_connect(ipc->path, ipc->size, notif_connect_cb,
+									ipc);
+	if (!ipc->notif_io)
 		raise(SIGTERM);
 
 	return FALSE;
 }
 
-void ipc_init(void)
+struct ipc *ipc_init(const char *path, size_t size, int max_service_id)
 {
-	cmd_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-						cmd_connect_cb, NULL);
-	if (!cmd_io)
-		raise(SIGTERM);
+	struct ipc *ipc;
+
+	ipc = g_new0(struct ipc, 1);
+
+	ipc->services = g_new0(struct service_handler, max_service_id + 1);
+	ipc->service_max = max_service_id;
+
+	ipc->path = path;
+	ipc->size = size;
+
+	ipc->cmd_io = ipc_connect(path, size, cmd_connect_cb, ipc);
+	if (!ipc->cmd_io) {
+		g_free(ipc->services);
+		g_free(ipc);
+		return NULL;
+	}
+
+	return ipc;
 }
 
-void ipc_cleanup(void)
+void ipc_cleanup(struct ipc *ipc)
 {
-	if (cmd_watch) {
-		g_source_remove(cmd_watch);
-		cmd_watch = 0;
+	if (ipc->cmd_watch) {
+		g_source_remove(ipc->cmd_watch);
+		ipc->cmd_watch = 0;
 	}
 
-	if (cmd_io) {
-		g_io_channel_shutdown(cmd_io, TRUE, NULL);
-		g_io_channel_unref(cmd_io);
-		cmd_io = NULL;
+	if (ipc->cmd_io) {
+		g_io_channel_shutdown(ipc->cmd_io, TRUE, NULL);
+		g_io_channel_unref(ipc->cmd_io);
+		ipc->cmd_io = NULL;
 	}
 
-	if (notif_watch) {
-		g_source_remove(notif_watch);
-		notif_watch = 0;
+	if (ipc->notif_watch) {
+		g_source_remove(ipc->notif_watch);
+		ipc->notif_watch = 0;
 	}
 
-	if (notif_io) {
-		g_io_channel_shutdown(notif_io, TRUE, NULL);
-		g_io_channel_unref(notif_io);
-		notif_io = NULL;
+	if (ipc->notif_io) {
+		g_io_channel_shutdown(ipc->notif_io, TRUE, NULL);
+		g_io_channel_unref(ipc->notif_io);
+		ipc->notif_io = NULL;
 	}
+
+	g_free(ipc->services);
+	g_free(ipc);
 }
 
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
@@ -299,12 +328,13 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 }
 
-void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
+void ipc_send_rsp(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+								uint8_t status)
 {
 	struct hal_status s;
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(cmd_io);
+	sk = g_io_channel_unix_get_fd(ipc->cmd_io);
 
 	if (status == HAL_STATUS_SUCCESS) {
 		ipc_send(sk, service_id, opcode, 0, NULL, -1);
@@ -316,32 +346,38 @@ void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
 
-void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
-							void *param, int fd)
+void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+					uint16_t len, void *param, int fd)
 {
-	ipc_send(g_io_channel_unix_get_fd(cmd_io), service_id, opcode, len,
+	ipc_send(g_io_channel_unix_get_fd(ipc->cmd_io), service_id, opcode, len,
 								param, fd);
 }
 
-void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
-								void *param)
+void ipc_send_notif(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+						uint16_t len, void *param)
 {
-	if (!notif_io)
+	if (!ipc || !ipc->notif_io)
 		return;
 
-	ipc_send(g_io_channel_unix_get_fd(notif_io), service_id, opcode, len,
-								param, -1);
+	ipc_send(g_io_channel_unix_get_fd(ipc->notif_io), service_id, opcode,
+								len, param, -1);
 }
 
-void ipc_register(uint8_t service, const struct ipc_handler *handlers,
-								uint8_t size)
+void ipc_register(struct ipc *ipc, uint8_t service,
+			const struct ipc_handler *handlers, uint8_t size)
 {
-	services[service].handler = handlers;
-	services[service].size = size;
+	if (service > ipc->service_max)
+		return;
+
+	ipc->services[service].handler = handlers;
+	ipc->services[service].size = size;
 }
 
-void ipc_unregister(uint8_t service)
+void ipc_unregister(struct ipc *ipc, uint8_t service)
 {
-	services[service].handler = NULL;
-	services[service].size = 0;
+	if (service > ipc->service_max)
+		return;
+
+	ipc->services[service].handler = NULL;
+	ipc->services[service].size = 0;
 }
diff --git a/android/ipc.h b/android/ipc.h
index cfa4018..601301c 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -32,20 +32,24 @@ struct service_handler {
 	uint8_t size;
 };
 
-void ipc_init(void);
-void ipc_cleanup(void);
+struct ipc;
+
+struct ipc *ipc_init(const char *path, size_t size, int max_service_id);
+void ipc_cleanup(struct ipc *ipc);
+
 GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
 							void *user_data);
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len);
 
-void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
-void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
-							void *param, int fd);
-void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
-								void *param);
+void ipc_send_rsp(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+								uint8_t status);
+void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+					uint16_t len, void *param, int fd);
+void ipc_send_notif(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+						uint16_t len, void *param);
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
-void ipc_register(uint8_t service, const struct ipc_handler *handlers,
-								uint8_t size);
-void ipc_unregister(uint8_t service);
+void ipc_register(struct ipc *ipc, uint8_t service,
+			const struct ipc_handler *handlers, uint8_t size);
+void ipc_unregister(struct ipc *ipc, uint8_t service);
diff --git a/android/main.c b/android/main.c
index aca6351..9f22486 100644
--- a/android/main.c
+++ b/android/main.c
@@ -48,11 +48,11 @@
 
 #include "lib/bluetooth.h"
 
+#include "ipc.h"
 #include "bluetooth.h"
 #include "socket.h"
 #include "hidhost.h"
 #include "hal-msg.h"
-#include "ipc.h"
 #include "a2dp.h"
 #include "pan.h"
 #include "avrcp.h"
@@ -67,6 +67,8 @@ static bdaddr_t adapter_bdaddr;
 
 static GMainLoop *event_loop;
 
+static struct ipc *hal_ipc = NULL;
+
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
 static void service_register(const void *buf, uint16_t len)
@@ -81,43 +83,43 @@ static void service_register(const void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_bluetooth_register();
+		bt_bluetooth_register(hal_ipc);
 
 		break;
 	case HAL_SERVICE_ID_SOCKET:
-		bt_socket_register(&adapter_bdaddr);
+		bt_socket_register(hal_ipc, &adapter_bdaddr);
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(&adapter_bdaddr)) {
+		if (!bt_hid_register(hal_ipc, &adapter_bdaddr)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(&adapter_bdaddr)) {
+		if (!bt_a2dp_register(hal_ipc, &adapter_bdaddr)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_pan_register(&adapter_bdaddr)) {
+		if (!bt_pan_register(hal_ipc, &adapter_bdaddr)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_AVRCP:
-		if (!bt_avrcp_register(&adapter_bdaddr)) {
+		if (!bt_avrcp_register(hal_ipc, &adapter_bdaddr)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_HANDSFREE:
-		if (!bt_handsfree_register(&adapter_bdaddr)) {
+		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
@@ -136,7 +138,8 @@ static void service_register(const void *buf, uint16_t len)
 	info("Service ID=%u registered", m->service_id);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+								status);
 }
 
 static void service_unregister(const void *buf, uint16_t len)
@@ -186,7 +189,8 @@ static void service_unregister(const void *buf, uint16_t len)
 	info("Service ID=%u unregistered", m->service_id);
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+								status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
@@ -240,7 +244,15 @@ static void adapter_ready(int err, const bdaddr_t *addr)
 
 	info("Adapter initialized");
 
-	ipc_init();
+	hal_ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							HAL_SERVICE_ID_MAX);
+	if (!hal_ipc) {
+		error("Failed to initialize IPC");
+		exit(EXIT_FAILURE);
+	}
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_CORE, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
@@ -464,9 +476,6 @@ int main(int argc, char *argv[])
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
 
-	ipc_register(HAL_SERVICE_ID_CORE, cmd_handlers,
-						G_N_ELEMENTS(cmd_handlers));
-
 	DBG("Entering main loop");
 
 	event_loop = g_main_loop_new(NULL, FALSE);
@@ -480,12 +489,12 @@ int main(int argc, char *argv[])
 
 	cleanup_services();
 
-	ipc_cleanup();
 	stop_sdp_server();
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
 
-	ipc_unregister(HAL_SERVICE_ID_CORE);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
+	ipc_cleanup(hal_ipc);
 
 	info("Exit");
 
diff --git a/android/pan.c b/android/pan.c
index cfc03bc..b4a3494 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -49,11 +49,11 @@
 #include "profiles/network/bnep.h"
 #include "src/log.h"
 
-#include "pan.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
+#include "pan.h"
 
 #define SVC_HINT_NETWORKING 0x02
 
@@ -64,6 +64,7 @@
 static bdaddr_t adapter_addr;
 GSList *devices = NULL;
 uint8_t local_role = HAL_PAN_ROLE_NONE;
+static struct ipc *hal_ipc = NULL;
 
 struct pan_device {
 	char		iface[16];
@@ -247,8 +248,8 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 	ev.remote_role = dev->role;
 	ev.status = HAL_STATUS_SUCCESS;
 
-	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE, sizeof(ev),
-									&ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE,
+							sizeof(ev), &ev);
 	if (dev->conn_state == HAL_PAN_STATE_DISCONNECTED)
 		pan_device_remove(dev);
 }
@@ -270,8 +271,8 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 	else
 		memcpy(ev.name, dev->iface, sizeof(dev->iface));
 
-	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE, sizeof(ev),
-									&ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE,
+							sizeof(ev), &ev);
 }
 
 static void bnep_disconn_cb(void *data)
@@ -414,7 +415,7 @@ static void bt_pan_connect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT, status);
 }
 
 static void bt_pan_disconnect(const void *buf, uint16_t len)
@@ -444,7 +445,8 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT,
+									status);
 }
 
 static gboolean nap_watchdog_cb(GIOChannel *chan, GIOCondition cond,
@@ -676,7 +678,7 @@ static void bt_pan_enable(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 reply:
-	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
 }
 
 static void bt_pan_get_role(const void *buf, uint16_t len)
@@ -686,8 +688,8 @@ static void bt_pan_get_role(const void *buf, uint16_t len)
 	DBG("");
 
 	rsp.local_role = local_role;
-	ipc_send_rsp_full(HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE, sizeof(rsp),
-								&rsp, -1);
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_PAN, HAL_OP_PAN_GET_ROLE,
+							sizeof(rsp), &rsp, -1);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
@@ -776,7 +778,7 @@ static sdp_record_t *pan_record(void)
 	return record;
 }
 
-bool bt_pan_register(const bdaddr_t *addr)
+bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	sdp_record_t *rec;
 	int err;
@@ -813,7 +815,9 @@ bool bt_pan_register(const bdaddr_t *addr)
 	}
 
 	nap_dev.record_id = rec->handle;
-	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
+
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_PAN, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
@@ -829,7 +833,9 @@ void bt_pan_unregister(void)
 
 	bnep_cleanup();
 
-	ipc_unregister(HAL_SERVICE_ID_PAN);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_PAN);
+	hal_ipc = NULL;
+
 	bt_adapter_remove_record(nap_dev.record_id);
 	nap_dev.record_id = 0;
 	destroy_nap_device();
diff --git a/android/pan.h b/android/pan.h
index 72a7eab..2045ac5 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_pan_register(const bdaddr_t *addr);
+bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_pan_unregister(void);
diff --git a/android/socket.c b/android/socket.c
index 655ee40..d463255 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -38,11 +38,11 @@
 #include "src/sdpd.h"
 #include "src/log.h"
 
-#include "bluetooth.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "ipc.h"
 #include "utils.h"
+#include "bluetooth.h"
 #include "socket.h"
 
 #define RFCOMM_CHANNEL_MAX 30
@@ -60,6 +60,7 @@
 #define MAP_MSG_TYPE_SMS_CDMA	0x04
 #define DEFAULT_MAS_MSG_TYPE	(MAP_MSG_TYPE_SMS_GSM | MAP_MSG_TYPE_SMS_CDMA)
 
+static struct ipc *hal_ipc = NULL;
 struct rfcomm_sock {
 	int channel;	/* RFCOMM channel */
 	BtIOSecLevel sec_level;
@@ -862,13 +863,14 @@ static void handle_listen(const void *buf, uint16_t len)
 	if (status != HAL_STATUS_SUCCESS)
 		goto failed;
 
-	ipc_send_rsp_full(HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_LISTEN, 0, NULL,
-								hal_sock);
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_LISTEN,
+							0, NULL, hal_sock);
 	close(hal_sock);
 	return ;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_LISTEN, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_LISTEN,
+									status);
 }
 
 static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
@@ -1106,13 +1108,14 @@ static void handle_connect(const void *buf, uint16_t len)
 	if (status != HAL_STATUS_SUCCESS)
 		goto failed;
 
-	ipc_send_rsp_full(HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_CONNECT, 0,
-							 NULL, hal_sock);
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_CONNECT,
+							0, NULL, hal_sock);
 	close(hal_sock);
 	return;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_CONNECT, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_SOCKET, HAL_OP_SOCKET_CONNECT,
+									status);
 
 }
 
@@ -1123,7 +1126,7 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_connect, false, sizeof(struct hal_cmd_socket_connect) },
 };
 
-void bt_socket_register(const bdaddr_t *addr)
+void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	size_t i;
 
@@ -1137,7 +1140,9 @@ void bt_socket_register(const bdaddr_t *addr)
 			servers[profiles[i].channel].reserved = true;
 
 	bacpy(&adapter_addr, addr);
-	ipc_register(HAL_SERVICE_ID_SOCKET, cmd_handlers,
+
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_SOCKET, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 }
 
@@ -1155,5 +1160,6 @@ void bt_socket_unregister(void)
 
 	memset(servers, 0, sizeof(servers));
 
-	ipc_unregister(HAL_SERVICE_ID_SOCKET);
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_SOCKET);
+	hal_ipc = NULL;
 }
diff --git a/android/socket.h b/android/socket.h
index d41616f..d3ed9b4 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -30,5 +30,5 @@ struct hal_sock_connect_signal {
 
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-void bt_socket_register(const bdaddr_t *addr);
+void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_socket_unregister(void);
diff --git a/android/test-ipc.c b/android/test-ipc.c
index 8dd53a1..054af84 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -43,6 +43,8 @@
 #include "android/hal-msg.h"
 #include "android/ipc.h"
 
+static struct ipc *ipc = NULL;
+
 struct test_data {
 	uint32_t expected_signal;
 	const void *cmd;
@@ -283,11 +285,15 @@ static void test_init(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc_init();
+	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							HAL_SERVICE_ID_MAX);
+
+	g_assert(ipc);
 
 	execute_context(context);
 
-	ipc_cleanup();
+	ipc_cleanup(ipc);
+	ipc = NULL;
 }
 
 static gboolean send_cmd(gpointer user_data)
@@ -310,7 +316,7 @@ static gboolean register_service(gpointer user_data)
 	struct context *context = user_data;
 	const struct test_data *test_data = context->data;
 
-	ipc_register(test_data->service, test_data->handlers,
+	ipc_register(ipc, test_data->service, test_data->handlers,
 						test_data->handlers_size);
 
 	return FALSE;
@@ -321,7 +327,7 @@ static gboolean unregister_service(gpointer user_data)
 	struct context *context = user_data;
 	const struct test_data *test_data = context->data;
 
-	ipc_unregister(test_data->service);
+	ipc_unregister(ipc, test_data->service);
 
 	return FALSE;
 }
@@ -330,13 +336,17 @@ static void test_cmd(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc_init();
+	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							HAL_SERVICE_ID_MAX);
+
+	g_assert(ipc);
 
 	g_idle_add(send_cmd, context);
 
 	execute_context(context);
 
-	ipc_cleanup();
+	ipc_cleanup(ipc);
+	ipc = NULL;
 }
 
 static void test_cmd_reg(gconstpointer data)
@@ -344,23 +354,30 @@ static void test_cmd_reg(gconstpointer data)
 	struct context *context = create_context(data);
 	const struct test_data *test_data = context->data;
 
-	ipc_init();
+	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							HAL_SERVICE_ID_MAX);
+
+	g_assert(ipc);
 
 	g_idle_add(register_service, context);
 	g_idle_add(send_cmd, context);
 
 	execute_context(context);
 
-	ipc_unregister(test_data->service);
+	ipc_unregister(ipc, test_data->service);
 
-	ipc_cleanup();
+	ipc_cleanup(ipc);
+	ipc = NULL;
 }
 
 static void test_cmd_reg_1(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc_init();
+	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							HAL_SERVICE_ID_MAX);
+
+	g_assert(ipc);
 
 	g_idle_add(register_service, context);
 	g_idle_add(unregister_service, context);
@@ -368,17 +385,18 @@ static void test_cmd_reg_1(gconstpointer data)
 
 	execute_context(context);
 
-	ipc_cleanup();
+	ipc_cleanup(ipc);
+	ipc = NULL;
 }
 
 static void test_cmd_handler_1(const void *buf, uint16_t len)
 {
-	ipc_send_rsp(0, 1, 0);
+	ipc_send_rsp(ipc, 0, 1, 0);
 }
 
 static void test_cmd_handler_2(const void *buf, uint16_t len)
 {
-	ipc_send_rsp(0, 2, 0);
+	ipc_send_rsp(ipc, 0, 2, 0);
 }
 
 static void test_cmd_handler_invalid(const void *buf, uint16_t len)
-- 
1.8.3.2

