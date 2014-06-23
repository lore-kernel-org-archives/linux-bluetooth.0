Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/7] android/bluetooth: Add get_device_android_addr helper
Date: Mon, 23 Jun 2014 16:28:31 +0200
Message-Id: <1403533714-5188-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
References: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to fake address for Android Framework.
---
 android/bluetooth.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index be50a1a..c664461 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -218,6 +218,11 @@ static GSList *browse_reqs;
 
 static struct ipc *hal_ipc = NULL;
 
+static void get_device_android_addr(struct device *dev, uint8_t *addr)
+{
+	bdaddr2android(&dev->bdaddr, addr);
+}
+
 static void mgmt_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -752,7 +757,7 @@ static void send_bond_state_change(struct device *dev, uint8_t status,
 
 	ev.status = status;
 	ev.state = state;
-	bdaddr2android(addr, ev.bdaddr);
+	get_device_android_addr(dev, ev.bdaddr);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 				HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev);
@@ -871,7 +876,7 @@ static void send_device_property(struct device *dev, uint8_t type,
 	struct hal_ev_remote_device_props *ev = (void *) buf;
 
 	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+	get_device_android_addr(dev, ev->bdaddr);
 	ev->num_props = 1;
 	ev->props[0].type = type;
 	ev->props[0].len = len;
@@ -1118,7 +1123,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	/* Name already sent in remote device prop */
 	memset(&hal_ev, 0, sizeof(hal_ev));
-	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+	get_device_android_addr(dev, hal_ev.bdaddr);
 	hal_ev.class_of_dev = dev->class;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
@@ -1132,7 +1137,7 @@ static void send_ssp_request(struct device *dev, uint8_t variant,
 
 	memset(&ev, 0, sizeof(ev));
 
-	bdaddr2android(&dev->bdaddr, ev.bdaddr);
+	get_device_android_addr(dev, ev.bdaddr);
 	memcpy(ev.name, dev->name, strlen(dev->name));
 	ev.class_of_dev = dev->class;
 
@@ -1459,7 +1464,7 @@ static void update_new_device(struct device *dev, int8_t rssi,
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_device_found *ev = (void *) buf;
-	bdaddr_t android_bdaddr;
+	uint8_t android_bdaddr[6];
 	uint8_t android_type;
 	int size;
 
@@ -1470,10 +1475,9 @@ static void update_new_device(struct device *dev, int8_t rssi,
 
 	size = sizeof(*ev);
 
-	bdaddr2android(&dev->bdaddr, &android_bdaddr);
+	get_device_android_addr(dev, android_bdaddr);
 	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
-						sizeof(android_bdaddr),
-						&android_bdaddr);
+				sizeof(android_bdaddr), android_bdaddr);
 	ev->num_props++;
 
 	android_type = get_device_android_type(dev);
@@ -1536,7 +1540,7 @@ static void update_device(struct device *dev, int8_t rssi,
 	size = sizeof(*ev);
 
 	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+	get_device_android_addr(dev, ev->bdaddr);
 
 	old_type = get_device_android_type(dev);
 
@@ -1715,6 +1719,7 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_device_connected *ev = param;
 	struct hal_ev_acl_state_changed hal_ev;
+	struct device *dev;
 
 	if (length < sizeof(*ev)) {
 		error("Too short device connected event (%u bytes)", length);
@@ -1726,7 +1731,12 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 
 	hal_ev.status = HAL_STATUS_SUCCESS;
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
-	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	get_device_android_addr(dev, hal_ev.bdaddr);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
@@ -1738,15 +1748,20 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_device_disconnected *ev = param;
 	struct hal_ev_acl_state_changed hal_ev;
+	struct device *dev;
 
 	if (length < sizeof(*ev)) {
 		error("Too short device disconnected event (%u bytes)", length);
 		return;
 	}
 
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
 	hal_ev.status = HAL_STATUS_SUCCESS;
 	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
-	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+	get_device_android_addr(dev, hal_ev.bdaddr);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
@@ -3345,7 +3360,7 @@ static uint8_t get_adapter_bonded_devices(void)
 	for (l = bonded_devices; l; l = g_slist_next(l)) {
 		struct device *dev = l->data;
 
-		bdaddr2android(&dev->bdaddr, buf + (i * sizeof(bdaddr_t)));
+		get_device_android_addr(dev, buf + (i * sizeof(bdaddr_t)));
 		i++;
 	}
 
@@ -3461,7 +3476,7 @@ static void get_adapter_properties(void)
 	for (i = 0, l = bonded_devices; l; l = g_slist_next(l), i++) {
 		struct device *dev = l->data;
 
-		bdaddr2android(&dev->bdaddr, bonded + (i * sizeof(bdaddr_t)));
+		get_device_android_addr(dev, bonded + (i * sizeof(bdaddr_t)));
 	}
 
 	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_BONDED_DEVICES,
@@ -4255,7 +4270,7 @@ static void get_remote_device_props(struct device *dev)
 	size = sizeof(*ev);
 
 	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(&dev->bdaddr, ev->bdaddr);
+	get_device_android_addr(dev, ev->bdaddr);
 
 	android_type = get_device_android_type(dev);
 	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
-- 
1.9.3

