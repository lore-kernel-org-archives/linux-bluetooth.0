Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH RESEND BlueZ v6 08/13] Do not set signature and reply in GDBus tables
Date: Fri, 18 May 2012 00:23:32 -0300
Message-Id: <1337311417-1245-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use GDBUS_* macros, so signature and reply fields are not set in each
method/signal.
---
 attrib/client.c           |   12 ++++++------
 audio/control.c           |   14 +++++++-------
 audio/device.c            |    8 ++++----
 audio/gateway.c           |   12 ++++++------
 audio/headset.c           |   46 ++++++++++++++++++++++-----------------------
 audio/media.c             |    8 ++++----
 audio/sink.c              |   18 +++++++++---------
 audio/source.c            |    8 ++++----
 audio/telephony-dummy.c   |   18 +++++++++---------
 audio/telephony-maemo5.c  |    2 +-
 audio/transport.c         |   10 +++++-----
 health/hdp.c              |   24 +++++++++++------------
 input/device.c            |    8 ++++----
 network/connection.c      |    8 ++++----
 network/server.c          |    4 ++--
 plugins/dbusoob.c         |    6 +++---
 plugins/service.c         |   10 +++++-----
 proximity/monitor.c       |    6 +++---
 proximity/reporter.c      |    4 ++--
 sap/sap-dummy.c           |    8 ++++----
 sap/server.c              |    6 +++---
 serial/port.c             |    6 +++---
 serial/proxy.c            |   18 +++++++++---------
 src/adapter.c             |   38 ++++++++++++++++++-------------------
 src/device.c              |   18 +++++++++---------
 src/manager.c             |   16 ++++++++--------
 thermometer/thermometer.c |   14 +++++++-------
 27 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index df1496f..8fbc1cc 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -516,10 +516,10 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable char_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
 	{ }
@@ -1019,16 +1019,16 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable prim_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("DiscoverCharacteristics", "", "ao",
+	{ GDBUS_ASYNC_METHOD("DiscoverCharacteristics",
 			NULL, GDBUS_ARGS({ "characteristics", "ao" }),
 			discover_char) },
-	{ _GDBUS_METHOD("RegisterCharacteristicsWatcher", "o", "",
+	{ GDBUS_METHOD("RegisterCharacteristicsWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			register_watcher) },
-	{ _GDBUS_METHOD("UnregisterCharacteristicsWatcher", "o", "",
+	{ GDBUS_METHOD("UnregisterCharacteristicsWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_watcher) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			prim_get_properties) },
 	{ }
diff --git a/audio/control.c b/audio/control.c
index 71c82eb..c5a6a58 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -198,21 +198,21 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable control_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("IsConnected", "", "b",
+	{ GDBUS_ASYNC_METHOD("IsConnected",
 				NULL, GDBUS_ARGS({ "connected", "b" }),
 				control_is_connected) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				control_get_properties) },
-	{ _GDBUS_METHOD("VolumeUp", "", "", NULL, NULL, volume_up) },
-	{ _GDBUS_METHOD("VolumeDown", "", "", NULL, NULL, volume_down) },
+	{ GDBUS_METHOD("VolumeUp", NULL, NULL, volume_up) },
+	{ GDBUS_METHOD("VolumeDown", NULL, NULL, volume_down) },
 	{ }
 };
 
 static const GDBusSignalTable control_signals[] = {
-	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/device.c b/audio/device.c
index e4ee4e3..b7b993e 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -619,16 +619,16 @@ static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dev_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, dev_connect) },
-	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, dev_disconnect) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
+	{ GDBUS_METHOD("GetProperties",
 		NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 		dev_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable dev_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/gateway.c b/audio/gateway.c
index 0892036..dcc4f55 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -713,20 +713,20 @@ done:
 }
 
 static const GDBusMethodTable gateway_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, ag_connect) },
-	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, ag_disconnect) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, ag_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, ag_disconnect) },
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			ag_get_properties) },
-	{ _GDBUS_METHOD("RegisterAgent", "o", "",
+	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL, register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
 	{ }
 };
 
 static const GDBusSignalTable gateway_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/headset.c b/audio/headset.c
index 22a26bd..729e4dc 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2058,51 +2058,51 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable headset_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, hs_connect) },
-	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, hs_disconnect) },
-	{ _GDBUS_METHOD("IsConnected", "", "b",
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, hs_connect) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, hs_disconnect) },
+	{ GDBUS_METHOD("IsConnected",
 			NULL, GDBUS_ARGS({ "connected", "b" }),
 			hs_is_connected) },
-	{ _GDBUS_METHOD("IndicateCall", "", "", NULL, NULL, hs_ring) },
-	{ _GDBUS_METHOD("CancelCall", "", "", NULL, NULL, hs_cancel_call) },
-	{ _GDBUS_DEPRECATED_ASYNC_METHOD("Play", "", "", NULL, NULL, hs_play) },
-	{ _GDBUS_METHOD("Stop", "", "", NULL, NULL, hs_stop) },
-	{ _GDBUS_DEPRECATED_METHOD("IsPlaying", "", "b",
+	{ GDBUS_METHOD("IndicateCall", NULL, NULL, hs_ring) },
+	{ GDBUS_METHOD("CancelCall", NULL, NULL, hs_cancel_call) },
+	{ GDBUS_DEPRECATED_ASYNC_METHOD("Play", NULL, NULL, hs_play) },
+	{ GDBUS_METHOD("Stop", NULL, NULL, hs_stop) },
+	{ GDBUS_DEPRECATED_METHOD("IsPlaying",
 					NULL, GDBUS_ARGS({ "playing", "b" }),
 					hs_is_playing) },
-	{ _GDBUS_DEPRECATED_METHOD("GetSpeakerGain", "", "q",
+	{ GDBUS_DEPRECATED_METHOD("GetSpeakerGain",
 					NULL, GDBUS_ARGS({ "gain", "q" }),
 					hs_get_speaker_gain) },
-	{ _GDBUS_DEPRECATED_METHOD("GetMicrophoneGain", "", "q",
+	{ GDBUS_DEPRECATED_METHOD("GetMicrophoneGain",
 					NULL, GDBUS_ARGS({ "gain", "q" }),
 					hs_get_mic_gain) },
-	{ _GDBUS_DEPRECATED_METHOD("SetSpeakerGain", "q", "",
+	{ GDBUS_DEPRECATED_METHOD("SetSpeakerGain",
 					GDBUS_ARGS({ "gain", "q" }), NULL,
 					hs_set_speaker_gain) },
-	{ _GDBUS_DEPRECATED_METHOD("SetMicrophoneGain", "q", "",
+	{ GDBUS_DEPRECATED_METHOD("SetMicrophoneGain",
 					GDBUS_ARGS({ "gain", "q" }), NULL,
 					hs_set_mic_gain) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			hs_get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			hs_set_property) },
 	{ }
 };
 
 static const GDBusSignalTable headset_signals[] = {
-	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("AnswerRequested", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Stopped", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Playing", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("SpeakerGainChanged", "q",
+	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("AnswerRequested", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Stopped", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Playing", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("SpeakerGainChanged",
 						GDBUS_ARGS({ "gain", "q" })) },
-	{ _GDBUS_DEPRECATED_SIGNAL("MicrophoneGainChanged", "q",
+	{ GDBUS_DEPRECATED_SIGNAL("MicrophoneGainChanged",
 						GDBUS_ARGS({ "gain", "q" })) },
-	{ _GDBUS_SIGNAL("CallTerminated", "", NULL) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("CallTerminated", NULL) },
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/media.c b/audio/media.c
index 0fbeb8a..3fe04d5 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1791,16 +1791,16 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable media_methods[] = {
-	{ _GDBUS_METHOD("RegisterEndpoint", "oa{sv}", "",
+	{ GDBUS_METHOD("RegisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }, { "properties", "a{sv}" }),
 		NULL, register_endpoint) },
-	{ _GDBUS_METHOD("UnregisterEndpoint", "o", "",
+	{ GDBUS_METHOD("UnregisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }), NULL, unregister_endpoint) },
-	{ _GDBUS_METHOD("RegisterPlayer", "oa{sv}a{sv}", "",
+	{ GDBUS_METHOD("RegisterPlayer",
 		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" },
 						{ "metadata", "a{sv}" }),
 		NULL, register_player) },
-	{ _GDBUS_METHOD("UnregisterPlayer", "o", "",
+	{ GDBUS_METHOD("UnregisterPlayer",
 		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
 	{ },
 };
diff --git a/audio/sink.c b/audio/sink.c
index f9b934b..6b21e47 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -556,23 +556,23 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable sink_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, sink_connect) },
-	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, sink_disconnect) },
-	{ _GDBUS_DEPRECATED_METHOD("IsConnected", "", "b",
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, sink_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, sink_disconnect) },
+	{ GDBUS_DEPRECATED_METHOD("IsConnected",
 			NULL, GDBUS_ARGS({ "connected", "b" }),
 			sink_is_connected) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				sink_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable sink_signals[] = {
-	{ _GDBUS_DEPRECATED_SIGNAL("Connected", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Disconnected", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Playing", "", NULL) },
-	{ _GDBUS_DEPRECATED_SIGNAL("Stopped", "", NULL) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Playing", NULL) },
+	{ GDBUS_DEPRECATED_SIGNAL("Stopped", NULL) },
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/source.c b/audio/source.c
index 2724358..dbba5b9 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -477,16 +477,16 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable source_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "", NULL, NULL, source_connect) },
-	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, source_disconnect) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, source_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, source_disconnect) },
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				source_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable source_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 0e488dc..2f89139 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -379,33 +379,33 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 }
 
 static const GDBusMethodTable dummy_methods[] = {
-	{ _GDBUS_METHOD("OutgoingCall", "s", "",
+	{ GDBUS_METHOD("OutgoingCall",
 			GDBUS_ARGS({ "number", "s" }), NULL,
 			outgoing_call) },
-	{ _GDBUS_METHOD("IncomingCall", "s", "",
+	{ GDBUS_METHOD("IncomingCall",
 			GDBUS_ARGS({ "number", "s" }), NULL,
 			incoming_call) },
-	{ _GDBUS_METHOD("CancelCall", "", "", NULL, NULL, cancel_call) },
-	{ _GDBUS_METHOD("SignalStrength", "u", "",
+	{ GDBUS_METHOD("CancelCall", NULL, NULL, cancel_call) },
+	{ GDBUS_METHOD("SignalStrength",
 			GDBUS_ARGS({ "strength", "u" }), NULL,
 			signal_strength) },
-	{ _GDBUS_METHOD("BatteryLevel", "u", "",
+	{ GDBUS_METHOD("BatteryLevel",
 			GDBUS_ARGS({ "level", "u" }), NULL,
 			battery_level) },
-	{ _GDBUS_METHOD("RoamingStatus", "b", "",
+	{ GDBUS_METHOD("RoamingStatus",
 			GDBUS_ARGS({ "roaming", "b" }), NULL,
 			roaming_status) },
-	{ _GDBUS_METHOD("RegistrationStatus", "b", "",
+	{ GDBUS_METHOD("RegistrationStatus",
 			GDBUS_ARGS({ "registration", "b" }), NULL,
 			registration_status) },
-	{ _GDBUS_METHOD("SetSubscriberNumber","s", "",
+	{ GDBUS_METHOD("SetSubscriberNumber",
 			GDBUS_ARGS({ "number", "s" }), NULL,
 			set_subscriber_number) },
 	{ }
 };
 
 static const GDBusSignalTable dummy_signals[] = {
-	{ _GDBUS_SIGNAL("VoiceDial", "", NULL) },
+	{ GDBUS_SIGNAL("VoiceDial", NULL) },
 	{ }
 };
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index a03ba09..8a00296 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1952,7 +1952,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable telephony_maemo_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("SetCallerId", "s", "",
+	{ GDBUS_ASYNC_METHOD("SetCallerId",
 				GDBUS_ARGS({ "id", "s" }), NULL,
 				set_callerid) },
 	{ }
diff --git a/audio/transport.c b/audio/transport.c
index f2a512a..753d4bf 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -915,25 +915,25 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable transport_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Acquire", "s", "hqq",
+	{ GDBUS_ASYNC_METHOD("Acquire",
 			GDBUS_ARGS({ "access_type", "s" }),
 			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
 							{ "mtu_w", "q" } ),
 			acquire) },
-	{ _GDBUS_ASYNC_METHOD("Release", "s", "",
+	{ GDBUS_ASYNC_METHOD("Release",
 			GDBUS_ARGS({ "access_type", "s" }), NULL,
 			release ) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
 			NULL, set_property) },
 	{ },
 };
 
 static const GDBusSignalTable transport_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/health/hdp.c b/health/hdp.c
index 6dabbff..2f04d2e 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -425,11 +425,11 @@ static void manager_path_unregister(gpointer data)
 }
 
 static const GDBusMethodTable health_manager_methods[] = {
-	{ _GDBUS_METHOD("CreateApplication", "a{sv}", "o",
+	{ GDBUS_METHOD("CreateApplication",
 			GDBUS_ARGS({ "config", "a{sv}" }),
 			GDBUS_ARGS({ "application", "o" }),
 			manager_create_application) },
-	{ _GDBUS_METHOD("DestroyApplication", "o", "",
+	{ GDBUS_METHOD("DestroyApplication",
 			GDBUS_ARGS({ "application", "o" }), NULL,
 			manager_destroy_application) },
 	{ }
@@ -737,13 +737,13 @@ end:
 }
 
 static const GDBusMethodTable health_channels_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			channel_get_properties) },
-	{ _GDBUS_ASYNC_METHOD("Acquire", "", "h",
+	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL, GDBUS_ARGS({ "fd", "h" }),
 			channel_acquire) },
-	{ _GDBUS_METHOD("Release", "", "", NULL, NULL, channel_release) },
+	{ GDBUS_METHOD("Release", NULL, NULL, channel_release) },
 	{ }
 };
 
@@ -2102,28 +2102,28 @@ static void health_device_destroy(void *data)
 }
 
 static const GDBusMethodTable health_device_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Echo", "", "b",
+	{ GDBUS_ASYNC_METHOD("Echo",
 			NULL, GDBUS_ARGS({ "value", "b" }), device_echo) },
-	{ _GDBUS_ASYNC_METHOD("CreateChannel", "os", "o",
+	{ GDBUS_ASYNC_METHOD("CreateChannel",
 			GDBUS_ARGS({ "application", "o" },
 					{ "configuration", "s" }),
 			GDBUS_ARGS({ "channel", "o" }),
 			device_create_channel) },
-	{ _GDBUS_ASYNC_METHOD("DestroyChannel", "o", "",
+	{ GDBUS_ASYNC_METHOD("DestroyChannel",
 			GDBUS_ARGS({ "channel", "o" }), NULL,
 			device_destroy_channel) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			device_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable health_device_signals[] = {
-	{ _GDBUS_SIGNAL("ChannelConnected", "o",
+	{ GDBUS_SIGNAL("ChannelConnected",
 			GDBUS_ARGS({ "channel", "o" })) },
-	{ _GDBUS_SIGNAL("ChannelDeleted", "o",
+	{ GDBUS_SIGNAL("ChannelDeleted",
 			GDBUS_ARGS({ "channel", "o" })) },
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/input/device.c b/input/device.c
index ab38d80..77e77b3 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1061,18 +1061,18 @@ static DBusMessage *input_device_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "",
+	{ GDBUS_ASYNC_METHOD("Connect",
 				NULL, NULL, input_device_connect) },
-	{ _GDBUS_METHOD("Disconnect", "", "",
+	{ GDBUS_METHOD("Disconnect",
 				NULL, NULL, input_device_disconnect) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			input_device_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/network/connection.c b/network/connection.c
index 4d0bb6c..544ec3a 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -553,18 +553,18 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable connection_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "", "",
+	{ GDBUS_ASYNC_METHOD("Connect",
 			NULL, NULL, connection_connect) },
-	{ _GDBUS_METHOD("Disconnect", "", "",
+	{ GDBUS_METHOD("Disconnect",
 			NULL, NULL, connection_disconnect) },
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			connection_get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable connection_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/network/server.c b/network/server.c
index 2539df8..e39769a 100644
--- a/network/server.c
+++ b/network/server.c
@@ -686,10 +686,10 @@ static void path_unregister(void *data)
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{ _GDBUS_METHOD("Register", "ss", "",
+	{ GDBUS_METHOD("Register",
 			GDBUS_ARGS({ "uuid", "s" }, { "bridge", "s" }), NULL,
 			register_server) },
-	{ _GDBUS_METHOD("Unregister", "s", "",
+	{ GDBUS_METHOD("Unregister",
 			GDBUS_ARGS({ "uuid", "s" }), NULL,
 			unregister_server) },
 	{ }
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 0d7a6ff..1791342 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -176,14 +176,14 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable oob_methods[] = {
-	{ _GDBUS_METHOD("AddRemoteData", "sayay", "",
+	{ GDBUS_METHOD("AddRemoteData",
 			GDBUS_ARGS({ "address", "s" }, { "hash", "ay" },
 					{ "randomizer", "ay" }), NULL,
 			add_remote_data) },
-	{ _GDBUS_METHOD("RemoveRemoteData", "s", "",
+	{ GDBUS_METHOD("RemoveRemoteData",
 			GDBUS_ARGS({ "address", "s" }), NULL,
 			remove_remote_data) },
-	{ _GDBUS_ASYNC_METHOD("ReadLocalData", "", "ayay",
+	{ GDBUS_ASYNC_METHOD("ReadLocalData",
 			NULL, GDBUS_ARGS({ "hash", "ay" },
 						{ "randomizer", "ay" }),
 			read_local_data) },
diff --git a/plugins/service.c b/plugins/service.c
index d03ef46..288f849 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -697,20 +697,20 @@ done:
 }
 
 static const GDBusMethodTable service_methods[] = {
-	{ _GDBUS_METHOD("AddRecord", "s", "u",
+	{ GDBUS_METHOD("AddRecord",
 		GDBUS_ARGS({ "record", "s" }),
 		GDBUS_ARGS({ "handle", "u" }),
 		add_service_record) },
-	{ _GDBUS_METHOD("UpdateRecord", "us", "",
+	{ GDBUS_METHOD("UpdateRecord",
 		GDBUS_ARGS({ "handle", "u" }, { "record", "s" }), NULL,
 		update_service_record) },
-	{ _GDBUS_METHOD("RemoveRecord", "u", "",
+	{ GDBUS_METHOD("RemoveRecord",
 		GDBUS_ARGS({ "handle", "u" }), NULL,
 		remove_service_record) },
-	{ _GDBUS_ASYNC_METHOD("RequestAuthorization","su", "",
+	{ GDBUS_ASYNC_METHOD("RequestAuthorization",
 		GDBUS_ARGS({ "address", "s" }, { "handle", "u"}), NULL,
 		request_authorization) },
-	{ _GDBUS_METHOD("CancelAuthorization", "", "",
+	{ GDBUS_METHOD("CancelAuthorization",
 		NULL, NULL, cancel_authorization) },
 	{ }
 };
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 139cae7..98dbcd1 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -547,17 +547,17 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static const GDBusMethodTable monitor_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
 	{ }
 };
 
 static const GDBusSignalTable monitor_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/proximity/reporter.c b/proximity/reporter.c
index d1a37a2..b9872ab 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -181,14 +181,14 @@ err:
 }
 
 static const GDBusMethodTable reporter_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
 	{ }
 };
 
 static const GDBusSignalTable reporter_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index b273918..e2032cf 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -316,15 +316,15 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable dummy_methods[] = {
-	{ _GDBUS_METHOD("OngoingCall", "b", "",
+	{ GDBUS_METHOD("OngoingCall",
 				GDBUS_ARGS({ "ongoing", "b" }), NULL,
 				ongoing_call) },
-	{ _GDBUS_METHOD("MaxMessageSize", "u", "",
+	{ GDBUS_METHOD("MaxMessageSize",
 				GDBUS_ARGS({ "size", "u" }), NULL,
 				max_msg_size) },
-	{ _GDBUS_METHOD("DisconnectImmediate", "", "", NULL, NULL,
+	{ GDBUS_METHOD("DisconnectImmediate", NULL, NULL,
 				disconnect_immediate) },
-	{ _GDBUS_METHOD("CardStatus", "u", "",
+	{ GDBUS_METHOD("CardStatus",
 				GDBUS_ARGS({ "status", "" }), NULL,
 				card_status) },
 	{ }
diff --git a/sap/server.c b/sap/server.c
index 342cd64..e44fa08 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1304,15 +1304,15 @@ static DBusMessage *get_properties(DBusConnection *c,
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_METHOD("Disconnect", "", "", NULL, NULL, disconnect) },
+	{ GDBUS_METHOD("Disconnect", NULL, NULL, disconnect) },
 	{ }
 };
 
 static const GDBusSignalTable server_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
diff --git a/serial/port.c b/serial/port.c
index 4ef3437..f288f90 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -568,13 +568,13 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 }
 
 static const GDBusMethodTable port_methods[] = {
-	{ _GDBUS_ASYNC_METHOD("Connect", "s", "s",
+	{ GDBUS_ASYNC_METHOD("Connect",
 		GDBUS_ARGS({ "pattern", "s" }),	GDBUS_ARGS({ "tty", "s" }),
 		port_connect) },
-	{ _GDBUS_ASYNC_METHOD("ConnectFD", "s", "h",
+	{ GDBUS_ASYNC_METHOD("ConnectFD",
 		GDBUS_ARGS({ "pattern", "s" }), GDBUS_ARGS({ "fd", "s" }),
 		port_connect) },
-	{ _GDBUS_METHOD("Disconnect", "s", "",
+	{ GDBUS_METHOD("Disconnect",
 		GDBUS_ARGS({ "device", "s" }), NULL,
 		port_disconnect) },
 	{ }
diff --git a/serial/proxy.c b/serial/proxy.c
index a2a9088..dd38317 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -729,12 +729,12 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 }
 
 static const GDBusMethodTable proxy_methods[] = {
-	{ _GDBUS_METHOD("Enable", "", "", NULL, NULL, proxy_enable) },
-	{ _GDBUS_METHOD("Disable", "", "", NULL, NULL, proxy_disable) },
-	{ _GDBUS_METHOD("GetInfo", "", "a{sv}",
+	{ GDBUS_METHOD("Enable", NULL, NULL, proxy_enable) },
+	{ GDBUS_METHOD("Disable", NULL, NULL, proxy_disable) },
+	{ GDBUS_METHOD("GetInfo",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			proxy_get_info) },
-	{ _GDBUS_METHOD("SetSerialParameters", "syys", "",
+	{ GDBUS_METHOD("SetSerialParameters",
 			GDBUS_ARGS({ "rate", "s" }, { "data", "y" },
 					{ "stop", "y" }, { "parity", "s" }),
 			NULL, proxy_set_serial_params) },
@@ -1117,23 +1117,23 @@ static void manager_path_unregister(void *data)
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ _GDBUS_METHOD("CreateProxy", "ss", "s",
+	{ GDBUS_METHOD("CreateProxy",
 			GDBUS_ARGS({ "pattern", "s" },
 					{ "address", "s" }),
 			GDBUS_ARGS({ "path", "s" }),
 			create_proxy) },
-	{ _GDBUS_METHOD("ListProxies", "", "as",
+	{ GDBUS_METHOD("ListProxies",
 			NULL, GDBUS_ARGS({ "paths", "as" }),
 			list_proxies) },
-	{ _GDBUS_METHOD("RemoveProxy", "s", "",
+	{ GDBUS_METHOD("RemoveProxy",
 			GDBUS_ARGS({ "path", "s" }), NULL,
 			remove_proxy) },
 	{ },
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ _GDBUS_SIGNAL("ProxyCreated", "s", GDBUS_ARGS({ "path", "s" })) },
-	{ _GDBUS_SIGNAL("ProxyRemoved", "s", GDBUS_ARGS({ "path", "s" })) },
+	{ GDBUS_SIGNAL("ProxyCreated", GDBUS_ARGS({ "path", "s" })) },
+	{ GDBUS_SIGNAL("ProxyRemoved", GDBUS_ARGS({ "path", "s" })) },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index d87406d..e2e466d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1656,63 +1656,63 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
-	{ _GDBUS_ASYNC_METHOD("RequestSession", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("RequestSession", NULL, NULL,
 			request_session) },
-	{ _GDBUS_METHOD("ReleaseSession", "", "", NULL, NULL,
+	{ GDBUS_METHOD("ReleaseSession", NULL, NULL,
 			release_session) },
-	{ _GDBUS_METHOD("StartDiscovery", "", "", NULL, NULL,
+	{ GDBUS_METHOD("StartDiscovery", NULL, NULL,
 			adapter_start_discovery) },
-	{ _GDBUS_ASYNC_METHOD("StopDiscovery", "", "", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("StopDiscovery", NULL, NULL,
 			adapter_stop_discovery) },
-	{ _GDBUS_DEPRECATED_METHOD("ListDevices", "", "ao",
+	{ GDBUS_DEPRECATED_METHOD("ListDevices",
 			NULL, GDBUS_ARGS({ "devices", "ao" }),
 			list_devices) },
-	{ _GDBUS_ASYNC_METHOD("CreateDevice", "s", "o",
+	{ GDBUS_ASYNC_METHOD("CreateDevice",
 			GDBUS_ARGS({ "address", "s" }),
 			GDBUS_ARGS({ "device", "o" }),
 			create_device) },
-	{ _GDBUS_ASYNC_METHOD("CreatePairedDevice", "sos", "o",
+	{ GDBUS_ASYNC_METHOD("CreatePairedDevice",
 			GDBUS_ARGS({ "address", "s" }, { "agent", "o" },
 							{ "capability", "s" }),
 			GDBUS_ARGS({ "device", "o" }),
 			create_paired_device) },
-	{ _GDBUS_ASYNC_METHOD("CancelDeviceCreation", "s", "",
+	{ GDBUS_ASYNC_METHOD("CancelDeviceCreation",
 			GDBUS_ARGS({ "address", "s" }), NULL,
 			cancel_device_creation) },
-	{ _GDBUS_ASYNC_METHOD("RemoveDevice", "o", "",
+	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL,
 			remove_device) },
-	{ _GDBUS_METHOD("FindDevice", "s", "o",
+	{ GDBUS_METHOD("FindDevice",
 			GDBUS_ARGS({ "address", "s" }),
 			GDBUS_ARGS({ "device", "o" }),
 			find_device) },
-	{ _GDBUS_METHOD("RegisterAgent", "os", "",
+	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "agent", "o" },
 					{ "capability", "s" }), NULL,
 			register_agent) },
-	{ _GDBUS_METHOD("UnregisterAgent", "o", "",
+	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_agent) },
 	{ }
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("DeviceCreated", "o",
+	{ GDBUS_SIGNAL("DeviceCreated",
 			GDBUS_ARGS({ "device", "o" })) },
-	{ _GDBUS_SIGNAL("DeviceRemoved", "o",
+	{ GDBUS_SIGNAL("DeviceRemoved",
 			GDBUS_ARGS({ "device", "o" })) },
-	{ _GDBUS_SIGNAL("DeviceFound", "sa{sv}",
+	{ GDBUS_SIGNAL("DeviceFound",
 			GDBUS_ARGS({ "address", "s" },
 						{ "values", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("DeviceDisappeared", "s",
+	{ GDBUS_SIGNAL("DeviceDisappeared",
 			GDBUS_ARGS({ "address", "s" })) },
 	{ }
 };
diff --git a/src/device.c b/src/device.c
index 2dc60e2..2695b16 100644
--- a/src/device.c
+++ b/src/device.c
@@ -878,25 +878,25 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
-	{ _GDBUS_METHOD("SetProperty", "sv", "",
+	{ GDBUS_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				get_properties) },
+	{ GDBUS_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
-	{ _GDBUS_ASYNC_METHOD("DiscoverServices", "s", "a{us}",
+	{ GDBUS_ASYNC_METHOD("DiscoverServices",
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "services", "a{us}" }),
 			discover_services) },
-	{ _GDBUS_METHOD("CancelDiscovery", "", "", NULL, NULL, cancel_discover) },
-	{ _GDBUS_ASYNC_METHOD("Disconnect", "", "", NULL, NULL, disconnect) },
+	{ GDBUS_METHOD("CancelDiscovery", NULL, NULL, cancel_discover) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect) },
 	{ }
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("DisconnectRequested", "", NULL) },
+	{ GDBUS_SIGNAL("DisconnectRequested", NULL) },
 	{ }
 };
 
diff --git a/src/manager.c b/src/manager.c
index 42c1a65..385354d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,30 +197,30 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_METHOD("DefaultAdapter", "", "o",
+	{ GDBUS_METHOD("DefaultAdapter",
 			NULL, GDBUS_ARGS({ "adapter", "o" }),
 			default_adapter) },
-	{ _GDBUS_METHOD("FindAdapter", "s", "o",
+	{ GDBUS_METHOD("FindAdapter",
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "adapter", "o" }),
 			find_adapter) },
-	{ _GDBUS_ASYNC_METHOD("ListAdapters", "", "ao",
+	{ GDBUS_ASYNC_METHOD("ListAdapters",
 			NULL, GDBUS_ARGS({ "adapters", "ao" }),
 			list_adapters) },
 	{ }
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ _GDBUS_SIGNAL("AdapterAdded", "o",
+	{ GDBUS_SIGNAL("AdapterAdded",
 			GDBUS_ARGS({ "adapter", "o" })) },
-	{ _GDBUS_SIGNAL("AdapterRemoved", "o",
+	{ GDBUS_SIGNAL("AdapterRemoved",
 			GDBUS_ARGS({ "adapter", "o" })) },
-	{ _GDBUS_SIGNAL("DefaultAdapterChanged", "o",
+	{ GDBUS_SIGNAL("DefaultAdapterChanged",
 			GDBUS_ARGS({ "adapter", "o" })) },
 	{ }
 };
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 4256f14..7ffd401 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -960,29 +960,29 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable thermometer_methods[] = {
-	{ _GDBUS_METHOD("GetProperties", "", "a{sv}",
+	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
-	{ _GDBUS_ASYNC_METHOD("SetProperty", "sv", "",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
 			set_property) },
-	{ _GDBUS_METHOD("RegisterWatcher", "o", "",
+	{ GDBUS_METHOD("RegisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			register_watcher) },
-	{ _GDBUS_METHOD("UnregisterWatcher", "o", "",
+	{ GDBUS_METHOD("UnregisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_watcher) },
-	{ _GDBUS_METHOD("EnableIntermediateMeasurement", "o", "",
+	{ GDBUS_METHOD("EnableIntermediateMeasurement",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			enable_intermediate) },
-	{ _GDBUS_METHOD("DisableIntermediateMeasurement","o", "",
+	{ GDBUS_METHOD("DisableIntermediateMeasurement",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			disable_intermediate) },
 	{ }
 };
 
 static const GDBusSignalTable thermometer_signals[] = {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
-- 
1.7.10.2

