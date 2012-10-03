Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 16/18] Add initial neard plugin implementation
Date: Wed, 3 Oct 2012 15:18:29 +0200
Message-ID: <1349270311-31103-17-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation. Only register and unregister support.

---
 Makefile.am         |    5 ++
 acinclude.m4        |    6 ++
 bootstrap-configure |    1 +
 plugins/neard.c     |  218 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 plugins/neard.c

diff --git a/Makefile.am b/Makefile.am
index 9868710..19dd602 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -275,6 +275,11 @@ builtin_modules += dbusoob
 builtin_sources += plugins/dbusoob.c
 endif
 
+if NEARDPLUGIN
+builtin_modules += neard
+builtin_sources += plugins/neard.c
+endif
+
 if MAINTAINER_MODE
 plugin_LTLIBRARIES += plugins/external-dummy.la
 plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
diff --git a/acinclude.m4 b/acinclude.m4
index 9f4b11f..4bac3f0 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -189,6 +189,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	dbusoob_enable=no
 	wiimote_enable=no
 	gatt_enable=no
+	neard_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -299,6 +300,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		gatt_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(neard, AC_HELP_STRING([--enable-neard], [compile with neard plugin]), [
+		neard_enable=${enableval}
+	])
+
 	misc_cflags=""
 	misc_ldflags=""
 
@@ -350,4 +355,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
 	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
+	AM_CONDITIONAL(NEARDPLUGIN, test "${neard_enable}" = "yes")
 ])
diff --git a/bootstrap-configure b/bootstrap-configure
index 7177c65..c02c246 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -24,6 +24,7 @@ fi
 		--enable-test \
 		--enable-cups \
 		--enable-dbusoob \
+		--enable-neard \
 		--enable-sap \
 		--enable-wiimote \
 		--disable-pcmcia \
diff --git a/plugins/neard.c b/plugins/neard.c
new file mode 100644
index 0000000..b98c0fe
--- /dev/null
+++ b/plugins/neard.c
@@ -0,0 +1,218 @@
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
+		agent_registered = FALSE;
+		g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
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

