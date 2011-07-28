Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH BlueZ] Add SetRemoteProperty method for OOB mechanism
Date: Thu, 28 Jul 2011 15:55:10 +0200
Message-Id: <1311861310-21531-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add possibility of suppling some additional data (like class of device)
when using OOB mechanism for pairing.
---
Sadly to handle all possible combination of acceptable parameters (extreme case
is when there is a string and an array of a dict entries with string and variant
with an array of bytes - sa{sv} -> v: ay) function must be rather complicated.
I thought of dividing it, but this use case is rather individual and refactoring
part of it out would tangled whole architecture.

 doc/oob-api.txt   |   16 ++++++++
 plugins/dbusoob.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index d838712..4f60ca1 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -36,3 +36,19 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
+
+		void SetRemoteProperty(string address, dict data)
+
+			This method set new properties for device with specified
+			address, to be used when device is created. Please note
+			that Hash and Randomizer must be both given in the same 
+			method call, otherwise it will be ignored.
+
+			Currently supported keys:
+
+				Class		uint32
+				Hash		array{byte}
+				Randomizer	array{byte}
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 2c03780..3647a3e 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -43,6 +43,7 @@
 #include "event.h"
 #include "error.h"
 #include "oob.h"
+#include "storage.h"
 
 #define OOB_INTERFACE	"org.bluez.OutOfBand"
 
@@ -153,6 +154,108 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *set_remote_property(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+	DBusMessageIter iter_msg, iter_dict, iter_entry, iter_variant,
+								iter_array;
+	char *addr;
+	bdaddr_t local, peer;
+	uint8_t *hash = NULL, *rand = NULL;
+	int32_t hlen, rlen;
+
+	if (!dbus_message_iter_init(msg, &iter_msg))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter_msg) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter_msg, &addr);
+
+	if (bachk(addr))
+		return btd_error_invalid_args(msg);
+
+	adapter_get_address(adapter, &local);
+	str2ba(addr, &peer);
+
+	dbus_message_iter_get_basic(&iter_msg, &addr);
+	dbus_message_iter_next(&iter_msg);
+
+	if (dbus_message_iter_get_arg_type(&iter_msg) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter_msg, &iter_dict);
+
+	for (; dbus_message_iter_get_arg_type(&iter_dict) != DBUS_TYPE_INVALID;
+					dbus_message_iter_next(&iter_dict)) {
+		char *property;
+
+		if (dbus_message_iter_get_arg_type(&iter_dict) !=
+							DBUS_TYPE_DICT_ENTRY)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter_dict, &iter_entry);
+
+		if (dbus_message_iter_get_arg_type(&iter_entry) !=
+							DBUS_TYPE_STRING)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&iter_entry, &property);
+		dbus_message_iter_next(&iter_entry);
+
+		if (dbus_message_iter_get_arg_type(&iter_entry) !=
+							DBUS_TYPE_VARIANT)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter_entry, &iter_variant);
+
+		if (g_str_equal("Class", property)) {
+			uint32_t class;
+
+			if (dbus_message_iter_get_arg_type(&iter_variant) !=
+							DBUS_TYPE_UINT32)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&iter_variant, &class);
+
+			if (write_remote_class(&local, &peer, class) < 0)
+				return btd_error_failed(msg, "Request failed");
+		} else if (g_str_equal("Hash", property)) {
+			if (dbus_message_iter_get_arg_type(&iter_variant) !=
+								DBUS_TYPE_ARRAY)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_recurse(&iter_variant, &iter_array);
+
+			dbus_message_iter_get_fixed_array(&iter_array, &hash,
+									&hlen);
+			if (hlen != 16)
+				return btd_error_invalid_args(msg);
+		} else if (g_str_equal("Randomizer", property)) {
+			if (dbus_message_iter_get_arg_type(&iter_variant) !=
+								DBUS_TYPE_ARRAY)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_recurse(&iter_variant, &iter_array);
+
+			dbus_message_iter_get_fixed_array(&iter_array, &rand,
+									&rlen);
+			if (rlen != 16)
+				return btd_error_invalid_args(msg);
+		} else {
+			error("Parameter name not recognized: %s", property);
+		}
+	}
+
+	if (rand != NULL && hash != NULL)
+		if (btd_adapter_add_remote_oob_data(adapter, &peer, hash, rand))
+			return btd_error_failed(msg,
+						"Adding remote data failed");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -177,6 +280,7 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 
 static GDBusMethodTable oob_methods[] = {
 	{"AddRemoteData",	"sayay",	"",	add_remote_data},
+	{"SetRemoteProperty",	"sa{sv}",	"",	set_remote_property},
 	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
 	{"ReadLocalData",	"",		"ayay",	read_local_data,
 						G_DBUS_METHOD_FLAG_ASYNC},
-- 
1.7.4.1

