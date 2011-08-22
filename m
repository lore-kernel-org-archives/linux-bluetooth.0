Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH BlueZ v2 2/3] Add support for OOB data in SetRemoteProperties
Date: Mon, 22 Aug 2011 13:39:15 +0200
Message-Id: <1314013156-17328-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314013156-17328-1-git-send-email-bulislaw@linux.com>
References: <1314013156-17328-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now its possible to exchange OOB simple pairing data through DBus API
method with other device properties.
---
 doc/oob-api.txt   |    5 ++++-
 plugins/dbusoob.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 0324758..500ef15 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -41,11 +41,14 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
 
 			This method set new properties for device with specified
 			address, to be used when device is created.
-			On success DeviceFound signal will be emitted.
+			On success DeviceFound signal will be emitted (except
+			situations when only hash and randomizer is supplied).
 
 			Currently supported keys:
 
 				Class		uint32
+				Hash		array{byte}
+				Randomizer	array{byte}
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 94aff72..bbe1b1f 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -58,6 +58,8 @@ struct oob_remote_parameters {
 	const char *address;
 	uint32_t class;
 	gboolean device_found;
+	uint8_t *hash;
+	uint8_t *randomizer;
 };
 
 static GSList *oob_requests = NULL;
@@ -217,6 +219,42 @@ static void set_class(struct oob_remote_parameters *params)
 	params->device_found = TRUE;
 }
 
+static DBusMessage *parse_oob_data(DBusMessageIter *value, uint8_t **data,
+							DBusMessage *msg)
+{
+	DBusMessageIter array_iter;
+	int32_t len;
+	uint8_t *tmp;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(value, &array_iter);
+
+	dbus_message_iter_get_fixed_array(&array_iter, &tmp, &len);
+
+	if (len != 16)
+		return btd_error_invalid_args(msg);
+
+	*data = tmp;
+
+	return NULL;
+}
+
+static void set_oob_data(struct btd_adapter *adapter,
+				struct oob_remote_parameters *parameters)
+{
+	if (parameters->hash == NULL || parameters->randomizer == NULL) {
+		error("OOB data incomplete");
+
+		return;
+	}
+
+	if (btd_adapter_add_remote_oob_data(adapter, &parameters->peer,
+				parameters->hash, parameters->randomizer))
+		error("Adding remote OOB data failed");
+}
+
 static DBusMessage *parse_property(const char *property,
 				DBusMessageIter *value, DBusMessage *msg,
 				struct oob_remote_parameters *params)
@@ -224,6 +262,12 @@ static DBusMessage *parse_property(const char *property,
 	if (g_str_equal("Class", property))
 		return parse_class(value, params, msg);
 
+	if (g_str_equal("Hash", property))
+		return parse_oob_data(value, &params->hash, msg);
+
+	if (g_str_equal("Randomizer", property))
+		return parse_oob_data(value, &params->randomizer, msg);
+
 	return NULL;
 }
 
@@ -233,6 +277,9 @@ static void set_properties(struct btd_adapter *adapter,
 	if (params->class != 0)
 		set_class(params);
 
+	if (parameters->hash != NULL && parameters->randomizer != NULL)
+		set_oob_data(adapter, params);
+
 	if (params->device_found)
 		emit_device_found(adapter_get_path(adapter), params);
 }
-- 
1.7.4.1

