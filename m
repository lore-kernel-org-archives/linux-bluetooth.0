Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 3/3] Add support for wiimote pairing
Date: Wed, 13 Jul 2011 15:40:15 +0200
Message-Id: <1310564415-26093-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
References: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Nintendo Wii Remote requires binary bluetooth addresses as PINs.
This is not possible via dbus agent API. So this adds a plugin that
registers a pin-callback and forces the right pin for every
authentication request of wiimotes.
---
V2: Rename *pincb* to *pin_cb*

 Makefile.am       |    5 ++
 acinclude.m4      |    6 +++
 plugins/wiimote.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 plugins/wiimote.c

diff --git a/Makefile.am b/Makefile.am
index 5f54b5b..6a9c76f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -227,6 +227,11 @@ builtin_sources += plugins/storage.c
 builtin_modules += adaptername
 builtin_sources += plugins/adaptername.c
 
+if WIIMOTEPLUGIN
+builtin_modules += wiimote
+builtin_sources += plugins/wiimote.c
+endif
+
 if MAEMO6PLUGIN
 builtin_modules += maemo6
 builtin_sources += plugins/maemo6.c
diff --git a/acinclude.m4 b/acinclude.m4
index af97cce..4073f59 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -213,6 +213,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	maemo6_enable=no
 	sap_driver=dummy
 	dbusoob_enable=no
+	wiimote_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -345,6 +346,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		dbusoob_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(wiimote, AC_HELP_STRING([--enable-wiimote], [compile with Wii Remote plugin]), [
+		wiimote_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
 		hal_enable=${enableval}
 	])
@@ -403,4 +408,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
+	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 ])
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
new file mode 100644
index 0000000..e60231b
--- /dev/null
+++ b/plugins/wiimote.c
@@ -0,0 +1,111 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  David Herrmann <dh.herrmann@googlemail.com>
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
+#include <bluetooth/bluetooth.h>
+
+#include "plugin.h"
+#include "adapter.h"
+#include "device.h"
+#include "log.h"
+#include "storage.h"
+
+/*
+ * Nintendo Wii Remote devices require the bdaddr of the host as pin input for
+ * authentication. This plugin registers a pin-callback and forces this pin
+ * to be used for authentication.
+ *
+ * There are two ways to place the wiimote into discoverable mode.
+ *  - Pressing the red-sync button on the back of the wiimote. This module
+ *    supports pairing via this method. Auto-reconnect should be possible after
+ *    the device was paired once.
+ *  - Pressing the 1+2 buttons on the front of the wiimote. This module does
+ *    not support this method since this method never enables auto-reconnect.
+ *    Hence, pairing is not needed. Use it without pairing if you want.
+ * After connecting the wiimote you should immediately connect to the input
+ * service of the wiimote. If you don't, the wiimote will close the connection.
+ * The wiimote waits about 5 seconds until it turns off again.
+ * Auto-reconnect is only enabled when pairing with the wiimote via the red
+ * sync-button and then connecting to the input service. If you do not connect
+ * to the input service, then auto-reconnect is not enabled.
+ * If enabled, the wiimote connects to the host automatically when any button
+ * is pressed.
+ */
+
+static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
+								char *pinbuf)
+{
+	uint16_t vendor, product;
+	bdaddr_t sba, dba;
+	char src_addr[18], dst_addr[18];
+
+	adapter_get_address(adapter, &sba);
+	device_get_address(device, &dba);
+	ba2str(&sba, src_addr);
+	ba2str(&dba, dst_addr);
+
+	if (0 == read_device_id(src_addr, dst_addr, NULL, &vendor, &product,
+									NULL)) {
+		if (vendor == 0x057e && product == 0x0306) {
+			DBG("Forcing fixed pin on detected wiimote %s", dst_addr);
+			memcpy(pinbuf, &sba, 6);
+			return 6;
+		}
+	}
+
+	return 0;
+}
+
+static int wii_probe(struct btd_adapter *adapter)
+{
+	btd_adapter_register_pin_cb(adapter, wii_pincb);
+
+	return 0;
+}
+
+static void wii_remove(struct btd_adapter *adapter)
+{
+	btd_adapter_unregister_pin_cb(adapter, wii_pincb);
+}
+
+static struct btd_adapter_driver wii_driver = {
+	.name	= "wiimote",
+	.probe	= wii_probe,
+	.remove	= wii_remove,
+};
+
+static int wii_init(void)
+{
+	return btd_register_adapter_driver(&wii_driver);
+}
+
+static void wii_exit(void)
+{
+	btd_unregister_adapter_driver(&wii_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(wiimote, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, wii_init, wii_exit)
-- 
1.7.6

