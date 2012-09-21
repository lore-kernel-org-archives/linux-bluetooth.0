Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 01/18] Add initial neard plugin implementation
Date: Fri, 21 Sep 2012 14:36:18 +0200
Message-ID: <1348230995-8967-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation. Only register and unregister support.

---
 Makefile.am         |   11 ++-
 acinclude.m4        |   19 +++--
 bootstrap-configure |    3 +-
 plugins/neard.c     |  219 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+), 10 deletions(-)
 create mode 100644 plugins/neard.c

diff --git a/Makefile.am b/Makefile.am
index 372111a..1d6b235 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -259,9 +259,14 @@ builtin_modules += wiimote
 builtin_sources += plugins/wiimote.c
 endif
 
-if DBUSOOBPLUGIN
-builtin_modules += dbusoob
-builtin_sources += plugins/dbusoob.c
+if OOB
+builtin_modules += @OOB_PLUGIN@
+builtin_sources += plugins/@OOB_PLUGIN@.c
+
+noinst_LIBRARIES += plugins/liboob.a
+
+plugins_liboob_a_SOURCES = plugins/dbusoob.c plugins/neard.c
+
 endif
 
 if MAINTAINER_MODE
diff --git a/acinclude.m4 b/acinclude.m4
index 39b0a18..69ab88f 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -185,9 +185,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	datafiles_enable=yes
 	telephony_driver=dummy
 	sap_driver=dummy
-	dbusoob_enable=no
 	wiimote_enable=no
 	gatt_enable=no
+	oob_enable=no
+	oob=dbusoob
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -280,10 +281,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 
 	AC_SUBST([TELEPHONY_DRIVER], [telephony-${telephony_driver}.c])
 
-	AC_ARG_ENABLE(dbusoob, AC_HELP_STRING([--enable-dbusoob], [compile with D-Bus OOB plugin]), [
-		dbusoob_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(wiimote, AC_HELP_STRING([--enable-wiimote], [compile with Wii Remote plugin]), [
 		wiimote_enable=${enableval}
 	])
@@ -292,6 +289,16 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		gatt_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(oob, AC_HELP_STRING([--enable-oob], [enable OOB plugin]), [
+		oob_enable=${enableval}
+	])
+
+	AC_ARG_WITH(oob, AC_HELP_STRING([--with-oob=PLUGIN], [select OOB plugin (dbusoob, neard)]), [
+		oob=${withval}
+	])
+
+	AC_SUBST([OOB_PLUGIN], [${oob}])
+
 	misc_cflags=""
 	misc_ldflags=""
 
@@ -339,7 +346,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
 	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
-	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
+	AM_CONDITIONAL(OOB, test "${oob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
 	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 7177c65..37f1a7d 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -23,7 +23,8 @@ fi
 		--enable-hid2hci \
 		--enable-test \
 		--enable-cups \
-		--enable-dbusoob \
+		--enable-oob \
+		--with-oob=neard\
 		--enable-sap \
 		--enable-wiimote \
 		--disable-pcmcia \
diff --git a/plugins/neard.c b/plugins/neard.c
new file mode 100644
index 0000000..3f8d054
--- /dev/null
+++ b/plugins/neard.c
@@ -0,0 +1,219 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Tieto Poland
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
+#include "dbus-common.h"
+#include "adapter.h"
+
+#define NEARD_NAME "org.neard"
+#define NEARD_PATH "/"
+#define NEARD_MANAGER_INTERFACE "org.neard.Manager"
+#define AGENT_INTERFACE "org.neard.HandoverAgent"
+#define AGENT_PATH "/org/bluez/neard_handover_agent"
+#define ERROR_INTERFACE "org.neard.HandoverAgent.Error"
+
+static guint watcher_id = 0;
+static gboolean agent_registered = FALSE;
+
+static DBusMessage *error_failed(DBusMessage *msg, int error)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+							"%s", strerror(error));
+}
+
+static void register_agent_cb(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+	DBusError err;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("neard manager replied with an error: %s, %s",
+						err.name, err.message);
+		dbus_error_free(&err);
+		dbus_message_unref(reply);
+
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+						AGENT_PATH, AGENT_INTERFACE);
+		return;
+	}
+
+	dbus_message_unref(reply);
+	agent_registered = TRUE;
+}
+
+static void register_agent(void)
+{
+	DBusMessage *message;
+	DBusPendingCall *call;
+	const gchar *path = AGENT_PATH;
+
+	message = dbus_message_new_method_call(NEARD_NAME, NEARD_PATH,
+			NEARD_MANAGER_INTERFACE, "RegisterHandoverAgent");
+	if (!message) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID);
+
+	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
+							message, &call, -1)) {
+		error("D-Bus send failed");
+		return;
+	}
+
+	dbus_pending_call_set_notify(call, register_agent_cb, NULL, NULL);
+	dbus_pending_call_unref(call);
+}
+
+static void unregister_agent(void)
+{
+	DBusMessage *message;
+	const gchar *path = AGENT_PATH;
+
+	agent_registered = FALSE;
+
+	message = dbus_message_new_method_call(NEARD_NAME, NEARD_PATH,
+			NEARD_MANAGER_INTERFACE, "UnregisterHandoverAgent");
+
+	if (!message) {
+		error("Couldn't allocate D-Bus message");
+		goto unregister;
+	}
+
+	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID);
+
+	if (!g_dbus_send_message(btd_get_dbus_connection(), message))
+		error("D-Bus send failed");
+
+unregister:
+	g_dbus_unregister_interface(btd_get_dbus_connection(), AGENT_PATH,
+							AGENT_INTERFACE);
+}
+
+static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	DBG("");
+
+	return error_failed(msg, ENOTSUP);
+}
+
+static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBG("");
+
+	return error_failed(msg, ENOTSUP);
+}
+
+static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	DBG("");
+
+	agent_registered = FALSE;
+
+	g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable neard_methods[] = {
+	{ GDBUS_ASYNC_METHOD("RequestOOB",
+			GDBUS_ARGS({ "data", "a{sv}" }),
+			GDBUS_ARGS({ "data", "a{sv}" }), request_oob) },
+	{ GDBUS_ASYNC_METHOD("PushOOB",
+			GDBUS_ARGS({ "data", "a{sv}"}), NULL, push_oob) },
+	{ GDBUS_METHOD("Release", NULL, NULL, release) },
+	{ }
+};
+
+static void neard_appeared(DBusConnection *conn, void *user_data)
+{
+	DBG("");
+
+	if (!g_dbus_register_interface(conn, AGENT_PATH, AGENT_INTERFACE,
+						neard_methods,
+						NULL, NULL, NULL, NULL)) {
+		error("neard interface init failed on path " AGENT_PATH);
+		return;
+	}
+
+	register_agent();
+}
+
+static void neard_vanished(DBusConnection *conn, void *user_data)
+{
+	DBG("");
+
+	/* neard existed without unregistering agent */
+	if (agent_registered) {
+		g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
+		agent_registered = FALSE;
+	}
+}
+
+static int neard_init(void)
+{
+	DBG("Setup neard plugin");
+
+	watcher_id = g_dbus_add_service_watch(btd_get_dbus_connection(),
+						NEARD_NAME, neard_appeared,
+						neard_vanished, NULL, NULL);
+	if (watcher_id == 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void neard_exit(void)
+{
+	DBG("Cleanup neard plugin");
+
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher_id);
+	watcher_id = 0;
+
+	if (agent_registered)
+		unregister_agent();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(neard, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						neard_init, neard_exit)
-- 
1.7.9.5

