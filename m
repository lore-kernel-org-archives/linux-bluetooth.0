Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 6/6] gdbus: add decorated signature to return values
Date: Thu, 19 Apr 2012 13:02:25 -0300
Message-Id: <1334851345-11058-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1334851345-11058-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334851345-11058-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c           |    4 ++--
 audio/device.c            |    2 +-
 audio/gateway.c           |    2 +-
 audio/headset.c           |    6 +++---
 audio/sink.c              |    2 +-
 audio/source.c            |    2 +-
 audio/transport.c         |    4 ++--
 gdbus/object.c            |    2 +-
 health/hdp.c              |   10 +++++-----
 input/device.c            |    2 +-
 network/connection.c      |    4 ++--
 plugins/dbusoob.c         |    2 +-
 proximity/monitor.c       |    2 +-
 proximity/reporter.c      |    2 +-
 sap/server.c              |    2 +-
 serial/port.c             |    4 ++--
 serial/proxy.c            |    6 +++---
 src/adapter.c             |   10 +++++-----
 src/device.c              |    4 ++--
 src/manager.c             |    8 ++++----
 thermometer/thermometer.c |    2 +-
 21 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0a5904d..7d3c3a5 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -516,7 +516,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static GDBusMethodTable char_methods[] = {
-	{ "GetProperties",	"",	"a{sv}", get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
@@ -1022,7 +1022,7 @@ static GDBusMethodTable prim_methods[] = {
 						register_watcher	},
 	{ "UnregisterCharacteristicsWatcher",	"o[agent]", "",
 						unregister_watcher	},
-	{ "GetProperties",	"",	"a{sv}",prim_get_properties	},
+	{ "GetProperties",	"",	"a{sv}[properties]",prim_get_properties	},
 	{ }
 };
 
diff --git a/audio/device.c b/audio/device.c
index 3875319..09cc0b1 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -622,7 +622,7 @@ static GDBusMethodTable dev_methods[] = {
 	{ "Connect",		"",	"",	dev_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	dev_disconnect },
-	{ "GetProperties",	"",	"a{sv}",dev_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]",dev_get_properties },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 1e8943a..742db0e 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -715,7 +715,7 @@ done:
 static GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties", "", "a{sv}", ag_get_properties },
+	{ "GetProperties", "", "a{sv}[properties]", ag_get_properties },
 	{ "RegisterAgent", "o[agent]", "", register_agent },
 	{ "UnregisterAgent", "o[agent]", "", unregister_agent },
 	{ NULL, NULL, NULL, NULL }
diff --git a/audio/headset.c b/audio/headset.c
index 61e09cb..2e465c9 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2068,15 +2068,15 @@ static GDBusMethodTable headset_methods[] = {
 	{ "Stop",		"",	"",	hs_stop },
 	{ "IsPlaying",		"",	"b",	hs_is_playing,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetSpeakerGain",	"",	"q",	hs_get_speaker_gain,
+	{ "GetSpeakerGain",	"",	"q[gain]",	hs_get_speaker_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetMicrophoneGain",	"",	"q",	hs_get_mic_gain,
+	{ "GetMicrophoneGain",	"",	"q[gain]",	hs_get_mic_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "SetSpeakerGain",	"q[gain]", "",	hs_set_speaker_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "SetMicrophoneGain",	"q[gain]", "",	hs_set_mic_gain,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",hs_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]",hs_get_properties },
 	{ "SetProperty",	"s[name]v[value]", "", hs_set_property },
 	{ NULL, NULL, NULL, NULL }
 };
diff --git a/audio/sink.c b/audio/sink.c
index 790aad4..c33e7ee 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -562,7 +562,7 @@ static GDBusMethodTable sink_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "IsConnected",	"",	"b",	sink_is_connected,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetProperties",	"",	"a{sv}",sink_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]",sink_get_properties },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/audio/source.c b/audio/source.c
index b9c7b77..b7bdf44 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -481,7 +481,7 @@ static GDBusMethodTable source_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	source_disconnect,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetProperties",	"",	"a{sv}",source_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]",source_get_properties },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/audio/transport.c b/audio/transport.c
index ae2c3f9..3b5ed47 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -915,8 +915,8 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable transport_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties },
-	{ "Acquire",		"s[accesstype]", "hqq", acquire,
+	{ "GetProperties",	"",	"a{sv}[properties]",	get_properties },
+	{ "Acquire",		"s[accesstype]", "h[fd]q[mtu_r]q[mtu_w]", acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "Release",		"s[accesstype]", "", release,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/gdbus/object.c b/gdbus/object.c
index a2df77e..a4ab13d 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -529,7 +529,7 @@ done:
 }
 
 static GDBusMethodTable introspect_methods[] = {
-	{ "Introspect",	"",	"s", introspect	},
+	{ "Introspect",	"",	"s[xml]", introspect	},
 	{ }
 };
 
diff --git a/health/hdp.c b/health/hdp.c
index 2723910..fc144cc 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -425,7 +425,7 @@ static void manager_path_unregister(gpointer data)
 }
 
 static GDBusMethodTable health_manager_methods[] = {
-	{"CreateApplication", "a{sv}[config]", "o", manager_create_application},
+	{"CreateApplication", "a{sv}[config]", "o[application]", manager_create_application},
 	{"DestroyApplication", "o[application]", "", manager_destroy_application},
 	{ NULL }
 };
@@ -732,8 +732,8 @@ end:
 }
 
 static GDBusMethodTable health_channels_methods[] = {
-	{"GetProperties","",	"a{sv}",	channel_get_properties },
-	{"Acquire",	"",	"h",		channel_acquire,
+	{"GetProperties","",	"a{sv}[properties]",	channel_get_properties },
+	{"Acquire",	"",	"h[fd]",		channel_acquire,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{"Release",	"",	"",		channel_release },
 	{ NULL }
@@ -2096,11 +2096,11 @@ static void health_device_destroy(void *data)
 static GDBusMethodTable health_device_methods[] = {
 	{"Echo",		"",	"b",	device_echo,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{"CreateChannel", "o[application]s[configuration]", "o", device_create_channel,
+	{"CreateChannel", "o[application]s[configuration]", "o[channel]", device_create_channel,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{"DestroyChannel", "o[channel]", "", device_destroy_channel,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{"GetProperties",	"",	"a{sv}", device_get_properties},
+	{"GetProperties",	"",	"a{sv}[properties]", device_get_properties},
 	{ NULL }
 };
 
diff --git a/input/device.c b/input/device.c
index a30e0e5..602d7c5 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1023,7 +1023,7 @@ static GDBusMethodTable device_methods[] = {
 	{ "Connect",		"",	"",	input_device_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	input_device_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",input_device_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]", input_device_get_properties },
 	{ }
 };
 
diff --git a/network/connection.c b/network/connection.c
index b4c3288..282234e 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -553,10 +553,10 @@ static void path_unregister(void *data)
 }
 
 static GDBusMethodTable connection_methods[] = {
-	{ "Connect",		"s[uuid]",	"s",	connection_connect,
+	{ "Connect", "s[uuid]", "s[interface_name]", connection_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	connection_disconnect	},
-	{ "GetProperties",	"",	"a{sv}",connection_get_properties },
+	{ "GetProperties",	"",	"a{sv}[properties]",connection_get_properties },
 	{ }
 };
 
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 1612fab..d147b1b 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -178,7 +178,7 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 static GDBusMethodTable oob_methods[] = {
 	{"AddRemoteData", "s[address]ay[hash]ay[randomizer]", "", add_remote_data},
 	{"RemoveRemoteData", "s[address]", "", remove_remote_data},
-	{"ReadLocalData",	"",		"ayay",	read_local_data,
+	{"ReadLocalData", "", "ay[hash]ay[randomizer]", read_local_data,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{}
 };
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 903ab69..a2f1479 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -547,7 +547,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 }
 
 static GDBusMethodTable monitor_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ "GetProperties", "", "a{sv}[properties]", get_properties	},
 	{ "SetProperty",	"s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
diff --git a/proximity/reporter.c b/proximity/reporter.c
index ac32ef7..cc4920c 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -181,7 +181,7 @@ err:
 }
 
 static GDBusMethodTable reporter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ "GetProperties",	"",	"a{sv}[properties]",	get_properties	},
 	{ }
 };
 
diff --git a/sap/server.c b/sap/server.c
index e0fcd9b..fdedd83 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1304,7 +1304,7 @@ static DBusMessage *get_properties(DBusConnection *c,
 }
 
 static GDBusMethodTable server_methods[] = {
-	{"GetProperties", "", "a{sv}", get_properties},
+	{"GetProperties", "", "a{sv}[properties]", get_properties},
 	{"Disconnect", "", "", disconnect},
 	{ }
 };
diff --git a/serial/port.c b/serial/port.c
index e7ec22b..e6b6957 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -568,8 +568,8 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 }
 
 static GDBusMethodTable port_methods[] = {
-	{ "Connect", "s[pattern]", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ConnectFD", "s[pattern]", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Connect", "s[pattern]", "s[tty]", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ConnectFD", "s[pattern]", "h[fd]", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "s[device]", "",  port_disconnect },
 	{ }
 };
diff --git a/serial/proxy.c b/serial/proxy.c
index b5631c7..3dd9fbf 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -731,7 +731,7 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 static GDBusMethodTable proxy_methods[] = {
 	{ "Enable",			"",	"",	proxy_enable },
 	{ "Disable",			"",	"",	proxy_disable },
-	{ "GetInfo",			"",	"a{sv}",proxy_get_info },
+	{ "GetInfo", "", "a{sv}[properties]", proxy_get_info },
 	{ "SetSerialParameters", "s[rate]y[data]y[stop]s[parity]", "", proxy_set_serial_params },
 	{ },
 };
@@ -1112,8 +1112,8 @@ static void manager_path_unregister(void *data)
 }
 
 static GDBusMethodTable manager_methods[] = {
-	{ "CreateProxy", "s[pattern]s[address]", "s", create_proxy },
-	{ "ListProxies", "", "as", list_proxies },
+	{ "CreateProxy", "s[pattern]s[address]", "s[path]", create_proxy },
+	{ "ListProxies", "", "as[paths]", list_proxies },
 	{ "RemoveProxy", "s[path]", "", remove_proxy },
 	{ },
 };
diff --git a/src/adapter.c b/src/adapter.c
index eb015f6..2a1052a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1660,7 +1660,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable adapter_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties		},
+	{ "GetProperties",	"",	"a{sv}[properties]",get_properties },
 	{ "SetProperty", "s[name]v[value]",	"",	set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "RequestSession",	"",	"",	request_session,
@@ -1669,17 +1669,17 @@ static GDBusMethodTable adapter_methods[] = {
 	{ "StartDiscovery",	"",	"",	adapter_start_discovery },
 	{ "StopDiscovery",	"",	"",	adapter_stop_discovery,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "ListDevices",	"",	"ao",	list_devices,
+	{ "ListDevices",	"",	"ao[devices]",	list_devices,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
-	{ "CreateDevice", "s[address]", "o",	create_device,
+	{ "CreateDevice", "s[address]", "o[device]",	create_device,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "CreatePairedDevice", "s[address]o[agent]s[capability]", "o",
+	{ "CreatePairedDevice", "s[address]o[agent]s[capability]", "o[device]",
 			create_paired_device, G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CancelDeviceCreation","s[address]", "", cancel_device_creation,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "RemoveDevice", "o[device]", "", remove_device,
 						G_DBUS_METHOD_FLAG_ASYNC},
-	{ "FindDevice",	"s[address]", "o", find_device },
+	{ "FindDevice",	"s[address]", "o[device]", find_device },
 	{ "RegisterAgent", "o[agent]s[capability]", "", register_agent },
 	{ "UnregisterAgent", "o[agent]", "", unregister_agent },
 	{ }
diff --git a/src/device.c b/src/device.c
index 493077a..fdee598 100644
--- a/src/device.c
+++ b/src/device.c
@@ -878,9 +878,9 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable device_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ "GetProperties",	"",	"a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "",		set_property	},
-	{ "DiscoverServices", "s[pattern]", "a{us}", discover_services,
+	{ "DiscoverServices", "s[pattern]", "a{us}[services]", discover_services,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CancelDiscovery",	"",	"",		cancel_discover	},
 	{ "Disconnect",		"",	"",		disconnect,
diff --git a/src/manager.c b/src/manager.c
index 258f966..57833f0 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,10 +197,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static GDBusMethodTable manager_methods[] = {
-	{ "GetProperties",	"",	"a{sv}",get_properties	},
-	{ "DefaultAdapter",	"",	"o",	default_adapter	},
-	{ "FindAdapter", "s[pattern]", "o", find_adapter },
-	{ "ListAdapters",	"",	"ao",	list_adapters,
+	{ "GetProperties",	"",	"a{sv}[properties]",get_properties	},
+	{ "DefaultAdapter",	"",	"o[adapter]",	default_adapter	},
+	{ "FindAdapter", "s[pattern]", "o[adapter]", find_adapter },
+	{ "ListAdapters",	"",	"ao[adapters]",	list_adapters,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ }
 };
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 6fbb528..09760fd 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -960,7 +960,7 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable thermometer_methods[] = {
-	{ "GetProperties", "", "a{sv}", get_properties },
+	{ "GetProperties", "", "a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RegisterWatcher", "o[agent]", "", register_watcher },
-- 
1.7.10

