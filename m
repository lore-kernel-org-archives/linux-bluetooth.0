Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v3 03/18] gatt: Register Manager D-Bus Interface
Date: Wed, 22 Jan 2014 10:40:10 -0300
Message-Id: <1390398025-28340-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch registers GATT Service Manager D-Bus Interface. This
interface implements the methods to allow external application register
and unregister GATT Services.
---
 Makefile.am     |  1 +
 src/gatt-dbus.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-dbus.h | 25 +++++++++++++++++++
 src/gatt.c      |  9 +++++++
 4 files changed, 110 insertions(+)
 create mode 100644 src/gatt-dbus.c
 create mode 100644 src/gatt-dbus.h

diff --git a/Makefile.am b/Makefile.am
index 3346ff5..d81302f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -146,6 +146,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
 			src/service.h src/service.c \
+			src/gatt-dbus.h src/gatt-dbus.c \
 			src/gatt.h src/gatt.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
new file mode 100644
index 0000000..183c611
--- /dev/null
+++ b/src/gatt-dbus.c
@@ -0,0 +1,75 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
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
+#include <stdint.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#include "dbus-common.h"
+#include "log.h"
+
+#include "gatt-dbus.h"
+
+#define GATT_MGR_IFACE			"org.bluez.GattManager1"
+
+static DBusMessage *register_service(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_service(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("RegisterService",
+				GDBUS_ARGS({ "service", "o"},
+						{ "options", "a{sv}"}),
+				NULL, register_service) },
+	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterService",
+				GDBUS_ARGS({"service", "o"}),
+				NULL, unregister_service) },
+	{ }
+};
+
+gboolean gatt_dbus_manager_register(void)
+{
+	return g_dbus_register_interface(btd_get_dbus_connection(),
+					"/org/bluez", GATT_MGR_IFACE,
+					methods, NULL, NULL, NULL, NULL);
+}
+
+void gatt_dbus_manager_unregister(void)
+{
+	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
+							GATT_MGR_IFACE);
+}
diff --git a/src/gatt-dbus.h b/src/gatt-dbus.h
new file mode 100644
index 0000000..310cfa9
--- /dev/null
+++ b/src/gatt-dbus.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
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
+gboolean gatt_dbus_manager_register(void);
+void gatt_dbus_manager_unregister(void);
diff --git a/src/gatt.c b/src/gatt.c
index 06619f0..e8b691a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -25,14 +25,23 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+
+#include "log.h"
+
+#include "gatt-dbus.h"
 #include "gatt.h"
 
 void gatt_init(void)
 {
+	DBG("Starting GATT server");
 
+	gatt_dbus_manager_register();
 }
 
 void gatt_cleanup(void)
 {
+	DBG("Stopping GATT server");
 
+	gatt_dbus_manager_unregister();
 }
-- 
1.8.3.1

