Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 09/13] gdbus: remove signatures from tables
Date: Thu,  3 May 2012 09:28:58 -0300
Message-Id: <1336048142-1194-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c           |   12 +++++-----
 audio/control.c           |   18 +++++++--------
 audio/device.c            |   13 +++++------
 audio/gateway.c           |   16 ++++++-------
 audio/headset.c           |   55 +++++++++++++++++++++------------------------
 audio/media.c             |    8 +++----
 audio/sink.c              |   25 +++++++++------------
 audio/source.c            |   14 +++++-------
 audio/telephony-dummy.c   |   18 +++++++--------
 audio/telephony-maemo5.c  |    2 +-
 audio/transport.c         |   10 ++++-----
 gdbus/gdbus.h             |    3 ---
 gdbus/object.c            |    2 +-
 health/hdp.c              |   24 ++++++++++----------
 input/device.c            |    9 ++++----
 network/connection.c      |    9 ++++----
 network/server.c          |    4 ++--
 plugins/dbusoob.c         |    7 +++---
 plugins/service.c         |   10 ++++-----
 proximity/monitor.c       |    6 ++---
 proximity/reporter.c      |    4 ++--
 sap/sap-dummy.c           |    8 +++----
 sap/server.c              |    6 ++---
 serial/port.c             |    6 ++---
 serial/proxy.c            |   18 +++++++--------
 src/adapter.c             |   43 ++++++++++++++++-------------------
 src/device.c              |   14 ++++++------
 src/manager.c             |   17 +++++++-------
 thermometer/thermometer.c |   14 ++++++------
 29 files changed, 187 insertions(+), 208 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index cd948c1..b15a375 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -517,10 +517,10 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 static const GDBusMethodTable char_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		"SetProperty", set_property, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
@@ -1021,17 +1021,17 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable prim_methods[] = {
 	{
-		"DiscoverCharacteristics", "", "ao", discover_char,
+		"DiscoverCharacteristics", discover_char,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.out_args = GDBUS_ARGS_INFO({ "characteristics", "ao" })
 	}, {
-		"RegisterCharacteristicsWatcher", "o", "", register_watcher,
+		"RegisterCharacteristicsWatcher", register_watcher,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"UnregisterCharacteristicsWatcher", "o", "", unregister_watcher,
+		"UnregisterCharacteristicsWatcher", unregister_watcher,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"GetProperties", "", "a{sv}", prim_get_properties,
+		"GetProperties", prim_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
 	{ }
diff --git a/audio/control.c b/audio/control.c
index 9a1e3c8..ab4ce7d 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -199,27 +199,27 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 
 static const GDBusMethodTable control_methods[] = {
 	{
-		"IsConnected", "", "b", control_is_connected,
+		"IsConnected", control_is_connected,
 		G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
 	},
 	{
-		"GetProperties", "", "a{sv}", control_get_properties,
+		"GetProperties", control_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
-	{ "VolumeUp",		"",	"",	volume_up },
-	{ "VolumeDown",		"",	"",	volume_down },
-	{ NULL, NULL, NULL, NULL }
+	{ "VolumeUp", volume_up },
+	{ "VolumeDown", volume_down },
+	{ }
 };
 
 static const GDBusSignalTable control_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
+	{ "Connected", G_DBUS_SIGNAL_FLAG_DEPRECATED},
+	{ "Disconnected", G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 static void path_unregister(void *data)
diff --git a/audio/device.c b/audio/device.c
index c849df5..7e91544 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -619,22 +619,21 @@ static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dev_methods[] = {
-	{ "Connect",		"",	"",	dev_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	dev_disconnect },
+	{ "Connect", dev_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", dev_disconnect },
 	{
-		"GetProperties", "", "a{sv}", dev_get_properties,
+		"GetProperties", dev_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
-	{ NULL, NULL, NULL, NULL }
+	{ }
 };
 
 static const GDBusSignalTable dev_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 struct audio_device *audio_device_register(DBusConnection *conn,
diff --git a/audio/gateway.c b/audio/gateway.c
index fca13e9..6b4a73d 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -713,27 +713,27 @@ done:
 }
 
 static const GDBusMethodTable gateway_methods[] = {
-	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Connect", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{
-		"GetProperties", "", "a{sv}", ag_get_properties,
+		"GetProperties", ag_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"RegisterAgent", "o", "", register_agent,
+		"RegisterAgent", register_agent,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"UnregisterAgent", "o", "", unregister_agent,
+		"UnregisterAgent", unregister_agent,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	},
-	{ NULL, NULL, NULL, NULL }
+	{ }
 };
 
 static const GDBusSignalTable gateway_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 static void path_unregister(void *data)
diff --git a/audio/headset.c b/audio/headset.c
index dd7f712..14a6866 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2058,68 +2058,65 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable headset_methods[] = {
-	{ "Connect",		"",	"",	hs_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	hs_disconnect },
+	{ "Connect", hs_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", hs_disconnect },
 	{
-		"IsConnected", "", "b", hs_is_connected,
+		"IsConnected", hs_is_connected,
 		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
 	},
-	{ "IndicateCall",	"",	"",	hs_ring },
-	{ "CancelCall",		"",	"",	hs_cancel_call },
-	{ "Play",		"",	"",	hs_play,
-						G_DBUS_METHOD_FLAG_ASYNC |
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "Stop",		"",	"",	hs_stop },
+	{ "IndicateCall", hs_ring },
+	{ "CancelCall", hs_cancel_call },
+	{ "Play", hs_play,
+		G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED },
+	{ "Stop", hs_stop },
 	{
-		"IsPlaying", "", "b", hs_is_playing,
-		G_DBUS_METHOD_FLAG_DEPRECATED,
+		"IsPlaying", hs_is_playing, G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "playing", "b" })
 	}, {
-		"GetSpeakerGain", "", "q", hs_get_speaker_gain,
+		"GetSpeakerGain", hs_get_speaker_gain,
 		G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "gain", "q" })
 	}, {
-		"GetMicrophoneGain", "", "q", hs_get_mic_gain,
+		"GetMicrophoneGain", hs_get_mic_gain,
 		G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "gain", "q" })
 	}, {
-		"SetSpeakerGain", "q", "", hs_set_speaker_gain,
+		"SetSpeakerGain", hs_set_speaker_gain,
 		G_DBUS_METHOD_FLAG_DEPRECATED,
 		.in_args = GDBUS_ARGS_INFO({ "gain", "q" })
 	}, {
-		"SetMicrophoneGain", "q", "", hs_set_mic_gain,
+		"SetMicrophoneGain", hs_set_mic_gain,
 		G_DBUS_METHOD_FLAG_DEPRECATED,
 		.in_args = GDBUS_ARGS_INFO({ "gain", "q" })
 	}, {
-		"GetProperties", "", "a{sv}", hs_get_properties,
+		"GetProperties", hs_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty", "sv", "", hs_set_property,
+		"SetProperty", hs_set_property,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL, NULL, NULL }
+	{ }
 };
 
 static const GDBusSignalTable headset_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "AnswerRequested",		""	},
-	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Connected", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Disconnected", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "AnswerRequested" },
+	{ "Stopped", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Playing", G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{
-		"SpeakerGainChanged", "q", G_DBUS_SIGNAL_FLAG_DEPRECATED,
+		"SpeakerGainChanged", G_DBUS_SIGNAL_FLAG_DEPRECATED,
 		.args = GDBUS_ARGS_INFO({ "gain", "q" })
 	},{
-		"MicrophoneGainChanged", "q", G_DBUS_SIGNAL_FLAG_DEPRECATED,
+		"MicrophoneGainChanged", G_DBUS_SIGNAL_FLAG_DEPRECATED,
 		.args = GDBUS_ARGS_INFO({ "gain", "q" })
 	},
-	{ "CallTerminated",		""	},
+	{ "CallTerminated" },
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 void headset_update(struct audio_device *dev, uint16_t svc,
diff --git a/audio/media.c b/audio/media.c
index 31f5bd3..2ad46a4 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1707,20 +1707,20 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable media_methods[] = {
 	{
-		"RegisterEndpoint", "oa{sv}", "", register_endpoint,
+		"RegisterEndpoint", register_endpoint,
 		.in_args = GDBUS_ARGS_INFO(
 				{ "endpoint", "o" },
 				{ "properties", "a{sv}" })
 	}, {
-		"UnregisterEndpoint", "o", "", unregister_endpoint,
+		"UnregisterEndpoint", unregister_endpoint,
 		.in_args = GDBUS_ARGS_INFO({ "endpoint", "o" })
 	}, {
-		"RegisterPlayer", "oa{sv}a{sv}", "", register_player,
+		"RegisterPlayer", register_player,
 		.in_args = GDBUS_ARGS_INFO(
 				{ "player", "o" }, { "properties", "a{sv}" },
 				{ "metadata", "a{sv}" })
 	}, {
-		"UnregisterPlayer", "o", "", unregister_player,
+		"UnregisterPlayer", unregister_player,
 		.in_args = GDBUS_ARGS_INFO({ "player", "o" })
 	},
 	{ },
diff --git a/audio/sink.c b/audio/sink.c
index d745f23..e2941d0 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -556,31 +556,28 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable sink_methods[] = {
-	{ "Connect",		"",	"",	sink_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	sink_disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Connect", sink_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", sink_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{
-		"IsConnected", "", "b", sink_is_connected,
-		G_DBUS_METHOD_FLAG_DEPRECATED,
+		"IsConnected", sink_is_connected, G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
 	}, {
-		"GetProperties", "", "a{sv}", sink_get_properties,
+		"GetProperties", sink_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
-	{ NULL, NULL, NULL, NULL }
+	{ }
 };
 
 static const GDBusSignalTable sink_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Connected", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Disconnected", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Playing", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Stopped", G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 static void sink_free(struct audio_device *dev)
diff --git a/audio/source.c b/audio/source.c
index e64bbd9..8dd831a 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -477,23 +477,21 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable source_methods[] = {
-	{ "Connect",		"",	"",	source_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	source_disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Connect", source_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", source_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{
-		"GetProperties", "", "a{sv}", source_get_properties,
+		"GetProperties", source_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
-	{ NULL, NULL, NULL, NULL }
+	{ }
 };
 
 static const GDBusSignalTable source_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ NULL, NULL }
+	{ }
 };
 
 static void source_free(struct audio_device *dev)
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 98bd546..5c699ab 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -380,34 +380,34 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 
 static const GDBusMethodTable dummy_methods[] = {
 	{
-		"OutgoingCall", "s", "", outgoing_call,
+		"OutgoingCall", outgoing_call,
 		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
 	}, {
-		"IncomingCall", "s", "", incoming_call,
+		"IncomingCall", incoming_call,
 		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
 	}, {
-		"CancelCall", "", "", cancel_call,
+		"CancelCall", cancel_call,
 	}, {
-		"SignalStrength", "u", "", signal_strength,
+		"SignalStrength", signal_strength,
 		.in_args = GDBUS_ARGS_INFO({ "strength", "u" })
 	}, {
-		"BatteryLevel", "u", "", battery_level,
+		"BatteryLevel", battery_level,
 		.in_args = GDBUS_ARGS_INFO({ "level", "u" })
 	}, {
-		"RoamingStatus", "b", "", roaming_status,
+		"RoamingStatus", roaming_status,
 		.in_args = GDBUS_ARGS_INFO({ "roaming", "b" })
 	}, {
-		"RegistrationStatus", "b", "", registration_status,
+		"RegistrationStatus", registration_status,
 		.in_args = GDBUS_ARGS_INFO({ "registration", "b" })
 	}, {
-		"SetSubscriberNumber","s", "", set_subscriber_number,
+		"SetSubscriberNumber", set_subscriber_number,
 		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
 	},
 	{ }
 };
 
 static const GDBusSignalTable dummy_signals[] = {
-	{ "VoiceDial",	"" },
+	{ "VoiceDial" },
 	{ }
 };
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 598ca36..1c35843 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1953,7 +1953,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable telephony_maemo_methods[] = {
 	{
-		"SetCallerId", "s", "", set_callerid, G_DBUS_METHOD_FLAG_ASYNC,
+		"SetCallerId", set_callerid, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "id", "s" })
 	},
 	{ }
diff --git a/audio/transport.c b/audio/transport.c
index ffad342..753e275 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -916,18 +916,18 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable transport_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"Acquire", "s", "hqq", acquire, G_DBUS_METHOD_FLAG_ASYNC,
+		"Acquire", acquire, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "access_type", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "fd", "h" }, { "mtu_r", "q" },
 							{ "mtu_w", "q" } )
 	}, {
-		"Release", "s", "", release, G_DBUS_METHOD_FLAG_ASYNC,
+		"Release", release, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "access_type", "s" }),
 	}, {
-		"SetProperty", "sv", "", set_property,
+		"SetProperty", set_property,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ },
@@ -935,7 +935,7 @@ static const GDBusMethodTable transport_methods[] = {
 
 static const GDBusSignalTable transport_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 610cb19..e9e8929 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -91,8 +91,6 @@ typedef struct {
 
 typedef struct {
 	const char *name;
-	const char *signature;
-	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
@@ -102,7 +100,6 @@ typedef struct {
 
 typedef struct {
 	const char *name;
-	const char *signature;
 	GDBusSignalFlags flags;
 	const GDBusArgInfo *args;
 } GDBusSignalTable;
diff --git a/gdbus/object.c b/gdbus/object.c
index db987dc..5712dcb 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -472,7 +472,7 @@ done:
 
 static const GDBusMethodTable introspect_methods[] = {
 	{
-		"Introspect", "", "s", introspect,
+		"Introspect", introspect,
 		.out_args = GDBUS_ARGS_INFO({ "xml", "s" })
 	},
 	{ }
diff --git a/health/hdp.c b/health/hdp.c
index 4284e86..9bedcb1 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -426,12 +426,12 @@ static void manager_path_unregister(gpointer data)
 
 static const GDBusMethodTable health_manager_methods[] = {
 	{
-		"CreateApplication", "a{sv}", "o", manager_create_application,
+		"CreateApplication", manager_create_application,
 		.in_args = GDBUS_ARGS_INFO({ "config", "a{sv}" }),
 		.out_args = GDBUS_ARGS_INFO({ "application", "o" })
 	},
 	{
-		"DestroyApplication", "o", "", manager_destroy_application,
+		"DestroyApplication", manager_destroy_application,
 		.in_args = GDBUS_ARGS_INFO({ "application", "o" })
 	},
 	{ NULL }
@@ -740,13 +740,13 @@ end:
 
 static const GDBusMethodTable health_channels_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", channel_get_properties,
+		"GetProperties", channel_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"Acquire", "", "h", channel_acquire, G_DBUS_METHOD_FLAG_ASYNC,
+		"Acquire", channel_acquire, G_DBUS_METHOD_FLAG_ASYNC,
 		.out_args = GDBUS_ARGS_INFO({ "fd", "h" })
 	}, {
-		"Release", "", "", channel_release
+		"Release", channel_release
 	},
 	{ NULL }
 };
@@ -2107,20 +2107,20 @@ static void health_device_destroy(void *data)
 
 static const GDBusMethodTable health_device_methods[] = {
 	{
-		"Echo", "", "b", device_echo, G_DBUS_METHOD_FLAG_ASYNC,
+		"Echo", device_echo, G_DBUS_METHOD_FLAG_ASYNC,
 		.out_args = GDBUS_ARGS_INFO({ "value", "b" })
 	}, {
-		"CreateChannel", "os", "o", device_create_channel,
+		"CreateChannel", device_create_channel,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "application", "o" },
 						{ "configuration", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "channel", "o" })
 	}, {
-		"DestroyChannel", "o", "", device_destroy_channel,
+		"DestroyChannel", device_destroy_channel,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "channel", "o" })
 	}, {
-		"GetProperties", "", "a{sv}",  device_get_properties,
+		"GetProperties", device_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
 	{ NULL }
@@ -2128,13 +2128,13 @@ static const GDBusMethodTable health_device_methods[] = {
 
 static const GDBusSignalTable health_device_signals[] = {
 	{
-		"ChannelConnected", "o",
+		"ChannelConnected",
 		.args = GDBUS_ARGS_INFO({ "channel", "o" })
 	}, {
-		"ChannelDeleted", "o",
+		"ChannelDeleted",
 		.args = GDBUS_ARGS_INFO({ "channel", "o" })
 	}, {
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ NULL }
diff --git a/input/device.c b/input/device.c
index 9b18299..35b3c32 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1020,11 +1020,10 @@ static DBusMessage *input_device_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "Connect",		"",	"",	input_device_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	input_device_disconnect	},
+	{ "Connect", input_device_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", input_device_disconnect },
 	{
-		"GetProperties", "", "a{sv}", input_device_get_properties,
+		"GetProperties", input_device_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
 	{ }
@@ -1032,7 +1031,7 @@ static const GDBusMethodTable device_methods[] = {
 
 static const GDBusSignalTable device_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/network/connection.c b/network/connection.c
index d7ec420..e77d2a1 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -554,14 +554,13 @@ static void path_unregister(void *data)
 
 static const GDBusMethodTable connection_methods[] = {
 	{
-		"Connect", "s", "s", connection_connect,
-		G_DBUS_METHOD_FLAG_ASYNC,
+		"Connect", connection_connect, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "interface_name", "" }),
 	}, {
-		"Disconnect", "", "", connection_disconnect
+		"Disconnect", connection_disconnect
 	}, {
-		"GetProperties", "", "a{sv}", connection_get_properties,
+		"GetProperties", connection_get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
 	{ }
@@ -569,7 +568,7 @@ static const GDBusMethodTable connection_methods[] = {
 
 static const GDBusSignalTable connection_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/network/server.c b/network/server.c
index 1a6dbf0..a842d4a 100644
--- a/network/server.c
+++ b/network/server.c
@@ -687,10 +687,10 @@ static void path_unregister(void *data)
 
 static const GDBusMethodTable server_methods[] = {
 	{
-		"Register", "ss", "", register_server,
+		"Register", register_server,
 		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" }, { "bridge", "s" })
 	}, {
-		"Unregister", "s", "", unregister_server,
+		"Unregister", unregister_server,
 		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" })
 	},
 	{ }
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 9ff4a30..d19b4b8 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -177,15 +177,14 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable oob_methods[] = {
 	{
-		"AddRemoteData", "sayay", "", add_remote_data,
+		"AddRemoteData", add_remote_data,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" },
 				{ "hash", "ay" }, { "randomizer", "ay" })
 	}, {
-		"RemoveRemoteData", "s", "", remove_remote_data,
+		"RemoveRemoteData", remove_remote_data,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" })
 	}, {
-		"ReadLocalData", "", "ayay", read_local_data,
-		G_DBUS_METHOD_FLAG_ASYNC,
+		"ReadLocalData", read_local_data, G_DBUS_METHOD_FLAG_ASYNC,
 		.out_args = GDBUS_ARGS_INFO({ "hash", "ay" },
 							{ "randomizer", "ay" })
 	},
diff --git a/plugins/service.c b/plugins/service.c
index b326564..78b45f3 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -698,21 +698,21 @@ done:
 
 static const GDBusMethodTable service_methods[] = {
 	{
-		"AddRecord", "s", "u", add_service_record,
+		"AddRecord", add_service_record,
 		.in_args = GDBUS_ARGS_INFO({ "record", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "handle", "u" })
 	}, {
-		"UpdateRecord", "us", "", update_service_record,
+		"UpdateRecord", update_service_record,
 		.in_args = GDBUS_ARGS_INFO({ "handle", "u" }, { "record", "s" })
 	}, {
-		"RemoveRecord", "u", "", remove_service_record,
+		"RemoveRecord", remove_service_record,
 		.in_args = GDBUS_ARGS_INFO({ "handle", "u" })
 	}, {
-		"RequestAuthorization", "su", "", request_authorization,
+		"RequestAuthorization", request_authorization,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" }, { "handle", "u"})
 	},
-	{ "CancelAuthorization",  "", "", cancel_authorization },
+	{ "CancelAuthorization", cancel_authorization },
 	{ }
 };
 
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 1382ef8..6110202 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -548,10 +548,10 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 static const GDBusMethodTable monitor_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty", "sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		"SetProperty", set_property, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
@@ -559,7 +559,7 @@ static const GDBusMethodTable monitor_methods[] = {
 
 static const GDBusSignalTable monitor_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 59595fc..ca11544 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -182,7 +182,7 @@ err:
 
 static const GDBusMethodTable reporter_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
 	{ }
@@ -190,7 +190,7 @@ static const GDBusMethodTable reporter_methods[] = {
 
 static const GDBusSignalTable reporter_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 63a7877..bb493be 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -317,15 +317,15 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable dummy_methods[] = {
 	{
-		"OngoingCall", "b", "", ongoing_call,
+		"OngoingCall", ongoing_call,
 		.in_args = GDBUS_ARGS_INFO({ "ongoing", "b" })
 	}, {
-		"MaxMessageSize", "u", "", max_msg_size,
+		"MaxMessageSize", max_msg_size,
 		.in_args = GDBUS_ARGS_INFO({ "size", "u" })
 	}, {
-		"DisconnectImmediate", "", "", disconnect_immediate,
+		"DisconnectImmediate", disconnect_immediate,
 	}, {
-		"CardStatus", "u", "", card_status,
+		"CardStatus", card_status,
 		.in_args = GDBUS_ARGS_INFO({ "status", "" })
 	},
 	{ }
diff --git a/sap/server.c b/sap/server.c
index 6a9bf92..8d14151 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1305,16 +1305,16 @@ static DBusMessage *get_properties(DBusConnection *c,
 
 static const GDBusMethodTable server_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	},
-	{"Disconnect", "", "", disconnect},
+	{"Disconnect", disconnect},
 	{ }
 };
 
 static const GDBusSignalTable server_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
diff --git a/serial/port.c b/serial/port.c
index 2be1951..afc54b6 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -569,15 +569,15 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 
 static const GDBusMethodTable port_methods[] = {
 	{
-		"Connect", "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
+		"Connect", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "tty", "s" })
 	}, {
-		"ConnectFD", "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
+		"ConnectFD", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "fd", "s" })
 	}, {
-		"Disconnect", "s", "",  port_disconnect,
+		"Disconnect", port_disconnect,
 		.in_args = GDBUS_ARGS_INFO({ "device", "s" }),
 	},
 	{ }
diff --git a/serial/proxy.c b/serial/proxy.c
index aa9ba62..5f88075 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -729,13 +729,13 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 }
 
 static const GDBusMethodTable proxy_methods[] = {
-	{ "Enable", "", "", proxy_enable },
-	{ "Disable", "", "", proxy_disable },
+	{ "Enable", proxy_enable },
+	{ "Disable", proxy_disable },
 	{
-		"GetInfo", "", "a{sv}", proxy_get_info,
+		"GetInfo", proxy_get_info,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetSerialParameters", "syys", "", proxy_set_serial_params,
+		"SetSerialParameters", proxy_set_serial_params,
 		.in_args = GDBUS_ARGS_INFO({ "rate", "s" }, { "data", "y" },
 					{ "stop", "y" }, { "parity", "s" })
 	},
@@ -1119,22 +1119,22 @@ static void manager_path_unregister(void *data)
 
 static const GDBusMethodTable manager_methods[] = {
 	{
-		"CreateProxy", "ss", "s", create_proxy,
+		"CreateProxy", create_proxy,
 		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" },
 							{ "address", "s" })
 	}, {
-		"ListProxies", "", "as", list_proxies,
+		"ListProxies", list_proxies,
 		.out_args = GDBUS_ARGS_INFO({ "paths", "as" })
 	}, {
-		"RemoveProxy", "s", "", remove_proxy,
+		"RemoveProxy", remove_proxy,
 		.in_args = GDBUS_ARGS_INFO({ "path", "s" })
 	},
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "ProxyCreated", "s", .args = GDBUS_ARGS_INFO({ "path", "s" }) },
-	{ "ProxyRemoved", "s", .args =  GDBUS_ARGS_INFO({ "path", "s" }) },
+	{ "ProxyCreated", .args = GDBUS_ARGS_INFO({ "path", "s" }) },
+	{ "ProxyRemoved", .args =  GDBUS_ARGS_INFO({ "path", "s" }) },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index d6e5e86..1e2dd02 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1661,51 +1661,46 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable adapter_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		"SetProperty", set_property, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ "RequestSession", "", "", request_session,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "ReleaseSession", "", "", release_session },
-	{ "StartDiscovery", "", "", adapter_start_discovery },
-	{ "StopDiscovery", "", "", adapter_stop_discovery,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{ "RequestSession", request_session, G_DBUS_METHOD_FLAG_ASYNC},
+	{ "ReleaseSession", release_session },
+	{ "StartDiscovery", adapter_start_discovery },
+	{ "StopDiscovery", adapter_stop_discovery, G_DBUS_METHOD_FLAG_ASYNC},
 	{
-		"ListDevices", "", "ao", list_devices,
-		G_DBUS_METHOD_FLAG_DEPRECATED,
+		"ListDevices", list_devices, G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "devices", "ao" })
 	}, {
-		"CreateDevice", "s", "o", create_device,
-		G_DBUS_METHOD_FLAG_ASYNC,
+		"CreateDevice", create_device, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "device", "o" }),
 	}, {
-		"CreatePairedDevice", "sos", "o", create_paired_device,
+		"CreatePairedDevice", create_paired_device,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" },
 				{ "agent", "o" }, { "capability", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "device", "o" })
 	}, {
-		"CancelDeviceCreation", "s", "", cancel_device_creation,
+		"CancelDeviceCreation", cancel_device_creation,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" })
 	}, {
-		"RemoveDevice", "o", "", remove_device,
-		G_DBUS_METHOD_FLAG_ASYNC,
+		"RemoveDevice", remove_device, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "device", "o" })
 	}, {
-		"FindDevice", "s", "o", find_device,
+		"FindDevice", find_device,
 		.in_args = GDBUS_ARGS_INFO({ "address", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "device", "o" })
 	}, {
-		"RegisterAgent", "os", "", register_agent,
+		"RegisterAgent", register_agent,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" },
 						{ "capability", "s" }),
 	}, {
-		"UnregisterAgent", "o", "", unregister_agent,
+		"UnregisterAgent", unregister_agent,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	},
 	{ }
@@ -1713,20 +1708,20 @@ static const GDBusMethodTable adapter_methods[] = {
 
 static const GDBusSignalTable adapter_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	}, {
-		"DeviceCreated", "o",
+		"DeviceCreated",
 		.args = GDBUS_ARGS_INFO({ "device", "o" })
 	}, {
-		"DeviceRemoved", "o",
+		"DeviceRemoved",
 		.args = GDBUS_ARGS_INFO({ "device", "o" })
 	}, {
-		"DeviceFound", "sa{sv}",
+		"DeviceFound",
 		.args = GDBUS_ARGS_INFO({ "address", "s" },
 						{ "values", "a{sv}" })
 	}, {
-		"DeviceDisappeared", "s",
+		"DeviceDisappeared",
 		.args = GDBUS_ARGS_INFO({ "address", "s" })
 	},
 	{ }
diff --git a/src/device.c b/src/device.c
index 552c202..b03e8db 100644
--- a/src/device.c
+++ b/src/device.c
@@ -879,28 +879,28 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable device_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty", "sv", "", set_property,
+		"SetProperty", set_property,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	}, {
-		"DiscoverServices", "s", "a{us}", discover_services,
+		"DiscoverServices", discover_services,
 		G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "services", "a{us}" })
 	},
-	{ "CancelDiscovery", "", "", cancel_discover },
-	{ "Disconnect", "", "", disconnect, G_DBUS_METHOD_FLAG_ASYNC},
+	{ "CancelDiscovery", cancel_discover },
+	{ "Disconnect", disconnect, G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
-	{ "DisconnectRequested", "" },
+	{ "DisconnectRequested" },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index 002118b..1419233 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -198,18 +198,17 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 static const GDBusMethodTable manager_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"DefaultAdapter", "", "o", default_adapter,
+		"DefaultAdapter", default_adapter,
 		.out_args = GDBUS_ARGS_INFO({ "adapter", "o" })
 	}, {
-		"FindAdapter", "s", "o", find_adapter,
+		"FindAdapter", find_adapter,
 		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
 		.out_args = GDBUS_ARGS_INFO({ "adapter", "o" })
 	}, {
-		"ListAdapters", "", "ao", list_adapters,
-		G_DBUS_METHOD_FLAG_DEPRECATED,
+		"ListAdapters", list_adapters, G_DBUS_METHOD_FLAG_DEPRECATED,
 		.out_args = GDBUS_ARGS_INFO({ "adapters", "ao" })
 	},
 	{ }
@@ -217,16 +216,16 @@ static const GDBusMethodTable manager_methods[] = {
 
 static const GDBusSignalTable manager_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	}, {
-		"AdapterAdded", "o",
+		"AdapterAdded",
 		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
 	}, {
-		"AdapterRemoved", "o",
+		"AdapterRemoved",
 		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
 	}, {
-		"DefaultAdapterChanged", "o",
+		"DefaultAdapterChanged",
 		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
 	},
 	{ }
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 137b712..e975101 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -961,22 +961,22 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable thermometer_methods[] = {
 	{
-		"GetProperties", "", "a{sv}", get_properties,
+		"GetProperties", get_properties,
 		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
 	}, {
-		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		"SetProperty", set_property, G_DBUS_METHOD_FLAG_ASYNC,
 		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	}, {
-		"RegisterWatcher", "o", "", register_watcher,
+		"RegisterWatcher", register_watcher,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"UnregisterWatcher", "o", "", unregister_watcher,
+		"UnregisterWatcher", unregister_watcher,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"EnableIntermediateMeasurement", "o", "", enable_intermediate,
+		"EnableIntermediateMeasurement", enable_intermediate,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	}, {
-		"DisableIntermediateMeasurement","o", "", disable_intermediate,
+		"DisableIntermediateMeasurement", disable_intermediate,
 		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
 	},
 	{ }
@@ -984,7 +984,7 @@ static const GDBusMethodTable thermometer_methods[] = {
 
 static const GDBusSignalTable thermometer_signals[] = {
 	{
-		"PropertyChanged", "sv",
+		"PropertyChanged",
 		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
 	},
 	{ }
-- 
1.7.10

