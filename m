Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 3/3] GATT: Profile support for EnableGatt
Date: Wed, 14 Mar 2012 10:07:13 +0200
Message-Id: <1331712433-27930-4-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331712433-27930-1-git-send-email-chen.ganir@ti.com>
References: <1331712433-27930-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Added support for the EnableGatt for all GATT profiles.
---
 alert/main.c           |    4 ++--
 plugins/gatt-example.c |    2 +-
 proximity/main.c       |   10 +++++++++-
 proximity/reporter.c   |    4 ++--
 src/main.conf          |    5 ++---
 thermometer/main.c     |   11 +++++++++++
 time/main.c            |    4 ++--
 7 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/alert/main.c b/alert/main.c
index 6e2e058..fe6fe8b 100644
--- a/alert/main.c
+++ b/alert/main.c
@@ -37,8 +37,8 @@
 static int alert_init(void)
 {
 	if (!main_opts.gatt_enabled) {
-		DBG("Attribute server is disabled");
-		return -1;
+		DBG("GATT is disabled !");
+		return -ENOTSUP;
 	}
 
 	return alert_server_init();
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 165d218..e4e2c6a 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -561,7 +561,7 @@ static struct btd_adapter_driver gatt_example_adapter_driver = {
 static int gatt_example_init(void)
 {
 	if (!main_opts.gatt_enabled) {
-		DBG("Attribute server is disabled");
+		DBG("GATT is disabled !");
 		return -ENOTSUP;
 	}
 
diff --git a/proximity/main.c b/proximity/main.c
index 5f0fc12..daca0bd 100644
--- a/proximity/main.c
+++ b/proximity/main.c
@@ -27,13 +27,14 @@
 #endif
 
 #include <errno.h>
-
+#include <stdint.h>
 #include <glib.h>
 #include <gdbus.h>
 
 #include "log.h"
 #include "plugin.h"
 #include "manager.h"
+#include "hcid.h"
 
 static DBusConnection *connection = NULL;
 static GKeyFile *config = NULL;
@@ -59,6 +60,10 @@ static GKeyFile *open_config_file(const char *file)
 
 static int proximity_init(void)
 {
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled !");
+		return -ENOTSUP;
+	}
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (connection == NULL)
@@ -76,6 +81,9 @@ static int proximity_init(void)
 
 static void proximity_exit(void)
 {
+	if (!main_opts.gatt_enabled)
+		return;
+
 	if (config)
 		g_key_file_free(config);
 
diff --git a/proximity/reporter.c b/proximity/reporter.c
index d4a4c96..d458327 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -173,8 +173,8 @@ static void register_immediate_alert(struct btd_adapter *adapter)
 int reporter_init(struct btd_adapter *adapter)
 {
 	if (!main_opts.gatt_enabled) {
-		DBG("Attribute server is disabled");
-		return -1;
+		DBG("GATT is disabled !");
+		return -ENOTSUP;
 	}
 
 	DBG("Proximity Reporter for adapter %p", adapter);
diff --git a/src/main.conf b/src/main.conf
index 321f622..469c077 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -62,6 +62,5 @@ NameResolving = true
 # that they were created for.
 DebugKeys = false
 
-# Enable the GATT Attribute Server. Default is false, because it is only
-# useful for testing.
-AttributeServer = false
+# Enable the GATT functionality. Default is false
+EnableGatt = false
diff --git a/thermometer/main.c b/thermometer/main.c
index 471764e..db9aae7 100644
--- a/thermometer/main.c
+++ b/thermometer/main.c
@@ -24,17 +24,25 @@
 #include <config.h>
 #endif
 
+#include <stdint.h>
 #include <glib.h>
 #include <errno.h>
 #include <gdbus.h>
 
 #include "plugin.h"
 #include "manager.h"
+#include "hcid.h"
+#include "log.h"
 
 static DBusConnection *connection = NULL;
 
 static int thermometer_init(void)
 {
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled !");
+		return -ENOTSUP;
+	}
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (connection == NULL)
 		return -EIO;
@@ -49,6 +57,9 @@ static int thermometer_init(void)
 
 static void thermometer_exit(void)
 {
+	if (!main_opts.gatt_enabled)
+		return;
+
 	thermometer_manager_exit();
 
 	dbus_connection_unref(connection);
diff --git a/time/main.c b/time/main.c
index cbcdb0d..5222251 100644
--- a/time/main.c
+++ b/time/main.c
@@ -37,8 +37,8 @@
 static int time_init(void)
 {
 	if (!main_opts.gatt_enabled) {
-		DBG("Attribute server is disabled");
-		return -1;
+		DBG("GATT is disabled !");
+		return -ENOTSUP;
 	}
 
 	return time_server_init();
-- 
1.7.4.1

