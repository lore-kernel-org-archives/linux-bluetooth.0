Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/bluetooth: Simplify check if device type changed
Date: Sun, 18 May 2014 13:54:00 +0200
Message-Id: <1400414040-30913-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
References: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes code easier to follow. Also LE address type is not lost
if dual mode device connected over BR/EDR.
---
 android/bluetooth.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5163291..ca6d242 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1389,7 +1389,7 @@ static void update_device(struct device *dev, int8_t rssi,
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_remote_device_props *ev = (void *) buf;
-	uint8_t android_type;
+	uint8_t old_type, new_type;
 	int size;
 
 	memset(buf, 0, sizeof(buf));
@@ -1399,25 +1399,21 @@ static void update_device(struct device *dev, int8_t rssi,
 	ev->status = HAL_STATUS_SUCCESS;
 	bdaddr2android(&dev->bdaddr, ev->bdaddr);
 
-	if (dev->bdaddr_type != bdaddr_type) {
-		bool type_changed = false;
+	old_type = get_device_android_type(dev);
 
+	if (bdaddr_type == BDADDR_BREDR) {
+		dev->bredr = true;
+	} else {
+		dev->le = true;
 		dev->bdaddr_type = bdaddr_type;
-		if (bdaddr_type == BDADDR_BREDR) {
-			type_changed = !dev->bredr;
-			dev->bredr = true;
-		} else {
-			type_changed = !dev->le;
-			dev->le = true;
-		}
+	}
 
-		if (type_changed) {
-			android_type = get_device_android_type(dev);
-			size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
-							sizeof(android_type),
-							&android_type);
-			ev->num_props++;
-		}
+	new_type = get_device_android_type(dev);
+
+	if (old_type != new_type) {
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
+						sizeof(new_type), &new_type);
+		ev->num_props++;
 	}
 
 	if (eir->class && dev->class != eir->class) {
-- 
1.9.0

