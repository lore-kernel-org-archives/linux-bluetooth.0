Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/4] gas: Move all the code to only one file
Date: Mon, 28 Jan 2013 20:48:10 -0300
Message-Id: <1359416891-12740-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Our Generic Attribute/Access Service plugin is small and simple enough
to be kept in only one file.
---
 Makefile.plugins        |  4 +--
 profiles/gatt/gas.c     | 46 ++++++++++++++++++++++++++++
 profiles/gatt/main.c    | 47 -----------------------------
 profiles/gatt/manager.c | 79 -------------------------------------------------
 profiles/gatt/manager.h | 24 ---------------
 5 files changed, 47 insertions(+), 153 deletions(-)
 delete mode 100644 profiles/gatt/main.c
 delete mode 100644 profiles/gatt/manager.c
 delete mode 100644 profiles/gatt/manager.h

diff --git a/Makefile.plugins b/Makefile.plugins
index faab011..f497782 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -69,9 +69,7 @@ builtin_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
 endif
 
 builtin_modules += gatt
-builtin_sources += profiles/gatt/main.c profiles/gatt/manager.h \
-			profiles/gatt/manager.c profiles/gatt/gas.h \
-			profiles/gatt/gas.c
+builtin_sources += profiles/gatt/gas.c
 
 builtin_modules += scanparam
 builtin_sources += profiles/scanparam/scan.c
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 429850b..e0edbf3 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -35,8 +35,10 @@
 #include <btio/btio.h>
 
 #include "lib/uuid.h"
+#include "plugin.h"
 #include "adapter.h"
 #include "device.h"
+#include "profile.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
@@ -405,3 +407,47 @@ void gas_unregister(struct btd_device *device)
 	devices = g_slist_remove(devices, gas);
 	gas_free(gas);
 }
+
+static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
+								GSList *uuids)
+{
+	struct gatt_primary *gap, *gatt;
+
+	gap = btd_device_get_primary(device, GAP_UUID);
+	gatt = btd_device_get_primary(device, GATT_UUID);
+
+	if (gap == NULL || gatt == NULL) {
+		error("GAP and GATT are mandatory");
+		return -EINVAL;
+	}
+
+	return gas_register(device, &gap->range, &gatt->range);
+}
+
+static void gatt_driver_remove(struct btd_profile *p,
+						struct btd_device *device)
+{
+	gas_unregister(device);
+}
+
+static struct btd_profile gatt_profile = {
+	.name		= "gap-gatt-profile",
+	.remote_uuids	= BTD_UUIDS(GAP_UUID, GATT_UUID),
+	.device_probe	= gatt_driver_probe,
+	.device_remove	= gatt_driver_remove
+};
+
+static int gatt_init(void)
+{
+	btd_profile_register(&gatt_profile);
+
+	return 0;
+}
+
+static void gatt_exit(void)
+{
+	btd_profile_unregister(&gatt_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gatt, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					gatt_init, gatt_exit)
diff --git a/profiles/gatt/main.c b/profiles/gatt/main.c
deleted file mode 100644
index ecd4455..0000000
--- a/profiles/gatt/main.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdint.h>
-#include <glib.h>
-#include <errno.h>
-
-#include "plugin.h"
-#include "manager.h"
-#include "hcid.h"
-#include "log.h"
-
-static int gatt_init(void)
-{
-	return gatt_manager_init();
-}
-
-static void gatt_exit(void)
-{
-	gatt_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(gatt, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-					gatt_init, gatt_exit)
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
deleted file mode 100644
index 2f2bd14..0000000
--- a/profiles/gatt/manager.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include <glib.h>
-#include <errno.h>
-#include <stdbool.h>
-
-#include "lib/uuid.h"
-#include "adapter.h"
-#include "device.h"
-#include "profile.h"
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "attrib/gatt.h"
-#include "gas.h"
-#include "log.h"
-#include "manager.h"
-
-static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
-{
-	struct gatt_primary *gap, *gatt;
-
-	gap = btd_device_get_primary(device, GAP_UUID);
-	gatt = btd_device_get_primary(device, GATT_UUID);
-
-	if (gap == NULL || gatt == NULL) {
-		error("GAP and GATT are mandatory");
-		return -EINVAL;
-	}
-
-	return gas_register(device, &gap->range, &gatt->range);
-}
-
-static void gatt_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
-{
-	gas_unregister(device);
-}
-
-static struct btd_profile gatt_profile = {
-	.name		= "gap-gatt-profile",
-	.remote_uuids	= BTD_UUIDS(GAP_UUID, GATT_UUID),
-	.device_probe	= gatt_driver_probe,
-	.device_remove	= gatt_driver_remove
-};
-
-int gatt_manager_init(void)
-{
-	return btd_profile_register(&gatt_profile);
-}
-
-void gatt_manager_exit(void)
-{
-	btd_profile_unregister(&gatt_profile);
-}
diff --git a/profiles/gatt/manager.h b/profiles/gatt/manager.h
deleted file mode 100644
index 502fceb..0000000
--- a/profiles/gatt/manager.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int gatt_manager_init(void);
-void gatt_manager_exit(void);
-- 
1.8.1.1

