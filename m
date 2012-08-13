Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 02/13] heartrate: Add Heart Rate Service GATT client skeleton
Date: Mon, 13 Aug 2012 17:08:06 +0200
Message-ID: <1344870497-6929-3-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add initial support for the Heart Rate Service GATT
Client side.

---
 Makefile.am                    |   10 ++++-
 lib/uuid.h                     |    2 +
 profiles/heartrate/heartrate.c |   84 ++++++++++++++++++++++++++++++++++++++++
 profiles/heartrate/heartrate.h |   24 ++++++++++++
 profiles/heartrate/main.c      |   52 +++++++++++++++++++++++++
 profiles/heartrate/manager.c   |   60 ++++++++++++++++++++++++++++
 profiles/heartrate/manager.h   |   24 ++++++++++++
 7 files changed, 254 insertions(+), 2 deletions(-)
 create mode 100644 profiles/heartrate/heartrate.c
 create mode 100644 profiles/heartrate/heartrate.h
 create mode 100644 profiles/heartrate/main.c
 create mode 100644 profiles/heartrate/manager.c
 create mode 100644 profiles/heartrate/manager.h

diff --git a/Makefile.am b/Makefile.am
index 45a811c..594ea56 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -211,7 +211,8 @@ builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity deviceinfo
+builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
+	heartrate
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -237,7 +238,12 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/manager.h \
 			profiles/deviceinfo/manager.c \
 			profiles/deviceinfo/deviceinfo.h \
-			profiles/deviceinfo/deviceinfo.c
+			profiles/deviceinfo/deviceinfo.c \
+			profiles/heartrate/main.c \
+			profiles/heartrate/manager.c \
+			profiles/heartrate/manager.h \
+			profiles/heartrate/heartrate.c \
+			profiles/heartrate/heartrate.h
 endif
 
 builtin_modules += formfactor
diff --git a/lib/uuid.h b/lib/uuid.h
index 2c2b351..99b88cc 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -63,6 +63,8 @@ extern "C" {
 
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
+#define HEART_RATE_UUID		"0000180d-0000-1000-8000-00805f9b34fb"
+
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
new file mode 100644
index 0000000..9bd93c5
--- /dev/null
+++ b/profiles/heartrate/heartrate.c
@@ -0,0 +1,84 @@
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
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "heartrate.h"
+
+struct heartrate {
+	struct btd_device	*dev;  /*Device reference*/
+};
+
+static GSList *hr_servers = NULL;
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
+static void heartrate_destroy(gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	btd_device_unref(hr->dev);
+	g_free(hr);
+}
+
+int heartrate_register(struct btd_device *device)
+{
+	struct heartrate *hr;
+
+	hr = g_new0(struct heartrate, 1);
+	hr->dev = btd_device_ref(device);
+
+	hr_servers = g_slist_prepend(hr_servers, hr);
+
+	return 0;
+}
+void heartrate_unregister(struct btd_device *device)
+{
+	struct heartrate *hr;
+	GSList *l;
+
+	l = g_slist_find_custom(hr_servers, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	hr = l->data;
+	hr_servers = g_slist_remove(hr_servers, hr);
+
+	heartrate_destroy(hr);
+}
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
new file mode 100644
index 0000000..8d4271c
--- /dev/null
+++ b/profiles/heartrate/heartrate.h
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
+int heartrate_register(struct btd_device *device);
+void heartrate_unregister(struct btd_device *device);
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
index 0000000..da6c7ef
--- /dev/null
+++ b/profiles/heartrate/manager.c
@@ -0,0 +1,60 @@
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
+static int heartrate_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	return heartrate_register(device);
+}
+
+static void heartrate_driver_remove(struct btd_device *device)
+{
+	heartrate_unregister(device);
+}
+
+static struct btd_device_driver heartrate_device_driver = {
+	.name	= "heart-rate-driver",
+	.uuids	= BTD_UUIDS(HEART_RATE_UUID),
+	.probe	= heartrate_driver_probe,
+	.remove	= heartrate_driver_remove
+};
+
+int heartrate_manager_init(void)
+{
+	return btd_register_device_driver(&heartrate_device_driver);
+}
+
+void heartrate_manager_exit(void)
+{
+	btd_unregister_device_driver(&heartrate_device_driver);
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
1.7.9.5

