Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/3] android/bluetooth: Refactor update_found_device function
Date: Tue,  4 Feb 2014 17:34:22 +0100
Message-Id: <1391531663-13143-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
References: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function grown too big and was hard to follow. Split it to helpers
for clarity.
---
 android/bluetooth.c | 153 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 60 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5aed4af..3becc45 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1051,97 +1051,132 @@ static bool rssi_above_threshold(int old, int new)
 	return abs(old - new) >= 8;
 }
 
-static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
-					int8_t rssi, bool confirm,
-					const uint8_t *data, uint8_t data_len)
+static void update_new_device(struct device *dev, int8_t rssi,
+						const struct eir_data *eir)
 {
 	uint8_t buf[BLUEZ_HAL_MTU];
-	struct eir_data eir;
-	struct device *dev;
-	uint8_t *num_prop;
-	uint8_t opcode;
-	int size = 0;
+	struct hal_ev_device_found *ev = (void*) buf;
+	bdaddr_t android_bdaddr;
+	uint8_t android_type;
+	int size;
 
 	memset(buf, 0, sizeof(buf));
-	memset(&eir, 0, sizeof(eir));
-
-	eir_parse(&eir, data, data_len);
-
-	dev = find_device(bdaddr);
 
-	/*
-	 * Device found event needs to be send also for known device if this is
-	 * new discovery session. Otherwise framework will ignore it.
-	 */
-	if (!dev || !dev->found) {
-		struct hal_ev_device_found *ev = (void *) buf;
-		bdaddr_t android_bdaddr;
-		uint8_t android_type;
+	if (adapter.discovering)
+		dev->found = true;
 
-		if (!dev)
-			dev = create_device(bdaddr, bdaddr_type);
+	size = sizeof(*ev);
 
-		dev->found = true;
+	bdaddr2android(&dev->bdaddr, &android_bdaddr);
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
+						sizeof(android_bdaddr),
+						&android_bdaddr);
+	ev->num_props++;
 
-		size += sizeof(*ev);
+	android_type = bdaddr_type2android(dev->bdaddr_type);
+	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
+				sizeof(android_type), &android_type);
+	ev->num_props++;
 
-		num_prop = &ev->num_props;
-		opcode = HAL_EV_DEVICE_FOUND;
+	if (eir->class) {
+		dev->class = eir->class;
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
+					sizeof(dev->class), &dev->class);
+		ev->num_props++;
+	}
 
-		bdaddr2android(bdaddr, &android_bdaddr);
+	if (rssi && rssi_above_threshold(dev->rssi, rssi)) {
+		dev->rssi = rssi;
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
+						sizeof(dev->rssi), &dev->rssi);
+		ev->num_props++;
+	}
 
-		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
-							sizeof(android_bdaddr),
-							&android_bdaddr);
-		(*num_prop)++;
+	if (eir->name) {
+		g_free(dev->name);
+		dev->name = g_strdup(eir->name);
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
+						strlen(dev->name), dev->name);
+		ev->num_props++;
+	}
 
-		android_type = bdaddr_type2android(dev->bdaddr_type);
-		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
-					sizeof(android_type), &android_type);
-		(*num_prop)++;
-	} else {
-		struct hal_ev_remote_device_props *ev = (void *) buf;
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND, size,
+									buf);
+}
 
-		size += sizeof(*ev);
+static void update_device(struct device *dev, int8_t rssi,
+						const struct eir_data *eir)
+{
+	uint8_t buf[BLUEZ_HAL_MTU];
+	struct hal_ev_remote_device_props *ev = (void *) buf;
+	int size;
 
-		num_prop = &ev->num_props;
-		opcode = HAL_EV_REMOTE_DEVICE_PROPS;
+	memset(buf, 0, sizeof(buf));
 
-		ev->status = HAL_STATUS_SUCCESS;
-		bdaddr2android(bdaddr, ev->bdaddr);
-	}
+	size = sizeof(*ev);
 
-	if (eir.class) {
-		dev->class = eir.class;
+	ev->status = HAL_STATUS_SUCCESS;
+	bdaddr2android(&dev->bdaddr, ev->bdaddr);
 
+	if (eir->class) {
+		dev->class = eir->class;
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
-						sizeof(eir.class), &eir.class);
-		(*num_prop)++;
+					sizeof(dev->class), &dev->class);
+		ev->num_props++;
 	}
 
 	if (rssi && rssi_above_threshold(dev->rssi, rssi)) {
 		dev->rssi = rssi;
-
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
 						sizeof(dev->rssi), &dev->rssi);
-		(*num_prop)++;
+		ev->num_props++;
 	}
 
-	if (eir.name) {
+	if (eir->name) {
 		g_free(dev->name);
-		dev->name = g_strdup(eir.name);
-
+		dev->name = g_strdup(eir->name);
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
-						strlen(eir.name), eir.name);
-		(*num_prop)++;
+						strlen(dev->name), dev->name);
+		ev->num_props++;
 	}
 
+	if (ev->num_props)
+		ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH,
+					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
+}
+
+static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+					int8_t rssi, bool confirm,
+					const uint8_t *data, uint8_t data_len)
+{
+	uint8_t buf[BLUEZ_HAL_MTU];
+	struct eir_data eir;
+	struct device *dev;
+
+	memset(buf, 0, sizeof(buf));
+	memset(&eir, 0, sizeof(eir));
+
+	eir_parse(&eir, data, data_len);
+
+	dev = find_device(bdaddr);
+
+	/* Device found event needs to be send also for known device if this is
+	 * new discovery session. Otherwise framework will ignore it.
+	 */
+	if (!dev || !dev->found) {
+		if (!dev)
+			dev = create_device(bdaddr, bdaddr_type);
+
+		update_new_device(dev, rssi, &eir);
+	} else {
+		update_device(dev, rssi, &eir);
+	}
+
+	eir_data_free(&eir);
+
 	if (dev->bond_state != HAL_BOND_STATE_BONDED)
 		cache_device(dev);
 
-	if (*num_prop)
-		ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf);
-
 	if (confirm) {
 		char addr[18];
 
@@ -1149,8 +1184,6 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		info("Device %s needs name confirmation.", addr);
 		confirm_device_name(bdaddr, bdaddr_type);
 	}
-
-	eir_data_free(&eir);
 }
 
 static void mgmt_device_found_event(uint16_t index, uint16_t length,
-- 
1.8.3.2

