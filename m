Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 01/20] cyclingspeed: Add CSC profile plugin skeleton
Date: Tue, 4 Dec 2012 13:43:27 +0100
Message-ID: <1354625026-29358-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds stub profile driver plugin for CSC profile.
---
 Makefile.am                          |   5 +-
 lib/uuid.h                           |   2 +
 profiles/cyclingspeed/cyclingspeed.c | 192 +++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 profiles/cyclingspeed/cyclingspeed.c

diff --git a/Makefile.am b/Makefile.am
index e95ba1a..d009828 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -178,7 +178,7 @@ builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
 endif
 
 builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
-			gatt scanparam heartrate
+			gatt scanparam heartrate cyclingspeed
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -217,7 +217,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/heartrate/manager.c \
 			profiles/heartrate/manager.h \
 			profiles/heartrate/heartrate.c \
-			profiles/heartrate/heartrate.h
+			profiles/heartrate/heartrate.h \
+			profiles/cyclingspeed/cyclingspeed.c
 
 
 builtin_modules += formfactor
diff --git a/lib/uuid.h b/lib/uuid.h
index f85abbe..a9a3b13 100644
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
index 0000000..025b09a
--- /dev/null
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -0,0 +1,192 @@
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
+#include "plugin.h"
+#include "adapter.h"
+#include "device.h"
+#include "profile.h"
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
+static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
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
+static void csc_adapter_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
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
+static int csc_device_probe(struct btd_profile *p,
+				struct btd_device *device, GSList *uuids)
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
+static void csc_device_remove(struct btd_profile *p,
+						struct btd_device *device)
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
+static int cyclingspeed_init(void)
+{
+	return btd_profile_register(&cscp_profile);
+}
+
+static void cyclingspeed_exit(void)
+{
+	btd_profile_unregister(&cscp_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(cyclingspeed, VERSION,
+					BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					cyclingspeed_init, cyclingspeed_exit)
-- 
1.8.0

