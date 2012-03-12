Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 1/2] Added DeviceInformation GATT Client
Date: Mon, 12 Mar 2012 15:12:18 +0200
Message-Id: <1331557939-26191-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331557939-26191-1-git-send-email-chen.ganir@ti.com>
References: <1331557939-26191-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Added the DeviceInformation GATT Client plugin skeleton.
---
 Makefile.am             |    7 ++++
 acinclude.m4            |    6 +++
 deviceinfo/deviceinfo.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 +++++++++++++
 deviceinfo/main.c       |   48 +++++++++++++++++++++++++
 deviceinfo/manager.c    |   85 +++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/manager.h    |   24 +++++++++++++
 7 files changed, 282 insertions(+), 0 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

diff --git a/Makefile.am b/Makefile.am
index bd587eb..c2c61d6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -244,6 +244,13 @@ builtin_sources += thermometer/main.c \
 			thermometer/thermometer.h thermometer/thermometer.c
 endif
 
+if DEVICEINFOPLUGIN
+builtin_modules += deviceinfo
+builtin_sources += deviceinfo/main.c \
+			deviceinfo/manager.h deviceinfo/manager.c \
+			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
+endif
+
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
diff --git a/acinclude.m4 b/acinclude.m4
index b0f790c..14b7a4c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -220,6 +220,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	dbusoob_enable=no
 	wiimote_enable=no
 	thermometer_enable=no
+	deviceinfo_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -372,6 +373,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		thermometer_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(deviceinfo, AC_HELP_STRING([--enable-deviceinfo], [enable deviceinfo plugin]), [
+		deviceinfo_enable=${enableval}
+	])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -429,4 +434,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
+	AM_CONDITIONAL(DEVICEINFOPLUGIN, test "${deviceinfo_enable}" = "yes")
 ])
diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
new file mode 100644
index 0000000..6d1834b
--- /dev/null
+++ b/deviceinfo/deviceinfo.c
@@ -0,0 +1,88 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+
+#include <glib.h>
+#include <bluetooth/uuid.h>
+#include "adapter.h"
+#include "device.h"
+#include "gattrib.h"
+#include "attio.h"
+#include "att.h"
+#include "gatt.h"
+#include "deviceinfo.h"
+
+struct deviceinfo {
+	struct btd_device	*dev;		/* Device reference */
+};
+
+static GSList *deviceinfoservers = NULL;
+
+static void destroy_deviceinfo(gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	btd_device_unref(d->dev);
+	g_free(d);
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct deviceinfo *d = a;
+	const struct btd_device *dev = b;
+
+	if (dev == d->dev)
+		return 0;
+
+	return -1;
+}
+
+int deviceinfo_register(struct btd_device *device, struct att_primary *dattr)
+{
+	struct deviceinfo *d;
+
+	d = g_new0(struct deviceinfo, 1);
+	d->dev = btd_device_ref(device);
+
+	deviceinfoservers = g_slist_prepend(deviceinfoservers, d);
+
+	return 0;
+}
+
+void deviceinfo_unregister(struct btd_device *device)
+{
+	struct deviceinfo *d;
+	GSList *l;
+
+	l = g_slist_find_custom(deviceinfoservers, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	d = l->data;
+	deviceinfoservers = g_slist_remove(deviceinfoservers, d);
+
+	destroy_deviceinfo(d);
+}
diff --git a/deviceinfo/deviceinfo.h b/deviceinfo/deviceinfo.h
new file mode 100644
index 0000000..1859821
--- /dev/null
+++ b/deviceinfo/deviceinfo.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+int deviceinfo_register(struct btd_device *device,struct att_primary *tattr);
+void deviceinfo_unregister(struct btd_device *device);
diff --git a/deviceinfo/main.c b/deviceinfo/main.c
new file mode 100644
index 0000000..ec5f103
--- /dev/null
+++ b/deviceinfo/main.c
@@ -0,0 +1,48 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+
+#include "plugin.h"
+#include "manager.h"
+
+static int deviceinfo_init(void)
+{
+	if (deviceinfo_manager_init() < 0) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void deviceinfo_exit(void)
+{
+	deviceinfo_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(deviceinfo, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					deviceinfo_init, deviceinfo_exit)
diff --git a/deviceinfo/manager.c b/deviceinfo/manager.c
new file mode 100644
index 0000000..7bfca49
--- /dev/null
+++ b/deviceinfo/manager.c
@@ -0,0 +1,85 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+#include <glib.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "deviceinfo.h"
+#include "manager.h"
+
+#define DEVICE_INFORMATION_UUID		"0000180a-0000-1000-8000-00805f9b34fb"
+
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct att_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
+static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	struct att_primary *tattr;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, DEVICE_INFORMATION_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	tattr = l->data;
+
+	return deviceinfo_register(device, tattr);
+}
+
+static void deviceinfo_driver_remove(struct btd_device *device)
+{
+	deviceinfo_unregister(device);
+}
+
+static struct btd_device_driver deviceinfo_device_driver = {
+	.name	= "deviceinformation-device-driver",
+	.uuids	= BTD_UUIDS(DEVICE_INFORMATION_UUID),
+	.probe	= deviceinfo_driver_probe,
+	.remove	= deviceinfo_driver_remove
+};
+
+int deviceinfo_manager_init(void)
+{
+	int ret;
+	ret = btd_register_device_driver(&deviceinfo_device_driver);
+	if (ret < 0)
+                return ret;
+
+	return 0;
+}
+
+void deviceinfo_manager_exit(void)
+{
+	btd_unregister_device_driver(&deviceinfo_device_driver);
+}
diff --git a/deviceinfo/manager.h b/deviceinfo/manager.h
new file mode 100644
index 0000000..0f742ca
--- /dev/null
+++ b/deviceinfo/manager.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+int deviceinfo_manager_init(void);
+void deviceinfo_manager_exit(void);
-- 
1.7.4.1

