Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v3 02/17] heartrate: Add Heart Rate Profile client
Date: Thu, 6 Sep 2012 13:32:36 +0200
Message-ID: <1346931171-18968-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds initial support for the Heart Rate Profile client.

---
 Makefile.am                    |   9 ++-
 lib/uuid.h                     |   2 +
 profiles/heartrate/heartrate.c | 165 +++++++++++++++++++++++++++++++++++++++++
 profiles/heartrate/heartrate.h |  26 +++++++
 profiles/heartrate/main.c      |  52 +++++++++++++
 profiles/heartrate/manager.c   |  75 +++++++++++++++++++
 profiles/heartrate/manager.h   |  24 ++++++
 7 files changed, 351 insertions(+), 2 deletions(-)
 create mode 100644 profiles/heartrate/heartrate.c
 create mode 100644 profiles/heartrate/heartrate.h
 create mode 100644 profiles/heartrate/main.c
 create mode 100644 profiles/heartrate/manager.c
 create mode 100644 profiles/heartrate/manager.h

diff --git a/Makefile.am b/Makefile.am
index 4977a05..cb36d91 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -212,7 +212,7 @@ endif
 
 if GATTMODULES
 builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
-			gatt
+			gatt heartrate
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -241,7 +241,12 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/deviceinfo.c \
 			profiles/gatt/main.c profiles/gatt/manager.h \
 			profiles/gatt/manager.c profiles/gatt/gas.h \
-			profiles/gatt/gas.c
+			profiles/gatt/gas.c \
+			profiles/heartrate/main.c \
+			profiles/heartrate/manager.c \
+			profiles/heartrate/manager.h \
+			profiles/heartrate/heartrate.c \
+			profiles/heartrate/heartrate.h
 endif
 
 builtin_modules += formfactor
diff --git a/lib/uuid.h b/lib/uuid.h
index aa6efdf..3488e66 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -63,6 +63,8 @@ extern "C" {
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
+#define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
+
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
new file mode 100644
index 0000000..17514c0
--- /dev/null
+++ b/profiles/heartrate/heartrate.c
@@ -0,0 +1,165 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Tieto Poland
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
+#include <stdbool.h>
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "heartrate.h"
+
+struct heartrate_adapter {
+	struct btd_adapter	*adapter;
+	GSList			*devices;
+};
+
+struct heartrate {
+	struct btd_device		*dev;
+	struct heartrate_adapter	*hra;
+};
+
+static GSList *heartrate_adapters = NULL;
+
+static gint cmp_adapter(gconstpointer a, gconstpointer b)
+{
+	const struct heartrate_adapter *hra = a;
+	const struct btd_adapter *adapter = b;
+
+	if (adapter == hra->adapter)
+		return 0;
+
+	return -1;
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct heartrate *hr = a;
+	const struct btd_device *dev = b;
+
+	if (dev == hr->dev)
+		return 0;
+
+	return -1;
+}
+
+static struct heartrate_adapter *
+find_heartrate_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(heartrate_adapters, adapter,
+								cmp_adapter);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static void destroy_heartrate_device(gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	btd_device_unref(hr->dev);
+	g_free(hr);
+}
+
+static void destroy_heartrate_adapter(gpointer user_data)
+{
+	struct heartrate_adapter *hra = user_data;
+
+	g_free(hra);
+}
+
+int heartrate_adapter_register(struct btd_adapter *adapter)
+{
+	struct heartrate_adapter *hra;
+
+	hra = g_new0(struct heartrate_adapter, 1);
+	hra->adapter = adapter;
+
+	heartrate_adapters = g_slist_prepend(heartrate_adapters, hra);
+
+	return 0;
+}
+
+void heartrate_adapter_unregister(struct btd_adapter *adapter)
+{
+	struct heartrate_adapter *hra;
+
+	hra = find_heartrate_adapter(adapter);
+	if (hra == NULL)
+		return;
+
+	heartrate_adapters = g_slist_remove(heartrate_adapters, hra);
+
+	destroy_heartrate_adapter(hra);
+}
+
+int heartrate_device_register(struct btd_device *device)
+{
+	struct heartrate_adapter *hra;
+	struct btd_adapter *adapter;
+	struct heartrate *hr;
+
+	adapter = device_get_adapter(device);
+
+	hra = find_heartrate_adapter(adapter);
+
+	if (hra == NULL)
+		return -1;
+
+	hr = g_new0(struct heartrate, 1);
+	hr->dev = btd_device_ref(device);
+	hr->hra = hra;
+
+	hra->devices = g_slist_prepend(hra->devices, hr);
+
+	return 0;
+}
+
+void heartrate_device_unregister(struct btd_device *device)
+{
+	struct heartrate_adapter *hra;
+	struct btd_adapter *adapter;
+	struct heartrate *hr;
+	GSList *l;
+
+	adapter = device_get_adapter(device);
+
+	hra = find_heartrate_adapter(adapter);
+	if (hra == NULL)
+		return;
+
+	l = g_slist_find_custom(hra->devices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	hr = l->data;
+
+	hra->devices = g_slist_remove(hra->devices, hr);
+
+	destroy_heartrate_device(hr);
+}
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
new file mode 100644
index 0000000..486f5b3
--- /dev/null
+++ b/profiles/heartrate/heartrate.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Tieto Poland
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
+int heartrate_adapter_register(struct btd_adapter *adapter);
+void heartrate_adapter_unregister(struct btd_adapter *adapter);
+int heartrate_device_register(struct btd_device *device);
+void heartrate_device_unregister(struct btd_device *device);
diff --git a/profiles/heartrate/main.c b/profiles/heartrate/main.c
new file mode 100644
index 0000000..40f34bc
--- /dev/null
+++ b/profiles/heartrate/main.c
@@ -0,0 +1,52 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Tieto Poland
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
+#include "plugin.h"
+#include "manager.h"
+#include "hcid.h"
+#include "log.h"
+
+static int heartrate_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return heartrate_manager_init();
+}
+
+static void heartrate_exit(void)
+{
+	heartrate_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(heartrate, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					heartrate_init, heartrate_exit)
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
new file mode 100644
index 0000000..9d2446c
--- /dev/null
+++ b/profiles/heartrate/manager.c
@@ -0,0 +1,75 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Tieto Poland
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
+#include <stdbool.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "heartrate.h"
+#include "manager.h"
+
+static int heartrate_adapter_probe(struct btd_adapter *adapter)
+{
+	return heartrate_adapter_register(adapter);
+}
+
+static void heartrate_adapter_remove(struct btd_adapter *adapter)
+{
+	heartrate_adapter_unregister(adapter);
+}
+
+static int heartrate_device_probe(struct btd_device *device, GSList *uuids)
+{
+	return heartrate_device_register(device);
+}
+
+static void heartrate_device_remove(struct btd_device *device)
+{
+	heartrate_device_unregister(device);
+}
+
+static struct btd_profile hrp_profile = {
+	.name		= "Heart Rate GATT Driver",
+	.remote_uuids	= BTD_UUIDS(HEART_RATE_UUID),
+
+	.device_probe	= heartrate_device_probe,
+	.device_remove	= heartrate_device_remove,
+
+	.adapter_probe	= heartrate_adapter_probe,
+	.adapter_remove	= heartrate_adapter_remove,
+};
+
+int heartrate_manager_init(void)
+{
+	return btd_profile_register(&hrp_profile);
+}
+
+void heartrate_manager_exit(void)
+{
+	btd_profile_unregister(&hrp_profile);
+}
diff --git a/profiles/heartrate/manager.h b/profiles/heartrate/manager.h
new file mode 100644
index 0000000..de799f6
--- /dev/null
+++ b/profiles/heartrate/manager.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Tieto Poland
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
+int heartrate_manager_init(void);
+void heartrate_manager_exit(void);
-- 
1.7.11.3

