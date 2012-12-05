Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 10/15] adapter: Remove DeviceCreated/DeviceRemoved signals
Date: Wed,  5 Dec 2012 13:51:37 +0100
Message-Id: <1354711902-16390-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The Adapter interface already reports changes in the device list in form
of property changes, so there is no need to keep these two signals.
---
 doc/adapter-api.txt |  8 --------
 src/adapter.c       | 17 -----------------
 2 files changed, 25 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index b638586..132e60f 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -116,14 +116,6 @@ Signals		DevicesFound(array{object path, dict values})
 			The dictionary contains the properties from the
 			org.bluez.Device interface.
 
-		DeviceCreated(object device)
-
-			Parameter is object path of created device.
-
-		DeviceRemoved(object device)
-
-			Parameter is object path of removed device.
-
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/src/adapter.c b/src/adapter.c
index ea0394f..a816ae3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1010,7 +1010,6 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 						uint8_t bdaddr_type)
 {
 	struct btd_device *device;
-	const char *path;
 
 	DBG("%s", address);
 
@@ -1022,12 +1021,6 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 
 	adapter->devices = g_slist_append(adapter->devices, device);
 
-	path = device_get_path(device);
-	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
-			ADAPTER_INTERFACE, "DeviceCreated",
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter->path, ADAPTER_INTERFACE, "Devices");
 
@@ -1055,7 +1048,6 @@ void adapter_remove_device(struct btd_adapter *adapter,
 						struct btd_device *dev,
 						gboolean remove_storage)
 {
-	const gchar *dev_path = device_get_path(dev);
 	struct discovery *discovery = adapter->discovery;
 	GList *l;
 
@@ -1087,11 +1079,6 @@ void adapter_remove_device(struct btd_adapter *adapter,
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter->path, ADAPTER_INTERFACE, "Devices");
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
-			ADAPTER_INTERFACE, "DeviceRemoved",
-			DBUS_TYPE_OBJECT_PATH, &dev_path,
-			DBUS_TYPE_INVALID);
-
 	device_remove(dev, remove_storage);
 }
 
@@ -1683,10 +1670,6 @@ static const GDBusMethodTable adapter_methods[] = {
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ GDBUS_SIGNAL("DeviceCreated",
-			GDBUS_ARGS({ "device", "o" })) },
-	{ GDBUS_SIGNAL("DeviceRemoved",
-			GDBUS_ARGS({ "device", "o" })) },
 	{ GDBUS_SIGNAL("DevicesFound",
 			GDBUS_ARGS({ "devices", "a{oa{sv}}" })) },
 	{ }
-- 
1.7.11.7

