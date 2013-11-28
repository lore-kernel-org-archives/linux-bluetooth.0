Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] android: Use ipc_send_notif for sending notifications
Date: Thu, 28 Nov 2013 15:15:25 +0100
Message-Id: <1385648130-12808-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c      |  4 ++--
 android/bluetooth.c | 63 ++++++++++++++++++++++++++---------------------------
 android/hidhost.c   | 20 ++++++++---------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 14f34ad..92c359e 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -112,8 +112,8 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_A2DP,
-			HAL_EV_A2DP_CONN_STATE, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_CONN_STATE, sizeof(ev),
+									&ev);
 
 	if (state != HAL_A2DP_STATE_DISCONNECTED)
 		return;
diff --git a/android/bluetooth.c b/android/bluetooth.c
index b5fd644..68e26fa 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -132,8 +132,8 @@ static void adapter_name_changed(const uint8_t *name)
 	ev->props[0].len = len;
 	memcpy(ev->props->val, name, len);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), ev);
 }
 
 static void adapter_set_name(const uint8_t *name)
@@ -173,8 +173,8 @@ static void powered_changed(void)
 
 	DBG("%u", ev.state);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_STATE_CHANGED,
+							sizeof(ev), &ev);
 }
 
 static uint8_t settings2scan_mode(void)
@@ -210,8 +210,8 @@ static void scan_mode_changed(void)
 
 	DBG("mode %u", *mode);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), buf);
 }
 
 static void adapter_class_changed(void)
@@ -226,8 +226,8 @@ static void adapter_class_changed(void)
 	ev->props[0].len = sizeof(uint32_t);
 	memcpy(ev->props->val, &adapter.dev_class, sizeof(uint32_t));
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), buf);
 }
 
 static void settings_changed(uint32_t settings)
@@ -327,8 +327,8 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 	ev.state = state;
 	bdaddr2android(addr, ev.bdaddr);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_BOND_STATE_CHANGED,
+							sizeof(ev), &ev);
 }
 
 static void cache_device_name(const bdaddr_t *addr, const char *name)
@@ -408,8 +408,8 @@ static void remote_uuids_callback(struct browse_req *req)
 	ev->props[0].len = sizeof(uint128_t) * g_slist_length(req->uuids);
 	fill_uuids(req->uuids, ev->props[0].val);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_REMOTE_DEVICE_PROPS, len, ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
+								len, ev);
 
 	g_free(ev);
 }
@@ -605,8 +605,8 @@ static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 	ev->props[0].len = strlen(name);
 	memcpy(&ev->props[0].val, name, strlen(name));
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_REMOTE_DEVICE_PROPS, ev_len, ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
+								ev_len, ev);
 
 	g_free(ev);
 }
@@ -639,8 +639,8 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
-						sizeof(hal_ev), &hal_ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
+						sizeof(hal_ev), &hal_ev);
 }
 
 static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
@@ -657,8 +657,8 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
 	ev.pairing_variant = variant;
 	ev.passkey = passkey;
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
-							sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
+							sizeof(ev), &ev);
 }
 
 static void user_confirm_request_callback(uint16_t index, uint16_t length,
@@ -760,8 +760,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
 static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
@@ -872,8 +872,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf,
-									-1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf);
 
 	if (confirm) {
 		char addr[18];
@@ -943,8 +942,8 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ACL_STATE_CHANGED,
+						sizeof(hal_ev), &hal_ev);
 }
 
 static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
@@ -962,8 +961,8 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ACL_STATE_CHANGED,
+						sizeof(hal_ev), &hal_ev);
 }
 
 static uint8_t status_mgmt2hal(uint8_t mgmt)
@@ -1169,8 +1168,8 @@ static bool get_uuids(void)
 		p += sizeof(uint128_t);
 	}
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), ev);
 
 	return true;
 }
@@ -1701,8 +1700,8 @@ static void get_address(void)
 	ev->props[0].len = sizeof(bdaddr_t);
 	bdaddr2android(&adapter.bdaddr, ev->props[0].val);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), buf);
 }
 
 static bool get_name(void)
@@ -1777,8 +1776,8 @@ static bool get_discoverable_timeout(void)
 	memcpy(&ev->props[0].val, &adapter.discoverable_timeout,
 							sizeof(uint32_t));
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+							sizeof(buf), ev);
 
 	return true;
 }
diff --git a/android/hidhost.c b/android/hidhost.c
index 80957e8..09c71f4 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -297,8 +297,8 @@ static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-			HAL_EV_HIDHOST_CONN_STATE, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_CONN_STATE,
+							sizeof(ev), &ev);
 }
 
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
@@ -356,8 +356,8 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 		ev.mode = HAL_HIDHOST_UNSUPPORTED_PROTOCOL;
 	}
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-			HAL_EV_HIDHOST_PROTO_MODE, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_PROTO_MODE,
+							sizeof(ev), &ev);
 }
 
 static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
@@ -399,8 +399,8 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 send:
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-				HAL_EV_HIDHOST_GET_REPORT, ev_len, ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_GET_REPORT,
+								ev_len, ev);
 	g_free(ev);
 }
 
@@ -424,8 +424,8 @@ static void bt_hid_notify_virtual_unplug(struct hid_device *dev,
 		ev.status = HAL_HIDHOST_STATUS_OK;
 	}
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-			HAL_EV_HIDHOST_VIRTUAL_UNPLUG, sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_VIRTUAL_UNPLUG,
+							sizeof(ev), &ev);
 
 }
 
@@ -509,8 +509,8 @@ static void bt_hid_set_info(struct hid_device *dev)
 	memset(ev.descr, 0, sizeof(ev.descr));
 	memcpy(ev.descr, dev->rd_data, ev.descr_len);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_INFO,
-							sizeof(ev), &ev, -1);
+	ipc_send_notif(HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_INFO, sizeof(ev),
+									&ev);
 }
 
 static int uhid_create(struct hid_device *dev)
-- 
1.8.3.2

