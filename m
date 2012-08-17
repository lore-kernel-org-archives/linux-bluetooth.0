Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/5] hog: Adds initial files for suspend support
Date: Fri, 17 Aug 2012 18:08:19 -0300
Message-Id: <1345237703-15342-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial files to support HoG suspend. The first
supported backend is UPower. The suspend concept for HoG is
implementation specific. For UPower, Suspend/Resume will be triggered
by "Sleeping" and "Resuming" signals.

When setting the Control Point, the report device can execute actions to
save power. eg: Reduce the cycle of the key press detection or disable
LEDs.
---
 Makefile.am                  |    3 ++-
 profiles/input/hog_manager.c |   14 ++++++++++++++
 profiles/input/upower.c      |   37 +++++++++++++++++++++++++++++++++++++
 profiles/input/upower.h      |   25 +++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 1 deletions(-)
 create mode 100644 profiles/input/upower.c
 create mode 100644 profiles/input/upower.h

diff --git a/Makefile.am b/Makefile.am
index a74709d..ec86e90 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -184,7 +184,8 @@ endif
 if HOGPLUGIN
 builtin_modules += hog
 builtin_sources += profiles/input/hog_manager.c profiles/input/hog_device.h \
-			profiles/input/hog_device.c profiles/input/uhid_copy.h
+			profiles/input/hog_device.c profiles/input/uhid_copy.h \
+			profiles/input/upower.c profiles/input/upower.h
 endif
 
 if NETWORKPLUGIN
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index ddc5baf..52b2c8a 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -34,8 +34,11 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "device.h"
+#include "upower.h"
 #include "hog_device.h"
 
+static gboolean upower_supported = FALSE;
+
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -63,11 +66,22 @@ static struct btd_device_driver hog_driver = {
 
 static int hog_manager_init(void)
 {
+	int err;
+
+	err = upower_init();
+	if (err < 0)
+		DBG("UPower: %s(%d)", strerror(-err), -err);
+	else
+		upower_supported = TRUE;
+
 	return btd_register_device_driver(&hog_driver);
 }
 
 static void hog_manager_exit(void)
 {
+	if (upower_supported)
+		upower_exit();
+
 	btd_unregister_device_driver(&hog_driver);
 }
 
diff --git a/profiles/input/upower.c b/profiles/input/upower.c
new file mode 100644
index 0000000..571b023
--- /dev/null
+++ b/profiles/input/upower.c
@@ -0,0 +1,37 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+#include "upower.h"
+
+int upower_init(void)
+{
+	return 0;
+}
+
+void upower_exit(void)
+{
+}
diff --git a/profiles/input/upower.h b/profiles/input/upower.h
new file mode 100644
index 0000000..f898d07
--- /dev/null
+++ b/profiles/input/upower.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
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
+int upower_init(void);
+void upower_exit(void);
-- 
1.7.8.6

