Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 16/38] android/bluetooth: Add function for getting device Android name
Date: Wed, 30 Apr 2014 11:13:47 +0200
Message-Id: <1398849249-5868-17-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used by GATT HAL
---
 android/bluetooth.c | 5 +++++
 android/bluetooth.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 03b8576..655fb1e 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1198,6 +1198,11 @@ uint8_t bt_get_device_android_type(const bdaddr_t *addr)
 	return get_device_android_type(dev);
 }
 
+const char *bt_get_adapter_name(void)
+{
+	return adapter.name;
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 649c9ba..dddbf20 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -48,3 +48,4 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 							void *user_data);
 
 uint8_t bt_get_device_android_type(const bdaddr_t *addr);
+const char *bt_get_adapter_name(void);
-- 
1.8.4

