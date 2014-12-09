Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/25] android/bluetooth: Add API to check if device is bonding
Date: Tue,  9 Dec 2014 16:11:29 +0100
Message-Id: <1418137907-16981-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some modules like GATT might be interested in information about ongoing
bonding on device. It can be useful e.g. to take decision if GATT can do
service search or should wait until bonding is done.
---
 android/bluetooth.c | 11 +++++++++++
 android/bluetooth.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7c4adb8..6e678e4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1765,6 +1765,17 @@ void bt_paired_unregister(bt_paired_device_cb cb)
 	queue_remove(paired_cb_list, cb);
 }
 
+bool bt_is_pairing(const bdaddr_t *addr)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	return dev->pairing;
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8e0e6e2..884aed3 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -94,3 +94,4 @@ void bt_unpaired_unregister(bt_unpaired_device_cb cb);
 typedef void (*bt_paired_device_cb)(const bdaddr_t *addr, uint8_t type);
 bool bt_paired_register(bt_paired_device_cb cb);
 void bt_paired_unregister(bt_paired_device_cb cb);
+bool bt_is_pairing(const bdaddr_t *addr);
-- 
1.8.4

