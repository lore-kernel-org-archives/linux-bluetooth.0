Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 09/10] Constify GDBus method tables
Date: Fri, 27 Apr 2012 18:14:44 -0300
Message-Id: <1335561285-3332-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c           |    4 ++--
 audio/control.c           |    2 +-
 audio/device.c            |    2 +-
 audio/gateway.c           |    2 +-
 audio/headset.c           |    2 +-
 audio/media.c             |    2 +-
 audio/sink.c              |    2 +-
 audio/source.c            |    2 +-
 audio/telephony-dummy.c   |    2 +-
 audio/telephony-maemo5.c  |    2 +-
 audio/transport.c         |    2 +-
 gdbus/object.c            |    2 +-
 health/hdp.c              |    6 +++---
 input/device.c            |    2 +-
 network/connection.c      |    2 +-
 network/server.c          |    2 +-
 plugins/dbusoob.c         |    2 +-
 plugins/service.c         |    2 +-
 proximity/monitor.c       |    2 +-
 proximity/reporter.c      |    2 +-
 sap/sap-dummy.c           |    2 +-
 sap/server.c              |    2 +-
 serial/port.c             |    2 +-
 serial/proxy.c            |    4 ++--
 src/adapter.c             |    2 +-
 src/device.c              |    2 +-
 src/manager.c             |    2 +-
 thermometer/thermometer.c |    2 +-
 28 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 7d3c3a5..7c9dc7a 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -515,7 +515,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable char_methods[] = {
+static const GDBusMethodTable char_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
@@ -1015,7 +1015,7 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static GDBusMethodTable prim_methods[] = {
+static const GDBusMethodTable prim_methods[] = {
 	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
 					G_DBUS_METHOD_FLAG_ASYNC	},
 	{ "RegisterCharacteristicsWatcher",	"o[agent]", "",
diff --git a/audio/control.c b/audio/control.c
index 23bca56..650239c 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -197,7 +197,7 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable control_methods[] = {
+static const GDBusMethodTable control_methods[] = {
 	{ "IsConnected",	"",	"b",	control_is_connected,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetProperties",	"",	"a{sv}",control_get_properties },
diff --git a/audio/device.c b/audio/device.c
index 09cc0b1..1ede250 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -618,7 +618,7 @@ static DBusMessage *dev_get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static GDBusMethodTable dev_methods[] = {
+static const GDBusMethodTable dev_methods[] = {
 	{ "Connect",		"",	"",	dev_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	dev_disconnect },
diff --git a/audio/gateway.c b/audio/gateway.c
index 742db0e..d5fef0d 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -712,7 +712,7 @@ done:
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable gateway_methods[] = {
+static const GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetProperties", "", "a{sv}[properties]", ag_get_properties },
diff --git a/audio/headset.c b/audio/headset.c
index 2e465c9..06dc3b0 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2055,7 +2055,7 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable headset_methods[] = {
+static const GDBusMethodTable headset_methods[] = {
 	{ "Connect",		"",	"",	hs_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	hs_disconnect },
diff --git a/audio/media.c b/audio/media.c
index 6607230..46de99c 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1705,7 +1705,7 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable media_methods[] = {
+static const GDBusMethodTable media_methods[] = {
 	{ "RegisterEndpoint", "o[endpoint]a{sv}[properties]", "", register_endpoint },
 	{ "UnregisterEndpoint", "o[endpoint]", "", unregister_endpoint },
 	{ "RegisterPlayer", "o[player]a{sv}[properties]a{sv}[metadata]", "", register_player },
diff --git a/audio/sink.c b/audio/sink.c
index c33e7ee..4db339e 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -555,7 +555,7 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable sink_methods[] = {
+static const GDBusMethodTable sink_methods[] = {
 	{ "Connect",		"",	"",	sink_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	sink_disconnect,
diff --git a/audio/source.c b/audio/source.c
index b7bdf44..79f42b5 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -476,7 +476,7 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable source_methods[] = {
+static const GDBusMethodTable source_methods[] = {
 	{ "Connect",		"",	"",	source_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	source_disconnect,
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index ec94d17..c0f7ada 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -378,7 +378,7 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable dummy_methods[] = {
+static const GDBusMethodTable dummy_methods[] = {
 	{ "OutgoingCall",	"s[number]", "", outgoing_call		},
 	{ "IncomingCall",	"s[number]", "", incoming_call		},
 	{ "CancelCall",		"",	"",	cancel_call		},
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 4ee0f24..b7ec679 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1951,7 +1951,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable telephony_maemo_methods[] = {
+static const GDBusMethodTable telephony_maemo_methods[] = {
 	{"SetCallerId",		"s[id]", "",	set_callerid,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
diff --git a/audio/transport.c b/audio/transport.c
index 3b5ed47..69dcb32 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -914,7 +914,7 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static GDBusMethodTable transport_methods[] = {
+static const GDBusMethodTable transport_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]",	get_properties },
 	{ "Acquire",		"s[accesstype]", "h[fd]q[mtu_r]q[mtu_w]", acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/gdbus/object.c b/gdbus/object.c
index 1a75b45..540d1fc 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -549,7 +549,7 @@ done:
 	g_free(parent_path);
 }
 
-static GDBusMethodTable introspect_methods[] = {
+static const GDBusMethodTable introspect_methods[] = {
 	{ "Introspect",	"",	"s[xml]", introspect	},
 	{ }
 };
diff --git a/health/hdp.c b/health/hdp.c
index fc144cc..9dfd635 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -424,7 +424,7 @@ static void manager_path_unregister(gpointer data)
 	g_slist_foreach(adapters, (GFunc) update_adapter, NULL);
 }
 
-static GDBusMethodTable health_manager_methods[] = {
+static const GDBusMethodTable health_manager_methods[] = {
 	{"CreateApplication", "a{sv}[config]", "o[application]", manager_create_application},
 	{"DestroyApplication", "o[application]", "", manager_destroy_application},
 	{ NULL }
@@ -731,7 +731,7 @@ end:
 	hdp_channel_unref(hdp_chan);
 }
 
-static GDBusMethodTable health_channels_methods[] = {
+static const GDBusMethodTable health_channels_methods[] = {
 	{"GetProperties","",	"a{sv}[properties]",	channel_get_properties },
 	{"Acquire",	"",	"h[fd]",		channel_acquire,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -2093,7 +2093,7 @@ static void health_device_destroy(void *data)
 	health_device_unref(device);
 }
 
-static GDBusMethodTable health_device_methods[] = {
+static const GDBusMethodTable health_device_methods[] = {
 	{"Echo",		"",	"b",	device_echo,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{"CreateChannel", "o[application]s[configuration]", "o[channel]", device_create_channel,
diff --git a/input/device.c b/input/device.c
index 602d7c5..cade3bc 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1019,7 +1019,7 @@ static DBusMessage *input_device_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable device_methods[] = {
+static const GDBusMethodTable device_methods[] = {
 	{ "Connect",		"",	"",	input_device_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	input_device_disconnect	},
diff --git a/network/connection.c b/network/connection.c
index 282234e..4895c7d 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -552,7 +552,7 @@ static void path_unregister(void *data)
 	peer_free(peer);
 }
 
-static GDBusMethodTable connection_methods[] = {
+static const GDBusMethodTable connection_methods[] = {
 	{ "Connect", "s[uuid]", "s[interface_name]", connection_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	connection_disconnect	},
diff --git a/network/server.c b/network/server.c
index 6cf9e18..15a5816 100644
--- a/network/server.c
+++ b/network/server.c
@@ -685,7 +685,7 @@ static void path_unregister(void *data)
 	adapter_free(na);
 }
 
-static GDBusMethodTable server_methods[] = {
+static const GDBusMethodTable server_methods[] = {
 	{ "Register",	"s[uuid]s[bridge]", "", register_server },
 	{ "Unregister",	"s[uuid]", "", unregister_server },
 	{ }
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index d147b1b..fa2b776 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -175,7 +175,7 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable oob_methods[] = {
+static const GDBusMethodTable oob_methods[] = {
 	{"AddRemoteData", "s[address]ay[hash]ay[randomizer]", "", add_remote_data},
 	{"RemoveRemoteData", "s[address]", "", remove_remote_data},
 	{"ReadLocalData", "", "ay[hash]ay[randomizer]", read_local_data,
diff --git a/plugins/service.c b/plugins/service.c
index 19fe666..37eb27a 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -696,7 +696,7 @@ done:
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable service_methods[] = {
+static const GDBusMethodTable service_methods[] = {
 	{ "AddRecord", "s[record]", "u", add_service_record },
 	{ "UpdateRecord", "u[handle]s[record]", "", update_service_record	},
 	{ "RemoveRecord", "u[handle]", "", remove_service_record },
diff --git a/proximity/monitor.c b/proximity/monitor.c
index a2f1479..8b103e5 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -546,7 +546,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable monitor_methods[] = {
+static const GDBusMethodTable monitor_methods[] = {
 	{ "GetProperties", "", "a{sv}[properties]", get_properties	},
 	{ "SetProperty",	"s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/proximity/reporter.c b/proximity/reporter.c
index cc4920c..511c7a4 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -180,7 +180,7 @@ err:
 	return btd_error_failed(msg, "not enough memory");
 }
 
-static GDBusMethodTable reporter_methods[] = {
+static const GDBusMethodTable reporter_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]",	get_properties	},
 	{ }
 };
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 6c4af62..5d3f7d6 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -315,7 +315,7 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable dummy_methods[] = {
+static const GDBusMethodTable dummy_methods[] = {
 	{ "OngoingCall", "b[ongoing]", "", ongoing_call},
 	{ "MaxMessageSize", "u[size]", "", max_msg_size},
 	{ "DisconnectImmediate", "", "", disconnect_immediate},
diff --git a/sap/server.c b/sap/server.c
index fdedd83..90b007e 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1303,7 +1303,7 @@ static DBusMessage *get_properties(DBusConnection *c,
 	return reply;
 }
 
-static GDBusMethodTable server_methods[] = {
+static const GDBusMethodTable server_methods[] = {
 	{"GetProperties", "", "a{sv}[properties]", get_properties},
 	{"Disconnect", "", "", disconnect},
 	{ }
diff --git a/serial/port.c b/serial/port.c
index e6b6957..89468e3 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -567,7 +567,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable port_methods[] = {
+static const GDBusMethodTable port_methods[] = {
 	{ "Connect", "s[pattern]", "s[tty]", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "ConnectFD", "s[pattern]", "h[fd]", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "s[device]", "",  port_disconnect },
diff --git a/serial/proxy.c b/serial/proxy.c
index 3dd9fbf..d6cfa2d 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -728,7 +728,7 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable proxy_methods[] = {
+static const GDBusMethodTable proxy_methods[] = {
 	{ "Enable",			"",	"",	proxy_enable },
 	{ "Disable",			"",	"",	proxy_disable },
 	{ "GetInfo", "", "a{sv}[properties]", proxy_get_info },
@@ -1111,7 +1111,7 @@ static void manager_path_unregister(void *data)
 	g_free(adapter);
 }
 
-static GDBusMethodTable manager_methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ "CreateProxy", "s[pattern]s[address]", "s[path]", create_proxy },
 	{ "ListProxies", "", "as[paths]", list_proxies },
 	{ "RemoveProxy", "s[path]", "", remove_proxy },
diff --git a/src/adapter.c b/src/adapter.c
index d219f7d..16a11c5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1659,7 +1659,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable adapter_methods[] = {
+static const GDBusMethodTable adapter_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]",get_properties },
 	{ "SetProperty", "s[name]v[value]",	"",	set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/src/device.c b/src/device.c
index 50086ca..e2a83f7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -877,7 +877,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static GDBusMethodTable device_methods[] = {
+static const GDBusMethodTable device_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "",		set_property	},
 	{ "DiscoverServices", "s[pattern]", "a{us}[services]", discover_services,
diff --git a/src/manager.c b/src/manager.c
index 57833f0..ef9150c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -196,7 +196,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable manager_methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}[properties]",get_properties	},
 	{ "DefaultAdapter",	"",	"o[adapter]",	default_adapter	},
 	{ "FindAdapter", "s[pattern]", "o[adapter]", find_adapter },
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 09760fd..674150d 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -959,7 +959,7 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable thermometer_methods[] = {
+static const GDBusMethodTable thermometer_methods[] = {
 	{ "GetProperties", "", "a{sv}[properties]", get_properties },
 	{ "SetProperty", "s[name]v[value]", "", set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
-- 
1.7.10

