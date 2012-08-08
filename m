Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <jprvita@openbossa.org>, Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 1/9] Battery: Add Battery Service GATT Client
Date: Wed, 8 Aug 2012 17:26:12 +0300
Message-ID: <1344435980-9866-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
References: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for the Battery Service Gatt Client side.
---
 Makefile.am                |   10 ++++-
 profiles/battery/battery.c |   88 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/battery/battery.h |   24 ++++++++++++
 profiles/battery/main.c    |   53 ++++++++++++++++++++++++++
 profiles/battery/manager.c |   62 +++++++++++++++++++++++++++++++
 profiles/battery/manager.h |   24 ++++++++++++
 6 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 profiles/battery/battery.c
 create mode 100644 profiles/battery/battery.h
 create mode 100644 profiles/battery/main.c
 create mode 100644 profiles/battery/manager.c
 create mode 100644 profiles/battery/manager.h

diff --git a/Makefile.am b/Makefile.am
index 45a811c..710350e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -211,7 +211,8 @@ builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity deviceinfo
+builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
+            battery
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -237,7 +238,12 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/manager.h \
 			profiles/deviceinfo/manager.c \
 			profiles/deviceinfo/deviceinfo.h \
-			profiles/deviceinfo/deviceinfo.c
+			profiles/deviceinfo/deviceinfo.c \
+			profiles/battery/main.c \
+			profiles/battery/manager.c \
+			profiles/battery/manager.h \
+			profiles/battery/battery.c \
+			profiles/battery/battery.h
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
new file mode 100644
index 0000000..7ed5707
--- /dev/null
+++ b/profiles/battery/battery.c
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
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "battery.h"
+
+struct battery {
+	struct btd_device	*dev;		/* Device reference */
+};
+
+static GSList *servers;
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct battery *batt = a;
+	const struct btd_device *dev = b;
+
+	if (dev == batt->dev)
+		return 0;
+
+	return -1;
+}
+
+static void battery_free(gpointer user_data)
+{
+	struct battery *batt = user_data;
+
+	btd_device_unref(batt->dev);
+	g_free(batt);
+}
+
+
+int battery_register(struct btd_device *device)
+{
+	struct battery *batt;
+
+	batt = g_new0(struct battery, 1);
+	batt->dev = btd_device_ref(device);
+
+	servers = g_slist_prepend(servers, batt);
+
+	return 0;
+}
+
+void battery_unregister(struct btd_device *device)
+{
+	struct battery *batt;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	batt = l->data;
+	servers = g_slist_remove(servers, batt);
+
+	battery_free(batt);
+}
diff --git a/profiles/battery/battery.h b/profiles/battery/battery.h
new file mode 100644
index 0000000..9933343
--- /dev/null
+++ b/profiles/battery/battery.h
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
+int battery_register(struct btd_device *device);
+void battery_unregister(struct btd_device *device);
diff --git a/profiles/battery/main.c b/profiles/battery/main.c
new file mode 100644
index 0000000..47f4249
--- /dev/null
+++ b/profiles/battery/main.c
@@ -0,0 +1,53 @@
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
+#include <stdint.h>
+#include <glib.h>
+#include <errno.h>
+
+#include "hcid.h"
+#include "plugin.h"
+#include "manager.h"
+#include "log.h"
+
+static int battery_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return battery_manager_init();
+}
+
+static void battery_exit(void)
+{
+	battery_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(battery, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, battery_init,
+			battery_exit)
diff --git a/profiles/battery/manager.c b/profiles/battery/manager.c
new file mode 100644
index 0000000..84b85a3
--- /dev/null
+++ b/profiles/battery/manager.c
@@ -0,0 +1,62 @@
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
+#include "battery.h"
+#include "manager.h"
+
+#define BATTERY_SERVICE_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
+
+static int battery_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	return battery_register(device);
+}
+
+static void battery_driver_remove(struct btd_device *device)
+{
+	battery_unregister(device);
+}
+
+static struct btd_device_driver battery_device_driver = {
+	.name	= "battery-driver",
+	.uuids	= BTD_UUIDS(BATTERY_SERVICE_UUID),
+	.probe	= battery_driver_probe,
+	.remove	= battery_driver_remove
+};
+
+int battery_manager_init(void)
+{
+	return btd_register_device_driver(&battery_device_driver);
+}
+
+void battery_manager_exit(void)
+{
+	btd_unregister_device_driver(&battery_device_driver);
+}
diff --git a/profiles/battery/manager.h b/profiles/battery/manager.h
new file mode 100644
index 0000000..b2c849f
--- /dev/null
+++ b/profiles/battery/manager.h
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
+int battery_manager_init(void);
+void battery_manager_exit(void);
-- 
1.7.9.5

