Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 2/8] scan: Register profile
Date: Tue, 25 Sep 2012 12:26:36 -0300
Message-Id: <1348586802-32613-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
 <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add the probe and remove callbacks for the GATT Scan
Parameters service.
---
 Makefile.am                  |  4 ++-
 profiles/scanparam/main.c    |  4 ++-
 profiles/scanparam/manager.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/scanparam/manager.h | 26 +++++++++++++++++
 4 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 profiles/scanparam/manager.c
 create mode 100644 profiles/scanparam/manager.h

diff --git a/Makefile.am b/Makefile.am
index bf86453..50f780e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -241,7 +241,9 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/gatt/main.c profiles/gatt/manager.h \
 			profiles/gatt/manager.c profiles/gatt/gas.h \
 			profiles/gatt/gas.c \
-			profiles/scanparam/main.c
+			profiles/scanparam/main.c \
+			profiles/scanparam/manager.h \
+			profiles/scanparam/manager.c
 endif
 
 builtin_modules += formfactor
diff --git a/profiles/scanparam/main.c b/profiles/scanparam/main.c
index 6e90929..ba4b2c0 100644
--- a/profiles/scanparam/main.c
+++ b/profiles/scanparam/main.c
@@ -33,6 +33,7 @@
 #include "log.h"
 #include "plugin.h"
 #include "hcid.h"
+#include "manager.h"
 
 static int scan_param_init(void)
 {
@@ -41,11 +42,12 @@ static int scan_param_init(void)
 		return -ENOTSUP;
 	}
 
-	return 0;
+	return scan_param_manager_init();
 }
 
 static void scan_param_exit(void)
 {
+	scan_param_manager_exit();
 }
 
 BLUETOOTH_PLUGIN_DEFINE(scanparam, VERSION,
diff --git a/profiles/scanparam/manager.c b/profiles/scanparam/manager.c
new file mode 100644
index 0000000..c1ac0bb
--- /dev/null
+++ b/profiles/scanparam/manager.c
@@ -0,0 +1,68 @@
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
+#include <glib.h>
+
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "profile.h"
+#include "manager.h"
+
+#define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
+
+static int scan_param_probe(struct btd_profile *p, struct btd_device *device,
+								GSList *uuids)
+{
+	DBG("Probing Scan Parameters");
+
+	return 0;
+}
+
+static void scan_param_remove(struct btd_profile *p, struct btd_device *device)
+{
+}
+
+static struct btd_profile scan_profile = {
+	.name = "Scan Parameters Client Driver",
+	.remote_uuids = BTD_UUIDS(SCAN_PARAMETERS_UUID),
+	.device_probe = scan_param_probe,
+	.device_remove = scan_param_remove,
+};
+
+int scan_param_manager_init(void)
+{
+	return btd_profile_register(&scan_profile);
+
+}
+
+void scan_param_manager_exit(void)
+{
+	btd_profile_unregister(&scan_profile);
+}
diff --git a/profiles/scanparam/manager.h b/profiles/scanparam/manager.h
new file mode 100644
index 0000000..1cf2e5e
--- /dev/null
+++ b/profiles/scanparam/manager.h
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
+int scan_param_manager_init(void);
+void scan_param_manager_exit(void);
-- 
1.7.12

