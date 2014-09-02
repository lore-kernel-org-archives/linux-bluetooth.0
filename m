Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/16] android/gatt: Extract remove_autoconnect_device helper
Date: Tue,  2 Sep 2014 12:09:54 +0200
Message-Id: <1409652601-28689-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 348a2a2..31a535c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1837,6 +1837,15 @@ static bool trigger_connection(struct app_connection *connection)
 	return ret;
 }
 
+static void remove_autoconnect_device(struct gatt_device *dev)
+{
+	bt_auto_connect_remove(&dev->bdaddr);
+	device_unref(dev);
+
+	if (dev->state == DEVICE_CONNECT_INIT)
+		device_set_state(dev, DEVICE_DISCONNECTED);
+}
+
 static void clear_autoconnect_devices(int app_id)
 {
 	struct gatt_device *dev;
@@ -1849,13 +1858,8 @@ static void clear_autoconnect_devices(int app_id)
 	while (dev) {
 		queue_remove(dev->autoconnect_apps, INT_TO_PTR(app_id));
 
-		if (queue_isempty(dev->autoconnect_apps)) {
-			bt_auto_connect_remove(&dev->bdaddr);
-			device_unref(dev);
-
-			if (dev->state == DEVICE_CONNECT_INIT)
-				device_set_state(dev, DEVICE_DISCONNECTED);
-		}
+		if (queue_isempty(dev->autoconnect_apps))
+			remove_autoconnect_device(dev);
 
 		dev = find_device_by_autoconnect_app_id(app_id);
 	};
@@ -6812,11 +6816,6 @@ void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr)
 
 	queue_remove(dev->autoconnect_apps, INT_TO_PTR(id));
 
-	if (queue_isempty(dev->autoconnect_apps)) {
-		bt_auto_connect_remove(addr);
-		device_unref(dev);
-
-		if (dev->state == DEVICE_CONNECT_INIT)
-			device_set_state(dev, DEVICE_DISCONNECTED);
-	}
+	if (queue_isempty(dev->autoconnect_apps))
+		remove_autoconnect_device(dev);
 }
-- 
1.8.4

