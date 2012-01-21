Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 2/2] autopair: add autopair plugin
Date: Fri, 20 Jan 2012 17:59:57 -0800
Message-Id: <1327111197-11446-3-git-send-email-scott@netsplit.com>
In-Reply-To: <1327111197-11446-1-git-send-email-scott@netsplit.com>
References: <1327111197-11446-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The autopair plugin sends an initial PIN of 0000 to "dumb" devices such
as mice and headsets (list of classes unashamedly stolen from Android)
and registers a bonding complete callback for that device.

If bonding should fail with the fixed PIN, the device is blacklisted
from auto-pairing and the pairing tried again after a short back-off
period, this time using the Agent's RequestPinCode method.
---
 Makefile.am        |    5 +
 acinclude.m4       |    6 ++
 plugins/autopair.c |  209 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 0 deletions(-)
 create mode 100644 plugins/autopair.c

diff --git a/Makefile.am b/Makefile.am
index 8dbe603..cdfdb93 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -278,6 +278,11 @@ builtin_modules += dbusoob
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
index 57fc5e0..187a049 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -218,6 +218,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	dbusoob_enable=no
 	wiimote_enable=no
 	thermometer_enable=no
+	autopair_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -374,6 +375,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		thermometer_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(autopair, AC_HELP_STRING([--enable-autopair], [enable auto-pairplugin]), [
+		autopair_enable=${enableval}
+	])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -432,4 +437,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
+	AM_CONDITIONAL(AUTOPAIRPLUGIN, test "${autopair_enable}" = "yes")
 ])
diff --git a/plugins/autopair.c b/plugins/autopair.c
new file mode 100644
index 0000000..6099b0f
--- /dev/null
+++ b/plugins/autopair.c
@@ -0,0 +1,209 @@
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
+#include <sys/stat.h>
+
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
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
+#include "bt_ids.h"
+#include "log.h"
+
+static GSList *attempting = NULL;
+static GSList *dynamic_blacklist = NULL;
+
+static gboolean autopair_bondingcb(struct btd_device *device, uint8_t status)
+{
+	GSList *match;
+	bdaddr_t *ba;
+
+	match = g_slist_find(attempting, device);
+	if (!match)
+		return FALSE;
+
+	attempting = g_slist_remove_link(attempting, match);
+	btd_device_unref(device);
+
+	/* successful pair */
+	if (!status)
+		return FALSE;
+
+	/* failed: blacklist and retry with the user's agent */
+	ba = g_new0(bdaddr_t, 1);
+	device_get_address(device, ba, NULL);
+	dynamic_blacklist = g_slist_prepend(dynamic_blacklist, ba);
+
+	return TRUE;
+}
+
+static void autopair_bonding_cancelcb(struct btd_device *device)
+{
+	GSList *match;
+
+	if ((match = g_slist_find(attempting, device))) {
+		attempting = g_slist_remove_link(attempting, match);
+		btd_device_unref (device);
+	}
+}
+
+static gboolean autopair_attempt(struct btd_device *device)
+{
+	if (g_slist_find(attempting, device))
+		return FALSE;
+
+	attempting = g_slist_prepend(attempting, btd_device_ref(device));
+
+	btd_device_register_bonding_cb(device, autopair_bondingcb,
+						autopair_bonding_cancelcb);
+	return TRUE;
+}
+
+static ssize_t autopair_pincb(struct btd_adapter *adapter,
+					struct btd_device *device, char *pinbuf)
+{
+	bdaddr_t local, peer;
+	uint32_t class;
+
+	/* Only autopair on host-initiated connections */
+	if (!device_is_bonding(device, NULL))
+		return 0;
+
+	device_get_address(device, &peer, NULL);
+	adapter_get_address(adapter, &local);
+
+	if (g_slist_find_custom(dynamic_blacklist, &peer, (GCompareFunc) bacmp))
+		return 0;
+
+	if (read_remote_class(&local, &peer, &class) != 0)
+		return 0;
+
+	switch (BLUETOOTH_DEVICE_CLASS(class)) {
+	case BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_WEARABLE_HEADSET:
+	case BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HANDSFREE:
+	case BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HEADPHONES:
+	case BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_PORTABLE_AUDIO:
+	case BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HIFI_AUDIO:
+		/* These are the classes Android attempts auto-pairing with */
+	case BLUETOOTH_DEVICE_CLASS_PERIPHERAL_POINTING:
+		/* Attempt auto-pairing with mice too */
+		if (autopair_attempt(device)) {
+			DBG("attempting auto-pairing with device (%d)", class);
+			memcpy(pinbuf, "0000", 4);
+			return 4;
+		}
+		break;
+	}
+
+	return 0;
+}
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
+static void autopair_add_blacklist(char *key, char *value, void *data)
+{
+	bdaddr_t *ba;
+
+	if (strcmp(value, "blacklist"))
+		return;
+
+	ba = g_new0(bdaddr_t, 1);
+	str2ba(key, ba);
+	dynamic_blacklist = g_slist_prepend(dynamic_blacklist, ba);
+}
+
+static int autopair_init(void)
+{
+	char filename[PATH_MAX + 1];
+
+	/* Load dynamic blacklist */
+	create_name(filename, PATH_MAX, STORAGEDIR, "autopair", "blacklist");
+	textfile_foreach(filename, autopair_add_blacklist, NULL);
+
+	return btd_register_adapter_driver(&autopair_driver);
+}
+
+static void autopair_exit(void)
+{
+	GSList *l;
+	struct btd_device *device;
+	char filename[PATH_MAX + 1];
+	bdaddr_t *ba;
+	char addr[18];
+
+	btd_unregister_adapter_driver(&autopair_driver);
+
+	/* Unregister device-level callbacks and unreference */
+	for (l = attempting; l != NULL; l = g_slist_next(l)) {
+		device = l->data;
+		btd_device_unregister_bonding_cb(device, autopair_bondingcb,
+						autopair_bonding_cancelcb);
+		btd_device_unref(device);
+	}
+	g_slist_free(attempting);
+
+	/* Save dynamic blacklist */
+	create_name(filename, PATH_MAX, STORAGEDIR, "autopair", "blacklist");
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	for (l = dynamic_blacklist; l != NULL; l = g_slist_next(l)) {
+		ba = l->data;
+		ba2str(ba, addr);
+		textfile_put(filename, addr, "blacklist");
+	}
+
+	g_slist_free_full(dynamic_blacklist, g_free);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(autopair, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, autopair_init, autopair_exit)
-- 
1.7.7.3

