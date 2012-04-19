Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 5/6] gdbus: add decorated signature to arguments
Date: Thu, 19 Apr 2012 13:02:24 -0300
Message-Id: <1334851345-11058-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1334851345-11058-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334851345-11058-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c           |    6 +++---
 audio/control.c           |    2 +-
 audio/device.c            |    2 +-
 audio/gateway.c           |    6 +++---
 audio/headset.c           |   12 ++++++------
 audio/media.c             |    8 ++++----
 audio/sink.c              |    2 +-
 audio/source.c            |    2 +-
 audio/telephony-dummy.c   |   14 +++++++-------
 audio/telephony-maemo5.c  |    2 +-
 audio/transport.c         |    8 ++++----
 doc/serial-api.txt        |    2 +-
 health/hdp.c              |   14 +++++++-------
 input/device.c            |    2 +-
 network/connection.c      |    4 ++--
 network/server.c          |    4 ++--
 plugins/dbusoob.c         |    4 ++--
 plugins/service.c         |    8 ++++----
 proximity/monitor.c       |    4 ++--
 proximity/reporter.c      |    2 +-
 sap/sap-dummy.c           |    6 +++---
 sap/server.c              |    2 +-
 serial/port.c             |    6 +++---
 serial/proxy.c            |   12 ++++++------
 src/adapter.c             |   28 ++++++++++++++--------------
 src/device.c              |    6 +++---
 src/manager.c             |   10 +++++-----
 thermometer/thermometer.c |   14 +++++++-------
 28 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 35f1c90..0a5904d 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -517,7 +517,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 static GDBusMethodTable char_methods[] = {
 	{ "GetProperties",	"",	"a{sv}", get_properties },
-	{ "SetProperty",	"sv",	"",	set_property,
+	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
 };
@@ -1018,9 +1018,9 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 static GDBusMethodTable prim_methods[] = {
 	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
 					G_DBUS_METHOD_FLAG_ASYNC	},
-	{ "RegisterCharacteristicsWatcher",	"o", "",
+	{ "RegisterCharacteristicsWatcher",	"o[agent]", "",
 						register_watcher	},
-	{ "UnregisterCharacteristicsWatcher",	"o", "",
+	{ "UnregisterCharacteristicsWatcher",	"o[agent]", "",
 						unregister_watcher	},
 	{ "GetProperties",	"",	"a{sv}",prim_get_properties	},
 	{ }
diff --git a/audio/control.c b/audio/control.c
index a75e992..23bca56 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -209,7 +209,7 @@ static GDBusMethodTable control_methods[] = {
 static GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/device.c b/audio/device.c
index a9d35f9..3875319 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -627,7 +627,7 @@ static GDBusMethodTable dev_methods[] = {
 };
 
 static GDBusSignalTable dev_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 7b9347d..1e8943a 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -716,13 +716,13 @@ static GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetProperties", "", "a{sv}", ag_get_properties },
-	{ "RegisterAgent", "o", "", register_agent },
-	{ "UnregisterAgent", "o", "", unregister_agent },
+	{ "RegisterAgent", "o[agent]", "", register_agent },
+	{ "UnregisterAgent", "o[agent]", "", unregister_agent },
 	{ NULL, NULL, NULL, NULL }
 };
 
 static GDBusSignalTable gateway_signals[] = {
-	{ "PropertyChanged", "sv" },
+	{ "PropertyChanged", "s[name]v[value]" },
 	{ NULL, NULL }
 };
 
diff --git a/audio/headset.c b/audio/headset.c
index f15951d..61e09cb 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2072,12 +2072,12 @@ static GDBusMethodTable headset_methods[] = {
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetMicrophoneGain",	"",	"q",	hs_get_mic_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetSpeakerGain",	"q",	"",	hs_set_speaker_gain,
+	{ "SetSpeakerGain",	"q[gain]", "",	hs_set_speaker_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetMicrophoneGain",	"q",	"",	hs_set_mic_gain,
+	{ "SetMicrophoneGain",	"q[gain]", "",	hs_set_mic_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetProperties",	"",	"a{sv}",hs_get_properties },
-	{ "SetProperty",	"sv",	"",	hs_set_property },
+	{ "SetProperty",	"s[name]v[value]", "", hs_set_property },
 	{ NULL, NULL, NULL, NULL }
 };
 
@@ -2087,10 +2087,10 @@ static GDBusSignalTable headset_signals[] = {
 	{ "AnswerRequested",		""	},
 	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "SpeakerGainChanged",		"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "MicrophoneGainChanged",	"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "SpeakerGainChanged",		"q[gain]", G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "MicrophoneGainChanged",	"q[gain]", G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "CallTerminated",		""	},
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]" },
 	{ NULL, NULL }
 };
 
diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..6607230 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1706,10 +1706,10 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable media_methods[] = {
-	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
-	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
-	{ "RegisterPlayer",	"oa{sv}a{sv}","",	register_player },
-	{ "UnregisterPlayer",	"o",		"",	unregister_player },
+	{ "RegisterEndpoint", "o[endpoint]a{sv}[properties]", "", register_endpoint },
+	{ "UnregisterEndpoint", "o[endpoint]", "", unregister_endpoint },
+	{ "RegisterPlayer", "o[player]a{sv}[properties]a{sv}[metadata]", "", register_player },
+	{ "UnregisterPlayer", "o[player]", "", unregister_player },
 	{ },
 };
 
diff --git a/audio/sink.c b/audio/sink.c
index 52f70a9..790aad4 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -571,7 +571,7 @@ static GDBusSignalTable sink_signals[] = {
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/source.c b/audio/source.c
index 4c6e2d0..b9c7b77 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -486,7 +486,7 @@ static GDBusMethodTable source_methods[] = {
 };
 
 static GDBusSignalTable source_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
 
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 1f89079..ec94d17 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -379,14 +379,14 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 }
 
 static GDBusMethodTable dummy_methods[] = {
-	{ "OutgoingCall",	"s",	"",	outgoing_call		},
-	{ "IncomingCall",	"s",	"",	incoming_call		},
+	{ "OutgoingCall",	"s[number]", "", outgoing_call		},
+	{ "IncomingCall",	"s[number]", "", incoming_call		},
 	{ "CancelCall",		"",	"",	cancel_call		},
-	{ "SignalStrength",	"u",	"",	signal_strength		},
-	{ "BatteryLevel",	"u",	"",	battery_level		},
-	{ "RoamingStatus",	"b",	"",	roaming_status		},
-	{ "RegistrationStatus",	"b",	"",	registration_status	},
-	{ "SetSubscriberNumber","s",	"",	set_subscriber_number	},
+	{ "SignalStrength",	"u[strength]","", signal_strength	},
+	{ "BatteryLevel",	"u[level]", "", battery_level		},
+	{ "RoamingStatus",	"b[roaming]", "", roaming_status	},
+	{ "RegistrationStatus",	"b[registration]", "", registration_status },
+	{ "SetSubscriberNumber","s[number]", "", set_subscriber_number	},
 	{ }
 };
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 49230f1..4ee0f24 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1952,7 +1952,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable telephony_maemo_methods[] = {
-	{"SetCallerId",		"s",	"",	set_callerid,
+	{"SetCallerId",		"s[id]", "",	set_callerid,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
 };
diff --git a/audio/transport.c b/audio/transport.c
index 7bf7309..ae2c3f9 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -916,16 +916,16 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 
 static GDBusMethodTable transport_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "Acquire",		"s",	"hqq",		acquire,
+	{ "Acquire",		"s[accesstype]", "hqq", acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "Release",		"s",	"",		release,
+	{ "Release",		"s[accesstype]", "", release,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "SetProperty",	"sv",	"",		set_property },
+	{ "SetProperty",	"s[name]v[value]", "", set_property },
 	{ },
 };
 
 static GDBusSignalTable transport_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]" },
 	{ }
 };
 
diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index 0bdbdcd..e6319cf 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -26,7 +26,7 @@ Methods		string Connect(string pattern)
 					 org.bluez.Error.ConnectionAttemptFailed
 					 org.bluez.Error.NotSupported
 
-Methods		fd ConnectFD(string pattern) [experimental]
+		fd ConnectFD(string pattern) [experimental]
 
 			Connects to a specific RFCOMM based service on a
 			remote device and returns a file descriptor to talk
diff --git a/health/hdp.c b/health/hdp.c
index 455240c..2723910 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -425,8 +425,8 @@ static void manager_path_unregister(gpointer data)
 }
 
 static GDBusMethodTable health_manager_methods[] = {
-	{"CreateApplication", "a{sv}", "o", manager_create_application},
-	{"DestroyApplication", "o", "", manager_destroy_application},
+	{"CreateApplication", "a{sv}[config]", "o", manager_create_application},
+	{"DestroyApplication", "o[application]", "", manager_destroy_application},
 	{ NULL }
 };
 
@@ -2096,18 +2096,18 @@ static void health_device_destroy(void *data)
 static GDBusMethodTable health_device_methods[] = {
 	{"Echo",		"",	"b",	device_echo,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{"CreateChannel",	"os",	"o",	device_create_channel,
+	{"CreateChannel", "o[application]s[configuration]", "o", device_create_channel,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{"DestroyChannel",	"o",	"",	device_destroy_channel,
+	{"DestroyChannel", "o[channel]", "", device_destroy_channel,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{"GetProperties",	"",	"a{sv}", device_get_properties},
 	{ NULL }
 };
 
 static GDBusSignalTable health_device_signals[] = {
-	{"ChannelConnected",		"o"		},
-	{"ChannelDeleted",		"o"		},
-	{"PropertyChanged",		"sv"		},
+	{"ChannelConnected",		"o[channel]"		},
+	{"ChannelDeleted",		"o[channel]"		},
+	{"PropertyChanged",		"s[name]v[value]"	},
 	{ NULL }
 };
 
diff --git a/input/device.c b/input/device.c
index 59388d8..a30e0e5 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1028,7 +1028,7 @@ static GDBusMethodTable device_methods[] = {
 };
 
 static GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
 
diff --git a/network/connection.c b/network/connection.c
index 36b51a7..b4c3288 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -553,7 +553,7 @@ static void path_unregister(void *data)
 }
 
 static GDBusMethodTable connection_methods[] = {
-	{ "Connect",		"s",	"s",	connection_connect,
+	{ "Connect",		"s[uuid]",	"s",	connection_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	connection_disconnect	},
 	{ "GetProperties",	"",	"a{sv}",connection_get_properties },
@@ -561,7 +561,7 @@ static GDBusMethodTable connection_methods[] = {
 };
 
 static GDBusSignalTable connection_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
 
diff --git a/network/server.c b/network/server.c
index 58c7297..6cf9e18 100644
--- a/network/server.c
+++ b/network/server.c
@@ -686,8 +686,8 @@ static void path_unregister(void *data)
 }
 
 static GDBusMethodTable server_methods[] = {
-	{ "Register",	"ss",	"",	register_server		},
-	{ "Unregister",	"s",	"",	unregister_server	},
+	{ "Register",	"s[uuid]s[bridge]", "", register_server },
+	{ "Unregister",	"s[uuid]", "", unregister_server },
 	{ }
 };
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 2c03780..1612fab 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -176,8 +176,8 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable oob_methods[] = {
-	{"AddRemoteData",	"sayay",	"",	add_remote_data},
-	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
+	{"AddRemoteData", "s[address]ay[hash]ay[randomizer]", "", add_remote_data},
+	{"RemoveRemoteData", "s[address]", "", remove_remote_data},
 	{"ReadLocalData",	"",		"ayay",	read_local_data,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{}
diff --git a/plugins/service.c b/plugins/service.c
index 14a5cb6..19fe666 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -697,10 +697,10 @@ done:
 }
 
 static GDBusMethodTable service_methods[] = {
-	{ "AddRecord",		"s",	"u",	add_service_record	},
-	{ "UpdateRecord",	"us",	"",	update_service_record	},
-	{ "RemoveRecord",	"u",	"",	remove_service_record	},
-	{ "RequestAuthorization","su",	"",	request_authorization,
+	{ "AddRecord", "s[record]", "u", add_service_record },
+	{ "UpdateRecord", "u[handle]s[record]", "", update_service_record	},
+	{ "RemoveRecord", "u[handle]", "", remove_service_record },
+	{ "RequestAuthorization","s[address]u[handle]",	"", request_authorization,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CancelAuthorization", "",	"",	cancel_authorization	},
 	{ }
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 687b41c..903ab69 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -548,13 +548,13 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 static GDBusMethodTable monitor_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property,
+	{ "SetProperty",	"s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
 };
 
 static GDBusSignalTable monitor_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
 
diff --git a/proximity/reporter.c b/proximity/reporter.c
index cb30da5..ac32ef7 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -186,7 +186,7 @@ static GDBusMethodTable reporter_methods[] = {
 };
 
 static GDBusSignalTable reporter_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
 
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index acdec77..6c4af62 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -316,10 +316,10 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable dummy_methods[] = {
-	{ "OngoingCall", "b", "", ongoing_call},
-	{ "MaxMessageSize", "u", "", max_msg_size},
+	{ "OngoingCall", "b[ongoing]", "", ongoing_call},
+	{ "MaxMessageSize", "u[size]", "", max_msg_size},
 	{ "DisconnectImmediate", "", "", disconnect_immediate},
-	{ "CardStatus", "u", "", card_status},
+	{ "CardStatus", "u[status]", "", card_status},
 	{ }
 };
 
diff --git a/sap/server.c b/sap/server.c
index eaf9d86..e0fcd9b 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1310,7 +1310,7 @@ static GDBusMethodTable server_methods[] = {
 };
 
 static GDBusSignalTable server_signals[] = {
-	{ "PropertyChanged", "sv"},
+	{ "PropertyChanged", "s[name]v[value]"},
 	{ }
 };
 
diff --git a/serial/port.c b/serial/port.c
index ea45c7a..e7ec22b 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -568,9 +568,9 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 }
 
 static GDBusMethodTable port_methods[] = {
-	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ConnectFD",    "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "s", "",  port_disconnect },
+	{ "Connect", "s[pattern]", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ConnectFD", "s[pattern]", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", "s[device]", "",  port_disconnect },
 	{ }
 };
 
diff --git a/serial/proxy.c b/serial/proxy.c
index ea5c29f..b5631c7 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -732,7 +732,7 @@ static GDBusMethodTable proxy_methods[] = {
 	{ "Enable",			"",	"",	proxy_enable },
 	{ "Disable",			"",	"",	proxy_disable },
 	{ "GetInfo",			"",	"a{sv}",proxy_get_info },
-	{ "SetSerialParameters",	"syys",	"",	proxy_set_serial_params },
+	{ "SetSerialParameters", "s[rate]y[data]y[stop]s[parity]", "", proxy_set_serial_params },
 	{ },
 };
 
@@ -1112,15 +1112,15 @@ static void manager_path_unregister(void *data)
 }
 
 static GDBusMethodTable manager_methods[] = {
-	{ "CreateProxy",		"ss",	"s",	create_proxy },
-	{ "ListProxies",		"",	"as",	list_proxies },
-	{ "RemoveProxy",		"s",	"",	remove_proxy },
+	{ "CreateProxy", "s[pattern]s[address]", "s", create_proxy },
+	{ "ListProxies", "", "as", list_proxies },
+	{ "RemoveProxy", "s[path]", "", remove_proxy },
 	{ },
 };
 
 static GDBusSignalTable manager_signals[] = {
-	{ "ProxyCreated",		"s"	},
-	{ "ProxyRemoved",		"s"	},
+	{ "ProxyCreated", "s[path]" },
+	{ "ProxyRemoved", "s[path]" },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index 12b6aeb..eb015f6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1661,7 +1661,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 
 static GDBusMethodTable adapter_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties		},
-	{ "SetProperty",	"sv",	"",	set_property,
+	{ "SetProperty", "s[name]v[value]",	"",	set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "RequestSession",	"",	"",	request_session,
 						G_DBUS_METHOD_FLAG_ASYNC},
@@ -1671,26 +1671,26 @@ static GDBusMethodTable adapter_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "ListDevices",	"",	"ao",	list_devices,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
-	{ "CreateDevice",	"s",	"o",	create_device,
+	{ "CreateDevice", "s[address]", "o",	create_device,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CreatePairedDevice",	"sos",	"o",	create_paired_device,
+	{ "CreatePairedDevice", "s[address]o[agent]s[capability]", "o",
+			create_paired_device, G_DBUS_METHOD_FLAG_ASYNC},
+	{ "CancelDeviceCreation","s[address]", "", cancel_device_creation,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CancelDeviceCreation","s",	"",	cancel_device_creation,
+	{ "RemoveDevice", "o[device]", "", remove_device,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "RemoveDevice",	"o",	"",	remove_device,
-						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "FindDevice",		"s",	"o",	find_device		},
-	{ "RegisterAgent",	"os",	"",	register_agent		},
-	{ "UnregisterAgent",	"o",	"",	unregister_agent	},
+	{ "FindDevice",	"s[address]", "o", find_device },
+	{ "RegisterAgent", "o[agent]s[capability]", "", register_agent },
+	{ "UnregisterAgent", "o[agent]", "", unregister_agent },
 	{ }
 };
 
 static GDBusSignalTable adapter_signals[] = {
-	{ "PropertyChanged",		"sv"		},
-	{ "DeviceCreated",		"o"		},
-	{ "DeviceRemoved",		"o"		},
-	{ "DeviceFound",		"sa{sv}"	},
-	{ "DeviceDisappeared",		"s"		},
+	{ "PropertyChanged",		"s[name]v[value]"		},
+	{ "DeviceCreated",		"o[device]"			},
+	{ "DeviceRemoved",		"o[device]"			},
+	{ "DeviceFound",		"s[address]a{sv}[values]"	},
+	{ "DeviceDisappeared",		"s[address]"			},
 	{ }
 };
 
diff --git a/src/device.c b/src/device.c
index ea6fec2..493077a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -879,8 +879,8 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 
 static GDBusMethodTable device_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
-	{ "SetProperty",	"sv",	"",		set_property	},
-	{ "DiscoverServices",	"s",	"a{us}",	discover_services,
+	{ "SetProperty", "s[name]v[value]", "",		set_property	},
+	{ "DiscoverServices", "s[pattern]", "a{us}", discover_services,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CancelDiscovery",	"",	"",		cancel_discover	},
 	{ "Disconnect",		"",	"",		disconnect,
@@ -889,7 +889,7 @@ static GDBusMethodTable device_methods[] = {
 };
 
 static GDBusSignalTable device_signals[] = {
-	{ "PropertyChanged",		"sv"	},
+	{ "PropertyChanged",		"s[name]v[value]" },
 	{ "DisconnectRequested",	""	},
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index 6244516..258f966 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -199,17 +199,17 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter",	"s",	"o",	find_adapter	},
+	{ "FindAdapter", "s[pattern]", "o", find_adapter },
 	{ "ListAdapters",	"",	"ao",	list_adapters,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ }
 };
 
 static GDBusSignalTable manager_signals[] = {
-	{ "PropertyChanged",		"sv"	},
-	{ "AdapterAdded",		"o"	},
-	{ "AdapterRemoved",		"o"	},
-	{ "DefaultAdapterChanged",	"o"	},
+	{ "PropertyChanged",		"s[name]v[value]"	},
+	{ "AdapterAdded",		"o[adapter]"		},
+	{ "AdapterRemoved",		"o[adapter]"		},
+	{ "DefaultAdapterChanged",	"o[adapter]"		},
 	{ }
 };
 
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 92c0225..6fbb528 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -960,18 +960,18 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable thermometer_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "SetProperty",	"sv",	"",		set_property,
+	{ "GetProperties", "", "a{sv}", get_properties },
+	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RegisterWatcher",	"o",	"",		register_watcher },
-	{ "UnregisterWatcher",	"o",	"",		unregister_watcher },
-	{ "EnableIntermediateMeasurement", "o", "", enable_intermediate },
-	{ "DisableIntermediateMeasurement","o",	"", disable_intermediate },
+	{ "RegisterWatcher", "o[agent]", "", register_watcher },
+	{ "UnregisterWatcher", "o[agent]", "", unregister_watcher },
+	{ "EnableIntermediateMeasurement", "o[agent]", "", enable_intermediate },
+	{ "DisableIntermediateMeasurement","o[agent]", "", disable_intermediate },
 	{ }
 };
 
 static GDBusSignalTable thermometer_signals[] = {
-	{ "PropertyChanged",	"sv"	},
+	{ "PropertyChanged",	"s[name]v[value]" },
 	{ }
 };
 
-- 
1.7.10

