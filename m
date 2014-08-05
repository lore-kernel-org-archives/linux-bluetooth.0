Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix Device1.Disconnect not always disabling auto connect
Date: Tue,  5 Aug 2014 16:30:46 +0300
Message-Id: <1407245446-16366-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Disconnect has the ability to disable auto connect temporarily until
Connect is then called again, but currently it can only do that if
the device is connected.
---
 src/device.c | 77 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6eba0af..d63e627 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1169,6 +1169,40 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 							device);
 }
 
+static void device_set_auto_connect(struct btd_device *device, gboolean enable)
+{
+	char addr[18];
+
+	if (!device || !device->le)
+		return;
+
+	ba2str(&device->bdaddr, addr);
+
+	DBG("%s auto connect: %d", addr, enable);
+
+	if (device->auto_connect == enable)
+		return;
+
+	device->auto_connect = enable;
+
+	/* Disabling auto connect */
+	if (enable == FALSE) {
+		adapter_connect_list_remove(device->adapter, device);
+		adapter_auto_connect_remove(device->adapter, device);
+		return;
+	}
+
+	/* Enabling auto connect */
+	adapter_auto_connect_add(device->adapter, device);
+
+	if (device->attrib) {
+		DBG("Already connected");
+		return;
+	}
+
+	adapter_connect_list_add(device->adapter, device);
+}
+
 static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
@@ -1178,8 +1212,10 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	 * Disable connections through passive scanning until
 	 * Device1.Connect is called
 	 */
-	if (device->auto_connect)
+	if (device->auto_connect) {
 		device->disable_auto_connect = TRUE;
+		device_set_auto_connect(device, FALSE);
+	}
 
 	device_request_disconnect(device, msg);
 
@@ -1484,7 +1520,10 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 
 		btd_device_set_temporary(dev, FALSE);
 
-		dev->disable_auto_connect = FALSE;
+		if (dev->disable_auto_connect) {
+			dev->disable_auto_connect = FALSE;
+			device_set_auto_connect(dev, TRUE);
+		}
 
 		err = device_connect_le(dev);
 		if (err < 0)
@@ -4099,40 +4138,6 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 						DEVICE_INTERFACE, "RSSI");
 }
 
-static void device_set_auto_connect(struct btd_device *device, gboolean enable)
-{
-	char addr[18];
-
-	if (!device || !device->le)
-		return;
-
-	ba2str(&device->bdaddr, addr);
-
-	DBG("%s auto connect: %d", addr, enable);
-
-	if (device->auto_connect == enable)
-		return;
-
-	device->auto_connect = enable;
-
-	/* Disabling auto connect */
-	if (enable == FALSE) {
-		adapter_connect_list_remove(device->adapter, device);
-		adapter_auto_connect_remove(device->adapter, device);
-		return;
-	}
-
-	/* Enabling auto connect */
-	adapter_auto_connect_add(device->adapter, device);
-
-	if (device->attrib) {
-		DBG("Already connected");
-		return;
-	}
-
-	adapter_connect_list_add(device->adapter, device);
-}
-
 static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
-- 
1.9.3

