Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] sink: Remove deprecated code
Date: Tue,  9 Oct 2012 18:03:53 +0200
Message-Id: <1349798633-28071-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349798633-28071-1-git-send-email-luiz.dentz@gmail.com>
References: <1349798633-28071-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remove decrecated properties and signals
---
 audio/sink.c      | 52 ----------------------------------------------------
 doc/audio-api.txt | 29 +----------------------------
 2 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 0628fd2..d45185c 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -148,15 +148,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		if (sink->state != SINK_STATE_CONNECTING) {
-			gboolean value = FALSE;
-			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
-					AUDIO_SINK_INTERFACE, "Disconnected",
-					DBUS_TYPE_INVALID);
-			emit_property_changed(dev->path,
-					AUDIO_SINK_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &value);
-		}
 		sink_set_state(dev, SINK_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
@@ -189,7 +180,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	DBusConnection *conn = btd_get_dbus_connection();
 	struct audio_device *dev = user_data;
 	struct sink *sink = dev->sink;
-	gboolean value;
 
 	if (err)
 		return;
@@ -216,38 +206,9 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		sink->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
-		if (old_state == AVDTP_STATE_CONFIGURED &&
-				sink->state == SINK_STATE_CONNECTING) {
-			value = TRUE;
-			g_dbus_emit_signal(conn, dev->path,
-						AUDIO_SINK_INTERFACE,
-						"Connected",
-						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->path,
-						AUDIO_SINK_INTERFACE,
-						"Connected",
-						DBUS_TYPE_BOOLEAN, &value);
-		} else if (old_state == AVDTP_STATE_STREAMING) {
-			value = FALSE;
-			g_dbus_emit_signal(conn, dev->path,
-						AUDIO_SINK_INTERFACE,
-						"Stopped",
-						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->path,
-						AUDIO_SINK_INTERFACE,
-						"Playing",
-						DBUS_TYPE_BOOLEAN, &value);
-		}
 		sink_set_state(dev, SINK_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
-		value = TRUE;
-		g_dbus_emit_signal(conn, dev->path,
-					AUDIO_SINK_INTERFACE, "Playing",
-					DBUS_TYPE_INVALID);
-		emit_property_changed(dev->path,
-					AUDIO_SINK_INTERFACE, "Playing",
-					DBUS_TYPE_BOOLEAN, &value);
 		sink_set_state(dev, SINK_STATE_PLAYING);
 		break;
 	case AVDTP_STATE_CONFIGURED:
@@ -505,7 +466,6 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	const char *state;
-	gboolean value;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -518,14 +478,6 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	/* Playing */
-	value = (sink->stream_state == AVDTP_STATE_STREAMING);
-	dict_append_entry(&dict, "Playing", DBUS_TYPE_BOOLEAN, &value);
-
-	/* Connected */
-	value = (sink->stream_state >= AVDTP_STATE_CONFIGURED);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
-
 	/* State */
 	state = state2str(sink->state);
 	if (state)
@@ -546,10 +498,6 @@ static const GDBusMethodTable sink_methods[] = {
 };
 
 static const GDBusSignalTable sink_signals[] = {
-	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Playing", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Stopped", NULL) },
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index ca430fc..72129fc 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -200,24 +200,7 @@ Methods		void Connect()
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 
-Signals		void Connected() {deprecated}
-
-			Sent when a successful connection has been made to the
-			remote A2DP Sink
-
-		void Disconnected() {deprecated}
-
-			Sent when the device has been disconnected from.
-
-		void Playing() {deprecated}
-
-			Sent when a stream with remote device is started.
-
-		void Stopped() {deprecated}
-
-			Sent when a stream with remote device is suspended.
-
-		PropertyChanged(string name, variant value)
+Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
 			property.
@@ -247,16 +230,6 @@ properties	string State [readonly]
 			"playing" -> "disconnected"
 				Disconnected from the remote device
 
-		boolean Connected [readonly]
-
-			Indicates if a stream is setup to a A2DP sink on
-			the remote device.
-
-		boolean Playing  [readonly]
-
-			Indicates if a stream is active to a A2DP sink on
-			the remote device.
-
 AudioSource hierarchy
 =====================
 
-- 
1.7.11.4

