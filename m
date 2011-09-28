Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/9] Register Health Thermometer Interface
Date: Wed, 28 Sep 2011 19:48:39 +0200
Message-Id: <1317232126-12640-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-2-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
 <1317232126-12640-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |  108 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 027ae02..a89d8a9 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -25,13 +25,119 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "error.h"
+#include "log.h"
+#include "gattrib.h"
 #include "att.h"
 #include "thermometer.h"
 
+#define THERMOMETER_INTERFACE "org.bluez.Thermometer"
+
+struct thermometer {
+	DBusConnection          *conn;		/* The connection to the bus */
+	struct btd_device       *dev;		/* Device reference */
+	struct att_range	*svc_range;	/* Thermometer range */
+};
+
+static GSList *thermometers = NULL;
+
+static void destroy_thermometer(gpointer user_data)
+{
+	struct thermometer *t = user_data;
+
+	dbus_connection_unref(t->conn);
+	btd_device_unref(t->dev);
+	g_free(t->svc_range);
+        g_free(t);
+}
+
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	/* TODO: */
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
+						"Function not implemented.");
+}
+
+static GDBusMethodTable thermometer_methods[] = {
+	{ "GetProperties",	"",	"a{sv}",	get_properties },
+	{ "SetProperty",	"sv",	"",		set_property,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterWatcher",	"o",	"",		register_watcher },
+	{ "UnregisterWatcher",	"o",	"",		unregister_watcher },
+	{ "EnableIntermediateMeasurement", "o", "", enable_intermediate },
+	{ "DisableIntermediateMeasurement","o",	"", disable_intermediate },
+	{ }
+};
+
+static GDBusSignalTable thermometer_signals[] = {
+	{ "PropertyChanged",	"sv"	},
+	{ }
+};
+
 int thermometer_register(DBusConnection *connection, struct btd_device *device,
 						struct att_primary *tattr)
 {
-	/* TODO: Register Health Thermometer Interface */
+	const gchar *path = device_get_path(device);
+	struct thermometer *t;
+
+	t = g_new0(struct thermometer, 1);
+	t->conn = dbus_connection_ref(connection);
+	t->dev = btd_device_ref(device);
+	t->svc_range = g_new0(struct att_range, 1);
+	t->svc_range->start = tattr->start;
+	t->svc_range->end = tattr->end;
+
+	if (!g_dbus_register_interface(t->conn, path, THERMOMETER_INTERFACE,
+				thermometer_methods, thermometer_signals,
+				NULL, t, destroy_thermometer)) {
+		error("D-Bus failed to register %s interface",
+							THERMOMETER_INTERFACE);
+		destroy_thermometer(t);
+		return -1;
+	}
+
+	thermometers = g_slist_prepend(thermometers, t);
 	return 0;
 }
 
-- 
1.7.6.1

