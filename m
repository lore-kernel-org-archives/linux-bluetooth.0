Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	marcel@holtmann.org,
	hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCHv3] autopair plugin
Date: Thu,  5 Apr 2012 15:46:27 -0700
Message-Id: <1333665987-30656-1-git-send-email-scott@netsplit.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The following plugin serves as a minimal example for the previous two
patch sets, implementing PIN generation for HID keyboard devices using
the "DisplayPinCode" set and a fixed PIN of 0000 for the set of mice
and tablets that require pairing.

Should the attempt fail, the bonding callback patch set is used to retry
after blacklisting the device's address so that the plugin will not
further act on the device (and thus the user is prompted for a PIN).

This provides a behavior very closely matching OS X with BlueZ.

A full implementation of this plugin should provide configuration equal
to the flexibility of the GNOME Bluetooth PIN Code Database, and perhaps
a D-Bus interface for the UI to determine whether or not pairing is
required for a given device.

This implementation serves while the debate about that plugin, and the
configuration file format, takes place.

---
 Makefile.am        |    5 ++
 acinclude.m4       |    6 ++
 plugins/autopair.c |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 plugins/autopair.c

diff --git a/Makefile.am b/Makefile.am
index b770fc5..dc32b5d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -267,6 +267,11 @@ builtin_modules += dbusoob
 builtin_sources += plugins/dbusoob.c
 endif
 
+if AUTOPAIRPLUGIN
+builtin_modules += autopair
+builtin_sources += plugins/autopair.c
+endif
+
 if MAINTAINER_MODE
 plugin_LTLIBRARIES += plugins/external-dummy.la
 plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
diff --git a/acinclude.m4 b/acinclude.m4
index 429e466..5f5c779 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -215,6 +215,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sap_driver=dummy
 	dbusoob_enable=no
 	wiimote_enable=no
+	autopair_enable=no
 	gatt_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
@@ -344,6 +345,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		wiimote_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(autopair, AC_HELP_STRING([--enable-autopair], [compile with autopairing plugin]), [
+		autopair_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
 		hal_enable=${enableval}
 	])
@@ -404,5 +409,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
+	AM_CONDITIONAL(AUTOPAIRPLUGIN, test "${autopair_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
 ])
diff --git a/plugins/autopair.c b/plugins/autopair.c
new file mode 100644
index 0000000..a1eab5a
--- /dev/null
+++ b/plugins/autopair.c
@@ -0,0 +1,202 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Google Inc.
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
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include "glib-compat.h"
+#include "plugin.h"
+#include "adapter.h"
+#include "device.h"
+#include "storage.h"
+#include "textfile.h"
+#include "log.h"
+
+/*
+ * Big comment here.
+ */
+
+static GSList *blacklist = NULL;
+
+static void autopair_blacklist_device(struct btd_device *device)
+{
+	bdaddr_t *ba;
+
+	ba = g_new0(bdaddr_t, 1);
+	device_get_address(device, ba, NULL);
+	blacklist = g_slist_prepend(blacklist, ba);
+}
+
+
+static GSList *attempting = NULL;
+
+static gboolean autopair_bondingcb(struct btd_device *device,
+					gboolean complete, uint8_t status)
+{
+	GSList *match;
+
+	match = g_slist_find(attempting, device);
+	if (!match)
+		return FALSE;
+
+	attempting = g_slist_remove_link(attempting, match);
+	btd_device_unref(device);
+
+	if (complete && status != 0) {
+		/* failed: blacklist and retry with the user's agent */
+		autopair_blacklist_device(device);
+		return TRUE;
+	} else {
+		/* successful or cancelled pair */
+		return FALSE;
+	}
+}
+
+static gboolean autopair_attempt(struct btd_device *device)
+{
+	if (g_slist_find(attempting, device))
+		return FALSE;
+
+	btd_device_register_bonding_cb(device, autopair_bondingcb);
+	attempting = g_slist_prepend(attempting, btd_device_ref(device));
+
+	return TRUE;
+}
+
+static void autopair_cancel_all(void)
+{
+	GSList *l;
+	struct btd_device *device;
+
+	for (l = attempting; l != NULL; l = g_slist_next(l)) {
+		device = l->data;
+		btd_device_unregister_bonding_cb(device, autopair_bondingcb);
+		btd_device_unref(device);
+	}
+
+	g_slist_free(attempting);
+	attempting = NULL;
+}
+
+static ssize_t autopair_pincb(struct btd_adapter *adapter,
+					struct btd_device *device,
+					char *pinbuf, gboolean *display)
+{
+	char addr[18];
+	bdaddr_t local, peer;
+	uint32_t class;
+
+	if (!device_is_bonding(device, NULL))
+		return 0;
+
+	adapter_get_address(adapter, &local);
+
+	device_get_address(device, &peer, NULL);
+	ba2str(&peer, addr);
+
+	read_remote_class(&local, &peer, &class);
+
+	DBG("device %s 0x%x", addr, class);
+
+	if (g_slist_find_custom(blacklist, &peer, (GCompareFunc) bacmp)) {
+		DBG("prior autopair failed");
+		return 0;
+	}
+
+	switch ((class & 0x1f00) >> 8) {
+	case 0x05:
+		switch ((class & 0xc0) >> 6) {
+		case 0x01:
+		case 0x03:
+			if (autopair_attempt(device)) {
+				char pinstr[7];
+				srand(time(NULL));
+				snprintf(pinstr, sizeof pinstr, "%06d",
+							rand() % 1000000);
+				*display = TRUE;
+				memcpy(pinbuf, pinstr, 6);
+				return 6;
+			}
+			break;
+		case 0x02:
+			if (autopair_attempt(device)) {
+				memcpy(pinbuf, "0000", 4);
+				return 4;
+			}
+			break;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+
+static int autopair_probe(struct btd_adapter *adapter)
+{
+	btd_adapter_register_pin_cb(adapter, autopair_pincb);
+
+	return 0;
+}
+
+static void autopair_remove(struct btd_adapter *adapter)
+{
+	btd_adapter_unregister_pin_cb(adapter, autopair_pincb);
+}
+
+static struct btd_adapter_driver autopair_driver = {
+	.name = "autopair",
+	.probe = autopair_probe,
+	.remove = autopair_remove,
+};
+
+static int autopair_init(void)
+{
+	return btd_register_adapter_driver(&autopair_driver);
+}
+
+static void autopair_exit(void)
+{
+	btd_unregister_adapter_driver(&autopair_driver);
+
+	autopair_cancel_all();
+
+	g_slist_free_full(blacklist, g_free);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(autopair, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, autopair_init, autopair_exit)
-- 
1.7.7.3
