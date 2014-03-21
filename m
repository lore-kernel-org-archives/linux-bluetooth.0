Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Filter out not discoverable LE devices
Date: Fri, 21 Mar 2014 17:34:08 +0100
Message-Id: <1395419649-15647-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395419649-15647-1-git-send-email-szymon.janc@tieto.com>
References: <1395419649-15647-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Filter out the LE devices that do not have Discoverable flag or Limited
Discoverable flag set.

Kernel is not adding flags field to EIR if none of flags is set so this
is also treated as non-discoverable if device is LE. For devices that
are connected flags are ignored and Android Framework is always
notified on new device.
---
 android/bluetooth.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d2795e3..5c7ba59 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1164,8 +1164,16 @@ static bool rssi_above_threshold(int old, int new)
 	return abs(old - new) >= 8;
 }
 
+static bool is_le_discoverable(int flags)
+{
+	if (flags < 0)
+		return false;
+
+	return flags & (EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC);
+}
+
 static void update_new_device(struct device *dev, int8_t rssi,
-						const struct eir_data *eir)
+				const struct eir_data *eir, bool connected)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_device_found *ev = (void *) buf;
@@ -1213,12 +1221,16 @@ static void update_new_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
+	if (!connected && dev->bdaddr_type != BDADDR_BREDR &&
+					!is_le_discoverable(eir->flags))
+		return;
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND,
 								size, buf);
 }
 
 static void update_device(struct device *dev, int8_t rssi,
-						const struct eir_data *eir)
+				const struct eir_data *eir, bool connected)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_remote_device_props *ev = (void *) buf;
@@ -1253,6 +1265,10 @@ static void update_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
+	if (!connected && dev->bdaddr_type != BDADDR_BREDR &&
+					!is_le_discoverable(eir->flags))
+		return;
+
 	if (ev->num_props)
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
@@ -1260,7 +1276,8 @@ static void update_device(struct device *dev, int8_t rssi,
 
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
-					const uint8_t *data, uint8_t data_len)
+					const uint8_t *data, uint8_t data_len,
+					bool connected)
 {
 	struct eir_data eir;
 	struct device *dev;
@@ -1278,9 +1295,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		if (!dev)
 			dev = create_device(bdaddr, bdaddr_type);
 
-		update_new_device(dev, rssi, &eir);
+		update_new_device(dev, rssi, &eir, connected);
 	} else {
-		update_device(dev, rssi, &eir);
+		update_device(dev, rssi, &eir, connected);
 	}
 
 	/* Notify Gatt if its registered for LE events */
@@ -1349,7 +1366,7 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;
 
 	update_found_device(&ev->addr.bdaddr, ev->addr.type, ev->rssi,
-						confirm_name, eir, eir_len);
+					confirm_name, eir, eir_len, false);
 }
 
 static void mgmt_device_connected_event(uint16_t index, uint16_t length,
@@ -1364,7 +1381,7 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 	}
 
 	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false,
-					&ev->eir[0], btohs(ev->eir_len));
+					&ev->eir[0], btohs(ev->eir_len), true);
 
 	hal_ev.status = HAL_STATUS_SUCCESS;
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
-- 
1.8.3.2

