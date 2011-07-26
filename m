Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/3] Initial support for Health Thermometer Profile (HTP)
Date: Tue, 26 Jul 2011 14:15:52 +0200
Message-Id: <1311682554-21241-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1311682554-21241-1-git-send-email-sancane@gmail.com>
References: <1311682554-21241-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am         |    5 +++++
 acinclude.m4        |    6 ++++++
 bootstrap-configure |    1 +
 thermometer/main.c  |   45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 thermometer/main.c

diff --git a/Makefile.am b/Makefile.am
index f61c9a8..99b48d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -215,6 +215,11 @@ builtin_sources += health/hdp_main.c health/hdp_types.h \
 			health/hdp_util.h health/hdp_util.c
 endif
 
+if THERMOMETERPLUGIN
+builtin_modules += thermometer
+builtin_sources += thermometer/main.c
+endif
+
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
diff --git a/acinclude.m4 b/acinclude.m4
index 68ece35..3cb9459 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -215,6 +215,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sap_driver=dummy
 	dbusoob_enable=no
 	wiimote_enable=no
+	thermometer_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -359,6 +360,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		hal_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(thermometer, AC_HELP_STRING([--enable-thermometer], [enable thermometer plugin]), [
+		thermometer_enable=${enableval}
+	])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -415,4 +420,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
+	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
 ])
diff --git a/bootstrap-configure b/bootstrap-configure
index b0020cb..ec5d821 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -31,5 +31,6 @@ fi
 		--enable-test \
 		--enable-cups \
 		--enable-sap \
+		--enable-thermometer \
 		--disable-pcmcia \
 		--disable-datafiles $*
diff --git a/thermometer/main.c b/thermometer/main.c
new file mode 100644
index 0000000..c47d396
--- /dev/null
+++ b/thermometer/main.c
@@ -0,0 +1,45 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez at gmail.com>
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
+
+static int thermometer_init(void)
+{
+	/*TODO: */
+	return 0;
+}
+
+static void thermometer_exit(void)
+{
+	/*TODO: */
+}
+
+BLUETOOTH_PLUGIN_DEFINE(thermometer, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					thermometer_init, thermometer_exit)
-- 
1.7.6

