Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v7 4/6] Add D-Bus OOB plugin
Date: Sat, 26 Mar 2011 12:27:09 +0100
Message-ID: <1301138831-12082-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
References: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A sample OOB plugin that directly exposes OOB functionality over D-Bus.
---
 Makefile.am       |    5 +
 acinclude.m4      |    6 ++
 plugins/dbusoob.c |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dbusoob.c

diff --git a/Makefile.am b/Makefile.am
index 0ed2acf..a23cc60 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -237,6 +237,11 @@ builtin_modules += maemo6
 builtin_sources += plugins/maemo6.c
 endif
 
+if DBUSOOBPLUGIN
+builtin_modules += dbusoob
+builtin_sources += plugins/dbusoob.c
+endif
+
 sbin_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
diff --git a/acinclude.m4 b/acinclude.m4
index faa7f7c..69e0740 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -206,6 +206,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	telephony_driver=dummy
 	maemo6_enable=no
 	sap_driver=dummy
+	dbusoob_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -338,6 +339,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		maemo6_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(dbusoob, AC_HELP_STRING([--enable-dbusoob], [compile with D-Bus OOB plugin]), [
+		dbusoob_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
 		hal_enable=${enableval}
 	])
@@ -396,4 +401,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
+	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 ])
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
new file mode 100644
index 0000000..fac5ba5
--- /dev/null
+++ b/plugins/dbusoob.c
@@ -0,0 +1,234 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  ST-Ericsson SA
+ *
+ *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
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
+#include <gdbus.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/sdp.h>
+
+#include "plugin.h"
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "manager.h"
+#include "dbus-common.h"
+#include "event.h"
+#include "error.h"
+#include "oob.h"
+
+#define REQUEST_TIMEOUT	(60 * 1000)	/* 60 seconds */
+#define OOB_INTERFACE	"org.bluez.Oob"
+
+struct oob_request {
+	struct btd_adapter *adapter;
+	DBusMessage *msg;
+};
+
+static GSList *oob_requests = NULL;
+static DBusConnection *connection = NULL;
+
+static gint oob_request_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct oob_request *data = a;
+	const struct btd_adapter *adapter = b;
+
+	return data->adapter != adapter;
+}
+
+static struct oob_request *find_oob_request(struct btd_adapter *adapter)
+{
+	GSList *match;
+
+	match = g_slist_find_custom(oob_requests, adapter, oob_request_cmp);
+
+	if (match)
+		return match->data;
+
+	return NULL;
+}
+
+static void read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
+				uint8_t *randomizer)
+{
+	struct DBusMessage *reply;
+	struct oob_request *oob_request;
+
+	oob_request = find_oob_request(adapter);
+	if (!oob_request)
+		return;
+
+	if (hash && randomizer)
+		reply = g_dbus_create_reply(oob_request->msg,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, 16,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, 16,
+			DBUS_TYPE_INVALID);
+	else
+		reply = btd_error_failed(oob_request->msg,
+					"Failed to read local OOB data.");
+
+	oob_requests = g_slist_remove(oob_requests, oob_request);
+	dbus_message_unref(oob_request->msg);
+	g_free(oob_request);
+
+	if (!reply) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	if (!g_dbus_send_message(connection, reply))
+		error("D-Bus send failed");
+}
+
+static DBusMessage *read_local_data(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+	struct oob_request *oob_request;
+
+	if (find_oob_request(adapter))
+		return btd_error_in_progress(msg);
+
+	if (btd_adapter_read_local_oob_data(adapter))
+		return btd_error_failed(msg, "Request failed.");
+
+	oob_request = g_new(struct oob_request, 1);
+	oob_request->adapter = adapter;
+	oob_requests = g_slist_append(oob_requests, oob_request);
+	oob_request->msg = dbus_message_ref(msg);
+	return NULL;
+}
+
+static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+	uint8_t *hash, *randomizer;
+	int32_t hlen, rlen;
+	const char *addr;
+	bdaddr_t bdaddr;
+
+	if (!dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_STRING, &addr,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, &hlen,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, &rlen,
+			DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	if (hlen != 16 || rlen != 16 || bachk(addr))
+		return btd_error_invalid_args(msg);
+
+	str2ba(addr, &bdaddr);
+
+	if (btd_adapter_add_remote_oob_data(adapter, &bdaddr, hash, randomizer))
+		return btd_error_failed(msg, "Request failed");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+	const char *addr;
+	bdaddr_t bdaddr;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &addr,
+			DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	if (bachk(addr))
+		return btd_error_invalid_args(msg);
+
+	str2ba(addr, &bdaddr);
+
+	if (btd_adapter_remove_remote_oob_data(adapter, &bdaddr))
+		return btd_error_failed(msg, "Request failed");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static GDBusMethodTable oob_methods[] = {
+	{"AddRemoteOobData",	"sayay",	"",	add_remote_data},
+	{"RemoveRemoteOobData",	"s",		"",	remove_remote_data},
+	{"ReadLocalOobData",	"",		"ayay",	read_local_data,
+						G_DBUS_METHOD_FLAG_ASYNC},
+	{}
+};
+
+static int oob_probe(struct btd_adapter *adapter)
+{
+	const char *path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(connection, path, OOB_INTERFACE,
+				oob_methods, NULL, NULL, adapter, NULL)) {
+			error("OOB interface init failed on path %s", path);
+			return -EIO;
+		}
+
+	return 0;
+}
+
+static void oob_remove(struct btd_adapter *adapter)
+{
+	read_local_data_complete(adapter, NULL, NULL);
+
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+							OOB_INTERFACE);
+}
+
+static struct btd_adapter_driver oob_driver = {
+	.name	= "oob",
+	.probe	= oob_probe,
+	.remove	= oob_remove,
+};
+
+static int dbusoob_init(void)
+{
+	DBG("Setup dbusoob plugin");
+
+	connection = get_dbus_connection();
+
+	oob_register_cb(read_local_data_complete);
+
+	return btd_register_adapter_driver(&oob_driver);
+}
+
+static void dbusoob_exit(void)
+{
+	DBG("Cleanup dbusoob plugin");
+
+	manager_foreach_adapter((adapter_cb) oob_remove, NULL);
+
+	btd_unregister_adapter_driver(&oob_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(dbusoob, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						dbusoob_init, dbusoob_exit)
-- 
1.7.0.4

