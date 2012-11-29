Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] media: Convert target MediaTransport interface to use D-Bus Properties
Date: Thu, 29 Nov 2012 11:06:34 +0200
Message-Id: <1354179996-17019-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/media.c     |   3 +-
 profiles/audio/transport.c | 229 ++++++++++++++++++++-------------------------
 2 files changed, 102 insertions(+), 130 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f2fba7b..2041d23 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -370,6 +370,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 					void *user_data,
 					GDestroyNotify destroy)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *msg;
 	const char *path;
 	DBusMessageIter iter;
@@ -401,7 +402,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	path = media_transport_get_path(transport);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	transport_get_properties(transport, &iter);
+	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport", &iter);
 
 	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bd8b203..d8116fd 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,13 +116,6 @@ struct media_transport {
 					struct media_owner *owner);
 	void			(*cancel) (struct media_transport *transport,
 								guint id);
-	void			(*get_properties) (
-					struct media_transport *transport,
-					DBusMessageIter *dict);
-	int			(*set_property) (
-					struct media_transport *transport,
-					const char *property,
-					DBusMessageIter *value);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -200,9 +193,10 @@ static void transport_set_state(struct media_transport *transport,
 	str = state2str(state);
 
 	if (g_strcmp0(str, state2str(old_state)) != 0)
-		emit_property_changed(transport->path,
-					MEDIA_TRANSPORT_INTERFACE, "State",
-					DBUS_TYPE_STRING, &str);
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"State");
 }
 
 void media_transport_destroy(struct media_transport *transport)
@@ -647,156 +641,133 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static int set_property_a2dp(struct media_transport *transport,
-						const char *property,
-						DBusMessageIter *value)
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct a2dp_transport *a2dp = transport->data;
+	struct media_transport *transport = data;
+	const char *path = device_get_path(transport->device->btd_dev);
 
-	if (g_strcmp0(property, "Delay") == 0) {
-		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
-			return -EINVAL;
-		dbus_message_iter_get_basic(value, &a2dp->delay);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-		/* FIXME: send new delay */
-		return 0;
-	} else if (g_strcmp0(property, "Volume") == 0) {
-		uint16_t volume;
+	return TRUE;
+}
 
-		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
-			return -EINVAL;
+static gboolean get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	const char *uuid = media_endpoint_get_uuid(transport->endpoint);
 
-		dbus_message_iter_get_basic(value, &volume);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
-		if (volume > 127)
-			return -EINVAL;
+	return TRUE;
+}
 
-		if (a2dp->volume == volume)
-			return 0;
+static gboolean get_codec(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	uint8_t codec = media_endpoint_get_codec(transport->endpoint);
 
-		return avrcp_set_volume(transport->device, volume);
-	}
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &codec);
 
-	return -EINVAL;
+	return TRUE;
 }
 
-static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static gboolean get_configuration(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	DBusMessageIter iter;
-	DBusMessageIter value;
-	const char *property, *sender;
-	GSList *l;
-	int err;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
+	DBusMessageIter array;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &property);
-	dbus_message_iter_next(&iter);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
-	dbus_message_iter_recurse(&iter, &value);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&transport->configuration,
+						transport->size);
 
-	sender = dbus_message_get_sender(msg);
-	err = -EINVAL;
+	dbus_message_iter_close_container(iter, &array);
 
-	/* Check if sender has acquired the transport */
-	for (l = transport->owners; l; l = l->next) {
-		struct media_owner *owner = l->data;
+	return TRUE;
+}
 
-		if (g_strcmp0(owner->name, sender) == 0) {
-			err = transport->set_property(transport, property,
-								&value);
-			break;
-		}
-	}
+static gboolean get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	const char *state = state2str(transport->state);
 
-	if (err < 0) {
-		if (err == -EINVAL)
-			return btd_error_invalid_args(msg);
-		return btd_error_failed(msg, strerror(-err));
-	}
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &state);
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	return TRUE;
 }
 
-static void get_properties_a2dp(struct media_transport *transport,
-						DBusMessageIter *dict)
+static gboolean delay_exists(const GDBusPropertyTable *property, void *data)
 {
+	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
 
-	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &a2dp->delay);
-
-	if (a2dp->volume <= 127)
-		dict_append_entry(dict, "Volume", DBUS_TYPE_UINT16,
-							&a2dp->volume);
+	return a2dp->delay != 0;
 }
 
-void transport_get_properties(struct media_transport *transport,
-							DBusMessageIter *iter)
+static gboolean get_delay(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	DBusMessageIter dict;
-	const char *uuid;
-	uint8_t codec;
-	const char *state;
-	const char *path;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	struct media_transport *transport = data;
+	struct a2dp_transport *a2dp = transport->data;
 
-	/* Device */
-	path = device_get_path(transport->device->btd_dev);
-	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &a2dp->delay);
 
-	uuid = media_endpoint_get_uuid(transport->endpoint);
-	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
+	return TRUE;
+}
 
-	codec = media_endpoint_get_codec(transport->endpoint);
-	dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &codec);
+static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+	struct a2dp_transport *a2dp = transport->data;
 
-	dict_append_array(&dict, "Configuration", DBUS_TYPE_BYTE,
-				&transport->configuration, transport->size);
+	return a2dp->volume <= 127;
+}
 
-	/* State */
-	state = state2str(transport->state);
-	dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
+static gboolean get_volume(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct a2dp_transport *a2dp = transport->data;
 
-	if (transport->get_properties)
-		transport->get_properties(transport, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &a2dp->volume);
 
-	dbus_message_iter_close_container(iter, &dict);
+	return TRUE;
 }
 
-static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
-					void *data)
+static void set_volume(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
 {
 	struct media_transport *transport = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
+	struct a2dp_transport *a2dp = transport->data;
+	uint16_t volume;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &volume);
 
-	dbus_message_iter_init_append(reply, &iter);
+	if (volume > 127)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
-	transport_get_properties(transport, &iter);
+	if (a2dp->volume != volume)
+		avrcp_set_volume(transport->device, volume);
 
-	return reply;
+	g_dbus_pending_property_success(id);
 }
 
 static const GDBusMethodTable transport_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			GDBUS_ARGS({ "access_type", "s" }),
 			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
@@ -805,15 +776,17 @@ static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Release",
 			GDBUS_ARGS({ "access_type", "s" }), NULL,
 			release ) },
-	{ GDBUS_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
-			NULL, set_property) },
 	{ },
 };
 
-static const GDBusSignalTable transport_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable transport_properties[] = {
+	{ "Device", "o", get_device },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "Configuration", "ay", get_configuration },
+	{ "State", "s", get_state },
+	{ "Delay", "q", get_delay, NULL, delay_exists },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
 };
 
@@ -932,8 +905,6 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 		transport->resume = resume_a2dp;
 		transport->suspend = suspend_a2dp;
 		transport->cancel = cancel_a2dp;
-		transport->get_properties = get_properties_a2dp;
-		transport->set_property = set_property_a2dp;
 		transport->data = a2dp;
 		transport->destroy = destroy_a2dp;
 
@@ -950,7 +921,7 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				transport->path, MEDIA_TRANSPORT_INTERFACE,
-				transport_methods, transport_signals, NULL,
+				transport_methods, NULL, transport_properties,
 				transport, media_transport_free) == FALSE) {
 		error("Could not register transport %s", transport->path);
 		goto fail;
@@ -979,9 +950,9 @@ void media_transport_update_delay(struct media_transport *transport,
 
 	a2dp->delay = delay;
 
-	emit_property_changed(transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "Delay",
-				DBUS_TYPE_UINT16, &a2dp->delay);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "Delay");
 }
 
 struct audio_device *media_transport_get_dev(struct media_transport *transport)
@@ -1000,7 +971,7 @@ void media_transport_update_volume(struct media_transport *transport,
 
 	a2dp->volume = volume;
 
-	emit_property_changed(transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "Volume",
-				DBUS_TYPE_UINT16, &a2dp->volume);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
-- 
1.7.11.7

