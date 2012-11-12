Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] dbusoob: Create device object and return it when adding OOB data
Date: Mon, 12 Nov 2012 16:53:15 +0100
Message-ID: <1352735596-731-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1352735596-731-1-git-send-email-szymon.janc@tieto.com>
References: <1352735596-731-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With recent change on how new device objects are created it is no
longer possible to create device object from string with
org.bluez.Adapter interface. When adding OOB data for specified
address device object is created if it was not yet existing.

Path to object is returned in AddRemoteData to avoid need for extra
FindDevice() call on org.bluez.Adapter to get object maching specified
address.

Change-Id: I5c30b2a9ca981e857729f9f50f6c839ea40a1ab7
---
 doc/oob-api.txt   |    6 +++++-
 plugins/dbusoob.c |   28 ++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index c3978fc..7f73db4 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -38,11 +38,15 @@ Methods		dict ReadLocalData()
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotSupported
 
-		void AddRemoteData(string address, dict data)
+		object AddRemoteData(string address, dict data)
 
 			This method adds new Out Of Band data for
 			specified address. If data for specified address
 			already exists it will be overwritten with new one.
+			If device object with given address does not exist yet
+			it will be created.
+
+			Returns the object path of device for given address.
 
 			All data is optional.
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 711fbc4..b59ffa8 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -222,6 +222,8 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter data;
 	struct oob_data remote_data;
 	struct btd_device *device;
+	DBusMessage *reply;
+	const char *dev_path;
 
 	if (!btd_adapter_ssp_enabled(adapter))
 		return btd_error_not_supported(msg);
@@ -236,19 +238,36 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	if (bachk(remote_data.addr) < 0)
 		return btd_error_invalid_args(msg);
 
-	device = adapter_find_device(adapter, remote_data.addr);
-	if (device && device_is_paired(device))
+	device = adapter_get_device(adapter, remote_data.addr);
+	if (!device)
+		return btd_error_failed(msg, "Creating device object failed");
+
+	if (device_is_paired(device))
 		return btd_error_already_exists(msg);
 
 	dbus_message_iter_recurse(&args, &data);
 
+	/*
+	 * TODO
+	 * Should device object be destroyed if parsing or storing failed?
+	 */
+
 	if (!parse_data(&data, &remote_data))
 		return btd_error_invalid_args(msg);
 
 	if (!store_data(adapter, &remote_data))
 		return btd_error_failed(msg, "Request failed");
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dev_path = device_get_path(device);
+
+	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &dev_path,
+							DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
@@ -277,7 +296,8 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 static const GDBusMethodTable oob_methods[] = {
 	{ GDBUS_METHOD("AddRemoteData",
 			GDBUS_ARGS({ "address", "s" }, { "data", "a{sv}"}),
-			NULL, add_remote_data) },
+			GDBUS_ARGS({ "device", "o" }),
+			add_remote_data) },
 	{ GDBUS_METHOD("RemoveRemoteData",
 			GDBUS_ARGS({ "address", "s" }), NULL,
 			remove_remote_data) },
-- 
1.7.9.5

