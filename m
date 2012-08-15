Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 01/10] gap: Add Generic Access Profile plugin skeleton
Date: Wed, 15 Aug 2012 11:19:58 -0300
Message-Id: <1345040407-17767-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial patch to create GATT based plugin to handle Generic Access
Profile service. GAP characteristics discovery will be moved from
device.c to this new plugin.
---
 Makefile.am            |    6 +++-
 profiles/gap/main.c    |   52 +++++++++++++++++++++++++++++++++++++++++++++
 profiles/gap/manager.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gap/manager.h |   24 +++++++++++++++++++++
 4 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 profiles/gap/main.c
 create mode 100644 profiles/gap/manager.c
 create mode 100644 profiles/gap/manager.h

diff --git a/Makefile.am b/Makefile.am
index a74709d..2db3ce1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -211,7 +211,7 @@ builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity deviceinfo
+builtin_modules += thermometer alert time gatt_example proximity deviceinfo gap
 builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/manager.h \
 			profiles/thermometer/manager.c \
@@ -237,7 +237,9 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/manager.h \
 			profiles/deviceinfo/manager.c \
 			profiles/deviceinfo/deviceinfo.h \
-			profiles/deviceinfo/deviceinfo.c
+			profiles/deviceinfo/deviceinfo.c \
+			profiles/gap/main.c profiles/gap/manager.h \
+			profiles/gap/manager.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/gap/main.c b/profiles/gap/main.c
new file mode 100644
index 0000000..7495807
--- /dev/null
+++ b/profiles/gap/main.c
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
+static int gap_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		error("GAP can not start: GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return gap_manager_init();
+}
+
+static void gap_exit(void)
+{
+	gap_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					gap_init, gap_exit)
diff --git a/profiles/gap/manager.c b/profiles/gap/manager.c
new file mode 100644
index 0000000..f2e36f5
--- /dev/null
+++ b/profiles/gap/manager.c
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
+static int gap_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	return 0;
+}
+
+static void gap_driver_remove(struct btd_device *device)
+{
+}
+
+static struct btd_device_driver gap_device_driver = {
+	.name	= "gap-driver",
+	.uuids	= BTD_UUIDS(GAP_UUID),
+	.probe	= gap_driver_probe,
+	.remove	= gap_driver_remove
+};
+
+int gap_manager_init(void)
+{
+	return btd_register_device_driver(&gap_device_driver);
+}
+
+void gap_manager_exit(void)
+{
+	btd_unregister_device_driver(&gap_device_driver);
+}
diff --git a/profiles/gap/manager.h b/profiles/gap/manager.h
new file mode 100644
index 0000000..7bc947f
--- /dev/null
+++ b/profiles/gap/manager.h
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
+int gap_manager_init(void);
+void gap_manager_exit(void);
-- 
1.7.8.6

