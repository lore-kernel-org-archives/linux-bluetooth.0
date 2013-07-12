Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 06/10] transport: Add microphone/speaker gains
Date: Fri, 12 Jul 2013 12:54:39 +0200
Message-Id: <1373626483-2031-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the D-Bus properties to the transport as described in the API
documentation.
---
 profiles/audio/transport.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.h |   8 +++
 2 files changed, 136 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a9b8c3b..cd2b45f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -95,6 +95,8 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;
 	uint16_t		volume;
+	char			microphone_gain;
+	char			speaker_gain;
 	transport_state_t	state;
 	struct media_transport_driver *driver;
 	void			*data;
@@ -666,6 +668,94 @@ static void set_volume(const GDBusPropertyTable *property,
 	g_dbus_pending_property_success(id);
 }
 
+static gboolean microphone_gain_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_transport *transport = data;
+
+	return transport->microphone_gain >= 0;
+}
+
+static gboolean get_microphone_gain(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&transport->microphone_gain);
+
+	return TRUE;
+}
+
+static char parse_gain(DBusMessageIter *iter, GDBusPendingPropertySet id)
+{
+	if (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_BYTE) {
+		char gain;
+
+		dbus_message_iter_get_basic(iter, &gain);
+
+		if (gain >= 0 && gain <= 15)
+			return gain;
+	}
+
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+	return -1;
+}
+
+static void set_microphone_gain(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_transport *transport = data;
+	char gain = parse_gain(iter, id);
+
+	if (gain < 0)
+		return;
+
+	if (transport->microphone_gain != gain)
+		transport->driver->set_microphone_gain(transport, gain);
+
+	transport->microphone_gain = gain;
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean speaker_gain_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_transport *transport = data;
+
+	return transport->speaker_gain >= 0;
+}
+
+static gboolean get_speaker_gain(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&transport->speaker_gain);
+
+	return TRUE;
+}
+
+static void set_speaker_gain(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_transport *transport = data;
+	char gain = parse_gain(iter, id);
+
+	if (gain < 0)
+		return;
+
+	if (transport->speaker_gain != gain)
+		transport->driver->set_speaker_gain(transport, gain);
+
+	transport->speaker_gain = gain;
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -689,6 +779,10 @@ static const GDBusPropertyTable transport_properties[] = {
 	{ "State", "s", get_state },
 	{ "Delay", "q", get_delay, NULL, delay_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "MicrophoneGain", "y", get_microphone_gain, set_microphone_gain,
+						microphone_gain_exists },
+	{ "SpeakerGain", "y", get_speaker_gain, set_speaker_gain,
+						speaker_gain_exists },
 	{ }
 };
 
@@ -851,6 +945,8 @@ struct media_transport *media_transport_create(struct audio_device *device,
 	transport->size = size;
 	transport->fd = -1;
 	transport->volume = -1;
+	transport->microphone_gain = -1;
+	transport->speaker_gain = -1;
 	transport->data = transport->driver->init(transport);
 	transport->path = g_strdup_printf("%s/fd%d",
 				device_get_path(device->btd_dev), fd++);
@@ -920,6 +1016,38 @@ void media_transport_update_volume(struct media_transport *transport,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
+void media_transport_update_microphone_gain(struct media_transport *transport,
+								char gain)
+{
+	if (transport->microphone_gain == gain)
+		return;
+
+	transport->microphone_gain = gain;
+
+	if (transport->path == NULL)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"MicrophoneGain");
+}
+
+void media_transport_update_speaker_gain(struct media_transport *transport,
+								char gain)
+{
+	if (transport->speaker_gain == gain)
+		return;
+
+	transport->speaker_gain = gain;
+
+	if (transport->path == NULL)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"SpeakerGain");
+}
+
 uint8_t media_transport_get_device_volume(struct audio_device *dev)
 {
 	GSList *l;
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index be0fcea..0fcc45b 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -33,6 +33,10 @@ struct media_transport_driver {
 						struct media_owner *owner);
 	guint (*suspend) (struct media_transport *transport,
 						struct media_owner *owner);
+	void (*set_speaker_gain) (struct media_transport *transport,
+						char gain);
+	void (*set_microphone_gain) (struct media_transport *transport,
+						char gain);
 	void (*cancel) (struct media_transport *transport, guint id);
 	GDestroyNotify destroy;
 };
@@ -50,6 +54,10 @@ void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume);
+void media_transport_update_microphone_gain(struct media_transport *transport,
+							char gain);
+void media_transport_update_speaker_gain(struct media_transport *transport,
+							char gain);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
-- 
1.8.1.4

