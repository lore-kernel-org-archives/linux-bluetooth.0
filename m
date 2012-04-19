Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Remove DiscoverSchedulerInterval option from main.conf
Date: Thu, 19 Apr 2012 21:03:35 +0300
Message-Id: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This option was designed to be the time where name resolving would happen
in between inquiries, but with the introdution of mgmt interface this is
no longer the case as it treats the discovery as both inquiry/scan + name
resolving and keeping it just to delay discovery rounds is probably
useless.
---
 src/adapter.c |    5 ++---
 src/hcid.h    |    1 -
 src/main.c    |   10 ----------
 src/main.conf |    4 ----
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 01630dd..e5605c7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2541,11 +2541,10 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 	if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
 		return;
 
-	DBG("hci%u enabling timer, disc_sessions %u", adapter->dev_id,
+	DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
 					g_slist_length(adapter->disc_sessions));
 
-	adapter->discov_id = g_timeout_add_seconds(main_opts.discov_interval,
-							discovery_cb, adapter);
+	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
 
 static void suspend_discovery(struct btd_adapter *adapter)
diff --git a/src/hcid.h b/src/hcid.h
index 2c1cbff..1e5e15a 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -41,7 +41,6 @@ struct main_opts {
 	gboolean	gatt_enabled;
 
 	uint8_t		mode;
-	uint8_t		discov_interval;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
diff --git a/src/main.c b/src/main.c
index 8763bf9..b062b4a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -190,16 +190,6 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
-	val = g_key_file_get_integer(config, "General",
-					"DiscoverSchedulerInterval", &err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("discov_interval=%d", val);
-		main_opts.discov_interval = val;
-	}
-
 	boolean = g_key_file_get_boolean(config, "General",
 						"InitiallyPowered", &err);
 	if (err) {
diff --git a/src/main.conf b/src/main.conf
index 3419d07..787ef4f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -26,10 +26,6 @@ PairableTimeout = 0
 # which is 16384 (10 seconds).
 PageTimeout = 8192
 
-# Discover scheduler interval used in Adapter.DiscoverDevices
-# The value is in seconds. Defaults is 30.
-DiscoverSchedulerInterval = 30
-
 # Automatic connection for bonded devices driven by platform/user events.
 # If a platform plugin uses this mechanism, automatic connections will be
 # enabled during the interval defined below. Initially, this feature
-- 
1.7.7.6

