Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 16/16] adapter: Remove FindDevice method from D-Bus API
Date: Thu, 15 Nov 2012 16:09:19 +0100
Message-Id: <1352992159-11559-17-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

ObjectManager.GetManagedObjects() returns all devices and their
corresponding properties to any interested client. The device address is
included in the property dictionary and therefore having such a
FindDevice method is an unnecessary duplication.
---
 doc/adapter-api.txt |  7 -------
 src/adapter.c       | 38 --------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 3582793..983a20d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -64,13 +64,6 @@ Methods		void RequestSession()
 					 org.bluez.Error.Failed
 					 org.bluez.Error.NotAuthorized
 
-		object FindDevice(string address)
-
-			Returns the object path of device for given address.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.InvalidArguments
-
 		void RemoveDevice(object device)
 
 			This removes the remote device object at the given
diff --git a/src/adapter.c b/src/adapter.c
index eb82102..71b5232 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1518,40 +1518,6 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *find_device(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct btd_adapter *adapter = data;
-	struct btd_device *device;
-	DBusMessage *reply;
-	const gchar *address;
-	GSList *l;
-	const gchar *dev_path;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	l = g_slist_find_custom(adapter->devices,
-			address, (GCompareFunc) device_address_cmp);
-	if (!l)
-		return btd_error_does_not_exist(msg);
-
-	device = l->data;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dev_path = device_get_path(device);
-
-	dbus_message_append_args(reply,
-				DBUS_TYPE_OBJECT_PATH, &dev_path,
-				DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
 static void agent_removed(struct agent *agent, struct btd_adapter *adapter)
 {
 	mgmt_set_io_capability(adapter->dev_id, IO_CAPABILITY_NOINPUTNOOUTPUT);
@@ -1623,10 +1589,6 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL,
 			remove_device) },
-	{ GDBUS_METHOD("FindDevice",
-			GDBUS_ARGS({ "address", "s" }),
-			GDBUS_ARGS({ "device", "o" }),
-			find_device) },
 	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "agent", "o" },
 					{ "capability", "s" }), NULL,
-- 
1.7.11.7

