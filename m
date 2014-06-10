Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] android/bluetooth: Add bt_is_device_le function
Date: Tue, 10 Jun 2014 18:53:55 +0300
Message-Id: <1402415643-32300-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
References: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/bluetooth.c | 11 +++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 36b073e..d275297 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1386,6 +1386,17 @@ uint8_t bt_get_device_android_type(const bdaddr_t *addr)
 	return get_device_android_type(dev);
 }
 
+bool bt_is_device_le(const bdaddr_t *addr)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	return dev->le;
+}
+
 const char *bt_get_adapter_name(void)
 {
 	return adapter.name;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index b4a5f32..2409d46 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -54,6 +54,8 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 							void *user_data);
 
 uint8_t bt_get_device_android_type(const bdaddr_t *addr);
+bool bt_is_device_le(const bdaddr_t *addr);
+
 const char *bt_get_adapter_name(void);
 bool bt_device_is_bonded(const bdaddr_t *bdaddr);
 
-- 
1.9.3

