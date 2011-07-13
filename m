Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/3] Add Proximity Monitor skeleton
Date: Wed, 13 Jul 2011 09:37:56 -0300
Message-Id: <1310560677-2773-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Registers hard-coded D-Bus object path for Proximity Monitor and
exports GetProperties and SetProperty.
---
 Makefile.am         |    4 ++-
 proximity/main.c    |   18 +++++++++++
 proximity/manager.c |   59 +++++++++++++++++++++++++++++++++++
 proximity/manager.h |   26 ++++++++++++++++
 proximity/monitor.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/monitor.h |   26 ++++++++++++++++
 6 files changed, 216 insertions(+), 1 deletions(-)
 create mode 100644 proximity/manager.c
 create mode 100644 proximity/manager.h
 create mode 100644 proximity/monitor.c
 create mode 100644 proximity/monitor.h

diff --git a/Makefile.am b/Makefile.am
index 0fd52fd..293a8cc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -192,7 +192,9 @@ endif
 
 if PROXIMITYPLUGIN
 builtin_modules += proximity
-builtin_sources += proximity/main.c
+builtin_sources += proximity/main.c \
+			proximity/manager.h proximity/manager.c \
+			proximity/monitor.h proximity/monitor.c
 endif
 
 if SERVICEPLUGIN
diff --git a/proximity/main.c b/proximity/main.c
index dccd619..ee7e4fb 100644
--- a/proximity/main.c
+++ b/proximity/main.c
@@ -26,15 +26,33 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
+#include <gdbus.h>
+
 #include "plugin.h"
+#include "manager.h"
+
+static DBusConnection *connection = NULL;
 
 static int proximity_init(void)
 {
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (proximity_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
 	return 0;
 }
 
 static void proximity_exit(void)
 {
+	proximity_manager_exit();
+	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(proximity, VERSION,
diff --git a/proximity/manager.c b/proximity/manager.c
new file mode 100644
index 0000000..795bdee
--- /dev/null
+++ b/proximity/manager.c
@@ -0,0 +1,59 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+#include <gdbus.h>
+
+#include "monitor.h"
+#include "manager.h"
+
+static DBusConnection *connection = NULL;
+
+int proximity_manager_init(DBusConnection *conn)
+{
+	int ret;
+	/* TODO: Add Proximity Monitor/Reporter config */
+
+	/* TODO: Register Proximity Monitor/Reporter drivers */
+
+	connection = dbus_connection_ref(conn);
+
+	ret = monitor_register(connection);
+
+	if (ret < 0) {
+		dbus_connection_unref(connection);
+		return ret;
+	}
+
+	return 0;
+}
+
+void proximity_manager_exit(void)
+{
+	monitor_unregister(connection);
+	dbus_connection_unref(connection);
+}
diff --git a/proximity/manager.h b/proximity/manager.h
new file mode 100644
index 0000000..7557a68
--- /dev/null
+++ b/proximity/manager.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+int proximity_manager_init(DBusConnection *conn);
+void proximity_manager_exit(void);
diff --git a/proximity/monitor.c b/proximity/monitor.c
new file mode 100644
index 0000000..4928c7a
--- /dev/null
+++ b/proximity/monitor.c
@@ -0,0 +1,84 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+#include <gdbus.h>
+
+#include "log.h"
+
+#include "monitor.h"
+
+#define PROXIMITY_INTERFACE "org.bluez.Proximity"
+#define PROXIMITY_PATH "/org/bluez/proximity"
+
+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable monitor_methods[] = {
+	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ "SetProperty",	"sv",	"",		set_property,
+						G_DBUS_METHOD_FLAG_ASYNC},
+	{ }
+};
+
+static GDBusSignalTable monitor_signals[] = {
+	{ "PropertyChanged",	"sv"	},
+	{ }
+};
+
+int monitor_register(DBusConnection *conn)
+{
+	int ret = -1;
+
+	if (g_dbus_register_interface(conn, PROXIMITY_PATH,
+					PROXIMITY_INTERFACE,
+					monitor_methods, monitor_signals,
+					NULL, NULL, NULL) == TRUE) {
+		DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE,
+							PROXIMITY_PATH);
+		ret = 0;
+
+	}
+
+	error("D-Bus failed to register %s interface", PROXIMITY_INTERFACE);
+
+	return ret;
+}
+
+void monitor_unregister(DBusConnection *conn)
+{
+	g_dbus_unregister_interface(conn, PROXIMITY_PATH, PROXIMITY_INTERFACE);
+}
diff --git a/proximity/monitor.h b/proximity/monitor.h
new file mode 100644
index 0000000..d4913ac
--- /dev/null
+++ b/proximity/monitor.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+int monitor_register(DBusConnection *conn);
+void monitor_unregister(DBusConnection *conn);
-- 
1.7.6

