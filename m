Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 02/10] gatt: Add GAP/GATT device registration
Date: Fri, 17 Aug 2012 11:43:23 -0300
Message-Id: <1345214611-9071-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds GAP/GATT device driver probe function and the skeleton
of the register GAP/GATT device function.
---
 Makefile.am             |    3 +-
 profiles/gatt/gas.c     |   91 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gatt/gas.h     |   25 +++++++++++++
 profiles/gatt/manager.c |   29 ++++++++++++++-
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 profiles/gatt/gas.c
 create mode 100644 profiles/gatt/gas.h

diff --git a/Makefile.am b/Makefile.am
index 6af33cb..4977a05 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -240,7 +240,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/deviceinfo.h \
 			profiles/deviceinfo/deviceinfo.c \
 			profiles/gatt/main.c profiles/gatt/manager.h \
-			profiles/gatt/manager.c
+			profiles/gatt/manager.c profiles/gatt/gas.h \
+			profiles/gatt/gas.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
new file mode 100644
index 0000000..d13eadc
--- /dev/null
+++ b/profiles/gatt/gas.c
@@ -0,0 +1,91 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+#include "log.h"
+#include "gas.h"
+
+/* Generic Attribute/Access Service */
+struct gas {
+	struct btd_device *device;
+	struct att_range gap;	/* GAP Primary service range */
+	struct att_range gatt;	/* GATT Primary service range */
+};
+
+static GSList *devices = NULL;
+
+static void gas_free(struct gas *gas)
+{
+	btd_device_unref(gas->device);
+	g_free(gas);
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct gas *gas = a;
+	const struct btd_device *device = b;
+
+	return (gas->device == device ? 0 : -1);
+}
+
+int gas_register(struct btd_device *device, struct att_range *gap,
+						struct att_range *gatt)
+{
+	struct gas *gas;
+
+	gas = g_new0(struct gas, 1);
+	gas->gap.start = gap->start;
+	gas->gap.end = gap->end;
+	gas->gatt.start = gatt->start;
+	gas->gatt.end = gatt->end;
+
+	gas->device = btd_device_ref(device);
+
+	devices = g_slist_append(devices, gas);
+
+	return 0;
+}
+
+void gas_unregister(struct btd_device *device)
+{
+	struct gas *gas;
+	GSList *l;
+
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	gas = l->data;
+	devices = g_slist_remove(devices, gas);
+	gas_free(gas);
+}
diff --git a/profiles/gatt/gas.h b/profiles/gatt/gas.h
new file mode 100644
index 0000000..34853c7
--- /dev/null
+++ b/profiles/gatt/gas.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+int gas_register(struct btd_device *device, struct att_range *gap,
+						struct att_range *gatt);
+void gas_unregister(struct btd_device *device);
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index ab98f86..a1fa756 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -26,15 +26,42 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "gas.h"
 #include "manager.h"
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int gatt_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return 0;
+	GSList *primaries, *l;
+	struct gatt_primary *gap = NULL, *gatt = NULL;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, GAP_UUID, primary_uuid_cmp);
+	if (l)
+		gap = l->data;
+
+	l = g_slist_find_custom(primaries, GATT_UUID, primary_uuid_cmp);
+	if (l)
+		gatt = l->data;
+
+	return gas_register(device, gap ? &gap->range : NULL,
+				gatt ? &gatt->range : NULL);
 }
 
 static void gatt_driver_remove(struct btd_device *device)
 {
+	gas_unregister(device);
 }
 
 static struct btd_device_driver gatt_device_driver = {
-- 
1.7.8.6

