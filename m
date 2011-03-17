Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 03/15] GATT server: add initial D-Bus interface
Date: Wed, 16 Mar 2011 21:00:27 -0400
Message-Id: <1300323639-13296-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 025a3c5..fc6b08e 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -26,15 +26,111 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
+#include <gdbus.h>
+
 #include "plugin.h"
+#include "adapter.h"
+#include "log.h"
+
+#define GATT_PROFILE_INTERFACE "org.bluez.GattProfile"
+
+static DBusConnection *connection = NULL;
+static const char *any_path = NULL;
+
+static DBusMessage *add_profile(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
+{
+	/* TODO */
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable gatt_profile_methods[] = {
+	{ "AddProfile", "s", "", add_profile },
+	{ }
+};
+
+static int register_interface(const char *path, struct btd_adapter *adapter)
+{
+	DBG("path %s", path);
+
+	if (!g_dbus_register_interface(connection, path, GATT_PROFILE_INTERFACE,
+					gatt_profile_methods, NULL, NULL, NULL,
+					NULL)) {
+		error("D-Bus failed to register %s interface",
+							GATT_PROFILE_INTERFACE);
+		return -EIO;
+	}
+
+	DBG("Registered interface %s on path %s", GATT_PROFILE_INTERFACE, path);
+
+	return 0;
+}
+
+static void unregister_interface(const char *path)
+{
+	DBG("path %s", path);
+
+	g_dbus_unregister_interface(connection, path, GATT_PROFILE_INTERFACE);
+}
+
+static int gatt_profile_probe(struct btd_adapter *adapter)
+{
+	register_interface(adapter_get_path(adapter), adapter);
+
+	return 0;
+}
+
+static void gatt_profile_remove(struct btd_adapter *adapter)
+{
+	unregister_interface(adapter_get_path(adapter));
+}
+
+static struct btd_adapter_driver gatt_profile_driver = {
+	.name = "gatt-profile",
+	.probe = gatt_profile_probe,
+	.remove = gatt_profile_remove,
+};
 
 static int gatt_profile_init(void)
 {
+	int err;
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	any_path = btd_adapter_any_request_path();
+	if (any_path != NULL) {
+		if (register_interface(any_path, NULL) < 0) {
+			btd_adapter_any_release_path();
+			any_path = NULL;
+		}
+	}
+
+	err = btd_register_adapter_driver(&gatt_profile_driver);
+	if (err < 0) {
+		dbus_connection_unref(connection);
+		return err;
+	}
+
 	return 0;
 }
 
 static void gatt_profile_exit(void)
 {
+	btd_unregister_adapter_driver(&gatt_profile_driver);
+
+	if (any_path != NULL) {
+		unregister_interface(any_path);
+
+		btd_adapter_any_release_path();
+		any_path = NULL;
+	}
+
+	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(gatt_profile, VERSION, BLUETOOTH_PLUGIN_PRIORITY_HIGH,
-- 
1.7.0.4

