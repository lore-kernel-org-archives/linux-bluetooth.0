Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 04/13] Constify GDBus signal tables
Date: Thu,  3 May 2012 09:28:53 -0300
Message-Id: <1336048142-1194-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Constify signal tables with the following command:

    find . -name '*.[ch]' -exec \
             sed -i 's/\(GDBusSignalTable .* =\)/const \1/g' {} \;
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
index 14820c8..da23535 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -206,7 +206,7 @@ static const GDBusMethodTable control_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable control_signals[] = {
+static const GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "PropertyChanged",		"sv"	},
diff --git a/audio/device.c b/audio/device.c
index e6a4328..90115d4 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -626,7 +626,7 @@ static const GDBusMethodTable dev_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable dev_signals[] = {
+static const GDBusSignalTable dev_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ NULL, NULL }
 };
diff --git a/audio/gateway.c b/audio/gateway.c
index 5eee163..9194a7c 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -721,7 +721,7 @@ static const GDBusMethodTable gateway_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable gateway_signals[] = {
+static const GDBusSignalTable gateway_signals[] = {
 	{ "PropertyChanged", "sv" },
 	{ NULL, NULL }
 };
diff --git a/audio/headset.c b/audio/headset.c
index ca8f711..ebe9a7c 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2083,7 +2083,7 @@ static const GDBusMethodTable headset_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable headset_signals[] = {
+static const GDBusSignalTable headset_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
 	{ "AnswerRequested",		""	},
diff --git a/audio/sink.c b/audio/sink.c
index ea7f26e..fe4dd4b 100644
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
index 98f3e3f..04bf131 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -485,7 +485,7 @@ static const GDBusMethodTable source_methods[] = {
 	{ NULL, NULL, NULL, NULL }
 };
 
-static GDBusSignalTable source_signals[] = {
+static const GDBusSignalTable source_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ NULL, NULL }
 };
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 83c5a13..1885b4a 100644
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
index e9e40c6..7223f38 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -924,7 +924,7 @@ static const GDBusMethodTable transport_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable transport_signals[] = {
+static const GDBusSignalTable transport_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
diff --git a/health/hdp.c b/health/hdp.c
index 2d3f9bb..3b1ea49 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -2104,7 +2104,7 @@ static const GDBusMethodTable health_device_methods[] = {
 	{ NULL }
 };
 
-static GDBusSignalTable health_device_signals[] = {
+static const GDBusSignalTable health_device_signals[] = {
 	{"ChannelConnected",		"o"		},
 	{"ChannelDeleted",		"o"		},
 	{"PropertyChanged",		"sv"		},
diff --git a/input/device.c b/input/device.c
index ae76db1..286e9b7 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1027,7 +1027,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable device_signals[] = {
+static const GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
diff --git a/network/connection.c b/network/connection.c
index d1d417e..77d91d6 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -560,7 +560,7 @@ static const GDBusMethodTable connection_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable connection_signals[] = {
+static const GDBusSignalTable connection_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
diff --git a/proximity/monitor.c b/proximity/monitor.c
index cc90195..b4a52d2 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -553,7 +553,7 @@ static const GDBusMethodTable monitor_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable monitor_signals[] = {
+static const GDBusSignalTable monitor_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 983bd33..0a89537 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -185,7 +185,7 @@ static const GDBusMethodTable reporter_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable reporter_signals[] = {
+static const GDBusSignalTable reporter_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
diff --git a/sap/server.c b/sap/server.c
index fc1a4c1..b21b02b 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1309,7 +1309,7 @@ static const GDBusMethodTable server_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable server_signals[] = {
+static const GDBusSignalTable server_signals[] = {
 	{ "PropertyChanged", "sv"},
 	{ }
 };
diff --git a/serial/proxy.c b/serial/proxy.c
index 6c4c33f..5a91186 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -1118,7 +1118,7 @@ static const GDBusMethodTable manager_methods[] = {
 	{ },
 };
 
-static GDBusSignalTable manager_signals[] = {
+static const GDBusSignalTable manager_signals[] = {
 	{ "ProxyCreated",		"s"	},
 	{ "ProxyRemoved",		"s"	},
 	{ }
diff --git a/src/adapter.c b/src/adapter.c
index 19f45d7..e3352d4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1685,7 +1685,7 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable adapter_signals[] = {
+static const GDBusSignalTable adapter_signals[] = {
 	{ "PropertyChanged",		"sv"		},
 	{ "DeviceCreated",		"o"		},
 	{ "DeviceRemoved",		"o"		},
diff --git a/src/device.c b/src/device.c
index f9ec4b9..af4219f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -888,7 +888,7 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable device_signals[] = {
+static const GDBusSignalTable device_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ "DisconnectRequested",	""	},
 	{ }
diff --git a/src/manager.c b/src/manager.c
index 8b9243e..e6c1675 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -205,7 +205,7 @@ static const GDBusMethodTable manager_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable manager_signals[] = {
+static const GDBusSignalTable manager_signals[] = {
 	{ "PropertyChanged",		"sv"	},
 	{ "AdapterAdded",		"o"	},
 	{ "AdapterRemoved",		"o"	},
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 08117a6..1f7b6a6 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -970,7 +970,7 @@ static const GDBusMethodTable thermometer_methods[] = {
 	{ }
 };
 
-static GDBusSignalTable thermometer_signals[] = {
+static const GDBusSignalTable thermometer_signals[] = {
 	{ "PropertyChanged",	"sv"	},
 	{ }
 };
-- 
1.7.10

