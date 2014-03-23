Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/5] android/bluetooth: Filter out not discoverable LE devices
Date: Sun, 23 Mar 2014 22:40:51 +0100
Message-Id: <1395610854-30579-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
References: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Filter out the LE devices that do not have Discoverable flag or Limited
Discoverable flag set.
---
 android/bluetooth.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d2795e3..3c859e8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1258,6 +1258,11 @@ static void update_device(struct device *dev, int8_t rssi,
 					HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
 }
 
+static bool is_le_dev_discoverable(unsigned int flags)
+{
+	return flags & (EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC);
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
@@ -1271,6 +1276,19 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	dev = find_device(bdaddr);
 
+	if (bdaddr_type != BDADDR_BREDR) {
+		/* Notify Gatt if its registered for LE events */
+		if (gatt_device_found_cb)
+			gatt_device_found_cb(bdaddr, bdaddr_type, rssi,
+							sizeof(eir), &eir);
+
+		if (adapter.cur_discovery_type != SCAN_TYPE_NONE &&
+					!is_le_dev_discoverable(eir.flags)) {
+			eir_data_free(&eir);
+			return;
+		}
+	}
+
 	/* Device found event needs to be send also for known device if this is
 	 * new discovery session. Otherwise framework will ignore it.
 	 */
@@ -1283,11 +1301,6 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		update_device(dev, rssi, &eir);
 	}
 
-	/* Notify Gatt if its registered for LE events */
-	if (gatt_device_found_cb && (dev->bdaddr_type & BDADDR_LE))
-		gatt_device_found_cb(&dev->bdaddr, dev->bdaddr_type,
-						dev->rssi, sizeof(eir), &eir);
-
 	eir_data_free(&eir);
 
 	if (dev->bond_state != HAL_BOND_STATE_BONDED)
-- 
1.8.5.3

