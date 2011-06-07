Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] Add OOB DBus method for changing device properties
Date: Tue,  7 Jun 2011 13:14:39 +0200
Message-Id: <1307445279-31865-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should be used when connection is made via Out of Band mechanisms.
For now there is only support for remote device class setting.
---
 doc/oob-api.txt   |   10 +++++++++
 plugins/dbusoob.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index d838712..606dd38 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -36,3 +36,13 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
+
+		void SetDeviceProperty(string address, string property,
+								variant class)
+
+			This method set property for devices with specified
+			address. For now only "Class" property (uint32) is
+			supported.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 2c03780..c7f13ed 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -175,11 +175,65 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *set_device_property(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+	char *addr;
+	char *property;
+	struct btd_device *device;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &addr);
+	dbus_message_iter_next(&iter);
+
+	if (bachk(addr) != 0)
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (g_str_equal("Class", property)) {
+		uint32_t class;
+		bdaddr_t src, peer;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &class);
+
+		device = adapter_get_device(conn, adapter, addr);
+		adapter_get_address(adapter, &src);
+		device_get_address(device, &peer);
+
+		btd_event_remote_class(&src, &peer, class);
+	} else
+		return btd_error_failed(msg, "Invalid property");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static GDBusMethodTable oob_methods[] = {
 	{"AddRemoteData",	"sayay",	"",	add_remote_data},
 	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
 	{"ReadLocalData",	"",		"ayay",	read_local_data,
 						G_DBUS_METHOD_FLAG_ASYNC},
+	{"SetDeviceProperty",	"ssv",		"",	set_device_property},
 	{}
 };
 
-- 
1.7.1

