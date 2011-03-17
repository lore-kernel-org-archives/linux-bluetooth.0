Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 02/15] GATT server: add profile API plugin skeleton
Date: Wed, 16 Mar 2011 21:00:26 -0400
Message-Id: <1300323639-13296-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am            |    3 +++
 plugins/gatt-profile.c |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 plugins/gatt-profile.c

diff --git a/Makefile.am b/Makefile.am
index 34c0def..5963c7f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,6 +199,9 @@ builtin_modules += attrib
 builtin_sources += attrib/main.c \
 		attrib/manager.h attrib/manager.c \
 		attrib/client.h attrib/client.c
+
+builtin_modules += gatt_profile
+builtin_sources += plugins/gatt-profile.c
 endif
 
 if HEALTHPLUGIN
diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
new file mode 100644
index 0000000..025a3c5
--- /dev/null
+++ b/plugins/gatt-profile.c
@@ -0,0 +1,41 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+#include "plugin.h"
+
+static int gatt_profile_init(void)
+{
+	return 0;
+}
+
+static void gatt_profile_exit(void)
+{
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gatt_profile, VERSION, BLUETOOTH_PLUGIN_PRIORITY_HIGH,
+					gatt_profile_init, gatt_profile_exit)
-- 
1.7.0.4

