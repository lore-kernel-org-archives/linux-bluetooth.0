Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] core: Remove defunct option AutoConnectTimeout
Message-ID: <6d4a8197-bb65-d327-5c75-e84d52207b19@jp.fujitsu.com>
Date: Thu, 12 Oct 2017 17:06:24 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the useless option AutoConnectTimeout since the commit dd3f4ca901
("plugins: remove unmaintained plugins") removed
btd_adapter_enable_auto_connect() for which this option was only intended.
---
 src/hcid.h    |  1 -
 src/main.c    | 11 -----------
 src/main.conf |  6 ------
 3 files changed, 18 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index 552d63bc..62e2bd6 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -38,7 +38,6 @@ typedef enum {
 struct main_opts {
 	char		*name;
 	uint32_t	class;
-	uint16_t	autoto;
 	uint32_t	pairto;
 	uint32_t	discovto;
 	uint8_t		privacy;
diff --git a/src/main.c b/src/main.c
index fc50bbd..21f0b14 100644
--- a/src/main.c
+++ b/src/main.c
@@ -82,7 +82,6 @@ static const char *supported_options[] = {
 	"Class",
 	"DiscoverableTimeout",
 	"PairableTimeout",
-	"AutoConnectTimeout",
 	"DeviceID",
 	"ReverseServiceDiscovery",
 	"NameResolving",
@@ -297,16 +296,6 @@ static void parse_config(GKeyFile *config)
 		main_opts.pairto = val;
 	}
 
-	val = g_key_file_get_integer(config, "General", "AutoConnectTimeout",
-									&err);
-	if (err) {
-		DBG("%s", err->message);
-		g_clear_error(&err);
-	} else {
-		DBG("auto_to=%d", val);
-		main_opts.autoto = val;
-	}
-
 	str = g_key_file_get_string(config, "General", "Privacy", &err);
 	if (err) {
 		DBG("%s", err->message);
diff --git a/src/main.conf b/src/main.conf
index ba17405..21986b3 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -18,12 +18,6 @@
 # 0 = disable timer, i.e. stay pairable forever
 #PairableTimeout = 0
 
-# Automatic connection for bonded devices driven by platform/user events.
-# If a platform plugin uses this mechanism, automatic connections will be
-# enabled during the interval defined below. Initially, this feature
-# intends to be used to establish connections to ATT channels. Default is 60.
-#AutoConnectTimeout = 60
-
 # Use vendor id source (assigner), vendor, product and version information for
 # DID profile support. The values are separated by ":" and assigner, VID, PID
 # and version.
-- 
2.7.4

