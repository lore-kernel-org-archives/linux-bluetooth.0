Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 3/8] scan: Add ATTIO callbacks registration
Date: Mon,  3 Sep 2012 15:12:40 -0300
Message-Id: <1346695965-25422-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add the functions to manage ATTIO callbacks. The current
registration mechanism is not suitable for this service since it needs
to be passive. Scan Parameters should not actively request connections,
it needs to be notified if the connections has been established
requested by other services.
---
 Makefile.am                  |   3 +-
 profiles/scanparam/manager.c |  26 ++++++++++-
 profiles/scanparam/scan.c    | 105 +++++++++++++++++++++++++++++++++++++++++++
 profiles/scanparam/scan.h    |  26 +++++++++++
 4 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 profiles/scanparam/scan.c
 create mode 100644 profiles/scanparam/scan.h

diff --git a/Makefile.am b/Makefile.am
index 0bc97ae..955c78f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -244,7 +244,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/gatt/gas.c \
 			profiles/scanparam/main.c \
 			profiles/scanparam/manager.h \
-			profiles/scanparam/manager.c
+			profiles/scanparam/manager.c \
+			profiles/scanparam/scan.h profiles/scanparam/scan.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/scanparam/manager.c b/profiles/scanparam/manager.c
index 94625f5..b413f41 100644
--- a/profiles/scanparam/manager.c
+++ b/profiles/scanparam/manager.c
@@ -27,24 +27,48 @@
 #endif
 
 #include <stdbool.h>
+#include <errno.h>
 #include <glib.h>
+#include <bluetooth/uuid.h>
 
 #include "log.h"
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
 #include "manager.h"
+#include "scan.h"
 
 #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int scan_param_probe(struct btd_device *device, GSList *uuids)
 {
+	GSList *primaries, *l;
+
 	DBG("Probing Scan Parameters");
 
-	return 0;
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, SCAN_PARAMETERS_UUID,
+							primary_uuid_cmp);
+	if (!l)
+		return -EINVAL;
+
+	return scan_register(device, l->data);
 }
 
 static void scan_param_remove(struct btd_device *device)
 {
+	scan_unregister(device);
 }
 
 static struct btd_profile scan_profile = {
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
new file mode 100644
index 0000000..c6aaf97
--- /dev/null
+++ b/profiles/scanparam/scan.c
@@ -0,0 +1,105 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+#include <stdbool.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "attio.h"
+#include "scan.h"
+
+struct scan {
+	struct btd_device *device;
+	GAttrib *attrib;
+	guint attioid;
+};
+
+GSList *servers = NULL;
+
+static gint scan_device_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct scan *scan = a;
+	const struct btd_device *device = b;
+
+	return (device == scan->device ? 0 : -1);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct scan *scan = user_data;
+
+	scan->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct scan *scan = user_data;
+
+	g_attrib_unref(scan->attrib);
+	scan->attrib = NULL;
+}
+
+int scan_register(struct btd_device *device, struct gatt_primary *prim)
+{
+	struct scan *scan;
+
+	scan = g_new0(struct scan, 1);
+	scan->device = btd_device_ref(device);
+	scan->attioid = btd_device_add_attio_callback(device,
+							attio_connected_cb,
+							attio_disconnected_cb,
+							scan);
+
+	servers = g_slist_prepend(servers, scan);
+
+	return 0;
+}
+
+void scan_unregister(struct btd_device *device)
+{
+	struct scan *scan;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, device, scan_device_cmp);
+	if (l == NULL)
+		return;
+
+	scan = l->data;
+	servers = g_slist_remove(servers, scan);
+
+	btd_device_remove_attio_callback(scan->device, scan->attioid);
+	btd_device_unref(scan->device);
+	g_attrib_unref(scan->attrib);
+	g_free(scan);
+}
diff --git a/profiles/scanparam/scan.h b/profiles/scanparam/scan.h
new file mode 100644
index 0000000..93f7edd
--- /dev/null
+++ b/profiles/scanparam/scan.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+int scan_register(struct btd_device *device, struct gatt_primary *prim);
+void scan_unregister(struct btd_device *device);
-- 
1.7.12

