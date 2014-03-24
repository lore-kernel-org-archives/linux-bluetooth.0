Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/5] android/bluetooth: Filter out not discoverable LE devices
Date: Mon, 24 Mar 2014 13:36:43 +0100
Message-Id: <1395664606-32263-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
References: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Filter out unknown LE devices that do not have Discoverable flag or
Limited Discoverable flag set.
---
 android/bluetooth.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d2795e3..ce4cc86 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1271,6 +1271,19 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	dev = find_device(bdaddr);
 
+	if (bdaddr_type != BDADDR_BREDR) {
+		/* Notify Gatt if its registered for LE events */
+		if (gatt_device_found_cb)
+			gatt_device_found_cb(bdaddr, bdaddr_type, rssi,
+							sizeof(eir), &eir);
+
+		if (!dev && adapter.cur_discovery_type != SCAN_TYPE_NONE &&
+				!(eir.flags & (EIR_LIM_DISC | EIR_GEN_DISC))) {
+			eir_data_free(&eir);
+			return;
+		}
+	}
+
 	/* Device found event needs to be send also for known device if this is
 	 * new discovery session. Otherwise framework will ignore it.
 	 */
@@ -1283,11 +1296,6 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
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
1.9.1

