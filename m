Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 3/6] Add config file for proximity monitor
Date: Thu, 28 Jul 2011 11:43:19 -0300
Message-Id: <1311864199-16227-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial config file to disable Proximity and Find ME support in the
proximity monitor side. By default all services will be supported.
Config file is necessary at least to disable Find ME profile since the
Immediate Alert service is shared between Pass Loss and Find ME.
---
 Makefile.am              |    4 ++--
 proximity/main.c         |   30 +++++++++++++++++++++++++++++-
 proximity/manager.c      |   34 ++++++++++++++++++++++++++++++++--
 proximity/manager.h      |    2 +-
 proximity/proximity.conf |    9 +++++++++
 5 files changed, 73 insertions(+), 6 deletions(-)
 create mode 100644 proximity/proximity.conf

diff --git a/Makefile.am b/Makefile.am
index 91232d9..24b75e7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -297,8 +297,8 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			input/input.conf serial/serial.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c
-
+			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
+			proximity/proximity.conf
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
diff --git a/proximity/main.c b/proximity/main.c
index ee7e4fb..5f0fc12 100644
--- a/proximity/main.c
+++ b/proximity/main.c
@@ -28,20 +28,45 @@
 
 #include <errno.h>
 
+#include <glib.h>
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
 static DBusConnection *connection = NULL;
+static GKeyFile *config = NULL;
+
+static GKeyFile *open_config_file(const char *file)
+{
+	GError *gerr = NULL;
+	GKeyFile *keyfile;
+
+	keyfile = g_key_file_new();
+
+	g_key_file_set_list_separator(keyfile, ',');
+
+	if (!g_key_file_load_from_file(keyfile, file, 0, &gerr)) {
+		error("Parsing %s failed: %s", file, gerr->message);
+		g_error_free(gerr);
+		g_key_file_free(keyfile);
+		return NULL;
+	}
+
+	return keyfile;
+}
 
 static int proximity_init(void)
 {
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (connection == NULL)
 		return -EIO;
 
-	if (proximity_manager_init(connection) < 0) {
+	config = open_config_file(CONFIGDIR "/proximity.conf");
+
+	if (proximity_manager_init(connection, config) < 0) {
 		dbus_connection_unref(connection);
 		return -EIO;
 	}
@@ -51,6 +76,9 @@ static int proximity_init(void)
 
 static void proximity_exit(void)
 {
+	if (config)
+		g_key_file_free(config);
+
 	proximity_manager_exit();
 	dbus_connection_unref(connection);
 }
diff --git a/proximity/manager.c b/proximity/manager.c
index 98ac59f..e3e049d 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -41,6 +41,16 @@
 
 static DBusConnection *connection = NULL;
 
+static struct {
+	gboolean linkloss;
+	gboolean pathloss;
+	gboolean findme;
+} enabled  = {
+	.linkloss = TRUE,
+	.pathloss = TRUE,
+	.findme = TRUE,
+};
+
 static int attio_device_probe(struct btd_device *device, GSList *uuids)
 {
 	return monitor_register(connection, device);
@@ -58,10 +68,30 @@ static struct btd_device_driver monitor_driver = {
 	.remove = attio_device_remove,
 };
 
-int proximity_manager_init(DBusConnection *conn)
+static void load_config_file(GKeyFile *config)
+{
+	char **list;
+	int i;
+
+	list = g_key_file_get_string_list(config, "General", "Disable",
+								NULL, NULL);
+	for (i = 0; list && list[i] != NULL; i++) {
+		if (g_str_equal(list[i], "FindMe"))
+			enabled.findme = FALSE;
+		else if (g_str_equal(list[i], "LinkLoss"))
+			enabled.linkloss = FALSE;
+		else if (g_str_equal(list[i], "PathLoss"))
+			enabled.pathloss = FALSE;
+	}
+
+	g_strfreev(list);
+}
+
+int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
 {
 	int ret;
-	/* TODO: Add Proximity Monitor/Reporter config */
+
+	load_config_file(config);
 
 	/* TODO: Register Proximity Monitor/Reporter drivers */
 	ret = btd_register_device_driver(&monitor_driver);
diff --git a/proximity/manager.h b/proximity/manager.h
index 7557a68..b0fe7c8 100644
--- a/proximity/manager.h
+++ b/proximity/manager.h
@@ -22,5 +22,5 @@
  *
  */
 
-int proximity_manager_init(DBusConnection *conn);
+int proximity_manager_init(DBusConnection *conn, GKeyFile *conf);
 void proximity_manager_exit(void);
diff --git a/proximity/proximity.conf b/proximity/proximity.conf
new file mode 100644
index 0000000..f4ef6f5
--- /dev/null
+++ b/proximity/proximity.conf
@@ -0,0 +1,9 @@
+# Configuration file for the proximity service
+
+# This section contains options which are not specific to any
+# particular interface
+[General]
+
+# If we want to disable support for specific services
+# Defaults to supporting all implemented services
+#Disable=LinkLoss,PathLoss,FindMe
-- 
1.7.6

