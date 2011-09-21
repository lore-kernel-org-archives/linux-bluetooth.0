Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] Add GATT Time Server skeleton plugin
Date: Wed, 21 Sep 2011 08:46:09 -0400
Message-Id: <1316609170-4929-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316609170-4929-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316609170-4929-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am         |    6 +++++
 acinclude.m4        |    6 +++++
 bootstrap-configure |    1 +
 time/main.c         |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 time/server.c       |   38 ++++++++++++++++++++++++++++++++++
 time/server.h       |   26 +++++++++++++++++++++++
 6 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 time/main.c
 create mode 100644 time/server.c
 create mode 100644 time/server.h

diff --git a/Makefile.am b/Makefile.am
index d51907a..05ed562 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -222,6 +222,12 @@ builtin_modules += gatt_example
 builtin_sources += plugins/gatt-example.c
 endif
 
+if TIMEPLUGIN
+builtin_modules += time
+builtin_sources += time/main.c \
+		   time/server.h time/server.c
+endif
+
 if HEALTHPLUGIN
 builtin_modules += health
 builtin_sources += health/hdp_main.c health/hdp_types.h \
diff --git a/acinclude.m4 b/acinclude.m4
index 3cb9459..115cd90 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -194,6 +194,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	network_enable=yes
 	sap_enable=no
 	proximity_enable=no
+	time_enable=no
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
@@ -246,6 +247,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		proximity_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(time, AC_HELP_STRING([--enable-time], [enable Time Profile plugin]), [
+		time_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -397,6 +402,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
 	AM_CONDITIONAL(PROXIMITYPLUGIN, test "${proximity_enable}" = "yes")
+	AM_CONDITIONAL(TIMEPLUGIN, test "${time_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index ec5d821..65e266f 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -19,6 +19,7 @@ fi
 		--enable-capng \
 		--enable-gatt-example \
 		--enable-proximity \
+		--enable-time \
 		--enable-health \
 		--enable-tracer \
 		--enable-tools \
diff --git a/time/main.c b/time/main.c
new file mode 100644
index 0000000..a4de0fe
--- /dev/null
+++ b/time/main.c
@@ -0,0 +1,57 @@
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
+#include <stdint.h>
+#include <glib.h>
+
+#include "plugin.h"
+#include "hcid.h"
+#include "log.h"
+#include "server.h"
+
+static int time_init(void)
+{
+	if (!main_opts.attrib_server) {
+		DBG("Attribute server is disabled");
+		return -1;
+	}
+
+	return time_server_init();
+}
+
+static void time_exit(void)
+{
+	if (!main_opts.attrib_server)
+		return;
+
+	time_server_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			time_init, time_exit)
diff --git a/time/server.c b/time/server.c
new file mode 100644
index 0000000..89cc460
--- /dev/null
+++ b/time/server.c
@@ -0,0 +1,38 @@
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
+#include "server.h"
+
+int time_server_init(void)
+{
+	return 0;
+}
+
+void time_server_exit(void)
+{
+}
diff --git a/time/server.h b/time/server.h
new file mode 100644
index 0000000..621bf2b
--- /dev/null
+++ b/time/server.h
@@ -0,0 +1,26 @@
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
+int time_server_init(void);
+void time_server_exit(void);
-- 
1.7.0.4

