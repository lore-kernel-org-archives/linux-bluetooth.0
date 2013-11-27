Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [RFC BlueZ v0 03/17] gatt: Add registering external service
Date: Wed, 27 Nov 2013 17:50:43 -0300
Message-Id: <1385585457-26951-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch allows external applications register a given service on
Bluez. Applications must provide an object path and a dictionary of
options. Options dictionary will be used later to provide additional
service information.
---
 src/gatt-dbus.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index c28c33c..69581a4 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -26,22 +26,112 @@
 #endif
 
 #include <stdint.h>
+#include <errno.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "adapter.h"
+#include "device.h"
+#include "lib/uuid.h"
 #include "dbus-common.h"
 #include "log.h"
 
+#include "error.h"
 #include "gatt-dbus.h"
 
 #define SERVICE_MGR_IFACE			"org.bluez.ServiceManager1"
 
+struct external_app {
+	char *owner;
+	char *path;
+	GDBusClient *client;
+	unsigned int watch;
+};
+
+static GSList *external_apps = NULL;
+
+static int external_app_path_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct external_app *eapp = a;
+	const char *path = b;
+
+	return g_strcmp0(eapp->path, path);
+}
+
+static void external_app_watch_destroy(gpointer user_data)
+{
+	struct external_app *eapp = user_data;
+
+	/* TODO: Remove from the database */
+
+	external_apps = g_slist_remove(external_apps, eapp);
+
+	g_dbus_client_unref(eapp->client);
+
+	g_free(eapp->owner);
+	g_free(eapp->path);
+	g_free(eapp);
+}
+
+static struct external_app *new_external_app(DBusConnection *conn,
+					const char *sender, const char *path)
+{
+	struct external_app *eapp;
+	GDBusClient *client;
+
+	client = g_dbus_client_new(conn, sender, "/");
+	if (client == NULL)
+		return NULL;
+
+	eapp = g_new0(struct external_app, 1);
+
+	eapp->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+			sender, NULL, eapp, external_app_watch_destroy);
+	if (eapp->watch == 0) {
+		g_dbus_client_unref(client);
+		g_free(eapp);
+		return NULL;
+	}
+
+	eapp->owner = g_strdup(sender);
+	eapp->client = client;
+	eapp->path = g_strdup(path);
+
+	return eapp;
+}
+
 static DBusMessage *register_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return dbus_message_new_method_return(msg);
+	struct external_app *eapp;
+	DBusMessageIter iter;
+	const char *path;
+
+	if (dbus_message_iter_init(msg, &iter) == false)
+		goto invalid;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	if (g_slist_find_custom(external_apps, path, external_app_path_cmp))
+		return btd_error_already_exists(msg);
+
+	eapp = new_external_app(conn, dbus_message_get_sender(msg), path);
+	if (eapp == NULL)
+		return btd_error_failed(msg, "Not enough resources");
+
+	external_apps = g_slist_prepend(external_apps, eapp);
+
+	DBG("New app %p: %s", eapp, path);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+invalid:
+	return btd_error_invalid_args(msg);
 }
 
 static DBusMessage *unregister_service(DBusConnection *conn,
-- 
1.8.3.1

