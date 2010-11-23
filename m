Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 2/7] Add D-Bus OOB plugin
Date: Tue, 23 Nov 2010 11:53:07 +0100
Message-ID: <1290509592-9262-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am       |    5 +
 acinclude.m4      |    6 +
 plugins/dbusoob.c |  412 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dbusoob.c

diff --git a/Makefile.am b/Makefile.am
index 47da8eb..9607553 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -218,6 +218,11 @@ builtin_modules += maemo6
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
index 287f07d..6704d46 100644
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
 
+	AC_ARG_ENABLE(dbusoob, AC_HELP_STRING([--enable-dbusoob], [compile with D-Bus OOB plugin]), [
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
index 0000000..e137b81
--- /dev/null
+++ b/plugins/dbusoob.c
@@ -0,0 +1,412 @@
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
+#define REQUEST_TIMEOUT		(60 * 1000)	/* 60 seconds */
+#define OOB_PROVIDER_INTERFACE	"org.bluez.OobProvider"
+#define OOB_MANAGER_INTERFACE	"org.bluez.OobManager"
+
+struct oob_provider {
+	char *name;
+	char *path;
+	struct btd_adapter *adapter;
+	DBusMessage *msg;
+	guint listener_id;
+	gboolean exited;
+};
+
+static GSList *providers = NULL;
+static DBusConnection *connection = NULL;
+static struct oob_plugin dbusoob;
+
+static void destroy_provider(struct oob_provider *provider)
+{
+	if (!provider->exited)
+		g_dbus_remove_watch(connection, provider->listener_id);
+
+	if (provider->msg)
+		dbus_message_unref(provider->msg);
+
+	DBG("Provider destroyed (%s at %s)", provider->name, provider->path);
+
+	g_free(provider->name);
+	g_free(provider->path);
+	g_free(provider);
+
+	providers = g_slist_remove(providers, provider);
+
+	if (!providers)
+		oob_deactivate_plugin(&dbusoob);
+}
+
+static void provider_exited(DBusConnection *conn, void *user_data)
+{
+	struct oob_provider *provider = user_data;
+
+	DBG("Provider exited without calling Unregister (%s at %s)",
+						provider->name, provider->path);
+
+	provider->exited = TRUE;
+	destroy_provider(provider);
+}
+
+static void create_provider(const char *path, const char *name,
+						struct btd_adapter *adapter)
+{
+	struct oob_provider *provider;
+
+	provider = g_new(struct oob_provider, 1);
+	provider->path = g_strdup(path);
+	provider->name = g_strdup(name);
+	provider->adapter = adapter;
+	provider->msg = NULL;
+	provider->exited = FALSE;
+	provider->listener_id = g_dbus_add_disconnect_watch(connection, name,
+					provider_exited, provider, NULL);
+
+	providers = g_slist_append(providers, provider);
+
+	DBG("OOB provider for %s registered at %s(%s)", provider->path,
+				provider->name, adapter_get_path(adapter));
+
+	oob_activate_plugin(&dbusoob);
+}
+
+static void request_remote_data_reply(DBusPendingCall *call, void *data)
+{
+	DBusMessage *msg;
+	DBusError err;
+	struct btd_device *device = data;
+	uint8_t *hash = NULL;
+	uint8_t *randomizer = NULL;
+	int32_t hlen, rlen;
+
+	msg = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, msg)) {
+		error("Provider replied with an error: %s, %s", err.name,
+								err.message);
+		dbus_error_free(&err);
+		goto error;
+	}
+
+	dbus_error_init(&err);
+	if (!dbus_message_get_args(msg, &err,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, &hlen,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, &rlen,
+			DBUS_TYPE_INVALID) || hlen != 16 || rlen != 16) {
+		error("RequestRemoteOobData reply signature error: %s, %s",
+							err.name, err.message);
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
+static gint provider_adapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct oob_provider *provider = a;
+	const struct btd_adapter *adapter = b;
+
+	return provider->adapter != adapter;
+}
+
+static struct oob_provider* find_provider(struct btd_adapter *adapter)
+{
+	GSList *match;
+
+	match = g_slist_find_custom(providers, adapter, provider_adapter_cmp);
+	if (match)
+		return match->data;
+
+	return NULL;
+}
+
+static gboolean request_remote_data(struct btd_device *device)
+{
+	DBusMessage* msg;
+	DBusPendingCall *call = NULL;
+	const gchar *path;
+	gboolean ret = FALSE;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct oob_provider *provider;
+
+	provider = find_provider(adapter);
+	if (!provider)
+		return ret;
+
+	msg = dbus_message_new_method_call(provider->name, provider->path,
+				OOB_PROVIDER_INTERFACE, "RequestRemoteOobData");
+
+	if (!msg) {
+		error("Couldn't allocate D-Bus message");
+		goto error;
+	}
+
+	path = device_get_path(device);
+
+	if (!dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID)) {
+		error ("Couldn't append arguments");
+		goto error;
+	}
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call,
+							REQUEST_TIMEOUT)) {
+		error("D-Bus send failed");
+		goto error;
+	}
+
+	if (!dbus_pending_call_set_notify(call, request_remote_data_reply,
+								device, NULL)) {
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
+static void local_data_read(struct btd_adapter *adapter, uint8_t *hash,
+				uint8_t *randomizer)
+{
+	struct DBusMessage *reply;
+	struct oob_provider *provider;
+
+	provider = find_provider(adapter);
+	if (!provider)
+		return;
+
+	if (hash && randomizer)
+		reply = g_dbus_create_reply(provider->msg,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, 16,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, 16,
+			DBUS_TYPE_INVALID);
+	else
+		reply = g_dbus_create_error(provider->msg,
+					ERROR_INTERFACE ".ReadFailed",
+					"Failed to read local OOB data.");
+
+	dbus_message_unref(provider->msg);
+	provider->msg = NULL;
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
+	const char *name;
+	struct btd_adapter *adapter = data;
+	struct oob_provider *provider;
+
+	name = dbus_message_get_sender(msg);
+
+	provider = find_provider(adapter);
+	if (!provider)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".NoProvider",
+						"No provider registered");
+
+	if (!g_str_equal(provider->name, name))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".NoProvider",
+							"Not OOB provider");
+
+	if (provider->msg)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+						"Another request in progress.");
+
+	if (btd_adapter_read_local_oob_data(adapter))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".ReadFailed",
+							"HCI request failed");
+
+	provider->msg = dbus_message_ref(msg);
+	return NULL;
+}
+
+static void release_provider(struct oob_provider *provider)
+{
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(provider->name, provider->path,
+					OOB_PROVIDER_INTERFACE, "Release");
+
+	if (!msg)
+		error("Couldn't allocate D-Bus message");
+	else if (!g_dbus_send_message(connection, msg))
+		error("D-Bus send failed");
+
+	destroy_provider(provider);
+}
+
+static void plugin_deactivated(void)
+{
+	g_slist_foreach(providers, (GFunc) release_provider, NULL);
+	g_slist_free(providers);
+}
+
+static DBusMessage *register_provider(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *path, *name;
+	struct btd_adapter *adapter = data;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	if (find_provider(adapter))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".AlreadyExists",
+					"OOB provider already registered");
+
+	name = dbus_message_get_sender(msg);
+	create_provider(path, name, adapter);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_provider(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *path, *name;
+	struct btd_adapter *adapter = data;
+	struct oob_provider *provider;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	name = dbus_message_get_sender(msg);
+
+	provider = find_provider(adapter);
+	if (!provider)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
+						"No provider registered");
+
+	if (!g_str_equal(provider->path, path) ||
+			!g_str_equal(provider->name, name))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
+						"Not a registered provider");
+
+	DBG("OOB provider %s(%s) unregistered", provider->path, provider->name);
+
+	destroy_provider(provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable oob_methods[] = {
+	{ "RegisterProvider",	"o",	"",	register_provider	},
+	{ "UnregisterProvider",	"o",	"",	unregister_provider	},
+	{ "ReadLocalOobData",	"",	"ayay",	read_local_data,
+						G_DBUS_METHOD_FLAG_ASYNC},
+	{ }
+};
+
+static int oob_probe(struct btd_adapter *adapter)
+{
+	const char* path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(connection, path, OOB_MANAGER_INTERFACE,
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
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+							OOB_MANAGER_INTERFACE);
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
+	dbusoob.request_remote_data = request_remote_data;
+	dbusoob.local_data_read = local_data_read;
+	dbusoob.plugin_deactivated = plugin_deactivated;
+
+	return btd_register_adapter_driver(&oob_driver);
+}
+
+static void dbusoob_exit(void)
+{
+	DBG("Cleanup dbusoob plugin");
+	oob_deactivate_plugin(&dbusoob);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(dbusoob, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						dbusoob_init, dbusoob_exit)
-- 
1.7.1

