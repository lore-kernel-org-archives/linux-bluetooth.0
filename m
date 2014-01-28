Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/bluetooth: Add threashold to RSSI change
Date: Wed, 29 Jan 2014 00:47:14 +0100
Message-Id: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to report very small RSSI changes.
---
 android/bluetooth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b105ac8..b95023c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1045,6 +1045,19 @@ static uint8_t bdaddr_type2android(uint8_t type)
 	return HAL_TYPE_LE;
 }
 
+static bool rssi_threashold(int old, int new)
+{
+	int delta;
+
+	if (old > new)
+		delta = old - new;
+	else
+		delta = new - old;
+
+	/* only 8 dBm or more */
+	return delta >= 8;
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
@@ -1113,7 +1126,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
-	if (rssi) {
+	if (rssi && rssi_threashold(dev->rssi, rssi)) {
 		dev->rssi = rssi;
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
-- 
1.8.5.3

