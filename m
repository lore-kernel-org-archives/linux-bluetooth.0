Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/3] android/bluetooth: Add threshold to RSSI change
Date: Tue,  4 Feb 2014 17:34:21 +0100
Message-Id: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to report very small RSSI changes.
---
v2: Fix name and use abs()

 android/bluetooth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d74d792..5aed4af 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1045,6 +1045,12 @@ static uint8_t bdaddr_type2android(uint8_t type)
 	return HAL_TYPE_LE;
 }
 
+static bool rssi_above_threshold(int old, int new)
+{
+	/* only 8 dBm or more */
+	return abs(old - new) >= 8;
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
@@ -1113,7 +1119,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
-	if (rssi) {
+	if (rssi && rssi_above_threshold(dev->rssi, rssi)) {
 		dev->rssi = rssi;
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
-- 
1.8.3.2

