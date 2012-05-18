Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH RESEND BlueZ v6 01/13] Constify GDBus method tables
Date: Fri, 18 May 2012 00:23:25 -0300
Message-Id: <1337311417-1245-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Constify method tables with the following command:

find . -name '*.[ch]' -exec \
	     sed -i 's/\(GDBusMethodTable .* =\)/const \1/g' {} \;
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
 27 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 35f1c90..2179f63 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -515,7 +515,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable char_methods[] = {
+static const GDBusMethodTable char_methods[] = {
 	{ "GetProperties",	"",	"a{sv}", get_properties },
 	{ "SetProperty",	"sv",	"",	set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
@@ -1015,7 +1015,7 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static GDBusMethodTable prim_methods[] = {
+static const GDBusMethodTable prim_methods[] = {
 	{ "DiscoverCharacteristics",	"",	"ao",	discover_char,
 					G_DBUS_METHOD_FLAG_ASYNC	},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
diff --git a/audio/control.c b/audio/control.c
index a75e992..14820c8 100644
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
index ee1ade1..7f454bb 100644
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
index 7b9347d..5eee163 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -712,7 +712,7 @@ done:
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable gateway_methods[] = {
+static const GDBusMethodTable gateway_methods[] = {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetProperties", "", "a{sv}", ag_get_properties },
diff --git a/audio/headset.c b/audio/headset.c
index fb10c36..ca8f711 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2057,7 +2057,7 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable headset_methods[] = {
+static const GDBusMethodTable headset_methods[] = {
 	{ "Connect",		"",	"",	hs_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	hs_disconnect },
diff --git a/audio/media.c b/audio/media.c
index 61ec153..7a83fbd 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1790,7 +1790,7 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable media_methods[] = {
+static const GDBusMethodTable media_methods[] = {
 	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
 	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
 	{ "RegisterPlayer",	"oa{sv}a{sv}","",	register_player },
diff --git a/audio/sink.c b/audio/sink.c
index 52f70a9..ea7f26e 100644
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
index 4c6e2d0..98f3e3f 100644
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
index 1f89079..83c5a13 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -378,7 +378,7 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable dummy_methods[] = {
+static const GDBusMethodTable dummy_methods[] = {
 	{ "OutgoingCall",	"s",	"",	outgoing_call		},
 	{ "IncomingCall",	"s",	"",	incoming_call		},
 	{ "CancelCall",		"",	"",	cancel_call		},
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 49230f1..6ab43b4 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1951,7 +1951,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable telephony_maemo_methods[] = {
+static const GDBusMethodTable telephony_maemo_methods[] = {
 	{"SetCallerId",		"s",	"",	set_callerid,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ }
diff --git a/audio/transport.c b/audio/transport.c
index 7bf7309..e9e40c6 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -914,7 +914,7 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static GDBusMethodTable transport_methods[] = {
+static const GDBusMethodTable transport_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties },
 	{ "Acquire",		"s",	"hqq",		acquire,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/health/hdp.c b/health/hdp.c
index 455240c..2d3f9bb 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -424,7 +424,7 @@ static void manager_path_unregister(gpointer data)
 	g_slist_foreach(adapters, (GFunc) update_adapter, NULL);
 }
 
-static GDBusMethodTable health_manager_methods[] = {
+static const GDBusMethodTable health_manager_methods[] = {
 	{"CreateApplication", "a{sv}", "o", manager_create_application},
 	{"DestroyApplication", "o", "", manager_destroy_application},
 	{ NULL }
@@ -731,7 +731,7 @@ end:
 	hdp_channel_unref(hdp_chan);
 }
 
-static GDBusMethodTable health_channels_methods[] = {
+static const GDBusMethodTable health_channels_methods[] = {
 	{"GetProperties","",	"a{sv}",	channel_get_properties },
 	{"Acquire",	"",	"h",		channel_acquire,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -2093,7 +2093,7 @@ static void health_device_destroy(void *data)
 	health_device_unref(device);
 }
 
-static GDBusMethodTable health_device_methods[] = {
+static const GDBusMethodTable health_device_methods[] = {
 	{"Echo",		"",	"b",	device_echo,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{"CreateChannel",	"os",	"o",	device_create_channel,
diff --git a/input/device.c b/input/device.c
index 092560d..2d8d724 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1060,7 +1060,7 @@ static DBusMessage *input_device_get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable device_methods[] = {
+static const GDBusMethodTable device_methods[] = {
 	{ "Connect",		"",	"",	input_device_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	input_device_disconnect	},
diff --git a/network/connection.c b/network/connection.c
index 36b51a7..d1d417e 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -552,7 +552,7 @@ static void path_unregister(void *data)
 	peer_free(peer);
 }
 
-static GDBusMethodTable connection_methods[] = {
+static const GDBusMethodTable connection_methods[] = {
 	{ "Connect",		"s",	"s",	connection_connect,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	connection_disconnect	},
diff --git a/network/server.c b/network/server.c
index 58c7297..688ec7d 100644
--- a/network/server.c
+++ b/network/server.c
@@ -685,7 +685,7 @@ static void path_unregister(void *data)
 	adapter_free(na);
 }
 
-static GDBusMethodTable server_methods[] = {
+static const GDBusMethodTable server_methods[] = {
 	{ "Register",	"ss",	"",	register_server		},
 	{ "Unregister",	"s",	"",	unregister_server	},
 	{ }
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 2c03780..bcd0556 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -175,7 +175,7 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable oob_methods[] = {
+static const GDBusMethodTable oob_methods[] = {
 	{"AddRemoteData",	"sayay",	"",	add_remote_data},
 	{"RemoveRemoteData",	"s",		"",	remove_remote_data},
 	{"ReadLocalData",	"",		"ayay",	read_local_data,
diff --git a/plugins/service.c b/plugins/service.c
index 14a5cb6..978e371 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -696,7 +696,7 @@ done:
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable service_methods[] = {
+static const GDBusMethodTable service_methods[] = {
 	{ "AddRecord",		"s",	"u",	add_service_record	},
 	{ "UpdateRecord",	"us",	"",	update_service_record	},
 	{ "RemoveRecord",	"u",	"",	remove_service_record	},
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 687b41c..cc90195 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -546,7 +546,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return btd_error_invalid_args(msg);
 }
 
-static GDBusMethodTable monitor_methods[] = {
+static const GDBusMethodTable monitor_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
 	{ "SetProperty",	"sv",	"",		set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/proximity/reporter.c b/proximity/reporter.c
index cb30da5..983bd33 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -180,7 +180,7 @@ err:
 	return btd_error_failed(msg, "not enough memory");
 }
 
-static GDBusMethodTable reporter_methods[] = {
+static const GDBusMethodTable reporter_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
 	{ }
 };
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 389548b..a2f2968 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -315,7 +315,7 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable dummy_methods[] = {
+static const GDBusMethodTable dummy_methods[] = {
 	{ "OngoingCall", "b", "", ongoing_call},
 	{ "MaxMessageSize", "u", "", max_msg_size},
 	{ "DisconnectImmediate", "", "", disconnect_immediate},
diff --git a/sap/server.c b/sap/server.c
index 945d599..39eddc8 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1303,7 +1303,7 @@ static DBusMessage *get_properties(DBusConnection *c,
 	return reply;
 }
 
-static GDBusMethodTable server_methods[] = {
+static const GDBusMethodTable server_methods[] = {
 	{"GetProperties", "", "a{sv}", get_properties},
 	{"Disconnect", "", "", disconnect},
 	{ }
diff --git a/serial/port.c b/serial/port.c
index ea45c7a..1c48bf7 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -567,7 +567,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static GDBusMethodTable port_methods[] = {
+static const GDBusMethodTable port_methods[] = {
 	{ "Connect",    "s", "s", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "ConnectFD",    "s", "h", port_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "s", "",  port_disconnect },
diff --git a/serial/proxy.c b/serial/proxy.c
index ea5c29f..6c4c33f 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -728,7 +728,7 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable proxy_methods[] = {
+static const GDBusMethodTable proxy_methods[] = {
 	{ "Enable",			"",	"",	proxy_enable },
 	{ "Disable",			"",	"",	proxy_disable },
 	{ "GetInfo",			"",	"a{sv}",proxy_get_info },
@@ -1111,7 +1111,7 @@ static void manager_path_unregister(void *data)
 	g_free(adapter);
 }
 
-static GDBusMethodTable manager_methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ "CreateProxy",		"ss",	"s",	create_proxy },
 	{ "ListProxies",		"",	"as",	list_proxies },
 	{ "RemoveProxy",		"s",	"",	remove_proxy },
diff --git a/src/adapter.c b/src/adapter.c
index 8e95ab2..9c9b08d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1655,7 +1655,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable adapter_methods[] = {
+static const GDBusMethodTable adapter_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties		},
 	{ "SetProperty",	"sv",	"",	set_property,
 						G_DBUS_METHOD_FLAG_ASYNC},
diff --git a/src/device.c b/src/device.c
index 2a8812e..b497431 100644
--- a/src/device.c
+++ b/src/device.c
@@ -877,7 +877,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static GDBusMethodTable device_methods[] = {
+static const GDBusMethodTable device_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
 	{ "SetProperty",	"sv",	"",		set_property	},
 	{ "DiscoverServices",	"s",	"a{us}",	discover_services,
diff --git a/src/manager.c b/src/manager.c
index 6244516..8b9243e 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -196,7 +196,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static GDBusMethodTable manager_methods[] = {
+static const GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
 	{ "FindAdapter",	"s",	"o",	find_adapter	},
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 92c0225..08117a6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -959,7 +959,7 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable thermometer_methods[] = {
+static const GDBusMethodTable thermometer_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties },
 	{ "SetProperty",	"sv",	"",		set_property,
 						G_DBUS_METHOD_FLAG_ASYNC },
-- 
1.7.10.2

