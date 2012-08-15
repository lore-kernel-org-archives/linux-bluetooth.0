Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 02/10] gap: Add GAP device registration
Date: Wed, 15 Aug 2012 11:19:59 -0300
Message-Id: <1345040407-17767-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds GAP device driver probe function and the skeleton of
the register GAP device function.
---
 Makefile.am            |    3 +-
 profiles/gap/gap.c     |   85 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gap/gap.h     |   24 +++++++++++++
 profiles/gap/manager.c |   22 ++++++++++++-
 4 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 profiles/gap/gap.c
 create mode 100644 profiles/gap/gap.h

diff --git a/Makefile.am b/Makefile.am
index 2db3ce1..d0a8de6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -239,7 +239,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/deviceinfo.h \
 			profiles/deviceinfo/deviceinfo.c \
 			profiles/gap/main.c profiles/gap/manager.h \
-			profiles/gap/manager.c
+			profiles/gap/manager.c profiles/gap/gap.h \
+			profiles/gap/gap.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/gap/gap.c b/profiles/gap/gap.c
new file mode 100644
index 0000000..7172975
--- /dev/null
+++ b/profiles/gap/gap.c
@@ -0,0 +1,85 @@
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
+#include "gap.h"
+
+struct gap {
+	struct btd_device *device;
+	struct att_range range;	/* GAP Primary service range */
+};
+
+static GSList *devices = NULL;
+
+static void gap_free(struct gap *gap)
+{
+	btd_device_unref(gap->device);
+	g_free(gap);
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct gap *gap = a;
+	const struct btd_device *device = b;
+
+	return (gap->device == device ? 0 : -1);
+}
+
+int gap_register(struct btd_device *device, struct gatt_primary *prim)
+{
+	struct gap *gap;
+
+	gap = g_new0(struct gap, 1);
+	gap->range.start = prim->range.start;
+	gap->range.end = prim->range.end;
+	gap->device = btd_device_ref(device);
+
+	devices = g_slist_append(devices, gap);
+
+	return 0;
+}
+
+void gap_unregister(struct btd_device *device)
+{
+	struct gap *gap;
+	GSList *l;
+
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	gap = l->data;
+	devices = g_slist_remove(devices, gap);
+	gap_free(gap);
+}
diff --git a/profiles/gap/gap.h b/profiles/gap/gap.h
new file mode 100644
index 0000000..722750e
--- /dev/null
+++ b/profiles/gap/gap.h
@@ -0,0 +1,24 @@
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
+int gap_register(struct btd_device *device, struct gatt_primary *prim);
+void gap_unregister(struct btd_device *device);
diff --git a/profiles/gap/manager.c b/profiles/gap/manager.c
index f2e36f5..9c2f3eb 100644
--- a/profiles/gap/manager.c
+++ b/profiles/gap/manager.c
@@ -26,11 +26,31 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "gap.h"
 #include "manager.h"
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int gap_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return 0;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, GAP_UUID, primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	return gap_register(device, l->data);
 }
 
 static void gap_driver_remove(struct btd_device *device)
-- 
1.7.8.6

