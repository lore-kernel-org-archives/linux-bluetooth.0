Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 11/11] Add automatic connect timeout config option
Date: Mon, 26 Sep 2011 14:48:28 -0300
Message-Id: <1317059308-20038-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new option in main.conf allowing change the default automatic
connection timer. This value defines how many seconds re-connection
for bonded devices will be active when a platform/user event triggers
the automatic re-connections.
---
 src/adapter.c |    3 +--
 src/hcid.h    |    1 +
 src/main.c    |   12 ++++++++++++
 src/main.conf |    6 ++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8ff4e3d..28063ad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -78,7 +78,6 @@
 #define check_address(address) bachk(address)
 
 #define OFF_TIMER 3
-#define AUTO_TIMER	60
 
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
@@ -3454,7 +3453,7 @@ void btd_adapter_enable_auto_connect(struct btd_adapter *adapter)
 
 	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
 
-	adapter->auto_timeout_id = g_timeout_add_seconds(AUTO_TIMER,
+	adapter->auto_timeout_id = g_timeout_add_seconds(main_opts.autoto,
 						disable_auto, adapter);
 }
 
diff --git a/src/hcid.h b/src/hcid.h
index ef25c79..e993a16 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -29,6 +29,7 @@ struct main_opts {
 	char		*name;
 	uint32_t	class;
 	uint16_t	pageto;
+	uint16_t	autoto;
 	uint32_t	discovto;
 	uint32_t	pairto;
 	uint16_t	link_mode;
diff --git a/src/main.c b/src/main.c
index 06becfe..5a953c3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -63,6 +63,7 @@
 #define LAST_ADAPTER_EXIT_TIMEOUT 30
 
 #define DEFAULT_DISCOVERABLE_TIMEOUT 180 /* 3 minutes */
+#define DEFAULT_AUTO_CONNECT_TIMEOUT  60 /* 60 seconds */
 
 struct main_opts main_opts;
 
@@ -128,6 +129,16 @@ static void parse_config(GKeyFile *config)
 		main_opts.flags |= 1 << HCID_SET_PAGETO;
 	}
 
+	val = g_key_file_get_integer(config, "General", "AutoConnectTimeout",
+									&err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("auto_to=%d", val);
+		main_opts.autoto = val;
+	}
+
 	str = g_key_file_get_string(config, "General", "Name", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -230,6 +241,7 @@ static void init_defaults(void)
 	main_opts.mode	= MODE_CONNECTABLE;
 	main_opts.name	= g_strdup("BlueZ");
 	main_opts.discovto	= DEFAULT_DISCOVERABLE_TIMEOUT;
+	main_opts.autoto = DEFAULT_AUTO_CONNECT_TIMEOUT;
 	main_opts.remember_powered = TRUE;
 	main_opts.reverse_sdp = TRUE;
 	main_opts.name_resolv = TRUE;
diff --git a/src/main.conf b/src/main.conf
index a9e2060..321f622 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -30,6 +30,12 @@ PageTimeout = 8192
 # The value is in seconds. Defaults is 30.
 DiscoverSchedulerInterval = 30
 
+# Automatic connection for bonded devices driven by platform/user events.
+# If a platform plugin uses this mechanism, automatic connections will be
+# enabled during the interval defined below. Initially, this feature
+# intends to be used to establish connections to ATT channels.
+AutoConnectTimeout = 60
+
 # What value should be assumed for the adapter Powered property when
 # SetProperty(Powered, ...) hasn't been called yet. Defaults to true
 InitiallyPowered = true
-- 
1.7.6.1

