Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] Add DBus OOB plugin.
Date: Thu, 4 Nov 2010 11:10:59 +0100
Message-ID: <1288865461-3760-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am       |    5 +
 acinclude.m4      |    6 +
 plugins/dbusoob.c |  356 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dbusoob.c

diff --git a/Makefile.am b/Makefile.am
index 1b71cc4..d6cbf92 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -216,6 +216,11 @@ builtin_modules += maemo6
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
index 287f07d..a52d063 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -193,6 +193,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	configfiles_enable=yes
 	telephony_driver=dummy
 	maemo6_enable=no
+	dbusoob_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -316,6 +317,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		maemo6_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(dbusoob, AC_HELP_STRING([--enable-dbusoob], [compile with DBUS OOB plugin]), [
+		dbusoob_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
 		hal_enable=${enableval}
 	])
@@ -372,4 +377,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
+	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 ])
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
new file mode 100644
index 0000000..335de76
--- /dev/null
+++ b/plugins/dbusoob.c
@@ -0,0 +1,356 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  ST-Ericsson SA
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
+#include "manager.h"
+#include "device.h"
+#include "adapter.h"
+#include "dbus-common.h"
+#include "event.h"
+#include "error.h"
+#include "oob.h"
+
+#define OOB_INTERFACE	"org.bluez.OOB"
+#define OOB_PATH	"/org/bluez"
+
+struct oob_provider {
+	char *name;
+	char *path;
+
+	struct btd_adapter *adapter;
+	DBusMessage *msg;
+
+	guint listener_id;
+	gboolean exited;
+};
+
+static struct oob_provider *provider = NULL;
+static DBusConnection *connection = NULL;
+static struct oob_plugin dbusoob;
+
+static void destroy_provider(void)
+{
+	if (!provider->exited)
+		g_dbus_remove_watch(connection, provider->listener_id);
+
+	if (provider->msg)
+		dbus_message_unref(provider->msg);
+
+	g_free(provider->name);
+	g_free(provider->path);
+	g_free(provider);
+	provider = NULL;
+
+	oob_deactivate_plugin(&dbusoob);
+}
+
+static void provider_exited(DBusConnection *conn, void *user_data)
+{
+	DBG("Provider exited without calling Unregister");
+
+	provider->exited = TRUE;
+	destroy_provider();
+}
+
+static void create_provider(const char *path, const char *name)
+{
+	provider = g_new(struct oob_provider, 1);
+	provider->path = g_strdup(path);
+	provider->name = g_strdup(name);
+	provider->adapter = NULL;
+	provider->msg = NULL;
+	provider->exited = FALSE;
+	provider->listener_id = g_dbus_add_disconnect_watch(connection, name,
+			provider_exited, NULL, NULL);
+
+	oob_activate_plugin(&dbusoob);
+}
+
+static void request_remote_data_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *msg;
+	DBusError err;
+	struct btd_device *device = user_data;
+	uint8_t *hash = NULL;
+	uint8_t *randomizer = NULL;
+	int32_t hash_len;
+	int32_t rand_len;
+
+	msg = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, msg)) {
+		error("Provider replied with an error: %s, %s", err.name,
+				err.message);
+		dbus_error_free(&err);
+		goto error;
+	}
+
+	dbus_error_init(&err);
+	if (!dbus_message_get_args(msg, &err,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, &hash_len,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, &rand_len,
+			DBUS_TYPE_INVALID)
+			|| hash_len != 16 || rand_len != 16) {
+		error("RequestRemoteOobData reply signature error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+		hash = NULL;
+		randomizer = NULL;
+	}
+
+error:
+	dbus_message_unref(msg);
+	dbus_pending_call_unref(call);
+
+	device_set_oob_data(device, hash, randomizer);
+}
+
+static gboolean request_remote_data(struct btd_device *device)
+{
+	DBusMessage* msg;
+	DBusPendingCall *call = NULL;
+	bdaddr_t ba;
+	char addr[18];
+	const char *paddr = addr;
+	gboolean ret = FALSE;
+
+	msg = dbus_message_new_method_call(provider->name, provider->path,
+			OOB_INTERFACE, "RequestRemoteOobData");
+
+	if (!msg) {
+		error("Couldn't allocate D-Bus message");
+		goto error;
+	}
+
+	device_get_address(device, &ba);
+	ba2str(&ba, addr);
+
+	if (!dbus_message_append_args(msg, DBUS_TYPE_STRING, &paddr,
+			DBUS_TYPE_INVALID)) {
+		error ("Couldn't append arguments");
+		goto error;
+	}
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		error("D-Bus send failed");
+		goto error;
+	}
+
+	if (!dbus_pending_call_set_notify(call, request_remote_data_reply,
+			device, NULL)) {
+		error("Couldn't set reply notification.");
+		dbus_pending_call_unref(call);
+		goto error;
+	}
+
+	ret = TRUE;
+
+error:
+	if (msg)
+		dbus_message_unref(msg);
+
+	return ret;
+}
+
+static void local_data_updated(bdaddr_t *ba, uint8_t *hash, uint8_t *randomizer)
+{
+	struct DBusMessage *reply;
+	bdaddr_t addr;
+
+	if (!provider)
+		return;
+
+	adapter_get_address(provider->adapter, &addr);
+	if (bacmp(ba, &addr))
+		return;
+
+	if (hash && randomizer)
+		reply = g_dbus_create_reply(provider->msg,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, 16,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, 16,
+			DBUS_TYPE_INVALID);
+	else
+		reply = g_dbus_create_error(provider->msg,
+				ERROR_INTERFACE ".UpdateFailed",
+				"Failed to update local OOB.");
+
+	dbus_message_unref(provider->msg);
+	provider->msg = NULL;
+	provider->adapter = NULL;
+
+	if (!reply) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	if (!g_dbus_send_message(connection, reply))
+		error("D-Bus send failed");
+
+}
+
+static DBusMessage *update_local_data(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *name;
+	const char *addr;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &addr,
+			DBUS_TYPE_INVALID))
+		return NULL;
+
+	name = dbus_message_get_sender(msg);
+	if (!provider || provider->name != name)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".UpdateFailed",
+				"Not a OOB provider or no provider registered");
+
+	if (provider->msg)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".UpdateFailed",
+				"Another request in progress.");
+
+	provider->adapter = manager_find_adapter_by_address(addr);
+	if (!provider->adapter)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".UpdateFailed",
+				"No adapter with given address found");
+
+	if (btd_adapter_read_local_oob_data(provider->adapter))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".UpdateFailed",
+				"HCI request failed");
+
+	provider->msg = dbus_message_ref(msg);
+	return NULL;
+}
+
+static void plugin_deactivated(void)
+{
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(provider->name, provider->path,
+				OOB_INTERFACE, "Deactivate");
+
+	if (!msg)
+		error("Couldn't allocate D-Bus message");
+	else if (!g_dbus_send_message(connection, msg))
+		error("D-Bus send failed");
+
+	destroy_provider();
+}
+
+static DBusMessage *register_provider(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *path;
+	const char *name;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID))
+		return NULL;
+
+	if (provider)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExists",
+				"OOB provider already registered");
+
+	name = dbus_message_get_sender(msg);
+	create_provider(path, name);
+
+	DBG("OOB provider registered at %s:%s", provider->name, provider->path);
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_provider(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *path;
+	const char *name;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID))
+		return NULL;
+
+	name = dbus_message_get_sender(msg);
+
+	if (!provider || !g_str_equal(provider->path, path)
+			|| !g_str_equal(provider->name, name))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
+				"No such OOB provider registered");
+
+	DBG("OOB provider (%s:%s) unregistered", provider->name, provider->path);
+
+	destroy_provider();
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable oob_methods[] = {
+	{ "RegisterProvider",	"o", "", register_provider},
+	{ "UnregisterProvider",	"o", "", unregister_provider},
+	{ "UpdateLocalOobData",	"s", "ayay", update_local_data, G_DBUS_METHOD_FLAG_ASYNC},
+	{ }
+};
+
+static gboolean register_on_dbus(void)
+{
+	connection = get_dbus_connection();
+
+	if (!g_dbus_register_interface(connection, OOB_PATH, OOB_INTERFACE,
+				oob_methods, NULL, NULL, NULL, NULL)) {
+			error("OOB interface init failed on path %s", OOB_PATH);
+			return FALSE;
+		}
+
+	return TRUE;
+}
+
+static int dbusoob_init(void)
+{
+	DBG("Setup dbusoob plugin");
+
+	dbusoob.request_remote_data = request_remote_data;
+	dbusoob.local_data_updated = local_data_updated;
+	dbusoob.plugin_deactivated = plugin_deactivated;
+
+	return register_on_dbus();
+}
+
+static void dbusoob_exit(void)
+{
+	DBG("Cleanup dbusoob plugin");
+	oob_deactivate_plugin(&dbusoob);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(dbusoob, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, dbusoob_init, dbusoob_exit)
-- 
1.7.1

