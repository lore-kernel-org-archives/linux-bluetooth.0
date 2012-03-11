Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 2/2] Added Battery Service GATT Client
Date: Sun, 11 Mar 2012 14:57:22 +0200
Message-Id: <1331470642-23924-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
References: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Added support for the Battery Service Gatt Client side.
---
 Makefile.am                 |    7 +++
 acinclude.m4                |    6 +++
 batterystate/batterystate.c |   89 +++++++++++++++++++++++++++++++++++++++++
 batterystate/batterystate.h |   26 ++++++++++++
 batterystate/main.c         |   60 ++++++++++++++++++++++++++++
 batterystate/manager.c      |   92 +++++++++++++++++++++++++++++++++++++++++++
 batterystate/manager.h      |   25 ++++++++++++
 7 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100644 batterystate/batterystate.c
 create mode 100644 batterystate/batterystate.h
 create mode 100644 batterystate/main.c
 create mode 100644 batterystate/manager.c
 create mode 100644 batterystate/manager.h

diff --git a/Makefile.am b/Makefile.am
index c2c61d6..10fd078 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -251,6 +251,13 @@ builtin_sources += deviceinfo/main.c \
 			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
 endif
 
+if BATTERYSTATEPLUGIN
+builtin_modules += batterystate
+builtin_sources += batterystate/main.c \
+			batterystate/manager.h batterystate/manager.c \
+			batterystate/batterystate.h batterystate/batterystate.c
+endif
+
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
diff --git a/acinclude.m4 b/acinclude.m4
index 14b7a4c..b33b4bf 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -221,6 +221,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	wiimote_enable=no
 	thermometer_enable=no
 	deviceinfo_enable=no
+	batterystate_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -377,6 +378,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		deviceinfo_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(batterystate, AC_HELP_STRING([--enable-batterystate], [enable batterystate plugin]), [
+		batterystate_enable=${enableval}
+	])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -435,4 +440,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
 	AM_CONDITIONAL(DEVICEINFOPLUGIN, test "${deviceinfo_enable}" = "yes")
+	AM_CONDITIONAL(BATTERYSTATEPLUGIN, test "${batterystate_enable}" = "yes")
 ])
diff --git a/batterystate/batterystate.c b/batterystate/batterystate.c
new file mode 100644
index 0000000..54e47fb
--- /dev/null
+++ b/batterystate/batterystate.c
@@ -0,0 +1,89 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "dbus-common.h"
+#include "adapter.h"
+#include "device.h"
+#include "error.h"
+#include "log.h"
+#include "gattrib.h"
+#include "attio.h"
+#include "att.h"
+#include "gatt.h"
+#include "batterystate.h"
+#include "glib-compat.h"
+
+struct batterystate {
+	DBusConnection		*conn;		/* The connection to the bus */
+	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;		/* GATT connection */
+};
+
+static GSList *batteryservices = NULL;
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct batterystate *bs = a;
+	const struct btd_device *dev = b;
+
+	if (dev == bs->dev)
+		return 0;
+
+	return -1;
+}
+
+int batterystate_register(DBusConnection *connection, struct btd_device *device,
+						struct att_primary *dattr)
+{
+	const gchar *path = device_get_path(device);
+	struct batterystate *bs;
+
+	bs = g_new0(struct batterystate, 1);
+	bs->conn = dbus_connection_ref(connection);
+	bs->dev = btd_device_ref(device);
+
+	batteryservices = g_slist_prepend(batteryservices, bs);
+
+	return 0;
+}
+
+void batterystate_unregister(struct btd_device *device)
+{
+	struct batterystate *bs;
+	GSList *l;
+
+	l = g_slist_find_custom(batteryservices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	bs = l->data;
+	batteryservices = g_slist_remove(batteryservices, bs);
+}
diff --git a/batterystate/batterystate.h b/batterystate/batterystate.h
new file mode 100644
index 0000000..eac8c2d
--- /dev/null
+++ b/batterystate/batterystate.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+int batterystate_register(DBusConnection *connection, struct btd_device *device,
+						struct att_primary *tattr);
+void batterystate_unregister(struct btd_device *device);
diff --git a/batterystate/main.c b/batterystate/main.c
new file mode 100644
index 0000000..165f6ea
--- /dev/null
+++ b/batterystate/main.c
@@ -0,0 +1,60 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <glib.h>
+#include <errno.h>
+#include <gdbus.h>
+
+#include "plugin.h"
+#include "manager.h"
+
+static DBusConnection *connection = NULL;
+
+static int batterystate_init(void)
+{
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (batterystate_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void batterystate_exit(void)
+{
+	batterystate_manager_exit();
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
+
+BLUETOOTH_PLUGIN_DEFINE(batterystate, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					batterystate_init, batterystate_exit)
diff --git a/batterystate/manager.c b/batterystate/manager.c
new file mode 100644
index 0000000..8f63717
--- /dev/null
+++ b/batterystate/manager.c
@@ -0,0 +1,92 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <gdbus.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "batterystate.h"
+#include "manager.h"
+
+#define BATTERY_SERVICE_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
+
+static DBusConnection *connection = NULL;
+
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct att_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
+static int batterystate_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	struct att_primary *tattr;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, BATTERY_SERVICE_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	tattr = l->data;
+
+	return batterystate_register(connection, device, tattr);
+}
+
+static void batterystate_driver_remove(struct btd_device *device)
+{
+	batterystate_unregister(device);
+}
+
+static struct btd_device_driver batterystate_device_driver = {
+	.name	= "batterystate-device-driver",
+	.uuids	= BTD_UUIDS(BATTERY_SERVICE_UUID),
+	.probe	= batterystate_driver_probe,
+	.remove	= batterystate_driver_remove
+};
+
+int batterystate_manager_init(DBusConnection *conn)
+{
+	int ret;
+	ret = btd_register_device_driver(&batterystate_device_driver);
+	if (ret < 0)
+                return ret;
+
+	connection = dbus_connection_ref(conn);
+	return 0;
+}
+
+void batterystate_manager_exit(void)
+{
+	btd_unregister_device_driver(&batterystate_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/batterystate/manager.h b/batterystate/manager.h
new file mode 100644
index 0000000..91b9799
--- /dev/null
+++ b/batterystate/manager.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+int batterystate_manager_init(DBusConnection *conn);
+void batterystate_manager_exit(void);
-- 
1.7.4.1

