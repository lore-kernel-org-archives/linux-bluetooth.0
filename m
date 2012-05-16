Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v5 06/13] Convert GDBus methods and signals to use GDBusArgInfo
Date: Wed, 16 May 2012 20:33:06 -0300
Message-Id: <1337211193-18230-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337211193-18230-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337211193-18230-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c           |   31 ++++++++++------
 audio/control.c           |   17 ++++++---
 audio/device.c            |   10 ++++--
 audio/gateway.c           |   18 +++++++---
 audio/headset.c           |   58 +++++++++++++++++++++---------
 audio/media.c             |   21 ++++++++---
 audio/sink.c              |   16 ++++++---
 audio/source.c            |   10 ++++--
 audio/telephony-dummy.c   |   32 ++++++++++++-----
 audio/telephony-maemo5.c  |    6 ++--
 audio/transport.c         |   26 ++++++++++----
 gdbus/object.c            |    5 ++-
 health/hdp.c              |   61 ++++++++++++++++++++++---------
 input/device.c            |   10 ++++--
 network/connection.c      |   20 ++++++++---
 network/server.c          |    9 +++--
 plugins/dbusoob.c         |   17 ++++++---
 plugins/service.c         |   22 ++++++++----
 proximity/monitor.c       |   15 +++++---
 proximity/reporter.c      |   10 ++++--
 sap/sap-dummy.c           |   16 ++++++---
 sap/server.c              |   10 ++++--
 serial/port.c             |   15 ++++++--
 serial/proxy.c            |   32 ++++++++++++-----
 src/adapter.c             |   88 ++++++++++++++++++++++++++++++++-------------
 src/device.c              |   28 ++++++++++-----
 src/manager.c             |   37 ++++++++++++++-----
 thermometer/thermometer.c |   31 +++++++++++-----
 28 files changed, 497 insertions(+), 174 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2179f63..cd948c1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -516,9 +516,13 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable char_methods[] = {
-	{ "GetProperties",	"",	"a{sv}", get_properties },
-	{ "SetProperty",	"sv",	"",	set_property,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
@@ -1016,13 +1020,20 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable prim_methods[] = {
-	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
-					G_DBUS_METHOD_FLAG_ASYNC	},
-	{ "RegisterCharacteristicsWatcher",	"o", "",
-						register_watcher	},
-	{ "UnregisterCharacteristicsWatcher",	"o", "",
-						unregister_watcher	},
-	{ "GetProperties",	"",	"a{sv}",prim_get_properties	},
+	{
+		"DiscoverCharacteristics", "", "ao", discover_char,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.out_args = GDBUS_ARGS_INFO({ "characteristics", "ao" })
+	}, {
+		"RegisterCharacteristicsWatcher", "o", "", register_watcher,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"UnregisterCharacteristicsWatcher", "o", "", unregister_watcher,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"GetProperties", "", "a{sv}", prim_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ }
 };
 
diff --git a/audio/control.c b/audio/control.c
index da23535..9a1e3c8 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -198,9 +198,15 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable control_methods[] = {
-	{ "IsConnected",	"",	"b",	control_is_connected,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",control_get_properties },
+	{
+		"IsConnected", "", "b", control_is_connected,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
+	},
+	{
+		"GetProperties", "", "a{sv}", control_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ "VolumeUp",		"",	"",	volume_up },
 	{ "VolumeDown",		"",	"",	volume_down },
 	{ NULL, NULL, NULL, NULL }
@@ -209,7 +215,10 @@ static const GDBusMethodTable control_methods[] = {
 static const GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "PropertyChanged",		"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/device.c b/audio/device.c
index ac00f1d..1e5a5c1 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -622,12 +622,18 @@ static const GDBusMethodTable dev_methods[] = {
 	{ "Connect",		"",	"",	dev_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	dev_disconnect },
-	{ "GetProperties",	"",	"a{sv}",dev_get_properties },
+	{
+		"GetProperties", "", "a{sv}", dev_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static const GDBusSignalTable dev_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 9194a7c..fca13e9 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -715,14 +715,24 @@ done:
 static const GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties", "", "a{sv}", ag_get_properties },
-	{ "RegisterAgent", "o", "", register_agent },
-	{ "UnregisterAgent", "o", "", unregister_agent },
+	{
+		"GetProperties", "", "a{sv}", ag_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"RegisterAgent", "o", "", register_agent,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"UnregisterAgent", "o", "", unregister_agent,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static const GDBusSignalTable gateway_signals[] = {
-	{ "PropertyChanged", "sv" },
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/headset.c b/audio/headset.c
index ebe9a7c..dd7f712 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2061,25 +2061,43 @@ static const GDBusMethodTable headset_methods[] = {
 	{ "Connect",		"",	"",	hs_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	hs_disconnect },
-	{ "IsConnected",	"",	"b",	hs_is_connected },
+	{
+		"IsConnected", "", "b", hs_is_connected,
+		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
+	},
 	{ "IndicateCall",	"",	"",	hs_ring },
 	{ "CancelCall",		"",	"",	hs_cancel_call },
 	{ "Play",		"",	"",	hs_play,
 						G_DBUS_METHOD_FLAG_ASYNC |
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "Stop",		"",	"",	hs_stop },
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
+	{
+		"IsPlaying", "", "b", hs_is_playing,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "playing", "b" })
+	}, {
+		"GetSpeakerGain", "", "q", hs_get_speaker_gain,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "gain", "q" })
+	}, {
+		"GetMicrophoneGain", "", "q", hs_get_mic_gain,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "gain", "q" })
+	}, {
+		"SetSpeakerGain", "q", "", hs_set_speaker_gain,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.in_args = GDBUS_ARGS_INFO({ "gain", "q" })
+	}, {
+		"SetMicrophoneGain", "q", "", hs_set_mic_gain,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.in_args = GDBUS_ARGS_INFO({ "gain", "q" })
+	}, {
+		"GetProperties", "", "a{sv}", hs_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty", "sv", "", hs_set_property,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL, NULL, NULL }
 };
 
@@ -2089,10 +2107,18 @@ static const GDBusSignalTable headset_signals[] = {
 	{ "AnswerRequested",		""	},
 	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "SpeakerGainChanged",		"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "MicrophoneGainChanged",	"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{
+		"SpeakerGainChanged", "q", G_DBUS_SIGNAL_FLAG_DEPRECATED,
+		.args = GDBUS_ARGS_INFO({ "gain", "q" })
+	},{
+		"MicrophoneGainChanged", "q", G_DBUS_SIGNAL_FLAG_DEPRECATED,
+		.args = GDBUS_ARGS_INFO({ "gain", "q" })
+	},
 	{ "CallTerminated",		""	},
-	{ "PropertyChanged",		"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/media.c b/audio/media.c
index 7a83fbd..b5d4967 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1791,10 +1791,23 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable media_methods[] = {
-	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
-	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
-	{ "RegisterPlayer",	"oa{sv}a{sv}","",	register_player },
-	{ "UnregisterPlayer",	"o",		"",	unregister_player },
+	{
+		"RegisterEndpoint", "oa{sv}", "", register_endpoint,
+		.in_args = GDBUS_ARGS_INFO(
+				{ "endpoint", "o" },
+				{ "properties", "a{sv}" })
+	}, {
+		"UnregisterEndpoint", "o", "", unregister_endpoint,
+		.in_args = GDBUS_ARGS_INFO({ "endpoint", "o" })
+	}, {
+		"RegisterPlayer", "oa{sv}a{sv}", "", register_player,
+		.in_args = GDBUS_ARGS_INFO(
+				{ "player", "o" }, { "properties", "a{sv}" },
+				{ "metadata", "a{sv}" })
+	}, {
+		"UnregisterPlayer", "o", "", unregister_player,
+		.in_args = GDBUS_ARGS_INFO({ "player", "o" })
+	},
 	{ },
 };
 
diff --git a/audio/sink.c b/audio/sink.c
index fe4dd4b..d745f23 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -560,9 +560,14 @@ static const GDBusMethodTable sink_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	sink_disconnect,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "IsConnected",	"",	"b",	sink_is_connected,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",sink_get_properties },
+	{
+		"IsConnected", "", "b", sink_is_connected,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "connected", "b" })
+	}, {
+		"GetProperties", "", "a{sv}", sink_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ NULL, NULL, NULL, NULL }
 };
 
@@ -571,7 +576,10 @@ static const GDBusSignalTable sink_signals[] = {
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "PropertyChanged",		"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/source.c b/audio/source.c
index 04bf131..e64bbd9 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -481,12 +481,18 @@ static const GDBusMethodTable source_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	source_disconnect,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties",	"",	"a{sv}",source_get_properties },
+	{
+		"GetProperties", "", "a{sv}", source_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static const GDBusSignalTable source_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 1885b4a..98bd546 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -379,14 +379,30 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
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
+	{
+		"OutgoingCall", "s", "", outgoing_call,
+		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
+	}, {
+		"IncomingCall", "s", "", incoming_call,
+		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
+	}, {
+		"CancelCall", "", "", cancel_call,
+	}, {
+		"SignalStrength", "u", "", signal_strength,
+		.in_args = GDBUS_ARGS_INFO({ "strength", "u" })
+	}, {
+		"BatteryLevel", "u", "", battery_level,
+		.in_args = GDBUS_ARGS_INFO({ "level", "u" })
+	}, {
+		"RoamingStatus", "b", "", roaming_status,
+		.in_args = GDBUS_ARGS_INFO({ "roaming", "b" })
+	}, {
+		"RegistrationStatus", "b", "", registration_status,
+		.in_args = GDBUS_ARGS_INFO({ "registration", "b" })
+	}, {
+		"SetSubscriberNumber","s", "", set_subscriber_number,
+		.in_args = GDBUS_ARGS_INFO({ "number", "s" })
+	},
 	{ }
 };
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 6ab43b4..598ca36 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1952,8 +1952,10 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable telephony_maemo_methods[] = {
-	{"SetCallerId",		"s",	"",	set_callerid,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{
+		"SetCallerId", "s", "", set_callerid, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "id", "s" })
+	},
 	{ }
 };
 
diff --git a/audio/transport.c b/audio/transport.c
index 7223f38..ffad342 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -915,17 +915,29 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable transport_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "Acquire",		"s",	"hqq",		acquire,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "Release",		"s",	"",		release,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "SetProperty",	"sv",	"",		set_property },
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"Acquire", "s", "hqq", acquire, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "access_type", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "fd", "h" }, { "mtu_r", "q" },
+							{ "mtu_w", "q" } )
+	}, {
+		"Release", "s", "", release, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "access_type", "s" }),
+	}, {
+		"SetProperty", "sv", "", set_property,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ },
 };
 
 static const GDBusSignalTable transport_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 0ef6c80..e99757f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -497,7 +497,10 @@ done:
 }
 
 static const GDBusMethodTable introspect_methods[] = {
-	{ "Introspect",	"",	"s", introspect	},
+	{
+		"Introspect", "", "s", introspect,
+		.out_args = GDBUS_ARGS_INFO({ "xml", "s" })
+	},
 	{ }
 };
 
diff --git a/health/hdp.c b/health/hdp.c
index 3b1ea49..4284e86 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -425,8 +425,15 @@ static void manager_path_unregister(gpointer data)
 }
 
 static const GDBusMethodTable health_manager_methods[] = {
-	{"CreateApplication", "a{sv}", "o", manager_create_application},
-	{"DestroyApplication", "o", "", manager_destroy_application},
+	{
+		"CreateApplication", "a{sv}", "o", manager_create_application,
+		.in_args = GDBUS_ARGS_INFO({ "config", "a{sv}" }),
+		.out_args = GDBUS_ARGS_INFO({ "application", "o" })
+	},
+	{
+		"DestroyApplication", "o", "", manager_destroy_application,
+		.in_args = GDBUS_ARGS_INFO({ "application", "o" })
+	},
 	{ NULL }
 };
 
@@ -732,10 +739,15 @@ end:
 }
 
 static const GDBusMethodTable health_channels_methods[] = {
-	{"GetProperties","",	"a{sv}",	channel_get_properties },
-	{"Acquire",	"",	"h",		channel_acquire,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"Release",	"",	"",		channel_release },
+	{
+		"GetProperties", "", "a{sv}", channel_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"Acquire", "", "h", channel_acquire, G_DBUS_METHOD_FLAG_ASYNC,
+		.out_args = GDBUS_ARGS_INFO({ "fd", "h" })
+	}, {
+		"Release", "", "", channel_release
+	},
 	{ NULL }
 };
 
@@ -2094,20 +2106,37 @@ static void health_device_destroy(void *data)
 }
 
 static const GDBusMethodTable health_device_methods[] = {
-	{"Echo",		"",	"b",	device_echo,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"CreateChannel",	"os",	"o",	device_create_channel,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"DestroyChannel",	"o",	"",	device_destroy_channel,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{"GetProperties",	"",	"a{sv}", device_get_properties},
+	{
+		"Echo", "", "b", device_echo, G_DBUS_METHOD_FLAG_ASYNC,
+		.out_args = GDBUS_ARGS_INFO({ "value", "b" })
+	}, {
+		"CreateChannel", "os", "o", device_create_channel,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "application", "o" },
+						{ "configuration", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "channel", "o" })
+	}, {
+		"DestroyChannel", "o", "", device_destroy_channel,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "channel", "o" })
+	}, {
+		"GetProperties", "", "a{sv}",  device_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ NULL }
 };
 
 static const GDBusSignalTable health_device_signals[] = {
-	{"ChannelConnected",		"o"		},
-	{"ChannelDeleted",		"o"		},
-	{"PropertyChanged",		"sv"		},
+	{
+		"ChannelConnected", "o",
+		.args = GDBUS_ARGS_INFO({ "channel", "o" })
+	}, {
+		"ChannelDeleted", "o",
+		.args = GDBUS_ARGS_INFO({ "channel", "o" })
+	}, {
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ NULL }
 };
 
diff --git a/input/device.c b/input/device.c
index af90e6d..ac18ced 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1064,12 +1064,18 @@ static const GDBusMethodTable device_methods[] = {
 	{ "Connect",		"",	"",	input_device_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	input_device_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",input_device_get_properties },
+	{
+		"GetProperties", "", "a{sv}", input_device_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/network/connection.c b/network/connection.c
index 77d91d6..d7ec420 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -553,15 +553,25 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable connection_methods[] = {
-	{ "Connect",		"s",	"s",	connection_connect,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect",		"",	"",	connection_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",connection_get_properties },
+	{
+		"Connect", "s", "s", connection_connect,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "interface_name", "" }),
+	}, {
+		"Disconnect", "", "", connection_disconnect
+	}, {
+		"GetProperties", "", "a{sv}", connection_get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable connection_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/network/server.c b/network/server.c
index 688ec7d..1a6dbf0 100644
--- a/network/server.c
+++ b/network/server.c
@@ -686,8 +686,13 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{ "Register",	"ss",	"",	register_server		},
-	{ "Unregister",	"s",	"",	unregister_server	},
+	{
+		"Register", "ss", "", register_server,
+		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" }, { "bridge", "s" })
+	}, {
+		"Unregister", "s", "", unregister_server,
+		.in_args = GDBUS_ARGS_INFO({ "uuid", "s" })
+	},
 	{ }
 };
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index bcd0556..9ff4a30 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -176,10 +176,19 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable oob_methods[] = {
-	{"AddRemoteData",	"sayay",	"",	add_remote_data},
-	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
-	{"ReadLocalData",	"",		"ayay",	read_local_data,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{
+		"AddRemoteData", "sayay", "", add_remote_data,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" },
+				{ "hash", "ay" }, { "randomizer", "ay" })
+	}, {
+		"RemoveRemoteData", "s", "", remove_remote_data,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" })
+	}, {
+		"ReadLocalData", "", "ayay", read_local_data,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.out_args = GDBUS_ARGS_INFO({ "hash", "ay" },
+							{ "randomizer", "ay" })
+	},
 	{}
 };
 
diff --git a/plugins/service.c b/plugins/service.c
index 978e371..b326564 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -697,12 +697,22 @@ done:
 }
 
 static const GDBusMethodTable service_methods[] = {
-	{ "AddRecord",		"s",	"u",	add_service_record	},
-	{ "UpdateRecord",	"us",	"",	update_service_record	},
-	{ "RemoveRecord",	"u",	"",	remove_service_record	},
-	{ "RequestAuthorization","su",	"",	request_authorization,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelAuthorization", "",	"",	cancel_authorization	},
+	{
+		"AddRecord", "s", "u", add_service_record,
+		.in_args = GDBUS_ARGS_INFO({ "record", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "handle", "u" })
+	}, {
+		"UpdateRecord", "us", "", update_service_record,
+		.in_args = GDBUS_ARGS_INFO({ "handle", "u" }, { "record", "s" })
+	}, {
+		"RemoveRecord", "u", "", remove_service_record,
+		.in_args = GDBUS_ARGS_INFO({ "handle", "u" })
+	}, {
+		"RequestAuthorization", "su", "", request_authorization,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" }, { "handle", "u"})
+	},
+	{ "CancelAuthorization",  "", "", cancel_authorization },
 	{ }
 };
 
diff --git a/proximity/monitor.c b/proximity/monitor.c
index b4a52d2..1382ef8 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -547,14 +547,21 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable monitor_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty", "sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable monitor_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 0a89537..59595fc 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -181,12 +181,18 @@ err:
 }
 
 static const GDBusMethodTable reporter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable reporter_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index a2f2968..ffa53d7 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -316,10 +316,18 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dummy_methods[] = {
-	{ "OngoingCall", "b", "", ongoing_call},
-	{ "MaxMessageSize", "u", "", max_msg_size},
-	{ "DisconnectImmediate", "", "", disconnect_immediate},
-	{ "CardStatus", "u", "", card_status},
+	{
+		"OngoingCall", "b", "", ongoing_call,
+		.in_args = GDBUS_ARGS_INFO({ "ongoing", "b" })
+	}, {
+		"MaxMessageSize", "u", "", max_msg_size,
+		.in_args = GDBUS_ARGS_INFO({ "size", "u" })
+	}, {
+		"DisconnectImmediate", "", "", disconnect_immediate,
+	}, {
+		"CardStatus", "u", "", card_status,
+		.in_args = GDBUS_ARGS_INFO({ "status", "" })
+	},
 	{ }
 };
 
diff --git a/sap/server.c b/sap/server.c
index b212ea0..bae6478 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1304,13 +1304,19 @@ static DBusMessage *get_properties(DBusConnection *c,
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{"GetProperties", "", "a{sv}", get_properties},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	},
 	{"Disconnect", "", "", disconnect},
 	{ }
 };
 
 static const GDBusSignalTable server_signals[] = {
-	{ "PropertyChanged", "sv"},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
diff --git a/serial/port.c b/serial/port.c
index 1c48bf7..2be1951 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -568,9 +568,18 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 }
 
 static const GDBusMethodTable port_methods[] = {
-	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ConnectFD",    "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "s", "",  port_disconnect },
+	{
+		"Connect", "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "tty", "s" })
+	}, {
+		"ConnectFD", "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "fd", "s" })
+	}, {
+		"Disconnect", "s", "",  port_disconnect,
+		.in_args = GDBUS_ARGS_INFO({ "device", "s" }),
+	},
 	{ }
 };
 
diff --git a/serial/proxy.c b/serial/proxy.c
index 5a91186..aa9ba62 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -729,10 +729,16 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 }
 
 static const GDBusMethodTable proxy_methods[] = {
-	{ "Enable",			"",	"",	proxy_enable },
-	{ "Disable",			"",	"",	proxy_disable },
-	{ "GetInfo",			"",	"a{sv}",proxy_get_info },
-	{ "SetSerialParameters",	"syys",	"",	proxy_set_serial_params },
+	{ "Enable", "", "", proxy_enable },
+	{ "Disable", "", "", proxy_disable },
+	{
+		"GetInfo", "", "a{sv}", proxy_get_info,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetSerialParameters", "syys", "", proxy_set_serial_params,
+		.in_args = GDBUS_ARGS_INFO({ "rate", "s" }, { "data", "y" },
+					{ "stop", "y" }, { "parity", "s" })
+	},
 	{ },
 };
 
@@ -1112,15 +1118,23 @@ static void manager_path_unregister(void *data)
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "CreateProxy",		"ss",	"s",	create_proxy },
-	{ "ListProxies",		"",	"as",	list_proxies },
-	{ "RemoveProxy",		"s",	"",	remove_proxy },
+	{
+		"CreateProxy", "ss", "s", create_proxy,
+		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" },
+							{ "address", "s" })
+	}, {
+		"ListProxies", "", "as", list_proxies,
+		.out_args = GDBUS_ARGS_INFO({ "paths", "as" })
+	}, {
+		"RemoveProxy", "s", "", remove_proxy,
+		.in_args = GDBUS_ARGS_INFO({ "path", "s" })
+	},
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "ProxyCreated",		"s"	},
-	{ "ProxyRemoved",		"s"	},
+	{ "ProxyCreated", "s", .args = GDBUS_ARGS_INFO({ "path", "s" }) },
+	{ "ProxyRemoved", "s", .args =  GDBUS_ARGS_INFO({ "path", "s" }) },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index 9dfed54..2fce399 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1656,37 +1656,75 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties		},
-	{ "SetProperty",	"sv",	"",	set_property,
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
+	{ "RequestSession", "", "", request_session,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "RequestSession",	"",	"",	request_session,
+	{ "ReleaseSession", "", "", release_session },
+	{ "StartDiscovery", "", "", adapter_start_discovery },
+	{ "StopDiscovery", "", "", adapter_stop_discovery,
 						G_DBUS_METHOD_FLAG_ASYNC},
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
+	{
+		"ListDevices", "", "ao", list_devices,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "devices", "ao" })
+	}, {
+		"CreateDevice", "s", "o", create_device,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "device", "o" }),
+	}, {
+		"CreatePairedDevice", "sos", "o", create_paired_device,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" },
+				{ "agent", "o" }, { "capability", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "device", "o" })
+	}, {
+		"CancelDeviceCreation", "s", "", cancel_device_creation,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" })
+	}, {
+		"RemoveDevice", "o", "", remove_device,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "device", "o" })
+	}, {
+		"FindDevice", "s", "o", find_device,
+		.in_args = GDBUS_ARGS_INFO({ "address", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "device", "o" })
+	}, {
+		"RegisterAgent", "os", "", register_agent,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" },
+						{ "capability", "s" }),
+	}, {
+		"UnregisterAgent", "o", "", unregister_agent,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ "PropertyChanged",		"sv"		},
-	{ "DeviceCreated",		"o"		},
-	{ "DeviceRemoved",		"o"		},
-	{ "DeviceFound",		"sa{sv}"	},
-	{ "DeviceDisappeared",		"s"		},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	}, {
+		"DeviceCreated", "o",
+		.args = GDBUS_ARGS_INFO({ "device", "o" })
+	}, {
+		"DeviceRemoved", "o",
+		.args = GDBUS_ARGS_INFO({ "device", "o" })
+	}, {
+		"DeviceFound", "sa{sv}",
+		.args = GDBUS_ARGS_INFO({ "address", "s" },
+						{ "values", "a{sv}" })
+	}, {
+		"DeviceDisappeared", "s",
+		.args = GDBUS_ARGS_INFO({ "address", "s" })
+	},
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index 16f9d7a..66672d4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -878,19 +878,29 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property	},
-	{ "DiscoverServices",	"s",	"a{us}",	discover_services,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelDiscovery",	"",	"",		cancel_discover	},
-	{ "Disconnect",		"",	"",		disconnect,
-						G_DBUS_METHOD_FLAG_ASYNC},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty", "sv", "", set_property,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	}, {
+		"DiscoverServices", "s", "a{us}", discover_services,
+		G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "services", "a{us}" })
+	},
+	{ "CancelDiscovery", "", "", cancel_discover },
+	{ "Disconnect", "", "", disconnect, G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "DisconnectRequested",	""	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
+	{ "DisconnectRequested", "" },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index e6c1675..002118b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,19 +197,38 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties	},
-	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter",	"s",	"o",	find_adapter	},
-	{ "ListAdapters",	"",	"ao",	list_adapters,
-						G_DBUS_METHOD_FLAG_DEPRECATED},
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"DefaultAdapter", "", "o", default_adapter,
+		.out_args = GDBUS_ARGS_INFO({ "adapter", "o" })
+	}, {
+		"FindAdapter", "s", "o", find_adapter,
+		.in_args = GDBUS_ARGS_INFO({ "pattern", "s" }),
+		.out_args = GDBUS_ARGS_INFO({ "adapter", "o" })
+	}, {
+		"ListAdapters", "", "ao", list_adapters,
+		G_DBUS_METHOD_FLAG_DEPRECATED,
+		.out_args = GDBUS_ARGS_INFO({ "adapters", "ao" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "AdapterAdded",		"o"	},
-	{ "AdapterRemoved",		"o"	},
-	{ "DefaultAdapterChanged",	"o"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	}, {
+		"AdapterAdded", "o",
+		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
+	}, {
+		"AdapterRemoved", "o",
+		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
+	}, {
+		"DefaultAdapterChanged", "o",
+		.args = GDBUS_ARGS_INFO({ "adapter", "s" })
+	},
 	{ }
 };
 
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 1f7b6a6..137b712 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -960,18 +960,33 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable thermometer_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "SetProperty",	"sv",	"",		set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RegisterWatcher",	"o",	"",		register_watcher },
-	{ "UnregisterWatcher",	"o",	"",		unregister_watcher },
-	{ "EnableIntermediateMeasurement", "o", "", enable_intermediate },
-	{ "DisableIntermediateMeasurement","o",	"", disable_intermediate },
+	{
+		"GetProperties", "", "a{sv}", get_properties,
+		.out_args = GDBUS_ARGS_INFO({ "properties", "a{sv}" })
+	}, {
+		"SetProperty",	"sv", "", set_property, G_DBUS_METHOD_FLAG_ASYNC,
+		.in_args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	}, {
+		"RegisterWatcher", "o", "", register_watcher,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"UnregisterWatcher", "o", "", unregister_watcher,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"EnableIntermediateMeasurement", "o", "", enable_intermediate,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	}, {
+		"DisableIntermediateMeasurement","o", "", disable_intermediate,
+		.in_args = GDBUS_ARGS_INFO({ "agent", "o" })
+	},
 	{ }
 };
 
 static const GDBusSignalTable thermometer_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{
+		"PropertyChanged", "sv",
+		.args = GDBUS_ARGS_INFO({ "name", "s" }, { "value", "v" })
+	},
 	{ }
 };
 
-- 
1.7.10.2

