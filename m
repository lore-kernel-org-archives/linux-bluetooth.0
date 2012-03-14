Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v7 2/2] Add Battery Service GATT Client
Date: Wed, 14 Mar 2012 15:04:33 +0200
Message-Id: <1331730273-12789-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331730273-12789-1-git-send-email-chen.ganir@ti.com>
References: <1331730273-12789-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for the Battery Service Gatt Client side.
---
 Makefile.am                 |    7 ++-
 batterystate/batterystate.c |   86 +++++++++++++++++++++++++++++++++++++++++++
 batterystate/batterystate.h |   24 ++++++++++++
 batterystate/main.c         |   55 +++++++++++++++++++++++++++
 batterystate/manager.c      |   80 ++++++++++++++++++++++++++++++++++++++++
 batterystate/manager.h      |   24 ++++++++++++
 6 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 batterystate/batterystate.c
 create mode 100644 batterystate/batterystate.h
 create mode 100644 batterystate/main.c
 create mode 100644 batterystate/manager.c
 create mode 100644 batterystate/manager.h

diff --git a/Makefile.am b/Makefile.am
index 0a2a38d..60e4ef4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -214,7 +214,7 @@ endif
 
 if GATTMODULES
 builtin_modules += thermometer alert time gatt_example proximity \
-			deviceinfo
+			deviceinfo batterystate
 builtin_sources += thermometer/main.c \
 			thermometer/manager.h thermometer/manager.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
@@ -226,7 +226,10 @@ builtin_sources += thermometer/main.c \
 			proximity/reporter.h proximity/reporter.c \
 			deviceinfo/main.c \
 			deviceinfo/manager.h deviceinfo/manager.c \
-			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
+			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c \
+			batterystate/main.c \
+			batterystate/manager.h batterystate/manager.c \
+			batterystate/batterystate.h batterystate/batterystate.c
 endif
 
 builtin_modules += hciops mgmtops
diff --git a/batterystate/batterystate.c b/batterystate/batterystate.c
new file mode 100644
index 0000000..b1da5f9
--- /dev/null
+++ b/batterystate/batterystate.c
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
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "batterystate.h"
+
+struct batterystate {
+	struct btd_device	*dev;		/* Device reference */
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
+static void batterystate_free(gpointer user_data)
+{
+	struct batterystate *bs = user_data;
+
+	btd_device_unref(bs->dev);
+	g_free(bs);
+}
+
+
+int batterystate_register(struct btd_device *device, struct att_primary *dattr)
+{
+	struct batterystate *bs;
+
+	bs = g_new0(struct batterystate, 1);
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
+
+	batterystate_free(bs);
+}
diff --git a/batterystate/batterystate.h b/batterystate/batterystate.h
new file mode 100644
index 0000000..b8b22f1
--- /dev/null
+++ b/batterystate/batterystate.h
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
+int batterystate_register(struct btd_device *device, struct att_primary *tattr);
+void batterystate_unregister(struct btd_device *device);
diff --git a/batterystate/main.c b/batterystate/main.c
new file mode 100644
index 0000000..1507c88
--- /dev/null
+++ b/batterystate/main.c
@@ -0,0 +1,55 @@
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
+static int batterystate_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return batterystate_manager_init();
+}
+
+static void batterystate_exit(void)
+{
+	if (!main_opts.gatt_enabled)
+		return;
+
+	batterystate_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(batterystate, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					batterystate_init, batterystate_exit)
diff --git a/batterystate/manager.c b/batterystate/manager.c
new file mode 100644
index 0000000..0ab5db9
--- /dev/null
+++ b/batterystate/manager.c
@@ -0,0 +1,80 @@
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
+#include "batterystate.h"
+#include "manager.h"
+
+#define BATTERY_SERVICE_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
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
+	struct att_primary *prim;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, BATTERY_SERVICE_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	prim = l->data;
+
+	return batterystate_register(device, prim);
+}
+
+static void batterystate_driver_remove(struct btd_device *device)
+{
+	batterystate_unregister(device);
+}
+
+static struct btd_device_driver batterystate_device_driver = {
+	.name	= "batterystate-driver",
+	.uuids	= BTD_UUIDS(BATTERY_SERVICE_UUID),
+	.probe	= batterystate_driver_probe,
+	.remove	= batterystate_driver_remove
+};
+
+int batterystate_manager_init(void)
+{
+	return btd_register_device_driver(&batterystate_device_driver);
+}
+
+void batterystate_manager_exit(void)
+{
+	btd_unregister_device_driver(&batterystate_device_driver);
+}
diff --git a/batterystate/manager.h b/batterystate/manager.h
new file mode 100644
index 0000000..7f0bf15
--- /dev/null
+++ b/batterystate/manager.h
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
+int batterystate_manager_init(void);
+void batterystate_manager_exit(void);
-- 
1.7.4.1

