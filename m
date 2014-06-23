Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/7] android/bluetooth: Map RPA to Identity address on New IRK event
Date: Mon, 23 Jun 2014 16:28:32 +0200
Message-Id: <1403533714-5188-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
References: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to pair with devices using RPA. There is no API
to notify HAL about new Identity Address. When New IRK event is
received ID address is stored in device and map to RPA is done.
This allows to use RPA after address was resolved making this
transparent to Android Framework. When daemon is restarted device
is advertised to Framework with ID address.
---
 android/bluetooth.c | 62 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c664461..61bee90 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -127,6 +127,9 @@ struct device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 
+	bdaddr_t rpa;
+	uint8_t rpa_type;
+
 	bool le;
 	bool bredr;
 
@@ -220,7 +223,10 @@ static struct ipc *hal_ipc = NULL;
 
 static void get_device_android_addr(struct device *dev, uint8_t *addr)
 {
-	bdaddr2android(&dev->bdaddr, addr);
+	if (bacmp(&dev->rpa, BDADDR_ANY))
+		bdaddr2android(&dev->rpa, addr);
+	else
+		bdaddr2android(&dev->bdaddr, addr);
 }
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -382,6 +388,9 @@ static int device_match(gconstpointer a, gconstpointer b)
 	const struct device *dev = a;
 	const bdaddr_t *bdaddr = b;
 
+	if (!bacmp(&dev->rpa, bdaddr))
+		return 0;
+
 	return bacmp(&dev->bdaddr, bdaddr);
 }
 
@@ -689,7 +698,7 @@ void bt_store_gatt_ccc(const bdaddr_t *dst, uint16_t value)
 		return;
 	}
 
-	ba2str(dst, addr);
+	ba2str(&dev->bdaddr, addr);
 
 	DBG("%s Gatt CCC %d", addr, value);
 
@@ -1642,12 +1651,21 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	/* Notify Gatt if its registered for LE events */
 	if (bdaddr_type != BDADDR_BREDR && gatt_device_found_cb) {
 		bool discoverable;
+		bdaddr_t *addr;
+		uint8_t addr_type;
 
 		discoverable = eir.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
 
-		gatt_device_found_cb(bdaddr, bdaddr_type, rssi, data_len, data,
-								discoverable,
-								dev->le_bonded);
+		if (bacmp(&dev->rpa, BDADDR_ANY)) {
+			addr = &dev->rpa;
+			addr_type = dev->rpa_type;
+		} else {
+			addr = &dev->bdaddr;
+			addr_type = dev->bdaddr_type;
+		}
+
+		gatt_device_found_cb(addr, addr_type, rssi, data_len, data,
+						discoverable, dev->le_bonded);
 	}
 
 	if (!dev->bredr_paired && !dev->le_paired)
@@ -2078,10 +2096,36 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 
 	DBG("new IRK for %s, RPA %s", dst, rpa);
 
-	/* TODO: handle new Identity to RPA mapping */
-	dev = find_device(&addr->bdaddr);
-	if (!dev)
-		return;
+	if (!bacmp(&ev->rpa, BDADDR_ANY)) {
+		dev = find_device(&addr->bdaddr);
+		if (!dev)
+			return;
+	} else {
+		dev = find_device(&addr->bdaddr);
+
+		if (dev && dev->bredr_paired) {
+			bacpy(&dev->rpa, &addr->bdaddr);
+			dev->rpa_type = addr->type;
+
+			/* TODO merge properties ie. UUIDs */
+		} else {
+			dev = find_device(&ev->rpa);
+			if (!dev)
+				return;
+
+			/* don't leave garbage in cache file */
+			remove_device_info(dev, CACHE_FILE);
+
+			bacpy(&dev->rpa, &dev->bdaddr);
+			dev->rpa_type = dev->bdaddr_type;
+
+			bacpy(&dev->bdaddr, &addr->bdaddr);
+			dev->bdaddr_type = addr->type;
+		}
+	}
+
+	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
+							true, !!ev->store_hint);
 
 	if (ev->store_hint)
 		store_irk(dev, ev->key.val);
-- 
1.9.3

