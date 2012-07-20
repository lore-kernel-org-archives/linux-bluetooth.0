Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 10:30:08 -0600
Message-ID: <CAAbnaHY0S65EHh9338EEiRgQkqpuneR+=pWXRnCHxYnKBgO7TA@mail.gmail.com>
Subject: [RFC generichid 1/5]
From: Nathaniel Haggard <natester@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Includes the build instructions as well as the plugin setup.

 Makefile.am         |   10 ++
 Makefile.tools      |    1 +
 acinclude.m4        |    6 +
 bootstrap-configure |    1 +
 input/generichid.c  |  394 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 412 insertions(+), 0 deletions(-)
diff --git a/Makefile.am b/Makefile.am
index 45a811c..a033de1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -185,8 +185,18 @@ if HOGPLUGIN
 builtin_modules += hog
 builtin_sources += profiles/input/hog_manager.c profiles/input/hog_device.h \
 			profiles/input/hog_device.c profiles/input/uhid_copy.h
+
 endif

+
+
+if GENERICHIDPLUGIN
+builtin_modules += generichid
+builtin_sources += input/generichid.c
+
+endif
+
+
 if NETWORKPLUGIN
 builtin_modules += network
 builtin_sources += profiles/network/main.c \
diff --git a/Makefile.tools b/Makefile.tools
index fccac2d..f29c23d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -16,6 +16,7 @@ tools/kword.c: tools/parser.h

 tools_rfcomm_SOURCES = tools/rfcomm.c tools/parser.y tools/lexer.l \
 					tools/kword.h tools/kword.c
+
 EXTRA_tools_rfcomm_SOURCES = tools/parser.h tools/parser.c \
 							tools/lexer.c
 tools_rfcomm_LDADD = lib/libbluetooth-private.la
diff --git a/acinclude.m4 b/acinclude.m4
index 39b0a18..4115084 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,6 +167,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	fortify_enable=yes
 	pie_enable=yes
 	sndfile_enable=${sndfile_found}
+	generichid_enable=yes
 	usb_enable=${usb_found}
 	gstreamer_enable=${gstreamer_found}
 	audio_enable=yes
@@ -226,6 +227,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		service_enable=${enableval}
 	])

+	AC_ARG_ENABLE(generichid, AC_HELP_STRING([--enable-generichid],
[enable generichid plugin]), [
+		generichid_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(health, AC_HELP_STRING([--enable-health], [enable
health plugin]), [
 		health_enable=${enableval}
 	])
@@ -320,6 +325,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	fi

 	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" = "yes" && test
"${sndfile_found}" = "yes")
+	AM_CONDITIONAL(GENERICHIDPLUGIN, test "${generichid_enable}" = "yes")
 	AM_CONDITIONAL(USB, test "${usb_enable}" = "yes" && test
"${usb_found}" = "yes")
 	AM_CONDITIONAL(SBC, test "${gstreamer_enable}" = "yes" || test
"${test_enable}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test
"${gstreamer_found}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 7177c65..9cde36b 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -21,6 +21,7 @@ fi
 		--enable-bccmd \
 		--enable-dfutool \
 		--enable-hid2hci \
+		--enable-generichid \
 		--enable-test \
 		--enable-cups \
 		--enable-dbusoob \
diff --git a/input/generichid.c b/input/generichid.c
new file mode 100644
index 0000000..926d8ec
--- /dev/null
+++ b/input/generichid.c
@@ -0,0 +1,394 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <uinput.h>
+#include <fcntl.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <gdbus.h>
+#include <glib.h>
+#include <dbus/dbus.h>
+
+#include "dbus-common.h"
+#include "plugin.h"
+#include "adapter.h"
+#include "error.h"
+#include "log.h"
+#include "glib-helper.h"
+#include "btio.h"
+#include "../profiles/input/device.h"
+#include "sdpd.h"
+
+#include "../src/device.h"
+
+#define GENERIC_HID_INTERFACE "org.bluez.GenericHID"
+#define GENERIC_HID_DEVICE    "org.bluez.GenericHIDDevice"
+#define GENERIC_INPUT_DEVICE  "org.bluez.GenericHIDInput"
+
+#define L2CAP_UUID_STR	"00000100-0000-1000-8000-00805f9b34fb"
+
+#define KEYB_MAJOR	0x25
+#define KEYB_MINOR	0x40
+
+#define HIDP_KEYB_SIZE	10
+
+typedef int (*func_ptr)();
+
+static GSList *adapters = NULL;
+
+static DBusConnection *connection;
+
+static const unsigned char keycode2hidp[256] = {
+		0, 41, 30, 31, 32, 33, 34, 35, 36,
+		37, 38, 39, 45, 46, 42, 43, 20,
+		26, 8, 21, 23, 28, 24, 12, 18, 19,
+		47, 48, 40, 224, 4, 22, 7, 9, 10, 11,
+		13, 14, 15, 51, 52, 53, 225, 49, 29,
+		27, 6, 25, 5, 17, 16, 54, 55, 56, 229,
+		85, 226, 44, 57, 58, 59, 60, 61, 62,
+		63, 64, 65, 66, 67, 83, 71, 95, 96, 97,
+		86, 92, 93, 94, 87, 89, 90, 91, 98, 99,
+		0, 148, 100, 68, 69, 135, 146, 147, 138,
+		136, 139, 140, 88, 228, 84, 70, 230, 0,
+		74, 82, 75, 80, 79, 77, 81, 78, 73, 76,
+		0, 127, 129, 128, 102, 103, 0, 72, 0,
+		133, 144, 145, 137, 227, 231, 101, 120,
+		121, 118, 122, 119, 124, 116, 125, 126,
+		123, 117, 0, 251, 0, 248, 0, 0, 0, 0, 0,
+		0, 0, 240, 0, 249, 0, 0, 0, 0, 0, 241,
+		242, 0, 236, 0, 235, 232, 234, 233, 0, 0,
+		0, 0, 0, 0, 250, 0, 0, 247, 245, 246, 0,
+		0, 0, 0, 104, 105, 106, 107, 108, 109,
+		110, 111, 112, 113, 114, 115, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+		};
+
+struct keyboard_state {
+	unsigned char value[HIDP_KEYB_SIZE];
+	unsigned char last_value;
+};
+
+struct device_data {
+	GIOChannel *ctrl;
+	GIOChannel *intr;
+	bdaddr_t dst;
+	unsigned int intr_watch;
+	char *input_path;
+	struct keyboard_state keyboard;
+};
+
+struct adapter_data {
+	struct btd_adapter *adapter;
+	struct device_data *dev;
+	uint32_t sdp_record_handle;
+	GIOChannel *listen_ctrl;
+	GIOChannel *listen_intr;
+	int pending;
+	char active;
+	uint32_t original_cod;
+};
+
+struct user_data {
+	struct adapter_data *adapt;
+	func_ptr func;
+};
+
+
+static void add_lang_attr(sdp_record_t *r)
+{
+	sdp_lang_attr_t base_lang;
+	sdp_list_t *langs = 0;
+
+	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
+	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
+	base_lang.encoding = 106;
+	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
+	langs = sdp_list_append(0, &base_lang);
+	sdp_set_lang_attr(r, langs);
+	sdp_list_free(langs, 0);
+}
+
+
+static int sdp_keyboard_service(struct adapter_data *adapt)
+{
+    return -1;
+}
+
+
+
+static DBusMessage *send_event(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	return btd_error_failed(msg, "Invalid profile mode");
+}
+
+
+
+static DBusMessage *connect_device(DBusConnection *conn, DBusMessage *msg,
+					gpointer data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+
+static const GDBusSignalTable ghid_adapter_signals[] = {
+	{ GDBUS_SIGNAL("IncomingConnection", NULL) },
+	{ GDBUS_SIGNAL("DeviceReleased", NULL) },
+	{ }
+};
+
+
+static const GDBusMethodTable ghid_adapter_methods[] = {
+	{ GDBUS_METHOD("Connect", GDBUS_ARGS({"path", "s"}), NULL, connect_device) },
+	{ }
+};
+
+
+static void register_interface(const char *path, struct adapter_data *adapt)
+{
+	if (g_dbus_register_interface(connection, path, GENERIC_HID_INTERFACE,
+					ghid_adapter_methods, ghid_adapter_signals,
+					NULL, adapt, NULL) == FALSE) {
+		error("D-Bus failed to register %s interface",
+				GENERIC_HID_INTERFACE);
+		return;
+	}
+
+	btd_debug("Registered interface %s path %s", GENERIC_HID_INTERFACE, path);
+
+}
+
+
+static void unregister_interface(const char *path)
+{
+	btd_debug("path %s", path);
+
+	g_dbus_unregister_interface(connection, path, GENERIC_HID_INTERFACE);
+}
+
+static void confirm_event_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+}
+
+static int adapt_start(struct adapter_data *adapt)
+{
+	GError *err = NULL;
+	bdaddr_t src;
+	struct device_data *dev = adapt->dev;
+
+	adapter_get_address(adapt->adapter, &src);
+
+	adapt->listen_ctrl = bt_io_listen(BT_IO_L2CAP, confirm_event_cb,
+						NULL, adapt, NULL, &err,
+						BT_IO_OPT_SOURCE_BDADDR, &src,
+						BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+						BT_IO_OPT_INVALID);
+	if (!adapt->listen_ctrl) {
+		error("Failed to listen on control channel");
+		g_error_free(err);
+		g_free(adapt);
+		return -ENOTCONN;
+	}
+
+	adapt->listen_intr = bt_io_listen(BT_IO_L2CAP, confirm_event_cb,
+						NULL, adapt, NULL, &err,
+						BT_IO_OPT_SOURCE_BDADDR, &src,
+						BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+						BT_IO_OPT_INVALID);
+	if (!adapt->listen_intr) {
+		error("Failed to listen on interrupt channel");
+		/* TODO: fix this */
+		g_io_channel_unref(dev->ctrl);
+		dev->ctrl = NULL;
+		g_error_free(err);
+		g_free(adapt);
+		return -ENOTCONN;
+	}
+
+	return 0;
+}
+
+static void adapt_stop(struct adapter_data *adapt)
+{
+	struct device_data *dev = adapt->dev;
+
+	if (adapt->listen_intr != NULL) {
+		g_io_channel_shutdown(adapt->listen_intr, TRUE, NULL);
+		g_io_channel_unref(adapt->listen_intr);
+	}
+
+	if (adapt->listen_intr != NULL) {
+		g_io_channel_shutdown(adapt->listen_ctrl, TRUE, NULL);
+		g_io_channel_unref(adapt->listen_ctrl);
+	}
+
+	if (dev->intr != NULL) {
+		g_io_channel_shutdown(dev->intr, TRUE, NULL);
+		g_io_channel_unref(dev->intr);
+
+		g_source_remove(dev->intr_watch);
+	}
+
+	if (dev->ctrl != NULL) {
+		g_io_channel_shutdown(dev->ctrl, TRUE, NULL);
+		g_io_channel_unref(dev->ctrl);
+	}
+}
+
+static void cleanup(struct adapter_data *adapt)
+{
+	adapt_stop(adapt);
+
+	if (adapt->dev != NULL)
+		g_free(adapt->dev);
+
+	if (adapt != NULL)
+		g_free(adapt);
+}
+
+static gint adapter_cmp(gconstpointer con, gconstpointer user_data)
+{
+	const struct adapter_data *adapt = con;
+	const struct btd_adapter *adapter = user_data;
+
+    return (adapter == adapt->adapter);
+}
+
+static int ghid_probe(struct btd_adapter *adapter)
+{
+	struct adapter_data *adapt;
+
+	adapt = g_try_new0(struct adapter_data, 1);
+	if (adapt == NULL)
+		return -ENOMEM;
+
+	adapt->dev = g_try_new0(struct device_data, 1);
+	if (adapt->dev == NULL) {
+		g_free(adapt);
+		return -ENOMEM;
+	}
+
+	adapt->pending = 0;
+	adapt->adapter = adapter;
+	adapt->active = 0;
+
+	if (sdp_keyboard_service(adapt) < 0) {
+		btd_debug("Adding HID SDP service failed");
+		g_free(adapt);
+		return -1;
+	}
+
+	if (adapt_start(adapt) < 0)
+		return -ENOTCONN;
+
+	register_interface(adapter_get_path(adapter), adapt);
+
+	adapters = g_slist_append(adapters, adapt);
+
+	return 0;
+}
+
+static void ghid_remove(struct btd_adapter *adapter)
+{
+	struct adapter_data *adapt;
+	struct device_data *dev;
+	GSList *l;
+
+	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
+
+	if (l == NULL)
+		return;
+
+	adapt = l->data;
+	dev = adapt->dev;
+
+	adapters = g_slist_remove(adapters, adapt);
+
+	if (dev->input_path != NULL) {
+		g_dbus_unregister_interface(connection,
+						dev->input_path,
+						GENERIC_INPUT_DEVICE);
+
+		g_dbus_emit_signal(connection,  adapter_get_path(adapter),
+					GENERIC_HID_INTERFACE, "DeviceReleased",
+					DBUS_TYPE_INVALID);
+
+		g_free(dev->input_path);
+
+	}
+
+	remove_record_from_server(adapt->sdp_record_handle);
+	cleanup(adapt);
+
+	unregister_interface(adapter_get_path(adapter));
+}
+
+static struct btd_adapter_driver ghid_driver = {
+	.name	= "generic-hid",
+	.probe	= ghid_probe,
+	.remove	= ghid_remove,
+};
+
+static int generic_hid_init(void)
+{
+	int err;
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	err = btd_register_adapter_driver(&ghid_driver);
+	if (err < 0) {
+		dbus_connection_unref(connection);
+		return err;
+	}
+
+	return 0;
+}
+
+static void generic_hid_exit(void)
+{
+	btd_unregister_adapter_driver(&ghid_driver);
+
+	dbus_connection_unref(connection);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(generichid, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, generic_hid_init, generic_hid_exit)
