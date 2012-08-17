Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/5] hog: Add UPower Resuming/Suspending watch
Date: Fri, 17 Aug 2012 18:08:20 -0300
Message-Id: <1345237703-15342-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the DBus signal watcher for UPower Resuming, and
Suspending signals.
---
 profiles/input/hog_manager.c |   19 ++++++++++++---
 profiles/input/upower.c      |   51 +++++++++++++++++++++++++++++++++++++++++-
 profiles/input/upower.h      |    2 +-
 3 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 52b2c8a..5a5ac62 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -30,6 +30,7 @@
 #include "log.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "gdbus.h"
 
 #include "plugin.h"
 #include "hcid.h"
@@ -38,6 +39,7 @@
 #include "hog_device.h"
 
 static gboolean upower_supported = FALSE;
+static DBusConnection *connection = NULL;
 
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
@@ -68,10 +70,16 @@ static int hog_manager_init(void)
 {
 	int err;
 
-	err = upower_init();
-	if (err < 0)
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	err = upower_init(connection);
+	if (err < 0) {
+		dbus_connection_unref(connection);
+		connection = NULL;
 		DBG("UPower: %s(%d)", strerror(-err), -err);
-	else
+	} else
 		upower_supported = TRUE;
 
 	return btd_register_device_driver(&hog_driver);
@@ -79,8 +87,11 @@ static int hog_manager_init(void)
 
 static void hog_manager_exit(void)
 {
-	if (upower_supported)
+	if (upower_supported) {
 		upower_exit();
+		dbus_connection_unref(connection);
+		connection = NULL;
+	}
 
 	btd_unregister_device_driver(&hog_driver);
 }
diff --git a/profiles/input/upower.c b/profiles/input/upower.c
index 571b023..18a4730 100644
--- a/profiles/input/upower.c
+++ b/profiles/input/upower.c
@@ -25,13 +25,62 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
+#include "gdbus.h"
+#include "log.h"
+
 #include "upower.h"
 
-int upower_init(void)
+#define UPOWER_BUS_NAME		"org.freedesktop.UPower"
+#define UPOWER_PATH		"/org/freedesktop/UPower"
+#define UPOWER_INTERFACE	UPOWER_BUS_NAME
+
+static DBusConnection *connection = NULL;
+static guint suspending_watch = 0;
+static guint resuming_watch = 0;
+
+static gboolean suspending_cb(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
 {
+	DBG("UPOWER: Suspending ...");
+
+	return TRUE;
+}
+
+static gboolean resuming_cb(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	DBG("UPOWER: Resuming ...");
+
+	return TRUE;
+}
+
+int upower_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+
+	suspending_watch = g_dbus_add_signal_watch(connection, UPOWER_BUS_NAME,
+						UPOWER_PATH, UPOWER_INTERFACE,
+						"Sleeping", suspending_cb,
+						NULL, NULL);
+
+	resuming_watch = g_dbus_add_signal_watch(connection, UPOWER_BUS_NAME,
+						UPOWER_PATH, UPOWER_INTERFACE,
+						"Resuming", resuming_cb,
+						NULL, NULL);
+
 	return 0;
 }
 
 void upower_exit(void)
 {
+	if (suspending_watch)
+		g_dbus_remove_watch(connection, suspending_watch);
+
+	if (resuming_watch)
+		g_dbus_remove_watch(connection, resuming_watch);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
diff --git a/profiles/input/upower.h b/profiles/input/upower.h
index f898d07..90976ab 100644
--- a/profiles/input/upower.h
+++ b/profiles/input/upower.h
@@ -21,5 +21,5 @@
  *
  */
 
-int upower_init(void);
+int upower_init(DBusConnection *conn);
 void upower_exit(void);
-- 
1.7.8.6

