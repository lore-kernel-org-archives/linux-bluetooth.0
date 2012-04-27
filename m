Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 10/10] Constify GDBus signal tables
Date: Fri, 27 Apr 2012 18:14:45 -0300
Message-Id: <1335561285-3332-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c           |    2 +-
 audio/device.c            |    2 +-
 audio/gateway.c           |    2 +-
 audio/headset.c           |    2 +-
 audio/sink.c              |    2 +-
 audio/source.c            |    2 +-
 audio/telephony-dummy.c   |    2 +-
 audio/transport.c         |    2 +-
 health/hdp.c              |    2 +-
 input/device.c            |    2 +-
 network/connection.c      |    2 +-
 proximity/monitor.c       |    2 +-
 proximity/reporter.c      |    2 +-
 sap/server.c              |    2 +-
 serial/proxy.c            |    2 +-
 src/adapter.c             |    2 +-
 src/device.c              |    2 +-
 src/manager.c             |    2 +-
 thermometer/thermometer.c |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 650239c..aeee4c5 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -206,7 +206,7 @@ static const GDBusMethodTable control_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable control_signals[] = {
+static const GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "PropertyChanged",		"s[name]v[value]"	},
diff --git a/audio/device.c b/audio/device.c
index 1ede250..3a4632d 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -626,7 +626,7 @@ static const GDBusMethodTable dev_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable dev_signals[] = {
+static const GDBusSignalTable dev_signals[] = {
 	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
diff --git a/audio/gateway.c b/audio/gateway.c
index d5fef0d..677e16a 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -721,7 +721,7 @@ static const GDBusMethodTable gateway_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable gateway_signals[] = {
+static const GDBusSignalTable gateway_signals[] = {
 	{ "PropertyChanged", "s[name]v[value]" },
 	{ NULL, NULL }
 };
diff --git a/audio/headset.c b/audio/headset.c
index 06dc3b0..9117047 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2081,7 +2081,7 @@ static const GDBusMethodTable headset_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable headset_signals[] = {
+static const GDBusSignalTable headset_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "AnswerRequested",		""	},
diff --git a/audio/sink.c b/audio/sink.c
index 4db339e..8b27142 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -566,7 +566,7 @@ static const GDBusMethodTable sink_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable sink_signals[] = {
+static const GDBusSignalTable sink_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
diff --git a/audio/source.c b/audio/source.c
index 79f42b5..37dd6a5 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -485,7 +485,7 @@ static const GDBusMethodTable source_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable source_signals[] = {
+static const GDBusSignalTable source_signals[] = {
 	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ NULL, NULL }
 };
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index c0f7ada..de618f3 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -390,7 +390,7 @@ static const GDBusMethodTable dummy_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable dummy_signals[] = {
+static const GDBusSignalTable dummy_signals[] = {
 	{ "VoiceDial",	"" },
 	{ }
 };
diff --git a/audio/transport.c b/audio/transport.c
index 69dcb32..fbe3a0b 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -924,7 +924,7 @@ static const GDBusMethodTable transport_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable transport_signals[] = {
+static const GDBusSignalTable transport_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]" },
 	{ }
 };
diff --git a/health/hdp.c b/health/hdp.c
index 9dfd635..5cebc29 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -2104,7 +2104,7 @@ static const GDBusMethodTable health_device_methods[] = {
 	{ NULL }
 };
 
-static GDBusSignalTable health_device_signals[] = {
+static const GDBusSignalTable health_device_signals[] = {
 	{"ChannelConnected",		"o[channel]"		},
 	{"ChannelDeleted",		"o[channel]"		},
 	{"PropertyChanged",		"s[name]v[value]"	},
diff --git a/input/device.c b/input/device.c
index cade3bc..5b14d6e 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1027,7 +1027,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable device_signals[] = {
+static const GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
diff --git a/network/connection.c b/network/connection.c
index 4895c7d..0eb5cb9 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -560,7 +560,7 @@ static const GDBusMethodTable connection_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable connection_signals[] = {
+static const GDBusSignalTable connection_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 8b103e5..c255342 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -553,7 +553,7 @@ static const GDBusMethodTable monitor_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable monitor_signals[] = {
+static const GDBusSignalTable monitor_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 511c7a4..2a3274c 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -185,7 +185,7 @@ static const GDBusMethodTable reporter_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable reporter_signals[] = {
+static const GDBusSignalTable reporter_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]"	},
 	{ }
 };
diff --git a/sap/server.c b/sap/server.c
index 90b007e..6331075 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1309,7 +1309,7 @@ static const GDBusMethodTable server_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable server_signals[] = {
+static const GDBusSignalTable server_signals[] = {
 	{ "PropertyChanged", "s[name]v[value]"},
 	{ }
 };
diff --git a/serial/proxy.c b/serial/proxy.c
index d6cfa2d..7f23da3 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -1118,7 +1118,7 @@ static const GDBusMethodTable manager_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable manager_signals[] = {
+static const GDBusSignalTable manager_signals[] = {
 	{ "ProxyCreated", "s[path]" },
 	{ "ProxyRemoved", "s[path]" },
 	{ }
diff --git a/src/adapter.c b/src/adapter.c
index 16a11c5..772c926 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1685,7 +1685,7 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable adapter_signals[] = {
+static const GDBusSignalTable adapter_signals[] = {
 	{ "PropertyChanged",		"s[name]v[value]"		},
 	{ "DeviceCreated",		"o[device]"			},
 	{ "DeviceRemoved",		"o[device]"			},
diff --git a/src/device.c b/src/device.c
index e2a83f7..567ece1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -888,7 +888,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable device_signals[] = {
+static const GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",		"s[name]v[value]" },
 	{ "DisconnectRequested",	""	},
 	{ }
diff --git a/src/manager.c b/src/manager.c
index ef9150c..f43861d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -205,7 +205,7 @@ static const GDBusMethodTable manager_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable manager_signals[] = {
+static const GDBusSignalTable manager_signals[] = {
 	{ "PropertyChanged",		"s[name]v[value]"	},
 	{ "AdapterAdded",		"o[adapter]"		},
 	{ "AdapterRemoved",		"o[adapter]"		},
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 674150d..487c1fc 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -970,7 +970,7 @@ static const GDBusMethodTable thermometer_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable thermometer_signals[] = {
+static const GDBusSignalTable thermometer_signals[] = {
 	{ "PropertyChanged",	"s[name]v[value]" },
 	{ }
 };
-- 
1.7.10

