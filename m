Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v5 1/4] Add DeviceInformation GATT Client
Date: Tue,  3 Apr 2012 08:35:25 +0300
Message-Id: <1333431328-26888-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1333431328-26888-1-git-send-email-chen.ganir@ti.com>
References: <1333431328-26888-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add the DeviceInformation GATT Client plugin skeleton.
---
 Makefile.am             |    9 +++--
 deviceinfo/deviceinfo.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 +++++++++++++
 deviceinfo/main.c       |   52 ++++++++++++++++++++++++++++
 deviceinfo/manager.c    |   79 +++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/manager.h    |   24 +++++++++++++
 6 files changed, 271 insertions(+), 3 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

diff --git a/Makefile.am b/Makefile.am
index ddc28d2..0a2a38d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -213,7 +213,8 @@ builtin_sources += health/hdp_main.c health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity
+builtin_modules += thermometer alert time gatt_example proximity \
+			deviceinfo
 builtin_sources += thermometer/main.c \
 			thermometer/manager.h thermometer/manager.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
@@ -222,10 +223,12 @@ builtin_sources += thermometer/main.c \
             plugins/gatt-example.c \
             proximity/main.c proximity/manager.h proximity/manager.c \
 			proximity/monitor.h proximity/monitor.c \
-			proximity/reporter.h proximity/reporter.c
+			proximity/reporter.h proximity/reporter.c \
+			deviceinfo/main.c \
+			deviceinfo/manager.h deviceinfo/manager.c \
+			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
 endif
 
-
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
new file mode 100644
index 0000000..05926f2
--- /dev/null
+++ b/deviceinfo/deviceinfo.c
@@ -0,0 +1,86 @@
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
+#include <bluetooth/uuid.h>
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "deviceinfo.h"
+
+struct deviceinfo {
+	struct btd_device	*dev;		/* Device reference */
+};
+
+static GSList *servers;
+
+static void deviceinfo_free(gpointer user_data)
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
+int deviceinfo_register(struct btd_device *device)
+{
+	struct deviceinfo *d;
+
+	d = g_new0(struct deviceinfo, 1);
+	d->dev = btd_device_ref(device);
+
+	servers = g_slist_prepend(servers, d);
+
+	return 0;
+}
+
+void deviceinfo_unregister(struct btd_device *device)
+{
+	struct deviceinfo *d;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	d = l->data;
+	servers = g_slist_remove(servers, d);
+
+	deviceinfo_free(d);
+}
diff --git a/deviceinfo/deviceinfo.h b/deviceinfo/deviceinfo.h
new file mode 100644
index 0000000..0ea6ff5
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
+int deviceinfo_register(struct btd_device *device);
+void deviceinfo_unregister(struct btd_device *device);
diff --git a/deviceinfo/main.c b/deviceinfo/main.c
new file mode 100644
index 0000000..82ecc82
--- /dev/null
+++ b/deviceinfo/main.c
@@ -0,0 +1,52 @@
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
+#include <stdint.h>
+
+#include "plugin.h"
+#include "manager.h"
+#include "hcid.h"
+#include "log.h"
+
+static int deviceinfo_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		error("DIS cannot start: GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return deviceinfo_manager_init();
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
index 0000000..025a076
--- /dev/null
+++ b/deviceinfo/manager.c
@@ -0,0 +1,79 @@
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
+#include "gattrib.h"
+#include "gatt.h"
+#include "deviceinfo.h"
+#include "manager.h"
+
+#define DEVICE_INFORMATION_UUID		"0000180a-0000-1000-8000-00805f9b34fb"
+
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
+static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, DEVICE_INFORMATION_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	return deviceinfo_register(device);
+}
+
+static void deviceinfo_driver_remove(struct btd_device *device)
+{
+	deviceinfo_unregister(device);
+}
+
+static struct btd_device_driver deviceinfo_device_driver = {
+	.name	= "deviceinfo-driver",
+	.uuids	= BTD_UUIDS(DEVICE_INFORMATION_UUID),
+	.probe	= deviceinfo_driver_probe,
+	.remove	= deviceinfo_driver_remove
+};
+
+int deviceinfo_manager_init(void)
+{
+	return btd_register_device_driver(&deviceinfo_device_driver);
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

