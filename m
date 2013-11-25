Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 09/13] plugins: Add initial code for sixaxis plugin
Date: Mon, 25 Nov 2013 22:15:48 +0000
Message-Id: <1385417752-25664-10-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This plugin will be used to associate PS3 controllers.
---
 Makefile.plugins    |  8 ++++++++
 bootstrap-configure |  1 +
 configure.ac        |  5 +++++
 plugins/sixaxis.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 plugins/sixaxis.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 7c5f71d..f5025e9 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -110,3 +110,11 @@ builtin_sources += profiles/heartrate/heartrate.c
 builtin_modules += cyclingspeed
 builtin_sources += profiles/cyclingspeed/cyclingspeed.c
 endif
+
+if SIXAXIS
+plugin_LTLIBRARIES += plugins/sixaxis.la
+plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
+plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
+						-no-undefined @UDEV_LIBS@
+plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden @UDEV_CFLAGS@
+endif
diff --git a/bootstrap-configure b/bootstrap-configure
index dc36311..c7f08ed 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -13,4 +13,5 @@ fi
 		--localstatedir=/var \
 		--enable-experimental \
 		--enable-android \
+		--enable-sixaxis \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 949846e..ca226bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,6 +216,11 @@ AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
 					[enable_experimental=${enableval}])
 AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" = "yes")
 
+AC_ARG_ENABLE(sixaxis, AC_HELP_STRING([--enable-sixaxis],
+		[enable sixaxis plugin]), [enable_sixaxis=${enableval}])
+AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
+					 test "${enable_udev}" != "no")
+
 if (test "${prefix}" = "NONE"); then
 	dnl no prefix and no localstatedir, so default to /var
 	if (test "$localstatedir" = '${prefix}/var'); then
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
new file mode 100644
index 0000000..bf66bef
--- /dev/null
+++ b/plugins/sixaxis.c
@@ -0,0 +1,46 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009  Bastien Nocera <hadess@hadess.net>
+ *  Copyright (C) 2011  Antonio Ospite <ospite@studenti.unina.it>
+ *  Copyright (C) 2013  Szymon Janc <szymon.janc@gmail.com>
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
+#include "log.h"
+
+static int sixaxis_init(void)
+{
+	DBG("");
+
+	return 0;
+}
+
+static void sixaxis_exit(void)
+{
+	DBG("");
+}
+
+BLUETOOTH_PLUGIN_DEFINE(sixaxis, VERSION, BLUETOOTH_PLUGIN_PRIORITY_LOW,
+						sixaxis_init, sixaxis_exit)
-- 
1.8.4.4

