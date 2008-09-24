Return-Path: <cyrus@holtmann.org>
Subject: Re: First pass at HAL device class plugin
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1222214785.10497.127.camel@snoogens.fab.redhat.com>
References: <1222214785.10497.127.camel@snoogens.fab.redhat.com>
Content-Type: multipart/mixed; boundary="=-GO6fTkq61HPyZsn8StnZ"
Date: Tue, 23 Sep 2008 17:17:46 -0700
Message-Id: <1222215466.10497.128.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-GO6fTkq61HPyZsn8StnZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2008-09-23 at 17:06 -0700, Bastien Nocera wrote:
> Probably doesn't work, and it's missing some exported functionality to
> set the device class on the actual adapter (and have it written).

And the version with the build system changes attached.

Note that we do check for ->remove being NULL in adapter.c

Cheers

--=-GO6fTkq61HPyZsn8StnZ
Content-Disposition: attachment; filename="0001-First-pass-at-a-HAL-plugin-to-set-the-device-class.patch"
Content-Type: text/x-patch; name="0001-First-pass-at-a-HAL-plugin-to-set-the-device-class.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 3ac08a79c794715100282afb0a193e96fcf309a1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 23 Sep 2008 17:03:06 -0700
Subject: [PATCH] First pass at a HAL plugin to set the device class

---
 acinclude.m4                |   11 ++++
 bootstrap-configure         |    1 +
 configure.ac                |    1 +
 plugins/Makefile.am         |   16 +++++-
 plugins/hal-adapter-class.c |  126 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 plugins/hal-adapter-class.c

diff --git a/acinclude.m4 b/acinclude.m4
index 1991e4a..6325052 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -156,6 +156,12 @@ AC_DEFUN([AC_PATH_USB], [
 			[Define to 1 if you need the usb_interrupt_read() function.]))
 ])
 
+AC_DEFUN([AC_PATH_HAL], [
+	 PKG_CHECK_MODULES(HAL, hal, hal_found=yes, hal_found=no)
+	 AC_SUBST(HAL_CFLAGS)
+	 AC_SUBST(HAL_LIBS)
+])
+
 AC_DEFUN([AC_PATH_NETLINK], [
 	PKG_CHECK_MODULES(NETLINK, libnl-1, netlink_found=yes, netlink_found=no)
 	AC_SUBST(NETLINK_CFLAGS)
@@ -237,6 +243,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		usb_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [enable HAL support]), [
+		hal_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(netlink, AC_HELP_STRING([--enable-netlink], [enable NETLINK support]), [
 		netlink_enable=${enableval}
 	])
@@ -332,6 +342,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" = "yes" && test "${sndfile_found}" = "yes")
 	AM_CONDITIONAL(NETLINK, test "${netlink_enable}" = "yes" && test "${netlink_found}" = "yes")
 	AM_CONDITIONAL(USB, test "${usb_enable}" = "yes" && test "${usb_found}" = "yes")
+	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes" && test "${hal_found}" = "yes")
 	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes")
 	AM_CONDITIONAL(ALSA, test "${alsa_enable}" = "yes" && test "${alsa_found}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 7b07fe1..57f9553 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -27,6 +27,7 @@ fi
 		--enable-dund \
 		--enable-test \
 		--enable-cups \
+		--enable-hal \
 		--disable-manpages \
 		--disable-configfiles \
 		--disable-initscripts \
diff --git a/configure.ac b/configure.ac
index 30a256a..a7e978b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_PATH_GMODULE
 AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
+AC_PATH_HAL
 AC_PATH_NETLINK
 AC_PATH_SNDFILE
 
diff --git a/plugins/Makefile.am b/plugins/Makefile.am
index 8565bb2..bb38823 100644
--- a/plugins/Makefile.am
+++ b/plugins/Makefile.am
@@ -13,7 +13,13 @@ else
 service_plugins =
 endif
 
-plugin_LTLIBRARIES = $(netlink_plugins) $(service_plugins)
+if HAL
+hal_plugins = hal-adapter-class.la
+else
+hal_plugins =
+endif
+
+plugin_LTLIBRARIES = $(netlink_plugins) $(service_plugins) $(hal_plugins)
 
 noinst_LTLIBRARIES = echo.la storage.la
 
@@ -31,10 +37,16 @@ if SERVICEPLUGIN
 service_la_SOURCES = service.c
 endif
 
+if HAL
+hal_adapter_class_la_SOURCES = hal-adapter-class.c
+
+hal_adapter_class_la_LIBADD = @HAL_LIBS@
+endif
+
 AM_LDFLAGS = -module -avoid-version -no-undefined \
 			-export-symbols-regex bluetooth_plugin_desc
 
-AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAGS@ @NETLINK_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAGS@ @NETLINK_CFLAGS@ @HAL_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common -I$(top_srcdir)/src
 
diff --git a/plugins/hal-adapter-class.c b/plugins/hal-adapter-class.c
new file mode 100644
index 0000000..c5dae5c
--- /dev/null
+++ b/plugins/hal-adapter-class.c
@@ -0,0 +1,126 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2008  Marcel Holtmann <marcel@holtmann.org>
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
+#include <errno.h>
+#include <unistd.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+#include <hal/libhal.h>
+#include <gdbus.h>
+
+#include "plugin.h"
+#include "adapter.h"
+#include "logging.h"
+
+static guint32 get_form_factor(LibHalContext *ctx)
+{
+	char *formfactor;
+	guint32 ret;
+
+	ret = 1 << 8; /* Computer major class */
+	formfactor = libhal_device_get_property_string(ctx,
+				"/org/freedesktop/Hal/devices/computer",
+						"system.formfactor", NULL);
+
+	if (formfactor == NULL)
+		return ret;
+
+	if (g_str_equal(formfactor, "laptop"))
+		ret += (1 << 2) + (1 << 3);
+	else if (g_str_equal(formfactor, "desktop"))
+		ret += 1 << 2;
+	else if (g_str_equal(formfactor, "server"))
+		ret += 1 << 3;
+	else if (g_str_equal(formfactor, "handheld"))
+		ret += 1 << 4;
+
+	g_free (formfactor);
+
+	return ret;
+}
+
+static int hal_adapter_class_probe(struct btd_adapter *adapter)
+{
+	DBusConnection *conn;
+	LibHalContext *ctx = NULL;
+	guint32 class;
+
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	ctx = libhal_ctx_new();
+	if (libhal_ctx_set_dbus_connection(ctx, conn) == FALSE) {
+		libhal_ctx_free(ctx);
+		dbus_connection_unref(conn);
+		return -EIO;
+	}
+
+	if (libhal_ctx_init(ctx, NULL) == FALSE) {
+		g_warning("Unable to init HAL context");
+		libhal_ctx_free(ctx);
+		dbus_connection_unref(conn);
+		return -EIO;
+	}
+
+	class = get_form_factor (ctx);
+	debug ("0: 0x%X", class);
+#if 0
+	adapter_set_class (adapter, class);
+	dbus_g_proxy_call(object, "SetMajorClass", NULL,
+		G_TYPE_STRING, "computer", G_TYPE_INVALID, G_TYPE_INVALID);
+	dbus_g_proxy_call(object, "SetMinorClass", NULL,
+		G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
+	g_free (formfactor);
+#endif
+	libhal_ctx_free(ctx);
+	dbus_connection_unref(conn);
+
+	return 0;
+}
+
+static struct btd_adapter_driver hal_adapter_class = {
+	.name	= "hal-adapter-class",
+	.probe	= hal_adapter_class_probe,
+	.remove	= NULL,
+};
+
+static int hal_adapter_class_init(void)
+{
+	debug("Setup HAL Adapter Class plugin");
+
+	return btd_register_adapter_driver(&hal_adapter_class);
+}
+
+static void hal_adapter_class_exit(void)
+{
+	debug("Cleanup HAL Adapter Class plugin");
+
+	btd_unregister_adapter_driver(&hal_adapter_class);
+}
+
+BLUETOOTH_PLUGIN_DEFINE("hal", hal_adapter_class_init, hal_adapter_class_exit)
-- 
1.6.0.1


--=-GO6fTkq61HPyZsn8StnZ--

