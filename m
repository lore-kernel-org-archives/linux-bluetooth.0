Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 01/18] cyclingspeed: Add CSC profile plugin skeleton
Date: Thu, 25 Oct 2012 16:43:31 +0200
Message-ID: <1351176228-5789-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds stub profile driver plugin for CSC profile.
---
 Makefile.am                          |   9 +-
 lib/uuid.h                           |   2 +
 profiles/cyclingspeed/cyclingspeed.c | 163 +++++++++++++++++++++++++++++++++++
 profiles/cyclingspeed/cyclingspeed.h |  26 ++++++
 profiles/cyclingspeed/main.c         |  53 ++++++++++++
 profiles/cyclingspeed/manager.c      |  79 +++++++++++++++++
 profiles/cyclingspeed/manager.h      |  24 ++++++
 7 files changed, 354 insertions(+), 2 deletions(-)
 create mode 100644 profiles/cyclingspeed/cyclingspeed.c
 create mode 100644 profiles/cyclingspeed/cyclingspeed.h
 create mode 100644 profiles/cyclingspeed/main.c
 create mode 100644 profiles/cyclingspeed/manager.c
 create mode 100644 profiles/cyclingspeed/manager.h

diff --git a/Makefile.am b/Makefile.am
index 35b1520..9bdfd71 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -212,7 +212,7 @@ endif
 
 if GATTMODULES
 builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
-			gatt scanparam heartrate
+			gatt scanparam heartrate cyclingspeed
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -251,7 +251,12 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/heartrate/manager.c \
 			profiles/heartrate/manager.h \
 			profiles/heartrate/heartrate.c \
-			profiles/heartrate/heartrate.h
+			profiles/heartrate/heartrate.h \
+			profiles/cyclingspeed/main.c \
+			profiles/cyclingspeed/manager.c \
+			profiles/cyclingspeed/manager.h \
+			profiles/cyclingspeed/cyclingspeed.c \
+			profiles/cyclingspeed/cyclingspeed.h
 
 endif
 
diff --git a/lib/uuid.h b/lib/uuid.h
index a812309..ebc6d27 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -74,6 +74,8 @@ extern "C" {
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
+#define CYCLING_SC_UUID		"00001816-0000-1000-8000-00805f9b34fb"
+
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
 
 #define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
new file mode 100644
index 0000000..9674a94
--- /dev/null
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -0,0 +1,163 @@
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
+#include "cyclingspeed.h"
+
+struct csc_adapter {
+	struct btd_adapter	*adapter;
+	GSList			*devices;	/* list of registered devices */
+};
+
+struct csc {
+	struct btd_device	*dev;
+	struct csc_adapter	*cadapter;
+};
+
+static GSList *csc_adapters = NULL;
+
+static gint cmp_adapter(gconstpointer a, gconstpointer b)
+{
+	const struct csc_adapter *cadapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (adapter == cadapter->adapter)
+		return 0;
+
+	return -1;
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct csc *csc = a;
+	const struct btd_device *dev = b;
+
+	if (dev == csc->dev)
+		return 0;
+
+	return -1;
+}
+
+static struct csc_adapter *find_csc_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(csc_adapters, adapter, cmp_adapter);
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static void destroy_csc_adapter(gpointer user_data)
+{
+	struct csc_adapter *cadapter = user_data;
+
+	g_free(cadapter);
+}
+
+static void destroy_csc(gpointer user_data)
+{
+	struct csc *csc = user_data;
+
+	btd_device_unref(csc->dev);
+	g_free(csc);
+}
+
+int csc_adapter_register(struct btd_adapter *adapter)
+{
+	struct csc_adapter *cadapter;
+
+	cadapter = g_new0(struct csc_adapter, 1);
+	cadapter->adapter = adapter;
+
+	csc_adapters = g_slist_prepend(csc_adapters, cadapter);
+
+	return 0;
+}
+
+void csc_adapter_unregister(struct btd_adapter *adapter)
+{
+	struct csc_adapter *cadapter;
+
+	cadapter = find_csc_adapter(adapter);
+	if (cadapter == NULL)
+		return;
+
+	csc_adapters = g_slist_remove(csc_adapters, cadapter);
+
+	destroy_csc_adapter(cadapter);
+}
+
+int csc_device_register(struct btd_device *device)
+{
+	struct btd_adapter *adapter;
+	struct csc_adapter *cadapter;
+	struct csc *csc;
+
+	adapter = device_get_adapter(device);
+
+	cadapter = find_csc_adapter(adapter);
+	if (cadapter == NULL)
+		return -1;
+
+	csc = g_new0(struct csc, 1);
+	csc->dev = btd_device_ref(device);
+	csc->cadapter = cadapter;
+
+	cadapter->devices = g_slist_prepend(cadapter->devices, csc);
+
+	return 0;
+}
+
+void csc_device_unregister(struct btd_device *device)
+{
+	struct btd_adapter *adapter;
+	struct csc_adapter *cadapter;
+	struct csc *csc;
+	GSList *l;
+
+	adapter = device_get_adapter(device);
+
+	cadapter = find_csc_adapter(adapter);
+	if (cadapter == NULL)
+		return;
+
+	l = g_slist_find_custom(cadapter->devices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	csc = l->data;
+
+	cadapter->devices = g_slist_remove(cadapter->devices, csc);
+
+	destroy_csc(csc);
+}
diff --git a/profiles/cyclingspeed/cyclingspeed.h b/profiles/cyclingspeed/cyclingspeed.h
new file mode 100644
index 0000000..b83fa9e
--- /dev/null
+++ b/profiles/cyclingspeed/cyclingspeed.h
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
+int csc_adapter_register(struct btd_adapter *adapter);
+void csc_adapter_unregister(struct btd_adapter *adapter);
+int csc_device_register(struct btd_device *device);
+void csc_device_unregister(struct btd_device *device);
diff --git a/profiles/cyclingspeed/main.c b/profiles/cyclingspeed/main.c
new file mode 100644
index 0000000..c2ef765
--- /dev/null
+++ b/profiles/cyclingspeed/main.c
@@ -0,0 +1,53 @@
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
+static int cyclingspeed_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return cyclingspeed_manager_init();
+}
+
+static void cyclingspeed_exit(void)
+{
+	cyclingspeed_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(cyclingspeed, VERSION,
+					BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					cyclingspeed_init, cyclingspeed_exit)
diff --git a/profiles/cyclingspeed/manager.c b/profiles/cyclingspeed/manager.c
new file mode 100644
index 0000000..e5f7553
--- /dev/null
+++ b/profiles/cyclingspeed/manager.c
@@ -0,0 +1,79 @@
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
+#include "profile.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "cyclingspeed.h"
+#include "manager.h"
+
+static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	return csc_adapter_register(adapter);
+}
+
+static void csc_adapter_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	csc_adapter_unregister(adapter);
+}
+
+static int csc_device_probe(struct btd_profile *p,
+				struct btd_device *device, GSList *uuids)
+{
+	return csc_device_register(device);
+}
+
+static void csc_device_remove(struct btd_profile *p,
+						struct btd_device *device)
+{
+	csc_device_unregister(device);
+}
+
+static struct btd_profile cscp_profile = {
+	.name		= "Cycling Speed and Cadence GATT Driver",
+	.remote_uuids	= BTD_UUIDS(CYCLING_SC_UUID),
+
+	.adapter_probe	= csc_adapter_probe,
+	.adapter_remove	= csc_adapter_remove,
+
+	.device_probe	= csc_device_probe,
+	.device_remove	= csc_device_remove,
+};
+
+int cyclingspeed_manager_init(void)
+{
+	return btd_profile_register(&cscp_profile);
+}
+
+void cyclingspeed_manager_exit(void)
+{
+	btd_profile_unregister(&cscp_profile);
+}
diff --git a/profiles/cyclingspeed/manager.h b/profiles/cyclingspeed/manager.h
new file mode 100644
index 0000000..7d25ae4
--- /dev/null
+++ b/profiles/cyclingspeed/manager.h
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
+int cyclingspeed_manager_init(void);
+void cyclingspeed_manager_exit(void);
-- 
1.8.0

