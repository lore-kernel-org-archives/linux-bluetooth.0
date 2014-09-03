Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/6] android/gatt: Extract remove_autoconnect_device helper
Date: Wed,  3 Sep 2014 16:42:30 +0200
Message-Id: <1409755353-6027-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 645f5f2..f4be376 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1865,19 +1865,25 @@ static bool trigger_connection(struct app_connection *connection)
 	return ret;
 }
 
+static void remove_autoconnect_device(struct gatt_device *dev)
+{
+	bt_auto_connect_remove(&dev->bdaddr);
+
+	if (dev->state == DEVICE_CONNECT_INIT)
+		device_set_state(dev, DEVICE_DISCONNECTED);
+
+	device_unref(dev);
+}
+
 static void clear_autoconnect_devices(void *data, void *user_data)
 {
 	struct gatt_device *dev = data;
 
 	if (queue_remove(dev->autoconnect_apps, user_data))
-		if (queue_isempty(dev->autoconnect_apps)) {
-			bt_auto_connect_remove(&dev->bdaddr);
+		if (queue_isempty(dev->autoconnect_apps))
+			remove_autoconnect_device(dev);
 
-			if (dev->state == DEVICE_CONNECT_INIT)
-				device_set_state(dev, DEVICE_DISCONNECTED);
 
-			device_unref(dev);
-		}
 }
 
 static uint8_t unregister_app(int client_if)
@@ -6804,12 +6810,8 @@ void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr)
 
 	queue_remove(dev->autoconnect_apps, INT_TO_PTR(id));
 
-	if (queue_isempty(dev->autoconnect_apps)) {
-		bt_auto_connect_remove(addr);
-
-		if (dev->state == DEVICE_CONNECT_INIT)
-			device_set_state(dev, DEVICE_DISCONNECTED);
+	if (queue_isempty(dev->autoconnect_apps))
+		remove_autoconnect_device(dev);
 
 		device_unref(dev);
-	}
 }
-- 
1.8.4

