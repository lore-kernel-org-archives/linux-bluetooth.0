Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 12/17] test: Add external service GATT skeleton
Date: Wed, 27 Nov 2013 17:50:52 -0300
Message-Id: <1385585457-26951-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial code for an external GATT service example.
It implements the API defined at doc/gatt-api.txt
---
 Makefile.tools      |   5 ++
 test/gatt-service.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 test/gatt-service.c

diff --git a/Makefile.tools b/Makefile.tools
index 78034f5..7eaf03d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -292,3 +292,8 @@ test_scripts += test/sap_client.py test/bluezutils.py \
 		test/service-ftp.xml test/simple-player test/test-nap \
 		test/test-heartrate test/test-alert test/test-hfp \
 		test/test-cyclingspeed
+
+test_gatt_service_SOURCES = test/gatt-service.c
+test_gatt_service_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ gdbus/libgdbus-internal.la
+
+noinst_PROGRAMS += test/gatt-service
diff --git a/test/gatt-service.c b/test/gatt-service.c
new file mode 100644
index 0000000..31aa06b
--- /dev/null
+++ b/test/gatt-service.c
@@ -0,0 +1,136 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#define SERVICE_IFACE			"org.bluez.Service1"
+
+/* Immediate Alert Service UUID */
+#define IAS_UUID			"00001802-0000-1000-8000-00805f9b34fb"
+
+static GMainLoop *main_loop;
+static GSList *services;
+
+static gboolean service_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static gboolean service_get_includes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	return TRUE;
+}
+
+static gboolean service_exist_includes(const GDBusPropertyTable *property,
+							void *user_data)
+{
+	return FALSE;
+}
+
+static DBusMessage *service_release(DBusConnection *conn,
+				DBusMessage *msg, void *user_data)
+{
+	fprintf(stderr, "Terminating...\n");
+
+	g_main_loop_quit(main_loop);
+
+	return NULL;
+};
+
+static const GDBusMethodTable service_methods[] = {
+	{ GDBUS_NOREPLY_METHOD("Release", NULL, NULL, service_release) },
+	{ }
+};
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "UUID", "s", service_get_uuid },
+	{ "Includes", "ao", service_get_includes, NULL,
+					service_exist_includes },
+	{ }
+};
+
+static char *register_service(DBusConnection *conn, const char *uuid)
+{
+	static int id = 1;
+	char *path;
+
+	path = g_strdup_printf("/service%d", id++);
+	if (g_dbus_register_interface(conn, path, SERVICE_IFACE,
+				service_methods, NULL, service_properties,
+				g_strdup(uuid), g_free) == FALSE) {
+		fprintf(stderr, "Couldn't register service interface\n");
+		g_free(path);
+		return NULL;
+	}
+
+	return path;
+}
+
+static void create_services(DBusConnection *conn)
+{
+	char *service_path;
+
+	service_path = register_service(conn, IAS_UUID);
+
+	services = g_slist_prepend(services, service_path);
+
+	printf("Registered service: %s\n", service_path);
+}
+
+int main(int argc, char *argv[])
+{
+	DBusConnection *dbus_conn;
+
+	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	g_dbus_attach_object_manager(dbus_conn);
+
+	printf("gatt-service unique name: %s\n",
+				dbus_bus_get_unique_name(dbus_conn));
+
+	create_services(dbus_conn);
+
+	g_main_loop_run(main_loop);
+
+	g_slist_free_full(services, g_free);
+	dbus_connection_unref(dbus_conn);
+
+	return 0;
+}
-- 
1.8.3.1

