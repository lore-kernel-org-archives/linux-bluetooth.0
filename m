Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/bluetooth: Add function for getting device Android type
Date: Sat, 26 Apr 2014 17:26:13 +0200
Message-Id: <1398525974-3672-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used by GATT HAL.
---
 android/bluetooth.c | 9 +++++++++
 android/bluetooth.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7d82aba..20455e3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1180,6 +1180,15 @@ static uint8_t get_device_android_type(struct device *dev)
 	return HAL_TYPE_BREDR;
 }
 
+uint8_t bt_get_device_android_type(const bdaddr_t *addr)
+{
+	struct device *dev;
+
+	dev = get_device(addr, BDADDR_BREDR);
+
+	return get_device_android_type(dev);
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 634458f..649c9ba 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -46,3 +46,5 @@ bool bt_le_discovery_stop(bt_le_discovery_stopped cb);
 typedef void (*bt_le_set_advertising_done)(uint8_t status, void *user_data);
 bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 							void *user_data);
+
+uint8_t bt_get_device_android_type(const bdaddr_t *addr);
-- 
1.9.0

