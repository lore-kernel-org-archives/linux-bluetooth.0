Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/11] input: Remove Input interface
Date: Mon, 26 Nov 2012 15:09:16 +0200
Message-Id: <1353935362-8666-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface is no longer needed as Device interface can now connect
the profiles.
---
 doc/input-api.txt       | 44 -----------------------
 profiles/input/device.c | 93 ++++---------------------------------------------
 2 files changed, 6 insertions(+), 131 deletions(-)
 delete mode 100644 doc/input-api.txt

diff --git a/doc/input-api.txt b/doc/input-api.txt
deleted file mode 100644
index 7c3a4b2..0000000
--- a/doc/input-api.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-BlueZ D-Bus Input API description
-*********************************
-
-Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
-
-
-Input hierarchy
-===============
-
-Service		org.bluez
-Interface	org.bluez.Input
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void Connect()
-
-			Connect to the input device.
-
-			Possible errors: org.bluez.Error.AlreadyConnected
-					 org.bluez.Error.ConnectionAttemptFailed
-
-		void Disconnect()
-
-			Disconnect from the input device.
-
-			To abort a connection attempt in case of errors or
-			timeouts in the client it is fine to call this method.
-
-			Possible errors: org.bluez.Error.Failed
-
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
-Properties	boolean Connected [readonly]
-
-			Indicates if the device is connected.
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 108be39..2871cc3 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -680,26 +680,6 @@ int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
 	return dev_connect(idev);
 }
 
-static DBusMessage *local_connect(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct input_device *idev = data;
-
-	if (idev->pending)
-		return btd_error_in_progress(msg);
-
-	if (is_connected(idev))
-		return btd_error_already_connected(msg);
-
-	idev->pending = g_new0(struct pending_connect, 1);
-	idev->pending->local = true;
-	idev->pending->msg = dbus_message_ref(msg);
-
-	dev_connect(idev);
-
-	return NULL;
-}
-
 int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
 							btd_profile_cb cb)
 {
@@ -720,57 +700,6 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
 	return 0;
 }
 
-static DBusMessage *local_disconnect(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct input_device *idev = data;
-	int err;
-
-	err = connection_disconnect(idev, 0);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-}
-
-static void device_unregister(void *data)
-{
-	struct input_device *idev = data;
-
-	DBG("Unregistered interface %s on path %s", INPUT_DEVICE_INTERFACE,
-								idev->path);
-
-	devices = g_slist_remove(devices, idev);
-	input_device_free(idev);
-}
-
-
-
-static gboolean input_device_property_get_connected(
-					const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct input_device *idev = data;
-	dbus_bool_t connected = is_connected(idev);
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &connected);
-
-	return TRUE;
-}
-
-static const GDBusMethodTable device_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect",
-				NULL, NULL, local_connect) },
-	{ GDBUS_METHOD("Disconnect",
-				NULL, NULL, local_disconnect) },
-	{ }
-};
-
-static const GDBusPropertyTable device_properties[] = {
-	{ "Connected", "b", input_device_property_get_connected },
-	{ }
-};
-
 static struct input_device *input_device_new(struct btd_device *device,
 				const char *path, const uint32_t handle,
 				gboolean disable_sdp)
@@ -791,20 +720,6 @@ static struct input_device *input_device_new(struct btd_device *device,
 	if (strlen(name) > 0)
 		idev->name = g_strdup(name);
 
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
-					idev->path, INPUT_DEVICE_INTERFACE,
-					device_methods, NULL,
-					device_properties, idev,
-					device_unregister) == FALSE) {
-		error("Failed to register interface %s on path %s",
-			INPUT_DEVICE_INTERFACE, path);
-		input_device_free(idev);
-		return NULL;
-	}
-
-	DBG("Registered interface %s on path %s",
-			INPUT_DEVICE_INTERFACE, idev->path);
-
 	return idev;
 }
 
@@ -823,6 +738,8 @@ int input_device_register(struct btd_device *device,
 {
 	struct input_device *idev;
 
+	DBG("%s", path);
+
 	idev = find_device_by_path(devices, path);
 	if (idev)
 		return -EEXIST;
@@ -859,6 +776,8 @@ int input_device_unregister(const char *path, const char *uuid)
 {
 	struct input_device *idev;
 
+	DBG("%s", path);
+
 	idev = find_device_by_path(devices, path);
 	if (idev == NULL)
 		return -EINVAL;
@@ -868,8 +787,8 @@ int input_device_unregister(const char *path, const char *uuid)
 		return -EBUSY;
 	}
 
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						path, INPUT_DEVICE_INTERFACE);
+	devices = g_slist_remove(devices, idev);
+	input_device_free(idev);
 
 	return 0;
 }
-- 
1.7.11.7

