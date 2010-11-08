Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Create __btd_error_invalid_args()
Date: Mon,  8 Nov 2010 04:29:39 -0200
Message-Id: <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DBus error handling in BlueZ is a mess. This is the first patch to unify
all DBus error handling like in ConnMan and oFono. This unifies all
.InvalidArguments errors.
---
 attrib/client.c          |   20 +++++----------
 audio/gateway.c          |    8 +----
 audio/headset.c          |   18 ++++---------
 audio/media.c            |    9 ++----
 audio/telephony-dummy.c  |   25 ++++++++------------
 audio/telephony-maemo5.c |   11 ++------
 audio/telephony-maemo6.c |   11 ++------
 audio/transport.c        |   14 +++--------
 health/hdp.c             |   58 ++++++++++++----------------------------------
 network/server.c         |    7 -----
 plugins/service.c        |    8 +-----
 serial/port.c            |    8 ------
 serial/proxy.c           |   19 ++++----------
 src/adapter.c            |   52 ++++++++++++++++++-----------------------
 src/device.c             |   22 ++++++-----------
 src/error.c              |    7 +++++
 src/error.h              |    2 +
 src/manager.c            |    7 -----
 18 files changed, 100 insertions(+), 206 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 1f2c217..cd6e401 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -190,12 +190,6 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-			"Invalid arguments in method call");
-}
-
 static inline DBusMessage *not_authorized(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
@@ -465,7 +459,7 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (l2cap_connect(prim->gatt, &gerr, TRUE) < 0) {
 		DBusMessage *reply;
@@ -499,7 +493,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	match = g_new0(struct watcher, 1);
 	match->name = g_strdup(sender);
@@ -537,7 +531,7 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
 			dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_recurse(iter, &sub);
 
@@ -586,23 +580,23 @@ static DBusMessage *set_property(DBusConnection *conn,
 	const char *property;
 
 	if (!dbus_message_iter_init(msg, &iter))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_get_basic(&iter, &property);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("Value", property))
 		return set_value(conn, msg, &sub, chr);
 
-	return invalid_args(msg);
+	return __btd_error_invalid_args(msg);
 }
 
 static GDBusMethodTable char_methods[] = {
diff --git a/audio/gateway.c b/audio/gateway.c
index 07ebdd4..ab7d310 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -494,9 +494,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID))
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid argument");
+		return __btd_error_invalid_args(msg);
 
 	name = dbus_message_get_sender(msg);
 	agent = g_new0(struct hf_agent, 1);
@@ -529,9 +527,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".InvalidArguments",
-				"Invalid argument");
+		return __btd_error_invalid_args(msg);
 
 	if (strcmp(gw->agent->path, path) != 0)
 		return g_dbus_create_error(msg,
diff --git a/audio/headset.c b/audio/headset.c
index 0763585..2cca5ca 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -180,12 +180,6 @@ struct event {
 
 static GSList *headset_callbacks = NULL;
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-			"Invalid arguments in method call");
-}
-
 static DBusHandlerResult error_not_supported(DBusConnection *conn,
 							DBusMessage *msg)
 {
@@ -2026,35 +2020,35 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 	uint16_t gain;
 
 	if (!dbus_message_iter_init(msg, &iter))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_get_basic(&iter, &property);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("SpeakerGain", property)) {
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &gain);
 		return hs_set_gain(conn, msg, data, gain,
 					HEADSET_GAIN_SPEAKER);
 	} else if (g_str_equal("MicrophoneGain", property)) {
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &gain);
 		return hs_set_gain(conn, msg, data, gain,
 					HEADSET_GAIN_MICROPHONE);
 	}
 
-	return invalid_args(msg);
+	return __btd_error_invalid_args(msg);
 }
 static GDBusMethodTable headset_methods[] = {
 	{ "Connect",		"",	"",	hs_connect,
diff --git a/audio/media.c b/audio/media.c
index b6c90f9..862cee6 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -323,18 +323,15 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_recurse(&args, &props);
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".Failed", "Invalid argument");
+		return __btd_error_invalid_args(msg);
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec,
 				&capabilities, &size) || uuid == NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Invalid argument");
+		return __btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
 				codec, capabilities, size) == FALSE)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Invalid argument");
+		return __btd_error_invalid_args(msg);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 06cb798..b56b6e7 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -35,6 +35,7 @@
 
 #include "log.h"
 #include "telephony.h"
+#include "error.h"
 
 #define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
 #define TELEPHONY_DUMMY_PATH "/org/bluez/test"
@@ -69,12 +70,6 @@ static struct indicator dummy_indicators[] =
 	{ NULL }
 };
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 void telephony_device_connected(void *telephony_device)
 {
 	DBG("telephony-dummy: device %p connected", telephony_device);
@@ -236,7 +231,7 @@ static DBusMessage *outgoing_call(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	DBG("telephony-dummy: outgoing call to %s", number);
 
@@ -261,7 +256,7 @@ static DBusMessage *incoming_call(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	DBG("telephony-dummy: incoming call to %s", number);
 
@@ -307,10 +302,10 @@ static DBusMessage *signal_strength(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &strength,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (strength > 5)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	telephony_update_indicator(dummy_indicators, "signal", strength);
 
@@ -326,10 +321,10 @@ static DBusMessage *battery_level(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &level,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (level > 5)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	telephony_update_indicator(dummy_indicators, "battchg", level);
 
@@ -346,7 +341,7 @@ static DBusMessage *roaming_status(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &roaming,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	val = roaming ? EV_ROAM_ACTIVE : EV_ROAM_INACTIVE;
 
@@ -365,7 +360,7 @@ static DBusMessage *registration_status(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &registration,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	val = registration ? EV_SERVICE_PRESENT : EV_SERVICE_NONE;
 
@@ -384,7 +379,7 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	g_free(subscriber_number);
 	subscriber_number = g_strdup(number);
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 4d0134c..0f9819c 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -38,6 +38,7 @@
 
 #include "log.h"
 #include "telephony.h"
+#include "error.h"
 
 /* SSC D-Bus definitions */
 #define SSC_DBUS_NAME  "com.nokia.phone.SSC"
@@ -1880,12 +1881,6 @@ static void csd_init(void)
 	}
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg,"org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static uint32_t get_callflag(const char *callerid_setting)
 {
 	if (callerid_setting != NULL) {
@@ -1950,7 +1945,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING,
 						&callerid_setting,
 						DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (g_str_equal(callerid_setting, "allowed") ||
 			g_str_equal(callerid_setting, "restricted") ||
@@ -1964,7 +1959,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 
 	error("telephony-maemo: invalid argument %s for method call"
 					" SetCallerId", callerid_setting);
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 }
 
 static GDBusMethodTable telephony_maemo_methods[] = {
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 72c8e36..4663b4d 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -38,6 +38,7 @@
 
 #include "log.h"
 #include "telephony.h"
+#include "error.h"
 
 /* SSC D-Bus definitions */
 #define SSC_DBUS_NAME  "com.nokia.phone.SSC"
@@ -1760,12 +1761,6 @@ static void csd_init(void)
 	}
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg,"org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static uint32_t get_callflag(const char *callerid_setting)
 {
 	if (callerid_setting != NULL) {
@@ -1830,7 +1825,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING,
 						&callerid_setting,
 						DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (g_str_equal(callerid_setting, "allowed") ||
 			g_str_equal(callerid_setting, "restricted") ||
@@ -1844,7 +1839,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 
 	error("telephony-maemo6: invalid argument %s for method call"
 					" SetCallerId", callerid_setting);
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 }
 
 static DBusMessage *clear_lastnumber(DBusConnection *conn, DBusMessage *msg,
diff --git a/audio/transport.c b/audio/transport.c
index eda46e1..0c865f7 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -93,12 +93,6 @@ struct media_transport {
 					DBusMessageIter *value);
 };
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static inline DBusMessage *error_failed(DBusMessage *msg, const char *desc)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s", desc);
@@ -549,16 +543,16 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (!dbus_message_iter_init(msg, &iter))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_get_basic(&iter, &property);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &value);
 
 	sender = dbus_message_get_sender(msg);
@@ -577,7 +571,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 
 	if (err < 0) {
 		if (err == -EINVAL)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 		return error_failed(msg, strerror(-err));
 	}
 
diff --git a/health/hdp.c b/health/hdp.c
index 1eba8e1..6c1fd98 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -321,15 +321,8 @@ static DBusMessage *manager_create_application(DBusConnection *conn,
 
 	dbus_message_iter_init(msg, &iter);
 	app = hdp_get_app_config(&iter, &err);
-	if (err) {
-		DBusMessage *reply;
-
-		reply = g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments: %s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err)
+		return __btd_error_invalid_args(msg);
 
 	name = dbus_message_get_sender(msg);
 	if (!name) {
@@ -368,11 +361,8 @@ static DBusMessage *manager_destroy_application(DBusConnection *conn,
 	GSList *l;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-						DBUS_TYPE_INVALID)){
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-	}
+						DBUS_TYPE_INVALID))
+		return __btd_error_invalid_args(msg);
 
 	l = g_slist_find_custom(applications, path, cmp_app);
 
@@ -1801,18 +1791,13 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &app_path,
 							DBUS_TYPE_STRING, &conf,
-							DBUS_TYPE_INVALID)) {
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-	}
+							DBUS_TYPE_INVALID))
+		return __btd_error_invalid_args(msg);
 
 	l = g_slist_find_custom(applications, app_path, cmp_app);
 	if (!l)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call, "
-					"no such application");
+		return __btd_error_invalid_args(msg);
+
 	app = l->data;
 
 	if (g_ascii_strcasecmp("Reliable", conf) == 0)
@@ -1822,25 +1807,16 @@ static DBusMessage *device_create_channel(DBusConnection *conn,
 	else if (g_ascii_strcasecmp("Any", conf) == 0)
 		config = HDP_NO_PREFERENCE_DC;
 	else
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
+		return __btd_error_invalid_args(msg);
 
 	if (app->role == HDP_SINK && config != HDP_NO_PREFERENCE_DC)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Configuration not valid for sinks");
+		return __btd_error_invalid_args(msg);
 
 	if (app->role == HDP_SOURCE && config == HDP_NO_PREFERENCE_DC)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Configuration not valid for sources");
+		return __btd_error_invalid_args(msg);
 
 	if (!device->fr && config == HDP_STREAMING_DC)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Configuration not valid, first "
-					"channel should be reliable");
+		return __btd_error_invalid_args(msg);
 
 	data = g_new0(struct hdp_create_dc, 1);
 	data->dev = device;
@@ -1924,17 +1900,13 @@ static DBusMessage *device_destroy_channel(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID)){
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
+		return __btd_error_invalid_args(msg);
 	}
 
 	l = g_slist_find_custom(device->channels, path, cmp_chan_path);
 	if (!l)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call, "
-					"no such channel");
+		return __btd_error_invalid_args(msg);
+
 	hdp_chan = l->data;
 	del_data = g_new0(struct hdp_tmp_dc_data, 1);
 	del_data->msg = dbus_message_ref(msg);
diff --git a/network/server.c b/network/server.c
index e6706ec..ce1fe5e 100644
--- a/network/server.c
+++ b/network/server.c
@@ -575,13 +575,6 @@ static inline DBusMessage *failed(DBusMessage *msg, const char *description)
 							"%s", description);
 }
 
-static inline DBusMessage *invalid_arguments(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-							"%s", description);
-}
-
 static void server_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct network_server *ns = user_data;
diff --git a/plugins/service.c b/plugins/service.c
index f6b9da7..6f6a275 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -339,12 +339,6 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	g_free(user_record);
 }
 
-static inline DBusMessage *invalid_arguments(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static inline DBusMessage *not_available(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
@@ -466,7 +460,7 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 
 	len = (record ? strlen(record) : 0);
 	if (len == 0)
-		return invalid_arguments(msg);
+		return __btd_error_invalid_args(msg);
 
 	user_record = find_record(serv_adapter, handle,
 				dbus_message_get_sender(msg));
diff --git a/serial/port.c b/serial/port.c
index 0398f2e..b593311 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -57,7 +57,6 @@
 #include "port.h"
 
 #define SERIAL_PORT_INTERFACE	"org.bluez.Serial"
-#define ERROR_INVALID_ARGS	"org.bluez.Error.InvalidArguments"
 #define ERROR_DOES_NOT_EXIST	"org.bluez.Error.DoesNotExist"
 
 #define MAX_OPEN_TRIES		5
@@ -243,13 +242,6 @@ static inline DBusMessage *does_not_exist(DBusMessage *msg,
 							"%s", description);
 }
 
-static inline DBusMessage *invalid_arguments(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-							"%s", description);
-}
-
 static inline DBusMessage *failed(DBusMessage *msg, const char *description)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/serial/proxy.c b/serial/proxy.c
index 3aaabf3..8e182b6 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -140,13 +140,6 @@ static inline DBusMessage *does_not_exist(DBusMessage *msg,
 							"%s", description);
 }
 
-static inline DBusMessage *invalid_arguments(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-							"%s", description);
-}
-
 static inline DBusMessage *failed(DBusMessage *msg, const char *description)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
@@ -755,17 +748,17 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 		return NULL;
 
 	if (str2speed(ratestr, &speed)  == B0)
-		return invalid_arguments(msg, "Invalid baud rate");
+		return __btd_error_invalid_args(msg);
 
 	ctrl = prx->proxy_ti.c_cflag;
 	if (set_databits(databits, &ctrl) < 0)
-		return invalid_arguments(msg, "Invalid data bits");
+		return __btd_error_invalid_args(msg);
 
 	if (set_stopbits(stopbits, &ctrl) < 0)
-		return invalid_arguments(msg, "Invalid stop bits");
+		return __btd_error_invalid_args(msg);
 
 	if (set_parity(paritystr, &ctrl) < 0)
-		return invalid_arguments(msg, "Invalid parity");
+		return __btd_error_invalid_args(msg);
 
 	prx->proxy_ti.c_cflag = ctrl;
 	prx->proxy_ti.c_cflag |= (CLOCAL | CREAD);
@@ -1057,13 +1050,13 @@ static DBusMessage *create_proxy(DBusConnection *conn,
 
 	uuid_str = bt_name2string(pattern);
 	if (!uuid_str)
-		return invalid_arguments(msg, "Invalid UUID");
+		return __btd_error_invalid_args(msg);
 
 	err = register_proxy(adapter, uuid_str, address, &proxy);
 	g_free(uuid_str);
 
 	if (err == -EINVAL)
-		return invalid_arguments(msg, "Invalid address");
+		return __btd_error_invalid_args(msg);
 	else if (err == -EALREADY)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExist",
 						"Proxy already exists");
diff --git a/src/adapter.c b/src/adapter.c
index 31014e5..cc51816 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -148,12 +148,6 @@ struct btd_adapter {
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-			"Invalid arguments in method call");
-}
-
 static inline DBusMessage *adapter_not_ready(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
@@ -1088,7 +1082,7 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 
 	if (!g_utf8_validate(name, -1, NULL)) {
 		error("Name change failed: supplied name isn't valid UTF-8");
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	}
 
 	if (strncmp(name, (char *) dev->name, MAX_NAME_LENGTH) == 0)
@@ -1535,23 +1529,23 @@ static DBusMessage *set_property(DBusConnection *conn,
 	ba2str(&adapter->bdaddr, srcaddr);
 
 	if (!dbus_message_iter_init(msg, &iter))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_get_basic(&iter, &property);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("Name", property)) {
 		const char *name;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &name);
 
 		return set_name(conn, msg, name, data);
@@ -1559,7 +1553,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		gboolean powered;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &powered);
 
@@ -1568,7 +1562,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		gboolean discoverable;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &discoverable);
 
@@ -1577,7 +1571,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		uint32_t timeout;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &timeout);
 
@@ -1586,7 +1580,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		gboolean pairable;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &pairable);
 
@@ -1595,14 +1589,14 @@ static DBusMessage *set_property(DBusConnection *conn,
 		uint32_t timeout;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &timeout);
 
 		return set_pairable_timeout(conn, msg, timeout, data);
 	}
 
-	return invalid_args(msg);
+	return __btd_error_invalid_args(msg);
 }
 
 static DBusMessage *request_session(DBusConnection *conn,
@@ -1676,7 +1670,7 @@ static DBusMessage *list_devices(DBusConnection *conn,
 	const gchar *dev_path;
 
 	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1709,10 +1703,10 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (check_address(address) < 0)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	device = adapter_find_device(adapter, address);
 	if (!device || !device_is_creating(device, NULL))
@@ -1742,10 +1736,10 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (check_address(address) < 0)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (adapter_find_device(adapter, address))
 		return g_dbus_create_error(msg,
@@ -1790,21 +1784,21 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 					DBUS_TYPE_OBJECT_PATH, &agent_path,
 					DBUS_TYPE_STRING, &capability,
 					DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (check_address(address) < 0)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 	if (adapter->agent &&
 			agent_matches(adapter->agent, sender, agent_path)) {
 		error("Refusing adapter agent usage as device specific one");
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	}
 
 	cap = parse_io_capability(capability);
 	if (cap == IO_CAPABILITY_INVALID)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	device = adapter_get_device(conn, adapter, address);
 	if (!device)
@@ -1832,7 +1826,7 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID) == FALSE)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	l = g_slist_find_custom(adapter->devices,
 			path, (GCompareFunc) device_path_cmp);
@@ -1870,7 +1864,7 @@ static DBusMessage *find_device(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	l = g_slist_find_custom(adapter->devices,
 			address, (GCompareFunc) device_address_cmp);
@@ -1918,7 +1912,7 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 
 	cap = parse_io_capability(capability);
 	if (cap == IO_CAPABILITY_INVALID)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	name = dbus_message_get_sender(msg);
 
diff --git a/src/device.c b/src/device.c
index c2b6682..ef1a910 100644
--- a/src/device.c
+++ b/src/device.c
@@ -549,12 +549,6 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	}
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static DBusMessage *set_property(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
@@ -563,22 +557,22 @@ static DBusMessage *set_property(DBusConnection *conn,
 	const char *property;
 
 	if (!dbus_message_iter_init(msg, &iter))
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 
 	dbus_message_iter_get_basic(&iter, &property);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return invalid_args(msg);
+		return __btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("Trusted", property)) {
 		dbus_bool_t value;
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &value);
 
 		return set_trust(conn, msg, value, data);
@@ -586,7 +580,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		const char *alias;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &alias);
 
 		return set_alias(conn, msg, alias, data);
@@ -594,14 +588,14 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_bool_t value;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &value);
 
 		return set_blocked(conn, msg, value, data);
 	}
 
-	return invalid_args(msg);
+	return __btd_error_invalid_args(msg);
 }
 
 static void discover_services_req_exit(DBusConnection *conn, void *user_data)
@@ -636,7 +630,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 		uuid_t uuid;
 
 		if (bt_string2uuid(&uuid, pattern) < 0)
-			return invalid_args(msg);
+			return __btd_error_invalid_args(msg);
 
 		sdp_uuid128_to_uuid(&uuid);
 
diff --git a/src/error.c b/src/error.c
index c1a2fbf..a30c050 100644
--- a/src/error.c
+++ b/src/error.c
@@ -48,3 +48,10 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
+
+DBusMessage *__btd_error_invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".InvalidArguments",
+					"Invalid arguments in method call");
+}
diff --git a/src/error.h b/src/error.h
index 49ec05e..51c094c 100644
--- a/src/error.h
+++ b/src/error.h
@@ -29,3 +29,5 @@
 
 DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 					const char *name, const char *descr);
+
+DBusMessage *__btd_error_invalid_args(DBusMessage *msg);
diff --git a/src/manager.c b/src/manager.c
index 3fad9e6..315f5c3 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -66,13 +66,6 @@ void manager_update_svc(struct btd_adapter* adapter, uint8_t svc)
 	adapter_set_service_classes(adapter, svc);
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg,
-			ERROR_INTERFACE ".InvalidArguments",
-			"Invalid arguments in method call");
-}
-
 static inline DBusMessage *no_such_adapter(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg,
-- 
1.7.3.1

