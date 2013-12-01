Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/4] Rename device_is_connected to btd_device_is_connected
Date: Sun,  1 Dec 2013 14:41:54 +0100
Message-Id: <1385905316-21800-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
References: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 profiles/input/device.c | 4 ++--
 src/adapter.c           | 6 +++---
 src/device.c            | 6 +++---
 src/device.h            | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0c2089b..521aca8 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -667,7 +667,7 @@ static gboolean input_device_auto_reconnect(gpointer user_data)
 	/* Stop the recurrent reconnection attempts if the device is reconnected
 	 * or is marked for removal. */
 	if (device_is_temporary(idev->device) ||
-					device_is_connected(idev->device))
+					btd_device_is_connected(idev->device))
 		return FALSE;
 
 	/* Only attempt an auto-reconnect for at most 3 minutes (6 * 30s). */
@@ -713,7 +713,7 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 	/* If the device is temporary we are not required to reconnect with the
 	 * device. This is likely the case of a removing device. */
 	if (device_is_temporary(idev->device) ||
-					device_is_connected(idev->device))
+					btd_device_is_connected(idev->device))
 		return;
 
 	if (idev->reconnect_timer > 0)
diff --git a/src/adapter.c b/src/adapter.c
index 55a41db..41f7bd6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2158,7 +2158,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 
 	btd_device_set_temporary(device, TRUE);
 
-	if (!device_is_connected(device)) {
+	if (!btd_device_is_connected(device)) {
 		adapter_remove_device(adapter, device);
 		return dbus_message_new_method_return(msg);
 	}
@@ -4195,7 +4195,7 @@ connect_le:
 	 * connect_list stop passive scanning so that a connection
 	 * attempt to it can be made
 	 */
-	if (device_is_le(dev) && !device_is_connected(dev) &&
+	if (device_is_le(dev) && !btd_device_is_connected(dev) &&
 				g_slist_find(adapter->connect_list, dev)) {
 		adapter->connect_le = dev;
 		stop_passive_scanning(adapter);
@@ -5865,7 +5865,7 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 
 	btd_device_set_temporary(device, TRUE);
 
-	if (device_is_connected(device))
+	if (btd_device_is_connected(device))
 		device_request_disconnect(device, NULL);
 	else
 		adapter_remove_device(adapter, device);
diff --git a/src/device.c b/src/device.c
index 847ffad..5380c1a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1355,7 +1355,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	if (device_is_le(dev)) {
 		int err;
 
-		if (device_is_connected(dev))
+		if (btd_device_is_connected(dev))
 			return dbus_message_new_method_return(msg);
 
 		btd_device_set_temporary(dev, FALSE);
@@ -1645,7 +1645,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	 * channel first and only then start pairing (there's code for
 	 * this in the ATT connect callback)
 	 */
-	if (device_is_le(device) && !device_is_connected(device))
+	if (device_is_le(device) && !btd_device_is_connected(device))
 		err = device_connect_le(device);
 	else
 		err = adapter_create_bonding(adapter, &device->bdaddr,
@@ -1791,7 +1791,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ }
 };
 
-gboolean device_is_connected(struct btd_device *device)
+gboolean btd_device_is_connected(struct btd_device *device)
 {
 	return device->connected;
 }
diff --git a/src/device.h b/src/device.h
index c3fea4a..3a33cb2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -74,7 +74,7 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
-gboolean device_is_connected(struct btd_device *device);
+gboolean btd_device_is_connected(struct btd_device *device);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
-- 
1.8.5

