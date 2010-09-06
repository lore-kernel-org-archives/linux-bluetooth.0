Return-Path: <cyrus@holtmann.org>
Subject: Add new plugin to set adapter class
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-dz1Ya1W2gVE3di30cVLL"
Date: Mon, 06 Sep 2010 11:48:09 +0100
Message-ID: <1283770089.7529.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-dz1Ya1W2gVE3di30cVLL
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

To replace the old code that was using HAL.

This allows us to avoid HAL usage, as it is deprecated.

Cheers

--=-dz1Ya1W2gVE3di30cVLL
Content-Disposition: attachment; filename="0001-Add-new-plugin-to-set-adapter-class.patch"
Content-Type: text/x-patch; name="0001-Add-new-plugin-to-set-adapter-class.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From f8bb02df7e3c13f71105ceb8c116294cb3a0f6c2 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 6 Sep 2010 11:44:31 +0100
Subject: [PATCH] Add new plugin to set adapter class

This time based on the kernel exported DMI, rather than calling
out to HAL. The HAL plugin can still be preferred with
--enable-hal=yes passed to configure.
---
 Makefile.am          |    7 ++
 acinclude.m4         |    7 ++-
 plugins/formfactor.c |  151 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 1 deletions(-)
 create mode 100644 plugins/formfactor.c

diff --git a/Makefile.am b/Makefile.am
index 665c0a9..3fb948f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,8 +199,15 @@ endif
 builtin_modules += hciops
 builtin_sources += plugins/hciops.c
 
+if HAL
 builtin_modules += hal
 builtin_sources += plugins/hal.c
+else
+builtin_modules += formfactor
+builtin_sources += plugins/formfactor.c
+endif
+
+EXTRA_DIST += plugins/hal.c plugins/formfactor.c
 
 builtin_modules += storage
 builtin_sources += plugins/storage.c
diff --git a/acinclude.m4 b/acinclude.m4
index 25cd259..2566d0d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -178,7 +178,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	capng_enable=${capng_found}
 	sndfile_enable=${sndfile_found}
 	netlink_enable=no
-	hal_enable=${hal_found}
+	hal_enable=no
 	usb_enable=${usb_found}
 	cable_enable=${cable_found}
 	alsa_enable=${alsa_found}
@@ -337,6 +337,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		maemo6_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
+		hal_enable=${enableval}
+	])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -378,6 +382,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes")
+	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(ATTRIBPLUGIN, test "${attrib_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
diff --git a/plugins/formfactor.c b/plugins/formfactor.c
new file mode 100644
index 0000000..037a768
--- /dev/null
+++ b/plugins/formfactor.c
@@ -0,0 +1,151 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdlib.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include "plugin.h"
+#include "adapter.h"
+#include "log.h"
+#include "dbus-hci.h"
+
+#define DMI_CHASSIS_FILE "/sys/class/dmi/id/chassis_type"
+#define DMI_CHASSIS_FILE_FALLBACK "/sys/devices/virtual/dmi/id/chassis_type"
+
+/* Map the chassis type from chassis_type to a sensible type used in hal
+ *
+ * See also 3.3.4.1 of the "System Management BIOS Reference Specification,
+ * Version 2.6.1" (Preliminary Standard) document, available from
+ * http://www.dmtf.org/standards/smbios.
+ *
+ * TODO: figure out WTF the mapping should be; "Lunch Box"? Give me a break :-)
+ *
+ * Copied from hal/hald/linux/osspec.c
+ */
+static const char *chassis_map[] = {
+	"Other",                 "unknown", /* 0x01 */
+	"Unknown",               "unknown",
+	"Desktop",               "desktop",
+	"Low Profile Desktop",   "desktop",
+	"Pizza Box",             "server",
+	"Mini Tower",            "desktop",
+	"Tower",                 "desktop",
+	"Portable",              "laptop",
+	"Laptop",                "laptop",
+	"Notebook",              "laptop",
+	"Hand Held",             "handheld",
+	"Docking Station",       "laptop",
+	"All In One",            "unknown",
+	"Sub Notebook",          "laptop",
+	"Space-saving",          "desktop",
+	"Lunch Box",             "unknown",
+	"Main Server Chassis",   "server",
+	"Expansion Chassis",     "unknown",
+	"Sub Chassis",           "unknown",
+	"Bus Expansion Chassis", "unknown",
+	"Peripheral Chassis",    "unknown",
+	"RAID Chassis",          "unknown",
+	"Rack Mount Chassis",    "unknown",
+	"Sealed-case PC",        "unknown",
+	"Multi-system",          "unknown",
+	"CompactPCI",            "unknonw",
+	"AdvancedTCA",           "unknown",
+	"Blade",                 "server",
+	"Blade Enclosure"        "unknown", /* 0x1D */
+	NULL
+};
+
+static int formfactor_probe(struct btd_adapter *adapter)
+{
+	int chassis_type;
+	uint8_t minor = 0;
+	const char *formfactor;
+	char *contents;
+
+	if (g_file_get_contents(DMI_CHASSIS_FILE,
+				&contents, NULL, NULL) == FALSE) {
+		if (g_file_get_contents(DMI_CHASSIS_FILE_FALLBACK,
+					&contents, NULL, NULL) == FALSE) {
+			error("Could not get the contents of DMI chassis type");
+			return 0;
+		}
+	}
+
+	chassis_type = atoi(contents);
+	g_free (contents);
+
+	if (chassis_type > 0x1D || chassis_type <= 0) {
+		error ("Chassis type is not a known chassis type");
+		return 0;
+	}
+
+	formfactor = chassis_map[chassis_type * 2];
+	if (formfactor != NULL) {
+		if (g_str_equal(formfactor, "laptop") == TRUE)
+			minor |= (1 << 2) | (1 << 3);
+		else if (g_str_equal(formfactor, "desktop") == TRUE)
+			minor |= 1 << 2;
+		else if (g_str_equal(formfactor, "server") == TRUE)
+			minor |= 1 << 3;
+		else if (g_str_equal(formfactor, "handheld") == TRUE)
+			minor += 1 << 4;
+	}
+
+	/* Computer major class */
+	DBG("Setting 0x%06x for major/minor device class", (1 << 8) | minor);
+
+	btd_adapter_set_class(adapter, 0x01, minor);
+
+	return 0;
+}
+
+static void formfactor_remove(struct btd_adapter *adapter)
+{
+}
+
+static struct btd_adapter_driver formfactor_driver = {
+	.name	= "formfactor",
+	.probe	= formfactor_probe,
+	.remove	= formfactor_remove,
+};
+
+static int formfactor_init(void)
+{
+	return btd_register_adapter_driver(&formfactor_driver);
+}
+
+static void formfactor_exit(void)
+{
+	btd_unregister_adapter_driver(&formfactor_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(formfactor, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, formfactor_init, formfactor_exit)
-- 
1.7.0.1


--=-dz1Ya1W2gVE3di30cVLL--

