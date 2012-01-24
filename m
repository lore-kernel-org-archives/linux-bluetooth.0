Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCHv2] autopair: add autopair plugin
Date: Tue, 24 Jan 2012 15:47:42 -0800
Message-Id: <1327448862-21964-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This plugin handles automatically generating PIN codes for certain
device types following rules specified in an XML file derived from
that used by the GNOME Bluetooth wizard.

The plugin deliberately ignores unknown elements and attributes so
that this file can be extended by the UI, for example adding hints
that pairing shouldn't be attempted for certain devices (e.g. mice)
or other special pairing considerations.

Should autopairing fail for a device, it is blacklisted and will
be retried using the agent as usual. These blacklist files can be
harvested by distributions in order to further improve the database.
---
 Makefile.am                   |    9 +
 acinclude.m4                  |    6 +
 plugins/autopair.c            |  363 +++++++++++++++++++++++++++++++++++++++++
 plugins/pin-code-database.xml |  174 ++++++++++++++++++++
 4 files changed, 552 insertions(+), 0 deletions(-)
 create mode 100644 plugins/autopair.c
 create mode 100644 plugins/pin-code-database.xml

diff --git a/Makefile.am b/Makefile.am
index 102ee62..798f3ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -278,6 +278,15 @@ builtin_modules += dbusoob
 builtin_sources += plugins/dbusoob.c
 endif
 
+if AUTOPAIRPLUGIN
+builtin_modules += autopair
+builtin_sources += plugins/autopair.c
+
+if DATAFILES
+conf_DATA += plugins/pin-code-database.xml
+endif
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
index 0000000..b70d101
--- /dev/null
+++ b/plugins/autopair.c
@@ -0,0 +1,363 @@
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
+static void autopair_blacklist_addr(const char *address)
+{
+	bdaddr_t *ba;
+
+	ba = g_new0(bdaddr_t, 1);
+	str2ba(address, ba);
+	blacklist = g_slist_prepend(blacklist, ba);
+}
+
+static void autopair_load_blacklist(void)
+{
+	char filename[PATH_MAX + 1];
+
+	snprintf(filename, PATH_MAX, "%s/autopair_blacklist", STORAGEDIR);
+
+	textfile_foreach(filename, (textfile_cb)autopair_blacklist_addr, NULL);
+}
+
+static void autopair_save_blacklist(void)
+{
+	char filename[PATH_MAX + 1];
+	GSList *l;
+	bdaddr_t *ba;
+	char addr[18];
+
+	snprintf(filename, PATH_MAX, "%s/autopair_blacklist", STORAGEDIR);
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	for (l = blacklist; l != NULL; l = g_slist_next(l)) {
+		ba = l->data;
+		ba2str(ba, addr);
+		textfile_put(filename, addr, "blacklist");
+	}
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
+
+struct autopair_dev {
+	char addr[18];
+	char name[248 + 1];
+	uint32_t class;
+	char *pinbuf;
+	ssize_t pinlen;
+};
+
+static const char *autopair_type(uint32_t class)
+{
+	switch ((class & 0x1f00) >> 8) {
+	case 0x01:
+		return "computer";
+	case 0x02:
+		switch ((class & 0xfc) >> 2) {
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0x05:
+			return "phone";
+		case 0x04:
+			return "modem";
+		}
+		break;
+	case 0x03:
+		return "network";
+	case 0x04:
+		switch ((class & 0xfc) >> 2) {
+		case 0x01:
+		case 0x02:
+			return "headset";
+		case 0x06:
+			return "headphones";
+		case 0x0b: /* VCR */
+		case 0x0c: /* Video Camera */
+		case 0x0d: /* Camcorder */
+			return "video";
+		default:
+			return "audio";
+		}
+		break;
+	case 0x05:
+		switch ((class & 0xc0) >> 6) {
+		case 0x00:
+			switch ((class & 0x1e) >> 2) {
+			case 0x01:
+			case 0x02:
+				return "joypad";
+			}
+			break;
+		case 0x01:
+			return "keyboard";
+		case 0x02:
+			switch ((class & 0x1e) >> 2) {
+			case 0x05:
+				return "tablet";
+			default:
+				return "mouse";
+			}
+		}
+		break;
+	case 0x06:
+		if (class & 0x80)
+			return "printer";
+		if (class & 0x20)
+			return "camera";
+		break;
+	}
+
+	return NULL;
+}
+
+static void autopair_element(GMarkupParseContext *ctx, const char *element,
+				const char **attr, const char **value,
+				void *data, GError **error)
+{
+	struct autopair_dev *dev = data;
+	const char *pin = NULL;
+
+	if (strcmp(element, "device"))
+		return;
+
+	for (; *attr; attr++, value++) {
+		printf("%s=%s\n", *attr, *value);
+		if (!strcmp(*attr, "pin")) {
+			pin = *value;
+		} else if (!strcmp(*attr, "name")) {
+			if (strcmp(*value, dev->name))
+				return;
+		} else if (!strcmp(*attr, "oui")) {
+			if (strncmp(*value, dev->addr, strlen(*value)))
+				return;
+		} else if (!strcmp(*attr, "type")) {
+			const char *typestr;
+
+			typestr = autopair_type(dev->class);
+			if (!typestr)
+				return;
+			if (strcmp(*value, typestr))
+				return;
+		}
+	}
+
+	if (!pin)
+		return;
+
+	dev->pinlen = strlen(pin);
+	memcpy(dev->pinbuf, pin, dev->pinlen);
+}
+
+static const GMarkupParser autopair_parser = {
+	.start_element = autopair_element,
+};
+
+static void autopair_parse_config(struct autopair_dev *dev)
+{
+	GMarkupParseContext *ctx;
+	int fd;
+	char buf[4096];
+	ssize_t len;
+
+	ctx = g_markup_parse_context_new(&autopair_parser, 0, dev, NULL);
+	if (!ctx)
+		return;
+
+	fd = open(CONFIGDIR "/pin-code-database.xml", O_RDONLY);
+	if (fd < 0)
+		goto done;
+
+	while ((len = read(fd, buf, sizeof buf)) > 0)
+		if (!g_markup_parse_context_parse(ctx, buf, len, NULL))
+			goto done;
+
+	g_markup_parse_context_end_parse(ctx, NULL);
+
+done:
+	g_markup_parse_context_free(ctx);
+	close(fd);
+}
+
+static ssize_t autopair_pincb(struct btd_adapter *adapter,
+					struct btd_device *device, char *pinbuf)
+{
+	struct autopair_dev dev = { .pinbuf = pinbuf };
+	bdaddr_t local, peer;
+
+	if (!device_is_bonding(device, NULL))
+		return 0;
+
+	adapter_get_address(adapter, &local);
+
+	device_get_address(device, &peer, NULL);
+	ba2str(&peer, dev.addr);
+
+	device_get_name(device, dev.name, sizeof(dev.name));
+
+	read_remote_class(&local, &peer, &dev.class);
+
+	DBG("device %s 0x%x (%s) - %s", dev.addr, dev.class,
+			autopair_type(dev.class), dev.name);
+
+	if (g_slist_find_custom(blacklist, &peer, (GCompareFunc) bacmp)) {
+		DBG("prior autopair failed");
+		return 0;
+	}
+
+	autopair_parse_config(&dev);
+	if (dev.pinlen && autopair_attempt(device)) {
+		DBG("using PIN %.*s", (int)dev.pinlen, pinbuf);
+		return dev.pinlen;
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
+	autopair_load_blacklist();
+
+	return btd_register_adapter_driver(&autopair_driver);
+}
+
+static void autopair_exit(void)
+{
+	btd_unregister_adapter_driver(&autopair_driver);
+
+	autopair_cancel_all();
+
+	autopair_save_blacklist();
+	g_slist_free_full(blacklist, g_free);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(autopair, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, autopair_init, autopair_exit)
diff --git a/plugins/pin-code-database.xml b/plugins/pin-code-database.xml
new file mode 100644
index 0000000..467a67d
--- /dev/null
+++ b/plugins/pin-code-database.xml
@@ -0,0 +1,174 @@
+<?xml version="1.0" encoding="UTF-8"?>
+
+<!-- This is a PIN code database for use by the autopair plugin.
+
+  Copyright (C) 2008-2009  Bastien Nocera <hadess@hadess.net>
+  Copyright (C) 2012  Google Inc.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+-->
+
+<!--
+  The autopair plugin will match devices, following the order of the XML
+  file [1], on any combination of type, OUI, or name.
+
+  [1]: So specific devices should be at the top, and generic ones at the bottom,
+  so settings for specific devices are overridden as expected.
+-->
+
+<!DOCTYPE devices [
+	<!ELEMENT devices (device)+>
+	<!ELEMENT device EMPTY>
+	<!ATTLIST device type (any|mouse|tablet|keyboard|headset|headphones|audio|printer|network) "any">
+	<!ATTLIST device oui CDATA #IMPLIED>
+	<!ATTLIST device name CDATA #IMPLIED>
+	<!ATTLIST device pin CDATA #REQUIRED>
+]>
+
+<devices>
+
+<!-- Input devices -->
+
+	<!-- TomTom Go remote -->
+	<device type="keyboard" oui="00:13:6C:" name="TomTom Remote" pin="0000"/>
+
+	<!-- Sony PlayStation 3 Remote Control -->
+	<!-- removed pending discussion about how to handle such UI hints
+	<device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
+	<device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
+          -->
+
+	<!-- Apple Wireless and Mighty Mouse
+	     Note: Apple doesn't follow the specs, and requires their mice
+	     to be paired -->
+	<device oui="00:0A:95:" type="mouse" pin="0000"/>
+	<device oui="00:14:51:" type="mouse" pin="0000"/>
+	<device oui="34:15:9E:" type="mouse" pin="0000"/>
+
+	<!-- Apple Magic Trackpad
+	     Note: same as above, tablet needs to be paired -->
+	<device oui="D8:A2:5E:" type="tablet" pin="0000"/>
+
+	<!-- BT-GPS8 JENTRO, GPS mouse -->
+	<device oui="00:0D:B5:" name="BT-GPS8 JENTRO" pin="0000"/>
+
+	<!-- Lenovo Ideacenter remote -->
+	<device oui="00:08:1B:" name="lenovo_RC" pin="0000"/>
+
+	<!-- ION iCade Game Controller -->
+	<!-- removed pending discussion about how to handle such UI hints
+	<device oui="00:12:A1:" name="ION iCade Game Controller" type="keyboard" pin="ICADE"/>
+          -->
+
+<!-- GPS devices -->
+	<device oui="00:0D:B5:" name="TomTom Wireless GPS MkII" pin="0000"/>
+	<device oui="00:0D:B5:" name="GPS-GW-005" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560870 -->
+	<device oui="00:0A:3A:" name="BT GPS" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560606 -->
+	<device oui="00:1B:C1:" name="HOLUX_M-241" pin="0000"/>
+	<device oui="00:01:C1:" name="HOLUX_M-241" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560713 -->
+	<device oui="00:0B:24:" name="Triceiver" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560715 -->
+	<device oui="00:00:00:" name="BT-Q880" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560625 -->
+	<device oui="00:11:67:" name="eGPS-397" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560604 -->
+	<device oui="00:1B:C1:" name="HOLUX_M-1000" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=561326 -->
+	<device oui="00:0B:0D:" name="G-Rays1" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=571119 -->
+	<device oui="00:0B:0D:" name="G-Rays2" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=561327 -->
+	<device oui="00:0A:3A:" name="HUDGPS" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=562479 -->
+	<device oui="00:0B:0D:" name="iBT-GPS" pin="0000"/>
+	<device oui="00:1C:88:" name="iBT-GPS" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=563554 -->
+	<device oui="00:0D:B5:" name="BT-GPS-37A4C2" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=563614 -->
+	<device oui="00:0B:0D:" name="HOLUX GPSlim240" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=563554 -->
+	<device oui="00:0D:B5:" name="BT-GPS-37A4C2" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=576490 -->
+	<device oui="00:0D:B5:" name="BT-GPS-339D35" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560315#c20 -->
+	<device oui="00:02:5B:" name="Pharos iGPS-BT" pin="12345678"/>
+
+	<!-- https://bugzilla.redhat.com/show_bug.cgi?id=472686#c0 -->
+	<device oui="00:00:00:" name="Rikaline" pin="0000"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560609 -->
+	<device oui="00:18:96:" name="GW-GPS-009" pin="0000"/>
+
+	<!-- https://bugzilla.gnome.org/show_bug.cgi?id=613698 -->
+	<device oui="00:0C:A5:" name="NAVMAN GPS ONE" pin="NAVMAN"/>
+
+<!-- Audio devices -->
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=560315 -->
+	<device type="headset" name="X3 micro" pin="1234"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=561324 -->
+	<device type="headset" oui="00:03:C9:" name="BT Headset" pin="1111"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=573059 -->
+	<device type="headset" oui="00:12:A1:" name="BT Stereo Headset" pin="1234"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=561325 -->
+	<device type="network" oui="00:06:66:" name="OBDPros scantool" pin="1234"/>
+
+	<!-- http://bugzilla.gnome.org/show_bug.cgi?id=583651 -->
+	<device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>
+
+<!-- Generic types -->
+
+	<!-- Printers -->
+	<device type="printer" pin="0000"/>
+
+	<!-- Headphones and headsets -->
+	<device type="headphones" pin="0000"/>
+	<device type="headset" pin="0000"/>
+	<device type="audio" pin="0000"/>
+
+	<!-- Mice -->
+	<device type="mouse" pin="0000"/>
+	<!-- changed to 0000 pending discussion about UI hints
+	     (all the mice I have on my desk disobey the spec and have this
+	      fixed pin)
+	<device type="mouse" pin="NULL"/>
+	  -->
+
+	<!-- Keyboard need a special help text -->
+	<!-- removed pending discussion about how to handle such UI hints
+	<device type="keyboard" pin="KEYBOARD"/>
+	-->
+</devices>
-- 
1.7.7.3

