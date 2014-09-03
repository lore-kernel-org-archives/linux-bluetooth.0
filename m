Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/6] android/gatt: Add API to remove autoconnect GATT based device
Date: Wed,  3 Sep 2014 08:58:02 +0200
Message-Id: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v2: Fixed issue found by Szymon

 android/gatt.c | 24 ++++++++++++++++++++++++
 android/gatt.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index aff5dc5..a3486ca 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6768,3 +6768,27 @@ bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr)
 
 	return true;
 }
+
+void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr)
+{
+	struct gatt_device *dev;
+
+	DBG("");
+
+	dev = find_device_by_addr(addr);
+	if (!dev) {
+		error("gatt: Device not found");
+		return;
+	}
+
+	queue_remove(dev->autoconnect_apps, INT_TO_PTR(id));
+
+	if (queue_isempty(dev->autoconnect_apps)) {
+		bt_auto_connect_remove(addr);
+
+		if (dev->state == DEVICE_CONNECT_INIT)
+			device_set_state(dev, DEVICE_DISCONNECTED);
+
+		device_unref(dev);
+	}
+}
diff --git a/android/gatt.h b/android/gatt.h
index 40699b2..3382df9 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -40,3 +40,4 @@ bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_set_security(const bdaddr_t *bdaddr, int sec_level);
 bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr);
+void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr);
-- 
1.8.4

