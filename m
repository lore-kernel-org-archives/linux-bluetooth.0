Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 01/10] gatt: Add Generic Access/Attribute Profile plugin
Date: Fri, 17 Aug 2012 11:43:22 -0300
Message-Id: <1345214611-9071-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial patch to create GATT based plugin to handle Generic Access,
and Generic Attribute Profile services. GAP characteristics discovery
will be moved from device.c to this new plugin.
---
 Makefile.am             |    7 ++++-
 profiles/gatt/main.c    |   52 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/gatt/manager.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gatt/manager.h |   24 ++++++++++++++++++++
 4 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 profiles/gatt/main.c
 create mode 100644 profiles/gatt/manager.c
 create mode 100644 profiles/gatt/manager.h

diff --git a/Makefile.am b/Makefile.am
index a74709d..6af33cb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -211,7 +211,8 @@ builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity deviceinfo
+builtin_modules += thermometer alert time gatt_example proximity deviceinfo \
+			gatt
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -237,7 +238,9 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/manager.h \
 			profiles/deviceinfo/manager.c \
 			profiles/deviceinfo/deviceinfo.h \
-			profiles/deviceinfo/deviceinfo.c
+			profiles/deviceinfo/deviceinfo.c \
+			profiles/gatt/main.c profiles/gatt/manager.h \
+			profiles/gatt/manager.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/gatt/main.c b/profiles/gatt/main.c
new file mode 100644
index 0000000..efe92f5
--- /dev/null
+++ b/profiles/gatt/main.c
@@ -0,0 +1,52 @@
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
+#include <stdint.h>
+#include <glib.h>
+#include <errno.h>
+
+#include "plugin.h"
+#include "manager.h"
+#include "hcid.h"
+#include "log.h"
+
+static int gatt_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		error("GATT can not start: EnableGatt is false");
+		return -ENOTSUP;
+	}
+
+	return gatt_manager_init();
+}
+
+static void gatt_exit(void)
+{
+	gatt_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gatt, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					gatt_init, gatt_exit)
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
new file mode 100644
index 0000000..ab98f86
--- /dev/null
+++ b/profiles/gatt/manager.c
@@ -0,0 +1,55 @@
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
+#include <glib.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "manager.h"
+
+static int gatt_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	return 0;
+}
+
+static void gatt_driver_remove(struct btd_device *device)
+{
+}
+
+static struct btd_device_driver gatt_device_driver = {
+	.name	= "gap-gatt-driver",
+	.uuids	= BTD_UUIDS(GAP_UUID, GATT_UUID),
+	.probe	= gatt_driver_probe,
+	.remove	= gatt_driver_remove
+};
+
+int gatt_manager_init(void)
+{
+	return btd_register_device_driver(&gatt_device_driver);
+}
+
+void gatt_manager_exit(void)
+{
+	btd_unregister_device_driver(&gatt_device_driver);
+}
diff --git a/profiles/gatt/manager.h b/profiles/gatt/manager.h
new file mode 100644
index 0000000..502fceb
--- /dev/null
+++ b/profiles/gatt/manager.h
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
+int gatt_manager_init(void);
+void gatt_manager_exit(void);
-- 
1.7.8.6

