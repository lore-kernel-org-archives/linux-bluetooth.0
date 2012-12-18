Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] hog: Merge hog_device.h code into hog_device.c
Date: Tue, 18 Dec 2012 11:41:19 -0300
Message-Id: <1355841681-2589-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
References: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch merges hog_device.h code into hog_device.c and removes
hog_device.h file. As long as hog_manager.c was merged into hog_
device.c, there is no need to have a header for hog_device.

This patch also adds the static modifier to functions which are
now used only in hog_device.c.
---
 Makefile.plugins            |  5 ++---
 profiles/input/hog_device.c |  8 ++++----
 profiles/input/hog_device.h | 33 ---------------------------------
 3 files changed, 6 insertions(+), 40 deletions(-)
 delete mode 100644 profiles/input/hog_device.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 781218c..41b6876 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -59,9 +59,8 @@ builtin_sources += profiles/input/manager.h profiles/input/manager.c \
 			profiles/input/device.h profiles/input/device.c
 
 builtin_modules += hog
-builtin_sources += profiles/input/hog_device.h profiles/input/hog_device.c \
-			profiles/input/uhid_copy.h profiles/input/suspend.h \
-			profiles/input/suspend-dummy.c
+builtin_sources += profiles/input/hog_device.c profiles/input/uhid_copy.h \
+			profiles/input/suspend.h profiles/input/suspend-dummy.c
 
 builtin_modules += health
 builtin_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 310eb53..7efabf2 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -54,7 +54,7 @@
 #include "attio.h"
 #include "attrib/gatt.h"
 
-#include "hog_device.h"
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
@@ -716,7 +716,7 @@ static void hog_device_free(struct hog_device *hogdev)
 	g_free(hogdev);
 }
 
-struct hog_device *hog_device_register(struct btd_device *device,
+static struct hog_device *hog_device_register(struct btd_device *device,
 						struct gatt_primary *prim)
 {
 	struct hog_device *hogdev;
@@ -753,7 +753,7 @@ struct hog_device *hog_device_register(struct btd_device *device,
 	return hogdev;
 }
 
-int hog_device_unregister(struct hog_device *hogdev)
+static int hog_device_unregister(struct hog_device *hogdev)
 {
 	struct uhid_event ev;
 
@@ -777,7 +777,7 @@ int hog_device_unregister(struct hog_device *hogdev)
 	return 0;
 }
 
-int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend)
+static int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend)
 {
 	uint8_t value = suspend ? 0x00 : 0x01;
 
diff --git a/profiles/input/hog_device.h b/profiles/input/hog_device.h
deleted file mode 100644
index d1bfc08..0000000
--- a/profiles/input/hog_device.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright (C) 2012  Nordic Semiconductor Inc.
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
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
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
-
-struct hog_device;
-
-struct hog_device *hog_device_register(struct btd_device *device,
-						struct gatt_primary *prim);
-int hog_device_unregister(struct hog_device *hogdev);
-int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend);
-- 
1.8.0.1

