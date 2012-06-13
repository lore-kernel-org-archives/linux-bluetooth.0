Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 05/21] adapter: remove deprecated ListDevices() method
Date: Wed, 13 Jun 2012 17:43:27 -0300
Message-Id: <1339620223-6639-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 doc/adapter-api.txt |   10 ----------
 src/adapter.c       |   35 -----------------------------------
 2 files changed, 45 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index dccb6bf..3eea23d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -88,16 +88,6 @@ Methods		dict GetProperties()
 			Possible Errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.InvalidArguments
 
-		array{object} ListDevices() {deprecated}
-
-			Returns list of device object paths.
-			This method is deprecated, instead use the Devices
-			Property to get the list of devices object paths.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-					 org.bluez.Error.OutOfMemory
-
 		object CreateDevice(string address)
 
 			Creates a new object path for a remote device. This
diff --git a/src/adapter.c b/src/adapter.c
index 6e04faf..3535cc4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1307,38 +1307,6 @@ static DBusMessage *release_session(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *list_devices(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct btd_adapter *adapter = data;
-	DBusMessage *reply;
-	GSList *l;
-	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	const gchar *dev_path;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = adapter->devices; l; l = l->next) {
-		struct btd_device *device = l->data;
-
-		dev_path = device_get_path(device);
-
-		dbus_message_iter_append_basic(&array_iter,
-				DBUS_TYPE_OBJECT_PATH, &dev_path);
-	}
-
-	dbus_message_iter_close_container(&iter, &array_iter);
-
-	return reply;
-}
-
 static DBusMessage *cancel_device_creation(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -1662,9 +1630,6 @@ static const GDBusMethodTable adapter_methods[] = {
 			adapter_start_discovery) },
 	{ GDBUS_ASYNC_METHOD("StopDiscovery", NULL, NULL,
 			adapter_stop_discovery) },
-	{ GDBUS_DEPRECATED_METHOD("ListDevices",
-			NULL, GDBUS_ARGS({ "devices", "ao" }),
-			list_devices) },
 	{ GDBUS_ASYNC_METHOD("CreateDevice",
 			GDBUS_ARGS({ "address", "s" }),
 			GDBUS_ARGS({ "device", "o" }),
-- 
1.7.10.2

