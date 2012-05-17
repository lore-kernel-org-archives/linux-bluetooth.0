Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 07/15] Convert GDBus methods to use macro helpers
Date: Thu, 17 May 2012 15:20:04 -0300
Message-Id: <1337278812-4837-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With these macro helpers we can separate in/out arguments and use their
own vector.
---
 attrib/client.c           |   28 ++++++++++------
 audio/control.c           |   24 ++++++++------
 audio/device.c            |   16 +++++----
 audio/gateway.c           |   21 +++++++-----
 audio/headset.c           |   77 ++++++++++++++++++++++++------------------
 audio/media.c             |   15 ++++++---
 audio/sink.c              |   30 +++++++++--------
 audio/source.c            |   17 +++++-----
 audio/telephony-dummy.c   |   32 +++++++++++++-----
 audio/telephony-maemo5.c  |    5 +--
 audio/transport.c         |   23 +++++++++----
 health/hdp.c              |   57 ++++++++++++++++++++-----------
 input/device.c            |   14 +++++---
 network/connection.c      |   14 +++++---
 network/server.c          |    8 +++--
 plugins/dbusoob.c         |   17 +++++++---
 plugins/service.c         |   21 ++++++++----
 proximity/monitor.c       |   12 ++++---
 proximity/reporter.c      |    7 ++--
 sap/sap-dummy.c           |   15 ++++++---
 sap/server.c              |    9 +++--
 serial/port.c             |   12 +++++--
 serial/proxy.c            |   31 ++++++++++++-----
 src/adapter.c             |   81 ++++++++++++++++++++++++++++++---------------
 src/device.c              |   24 +++++++++-----
 src/manager.c             |   30 ++++++++++++-----
 thermometer/thermometer.c |   28 +++++++++++-----
 27 files changed, 435 insertions(+), 233 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2179f63..df1496f 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -516,9 +516,12 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable char_methods[] = {
-	{ "GetProperties",	"",	"a{sv}", get_properties },
-	{ "SetProperty",	"sv",	"",	set_property,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
 	{ }
 };
 
@@ -1016,13 +1019,18 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable prim_methods[] = {
-	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
-					G_DBUS_METHOD_FLAG_ASYNC	},
-	{ "RegisterCharacteristicsWatcher",	"o", "",
-						register_watcher	},
-	{ "UnregisterCharacteristicsWatcher",	"o", "",
-						unregister_watcher	},
-	{ "GetProperties",	"",	"a{sv}",prim_get_properties	},
+	{ _GDBUS_ASYNC_METHOD("DiscoverCharacteristics", "", "ao",
+			NULL, GDBUS_ARGS({ "characteristics", "ao" }),
+			discover_char) },
+	{ _GDBUS_METHOD("RegisterCharacteristicsWatcher", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			register_watcher) },
+	{ _GDBUS_METHOD("UnregisterCharacteristicsWatcher", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_watcher) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			prim_get_properties) },
 	{ }
 };
 
diff --git a/audio/control.c b/audio/control.c
index da23535..71c82eb 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -198,19 +198,23 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable control_methods[] = {
-	{ "IsConnected",	"",	"b",	control_is_connected,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",control_get_properties },
-	{ "VolumeUp",		"",	"",	volume_up },
-	{ "VolumeDown",		"",	"",	volume_down },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("IsConnected", "", "b",
+				NULL, GDBUS_ARGS({ "connected", "b" }),
+				control_is_connected) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				control_get_properties) },
+	{ _GDBUS_METHOD("VolumeUp", "", "", NULL, NULL, volume_up) },
+	{ _GDBUS_METHOD("VolumeDown", "", "", NULL, NULL, volume_down) },
+	{ }
 };
 
 static const GDBusSignalTable control_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "PropertyChanged",		"sv"	},
-	{ NULL, NULL }
+	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 static void path_unregister(void *data)
diff --git a/audio/device.c b/audio/device.c
index ac00f1d..e4ee4e3 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -619,16 +619,18 @@ static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dev_methods[] = {
-	{ "Connect",		"",	"",	dev_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	dev_disconnect },
-	{ "GetProperties",	"",	"a{sv}",dev_get_properties },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, dev_connect) },
+	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, dev_disconnect) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+		NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+		dev_get_properties) },
+	{ }
 };
 
 static const GDBusSignalTable dev_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ NULL, NULL }
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 struct audio_device *audio_device_register(DBusConnection *conn,
diff --git a/audio/gateway.c b/audio/gateway.c
index 9194a7c..0892036 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -713,17 +713,22 @@ done:
 }
 
 static const GDBusMethodTable gateway_methods[] = {
-	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties", "", "a{sv}", ag_get_properties },
-	{ "RegisterAgent", "o", "", register_agent },
-	{ "UnregisterAgent", "o", "", unregister_agent },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, ag_connect) },
+	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, ag_disconnect) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			ag_get_properties) },
+	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL, register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
+	{ }
 };
 
 static const GDBusSignalTable gateway_signals[] = {
-	{ "PropertyChanged", "sv" },
-	{ NULL, NULL }
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 static void path_unregister(void *data)
diff --git a/audio/headset.c b/audio/headset.c
index ebe9a7c..22a26bd 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2058,42 +2058,53 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable headset_methods[] = {
-	{ "Connect",		"",	"",	hs_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	hs_disconnect },
-	{ "IsConnected",	"",	"b",	hs_is_connected },
-	{ "IndicateCall",	"",	"",	hs_ring },
-	{ "CancelCall",		"",	"",	hs_cancel_call },
-	{ "Play",		"",	"",	hs_play,
-						G_DBUS_METHOD_FLAG_ASYNC |
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "Stop",		"",	"",	hs_stop },
-	{ "IsPlaying",		"",	"b",	hs_is_playing,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetSpeakerGain",	"",	"q",	hs_get_speaker_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetMicrophoneGain",	"",	"q",	hs_get_mic_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetSpeakerGain",	"q",	"",	hs_set_speaker_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetMicrophoneGain",	"q",	"",	hs_set_mic_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",hs_get_properties },
-	{ "SetProperty",	"sv",	"",	hs_set_property },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, hs_connect) },
+	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, hs_disconnect) },
+	{ _GDBUS_METHOD("IsConnected", "", "b",
+			NULL, GDBUS_ARGS({ "connected", "b" }),
+			hs_is_connected) },
+	{ _GDBUS_METHOD("IndicateCall", "", "", NULL, NULL, hs_ring) },
+	{ _GDBUS_METHOD("CancelCall", "", "", NULL, NULL, hs_cancel_call) },
+	{ _GDBUS_DEPRECATED_ASYNC_METHOD("Play", "", "", NULL, NULL, hs_play) },
+	{ _GDBUS_METHOD("Stop", "", "", NULL, NULL, hs_stop) },
+	{ _GDBUS_DEPRECATED_METHOD("IsPlaying", "", "b",
+					NULL, GDBUS_ARGS({ "playing", "b" }),
+					hs_is_playing) },
+	{ _GDBUS_DEPRECATED_METHOD("GetSpeakerGain", "", "q",
+					NULL, GDBUS_ARGS({ "gain", "q" }),
+					hs_get_speaker_gain) },
+	{ _GDBUS_DEPRECATED_METHOD("GetMicrophoneGain", "", "q",
+					NULL, GDBUS_ARGS({ "gain", "q" }),
+					hs_get_mic_gain) },
+	{ _GDBUS_DEPRECATED_METHOD("SetSpeakerGain", "q", "",
+					GDBUS_ARGS({ "gain", "q" }), NULL,
+					hs_set_speaker_gain) },
+	{ _GDBUS_DEPRECATED_METHOD("SetMicrophoneGain", "q", "",
+					GDBUS_ARGS({ "gain", "q" }), NULL,
+					hs_set_mic_gain) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			hs_get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			hs_set_property) },
+	{ }
 };
 
 static const GDBusSignalTable headset_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "AnswerRequested",		""	},
-	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "SpeakerGainChanged",		"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "MicrophoneGainChanged",	"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "CallTerminated",		""	},
-	{ "PropertyChanged",		"sv"	},
-	{ NULL, NULL }
+	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("AnswerRequested", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Stopped", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Playing", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("SpeakerGainChanged", "q",
+						GDBUS_ARGS({ "gain", "q" })) },
+	{ _GDBUS_DEPRECATED_SIGNAL("MicrophoneGainChanged", "q",
+						GDBUS_ARGS({ "gain", "q" })) },
+	{ _GDBUS_SIGNAL("CallTerminated", "", NULL) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 void headset_update(struct audio_device *dev, uint16_t svc,
diff --git a/audio/media.c b/audio/media.c
index 7a83fbd..0fbeb8a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1791,10 +1791,17 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable media_methods[] = {
-	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
-	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
-	{ "RegisterPlayer",	"oa{sv}a{sv}","",	register_player },
-	{ "UnregisterPlayer",	"o",		"",	unregister_player },
+	{ _GDBUS_METHOD("RegisterEndpoint", "oa{sv}", "",
+		GDBUS_ARGS({ "endpoint", "o" }, { "properties", "a{sv}" }),
+		NULL, register_endpoint) },
+	{ _GDBUS_METHOD("UnregisterEndpoint", "o", "",
+		GDBUS_ARGS({ "endpoint", "o" }), NULL, unregister_endpoint) },
+	{ _GDBUS_METHOD("RegisterPlayer", "oa{sv}a{sv}", "",
+		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" },
+						{ "metadata", "a{sv}" }),
+		NULL, register_player) },
+	{ _GDBUS_METHOD("UnregisterPlayer", "o", "",
+		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
 	{ },
 };
 
diff --git a/audio/sink.c b/audio/sink.c
index fe4dd4b..f9b934b 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -556,23 +556,25 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable sink_methods[] = {
-	{ "Connect",		"",	"",	sink_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	sink_disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "IsConnected",	"",	"b",	sink_is_connected,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",sink_get_properties },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, sink_connect) },
+	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, sink_disconnect) },
+	{ _GDBUS_DEPRECATED_METHOD("IsConnected", "", "b",
+			NULL, GDBUS_ARGS({ "connected", "b" }),
+			sink_is_connected) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				sink_get_properties) },
+	{ }
 };
 
 static const GDBusSignalTable sink_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "PropertyChanged",		"sv"	},
-	{ NULL, NULL }
+	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Playing", "", NULL) },
+	{ _GDBUS_DEPRECATED_SIGNAL("Stopped", "", NULL) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 static void sink_free(struct audio_device *dev)
diff --git a/audio/source.c b/audio/source.c
index 04bf131..2724358 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -477,17 +477,18 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable source_methods[] = {
-	{ "Connect",		"",	"",	source_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	source_disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties",	"",	"a{sv}",source_get_properties },
-	{ NULL, NULL, NULL, NULL }
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, source_connect) },
+	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, source_disconnect) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				source_get_properties) },
+	{ }
 };
 
 static const GDBusSignalTable source_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ NULL, NULL }
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 static void source_free(struct audio_device *dev)
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 1885b4a..0e488dc 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -379,19 +379,33 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 }
 
 static const GDBusMethodTable dummy_methods[] = {
-	{ "OutgoingCall",	"s",	"",	outgoing_call		},
-	{ "IncomingCall",	"s",	"",	incoming_call		},
-	{ "CancelCall",		"",	"",	cancel_call		},
-	{ "SignalStrength",	"u",	"",	signal_strength		},
-	{ "BatteryLevel",	"u",	"",	battery_level		},
-	{ "RoamingStatus",	"b",	"",	roaming_status		},
-	{ "RegistrationStatus",	"b",	"",	registration_status	},
-	{ "SetSubscriberNumber","s",	"",	set_subscriber_number	},
+	{ _GDBUS_METHOD("OutgoingCall", "s", "",
+			GDBUS_ARGS({ "number", "s" }), NULL,
+			outgoing_call) },
+	{ _GDBUS_METHOD("IncomingCall", "s", "",
+			GDBUS_ARGS({ "number", "s" }), NULL,
+			incoming_call) },
+	{ _GDBUS_METHOD("CancelCall", "", "", NULL, NULL, cancel_call) },
+	{ _GDBUS_METHOD("SignalStrength", "u", "",
+			GDBUS_ARGS({ "strength", "u" }), NULL,
+			signal_strength) },
+	{ _GDBUS_METHOD("BatteryLevel", "u", "",
+			GDBUS_ARGS({ "level", "u" }), NULL,
+			battery_level) },
+	{ _GDBUS_METHOD("RoamingStatus", "b", "",
+			GDBUS_ARGS({ "roaming", "b" }), NULL,
+			roaming_status) },
+	{ _GDBUS_METHOD("RegistrationStatus", "b", "",
+			GDBUS_ARGS({ "registration", "b" }), NULL,
+			registration_status) },
+	{ _GDBUS_METHOD("SetSubscriberNumber","s", "",
+			GDBUS_ARGS({ "number", "s" }), NULL,
+			set_subscriber_number) },
 	{ }
 };
 
 static const GDBusSignalTable dummy_signals[] = {
-	{ "VoiceDial",	"" },
+	{ _GDBUS_SIGNAL("VoiceDial", "", NULL) },
 	{ }
 };
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 6ab43b4..a03ba09 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1952,8 +1952,9 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable telephony_maemo_methods[] = {
-	{"SetCallerId",		"s",	"",	set_callerid,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{ _GDBUS_ASYNC_METHOD("SetCallerId", "s", "",
+				GDBUS_ARGS({ "id", "s" }), NULL,
+				set_callerid) },
 	{ }
 };
 
diff --git a/audio/transport.c b/audio/transport.c
index 7223f38..f2a512a 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -915,17 +915,26 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable transport_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "Acquire",		"s",	"hqq",		acquire,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "Release",		"s",	"",		release,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "SetProperty",	"sv",	"",		set_property },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Acquire", "s", "hqq",
+			GDBUS_ARGS({ "access_type", "s" }),
+			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
+							{ "mtu_w", "q" } ),
+			acquire) },
+	{ _GDBUS_ASYNC_METHOD("Release", "s", "",
+			GDBUS_ARGS({ "access_type", "s" }), NULL,
+			release ) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
+			NULL, set_property) },
 	{ },
 };
 
 static const GDBusSignalTable transport_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/health/hdp.c b/health/hdp.c
index 3b1ea49..6dabbff 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -425,9 +425,14 @@ static void manager_path_unregister(gpointer data)
 }
 
 static const GDBusMethodTable health_manager_methods[] = {
-	{"CreateApplication", "a{sv}", "o", manager_create_application},
-	{"DestroyApplication", "o", "", manager_destroy_application},
-	{ NULL }
+	{ _GDBUS_METHOD("CreateApplication", "a{sv}", "o",
+			GDBUS_ARGS({ "config", "a{sv}" }),
+			GDBUS_ARGS({ "application", "o" }),
+			manager_create_application) },
+	{ _GDBUS_METHOD("DestroyApplication", "o", "",
+			GDBUS_ARGS({ "application", "o" }), NULL,
+			manager_destroy_application) },
+	{ }
 };
 
 static DBusMessage *channel_get_properties(DBusConnection *conn,
@@ -732,11 +737,14 @@ end:
 }
 
 static const GDBusMethodTable health_channels_methods[] = {
-	{"GetProperties","",	"a{sv}",	channel_get_properties },
-	{"Acquire",	"",	"h",		channel_acquire,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"Release",	"",	"",		channel_release },
-	{ NULL }
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			channel_get_properties) },
+	{ _GDBUS_ASYNC_METHOD("Acquire", "", "h",
+			NULL, GDBUS_ARGS({ "fd", "h" }),
+			channel_acquire) },
+	{ _GDBUS_METHOD("Release", "", "", NULL, NULL, channel_release) },
+	{ }
 };
 
 static struct hdp_channel *create_channel(struct hdp_device *dev,
@@ -2094,21 +2102,30 @@ static void health_device_destroy(void *data)
 }
 
 static const GDBusMethodTable health_device_methods[] = {
-	{"Echo",		"",	"b",	device_echo,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"CreateChannel",	"os",	"o",	device_create_channel,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"DestroyChannel",	"o",	"",	device_destroy_channel,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"GetProperties",	"",	"a{sv}", device_get_properties},
-	{ NULL }
+	{ _GDBUS_ASYNC_METHOD("Echo", "", "b",
+			NULL, GDBUS_ARGS({ "value", "b" }), device_echo) },
+	{ _GDBUS_ASYNC_METHOD("CreateChannel", "os", "o",
+			GDBUS_ARGS({ "application", "o" },
+					{ "configuration", "s" }),
+			GDBUS_ARGS({ "channel", "o" }),
+			device_create_channel) },
+	{ _GDBUS_ASYNC_METHOD("DestroyChannel", "o", "",
+			GDBUS_ARGS({ "channel", "o" }), NULL,
+			device_destroy_channel) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			device_get_properties) },
+	{ }
 };
 
 static const GDBusSignalTable health_device_signals[] = {
-	{"ChannelConnected",		"o"		},
-	{"ChannelDeleted",		"o"		},
-	{"PropertyChanged",		"sv"		},
-	{ NULL }
+	{ _GDBUS_SIGNAL("ChannelConnected", "o",
+			GDBUS_ARGS({ "channel", "o" })) },
+	{ _GDBUS_SIGNAL("ChannelDeleted", "o",
+			GDBUS_ARGS({ "channel", "o" })) },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
 };
 
 static struct hdp_device *create_health_device(DBusConnection *conn,
diff --git a/input/device.c b/input/device.c
index af90e6d..ab38d80 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1061,15 +1061,19 @@ static DBusMessage *input_device_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "Connect",		"",	"",	input_device_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	input_device_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",input_device_get_properties },
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "",
+				NULL, NULL, input_device_connect) },
+	{ _GDBUS_METHOD("Disconnect", "", "",
+				NULL, NULL, input_device_disconnect) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			input_device_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/network/connection.c b/network/connection.c
index 77d91d6..4d0bb6c 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -553,15 +553,19 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable connection_methods[] = {
-	{ "Connect",		"s",	"s",	connection_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	connection_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",connection_get_properties },
+	{ _GDBUS_ASYNC_METHOD("Connect", "", "",
+			NULL, NULL, connection_connect) },
+	{ _GDBUS_METHOD("Disconnect", "", "",
+			NULL, NULL, connection_disconnect) },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			connection_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable connection_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/network/server.c b/network/server.c
index 688ec7d..2539df8 100644
--- a/network/server.c
+++ b/network/server.c
@@ -686,8 +686,12 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{ "Register",	"ss",	"",	register_server		},
-	{ "Unregister",	"s",	"",	unregister_server	},
+	{ _GDBUS_METHOD("Register", "ss", "",
+			GDBUS_ARGS({ "uuid", "s" }, { "bridge", "s" }), NULL,
+			register_server) },
+	{ _GDBUS_METHOD("Unregister", "s", "",
+			GDBUS_ARGS({ "uuid", "s" }), NULL,
+			unregister_server) },
 	{ }
 };
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index bcd0556..0d7a6ff 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -176,11 +176,18 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable oob_methods[] = {
-	{"AddRemoteData",	"sayay",	"",	add_remote_data},
-	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
-	{"ReadLocalData",	"",		"ayay",	read_local_data,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{}
+	{ _GDBUS_METHOD("AddRemoteData", "sayay", "",
+			GDBUS_ARGS({ "address", "s" }, { "hash", "ay" },
+					{ "randomizer", "ay" }), NULL,
+			add_remote_data) },
+	{ _GDBUS_METHOD("RemoveRemoteData", "s", "",
+			GDBUS_ARGS({ "address", "s" }), NULL,
+			remove_remote_data) },
+	{ _GDBUS_ASYNC_METHOD("ReadLocalData", "", "ayay",
+			NULL, GDBUS_ARGS({ "hash", "ay" },
+						{ "randomizer", "ay" }),
+			read_local_data) },
+	{ }
 };
 
 static int oob_probe(struct btd_adapter *adapter)
diff --git a/plugins/service.c b/plugins/service.c
index 978e371..d03ef46 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -697,12 +697,21 @@ done:
 }
 
 static const GDBusMethodTable service_methods[] = {
-	{ "AddRecord",		"s",	"u",	add_service_record	},
-	{ "UpdateRecord",	"us",	"",	update_service_record	},
-	{ "RemoveRecord",	"u",	"",	remove_service_record	},
-	{ "RequestAuthorization","su",	"",	request_authorization,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelAuthorization", "",	"",	cancel_authorization	},
+	{ _GDBUS_METHOD("AddRecord", "s", "u",
+		GDBUS_ARGS({ "record", "s" }),
+		GDBUS_ARGS({ "handle", "u" }),
+		add_service_record) },
+	{ _GDBUS_METHOD("UpdateRecord", "us", "",
+		GDBUS_ARGS({ "handle", "u" }, { "record", "s" }), NULL,
+		update_service_record) },
+	{ _GDBUS_METHOD("RemoveRecord", "u", "",
+		GDBUS_ARGS({ "handle", "u" }), NULL,
+		remove_service_record) },
+	{ _GDBUS_ASYNC_METHOD("RequestAuthorization","su", "",
+		GDBUS_ARGS({ "address", "s" }, { "handle", "u"}), NULL,
+		request_authorization) },
+	{ _GDBUS_METHOD("CancelAuthorization", "", "",
+		NULL, NULL, cancel_authorization) },
 	{ }
 };
 
diff --git a/proximity/monitor.c b/proximity/monitor.c
index b4a52d2..139cae7 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -547,14 +547,18 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable monitor_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
 	{ }
 };
 
 static const GDBusSignalTable monitor_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 0a89537..d1a37a2 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -181,12 +181,15 @@ err:
 }
 
 static const GDBusMethodTable reporter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable reporter_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index a2f2968..b273918 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -316,10 +316,17 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dummy_methods[] = {
-	{ "OngoingCall", "b", "", ongoing_call},
-	{ "MaxMessageSize", "u", "", max_msg_size},
-	{ "DisconnectImmediate", "", "", disconnect_immediate},
-	{ "CardStatus", "u", "", card_status},
+	{ _GDBUS_METHOD("OngoingCall", "b", "",
+				GDBUS_ARGS({ "ongoing", "b" }), NULL,
+				ongoing_call) },
+	{ _GDBUS_METHOD("MaxMessageSize", "u", "",
+				GDBUS_ARGS({ "size", "u" }), NULL,
+				max_msg_size) },
+	{ _GDBUS_METHOD("DisconnectImmediate", "", "", NULL, NULL,
+				disconnect_immediate) },
+	{ _GDBUS_METHOD("CardStatus", "u", "",
+				GDBUS_ARGS({ "status", "" }), NULL,
+				card_status) },
 	{ }
 };
 
diff --git a/sap/server.c b/sap/server.c
index b212ea0..342cd64 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1304,13 +1304,16 @@ static DBusMessage *get_properties(DBusConnection *c,
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{"GetProperties", "", "a{sv}", get_properties},
-	{"Disconnect", "", "", disconnect},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, disconnect) },
 	{ }
 };
 
 static const GDBusSignalTable server_signals[] = {
-	{ "PropertyChanged", "sv"},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
diff --git a/serial/port.c b/serial/port.c
index 1c48bf7..4ef3437 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -568,9 +568,15 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 }
 
 static const GDBusMethodTable port_methods[] = {
-	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ConnectFD",    "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "s", "",  port_disconnect },
+	{ _GDBUS_ASYNC_METHOD("Connect", "s", "s",
+		GDBUS_ARGS({ "pattern", "s" }),	GDBUS_ARGS({ "tty", "s" }),
+		port_connect) },
+	{ _GDBUS_ASYNC_METHOD("ConnectFD", "s", "h",
+		GDBUS_ARGS({ "pattern", "s" }), GDBUS_ARGS({ "fd", "s" }),
+		port_connect) },
+	{ _GDBUS_METHOD("Disconnect", "s", "",
+		GDBUS_ARGS({ "device", "s" }), NULL,
+		port_disconnect) },
 	{ }
 };
 
diff --git a/serial/proxy.c b/serial/proxy.c
index 5a91186..a2a9088 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -729,10 +729,15 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 }
 
 static const GDBusMethodTable proxy_methods[] = {
-	{ "Enable",			"",	"",	proxy_enable },
-	{ "Disable",			"",	"",	proxy_disable },
-	{ "GetInfo",			"",	"a{sv}",proxy_get_info },
-	{ "SetSerialParameters",	"syys",	"",	proxy_set_serial_params },
+	{ _GDBUS_METHOD("Enable", "", "", NULL, NULL, proxy_enable) },
+	{ _GDBUS_METHOD("Disable", "", "", NULL, NULL, proxy_disable) },
+	{ _GDBUS_METHOD("GetInfo", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			proxy_get_info) },
+	{ _GDBUS_METHOD("SetSerialParameters", "syys", "",
+			GDBUS_ARGS({ "rate", "s" }, { "data", "y" },
+					{ "stop", "y" }, { "parity", "s" }),
+			NULL, proxy_set_serial_params) },
 	{ },
 };
 
@@ -1112,15 +1117,23 @@ static void manager_path_unregister(void *data)
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "CreateProxy",		"ss",	"s",	create_proxy },
-	{ "ListProxies",		"",	"as",	list_proxies },
-	{ "RemoveProxy",		"s",	"",	remove_proxy },
+	{ _GDBUS_METHOD("CreateProxy", "ss", "s",
+			GDBUS_ARGS({ "pattern", "s" },
+					{ "address", "s" }),
+			GDBUS_ARGS({ "path", "s" }),
+			create_proxy) },
+	{ _GDBUS_METHOD("ListProxies", "", "as",
+			NULL, GDBUS_ARGS({ "paths", "as" }),
+			list_proxies) },
+	{ _GDBUS_METHOD("RemoveProxy", "s", "",
+			GDBUS_ARGS({ "path", "s" }), NULL,
+			remove_proxy) },
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "ProxyCreated",		"s"	},
-	{ "ProxyRemoved",		"s"	},
+	{ _GDBUS_SIGNAL("ProxyCreated", "s", GDBUS_ARGS({ "path", "s" })) },
+	{ _GDBUS_SIGNAL("ProxyRemoved", "s", GDBUS_ARGS({ "path", "s" })) },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index 9dfed54..d87406d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1656,37 +1656,64 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties		},
-	{ "SetProperty",	"sv",	"",	set_property,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "RequestSession",	"",	"",	request_session,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "ReleaseSession",	"",	"",	release_session		},
-	{ "StartDiscovery",	"",	"",	adapter_start_discovery },
-	{ "StopDiscovery",	"",	"",	adapter_stop_discovery,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "ListDevices",	"",	"ao",	list_devices,
-						G_DBUS_METHOD_FLAG_DEPRECATED},
-	{ "CreateDevice",	"s",	"o",	create_device,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CreatePairedDevice",	"sos",	"o",	create_paired_device,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelDeviceCreation","s",	"",	cancel_device_creation,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "RemoveDevice",	"o",	"",	remove_device,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "FindDevice",		"s",	"o",	find_device		},
-	{ "RegisterAgent",	"os",	"",	register_agent		},
-	{ "UnregisterAgent",	"o",	"",	unregister_agent	},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
+	{ _GDBUS_ASYNC_METHOD("RequestSession", "", "", NULL, NULL,
+			request_session) },
+	{ _GDBUS_METHOD("ReleaseSession", "", "", NULL, NULL,
+			release_session) },
+	{ _GDBUS_METHOD("StartDiscovery", "", "", NULL, NULL,
+			adapter_start_discovery) },
+	{ _GDBUS_ASYNC_METHOD("StopDiscovery", "", "", NULL, NULL,
+			adapter_stop_discovery) },
+	{ _GDBUS_DEPRECATED_METHOD("ListDevices", "", "ao",
+			NULL, GDBUS_ARGS({ "devices", "ao" }),
+			list_devices) },
+	{ _GDBUS_ASYNC_METHOD("CreateDevice", "s", "o",
+			GDBUS_ARGS({ "address", "s" }),
+			GDBUS_ARGS({ "device", "o" }),
+			create_device) },
+	{ _GDBUS_ASYNC_METHOD("CreatePairedDevice", "sos", "o",
+			GDBUS_ARGS({ "address", "s" }, { "agent", "o" },
+							{ "capability", "s" }),
+			GDBUS_ARGS({ "device", "o" }),
+			create_paired_device) },
+	{ _GDBUS_ASYNC_METHOD("CancelDeviceCreation", "s", "",
+			GDBUS_ARGS({ "address", "s" }), NULL,
+			cancel_device_creation) },
+	{ _GDBUS_ASYNC_METHOD("RemoveDevice", "o", "",
+			GDBUS_ARGS({ "device", "o" }), NULL,
+			remove_device) },
+	{ _GDBUS_METHOD("FindDevice", "s", "o",
+			GDBUS_ARGS({ "address", "s" }),
+			GDBUS_ARGS({ "device", "o" }),
+			find_device) },
+	{ _GDBUS_METHOD("RegisterAgent", "os", "",
+			GDBUS_ARGS({ "agent", "o" },
+					{ "capability", "s" }), NULL,
+			register_agent) },
+	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_agent) },
 	{ }
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ "PropertyChanged",		"sv"		},
-	{ "DeviceCreated",		"o"		},
-	{ "DeviceRemoved",		"o"		},
-	{ "DeviceFound",		"sa{sv}"	},
-	{ "DeviceDisappeared",		"s"		},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("DeviceCreated", "o",
+			GDBUS_ARGS({ "device", "o" })) },
+	{ _GDBUS_SIGNAL("DeviceRemoved", "o",
+			GDBUS_ARGS({ "device", "o" })) },
+	{ _GDBUS_SIGNAL("DeviceFound", "sa{sv}",
+			GDBUS_ARGS({ "address", "s" },
+						{ "values", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("DeviceDisappeared", "s",
+			GDBUS_ARGS({ "address", "s" })) },
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index 16f9d7a..2dc60e2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -878,19 +878,25 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property	},
-	{ "DiscoverServices",	"s",	"a{us}",	discover_services,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelDiscovery",	"",	"",		cancel_discover	},
-	{ "Disconnect",		"",	"",		disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
+	{ _GDBUS_ASYNC_METHOD("DiscoverServices", "s", "a{us}",
+			GDBUS_ARGS({ "pattern", "s" }),
+			GDBUS_ARGS({ "services", "a{us}" }),
+			discover_services) },
+	{ _GDBUS_METHOD("CancelDiscovery", "", "", NULL, NULL, cancel_discover) },
+	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, disconnect) },
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "DisconnectRequested",	""	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("DisconnectRequested", "", NULL) },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index e6c1675..42c1a65 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,19 +197,31 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties	},
-	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter",	"s",	"o",	find_adapter	},
-	{ "ListAdapters",	"",	"ao",	list_adapters,
-						G_DBUS_METHOD_FLAG_DEPRECATED},
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_METHOD("DefaultAdapter", "", "o",
+			NULL, GDBUS_ARGS({ "adapter", "o" }),
+			default_adapter) },
+	{ _GDBUS_METHOD("FindAdapter", "s", "o",
+			GDBUS_ARGS({ "pattern", "s" }),
+			GDBUS_ARGS({ "adapter", "o" }),
+			find_adapter) },
+	{ _GDBUS_ASYNC_METHOD("ListAdapters", "", "ao",
+			NULL, GDBUS_ARGS({ "adapters", "ao" }),
+			list_adapters) },
 	{ }
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "AdapterAdded",		"o"	},
-	{ "AdapterRemoved",		"o"	},
-	{ "DefaultAdapterChanged",	"o"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ _GDBUS_SIGNAL("AdapterAdded", "o",
+			GDBUS_ARGS({ "adapter", "o" })) },
+	{ _GDBUS_SIGNAL("AdapterRemoved", "o",
+			GDBUS_ARGS({ "adapter", "o" })) },
+	{ _GDBUS_SIGNAL("DefaultAdapterChanged", "o",
+			GDBUS_ARGS({ "adapter", "o" })) },
 	{ }
 };
 
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 1f7b6a6..4256f14 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -960,18 +960,30 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable thermometer_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "SetProperty",	"sv",	"",		set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RegisterWatcher",	"o",	"",		register_watcher },
-	{ "UnregisterWatcher",	"o",	"",		unregister_watcher },
-	{ "EnableIntermediateMeasurement", "o", "", enable_intermediate },
-	{ "DisableIntermediateMeasurement","o",	"", disable_intermediate },
+	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
+	{ _GDBUS_METHOD("RegisterWatcher", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			register_watcher) },
+	{ _GDBUS_METHOD("UnregisterWatcher", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_watcher) },
+	{ _GDBUS_METHOD("EnableIntermediateMeasurement", "o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			enable_intermediate) },
+	{ _GDBUS_METHOD("DisableIntermediateMeasurement","o", "",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			disable_intermediate) },
 	{ }
 };
 
 static const GDBusSignalTable thermometer_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
-- 
1.7.10.2

