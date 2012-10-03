Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 17/18] neard: Implement PushOOB function
Date: Wed, 3 Oct 2012 15:18:30 +0200
Message-ID: <1349270311-31103-18-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements PushOOB function which allows neard to pass data used
for discovery and pairing. Only EIR data type is supported.

---
 plugins/neard.c |  254 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 247 insertions(+), 7 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index b98c0fe..d44e5c2 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -36,6 +36,11 @@
 #include "log.h"
 #include "dbus-common.h"
 #include "adapter.h"
+#include "manager.h"
+#include "device.h"
+#include "eir.h"
+#include "storage.h"
+#include "agent.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
@@ -46,11 +51,31 @@
 
 static guint watcher_id = 0;
 static gboolean agent_registered = FALSE;
+static gboolean agent_register_postpone = FALSE;
 
-static DBusMessage *error_failed(DBusMessage *msg, int error)
+static DBusMessage *error_reply(DBusMessage *msg, int error)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+	switch (error) {
+	case ENOTSUP:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotSupported",
+						"Operation is not supported");
+
+	case ENOENT:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".NoSuchDevice",
+							"No such device");
+
+	case EINPROGRESS:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+						"Operation already in progress");
+
+	case ENONET:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Disabled",
+							"Device disabled");
+
+	default:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 							"%s", strerror(error));
+	}
 }
 
 static void register_agent_cb(DBusPendingCall *call, void *user_data)
@@ -128,12 +153,216 @@ unregister:
 							AGENT_INTERFACE);
 }
 
-static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg,
-							void *user_data)
+static void bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+					uint8_t status, void *user_data)
+{
+	DBusMessage *msg = user_data;
+	DBusMessage *reply;
+
+	DBG("");
+
+	if (!agent_registered) {
+		dbus_message_unref(msg);
+
+		if (agent_register_postpone) {
+			agent_register_postpone = FALSE;
+			register_agent();
+		}
+
+		return;
+	}
+
+	if (status)
+		reply = error_reply(msg, EIO);
+	else
+		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	dbus_message_unref(msg);
+
+	if (!g_dbus_send_message(btd_get_dbus_connection(), reply))
+		error("D-Bus send failed");
+}
+
+/* returns 1 if pairing is not needed */
+static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
+							bdaddr_t *remote)
+{
+	struct btd_device *device;
+	struct eir_data eir_data;
+	bdaddr_t local;
+	char remote_address[18];
+
+	DBG("size %zu", size);
+
+	memset(&eir_data, 0, sizeof(eir_data));
+
+	if (eir_parse_oob(&eir_data, eir, size) < 0)
+		return -EINVAL;
+
+	ba2str(&eir_data.addr, remote_address);
+
+	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
+
+	device = adapter_find_device(adapter, remote_address);
+
+	/* If already paired do nothing */
+	if (device && device_is_paired(device)) {
+		DBG("already paired");
+		eir_data_free(&eir_data);
+		return 1;
+	}
+
+	/* Pairing in progress... */
+	if (device && device_is_bonding(device, NULL)) {
+		DBG("pairing in progress");
+		eir_data_free(&eir_data);
+		return -EINPROGRESS;
+	}
+
+	/* If we have unpaired device hanging around, purge it */
+	if (device)
+		adapter_remove_device(adapter, device, TRUE);
+
+	adapter_get_address(adapter, &local);
+
+	/* store OOB data */
+	if (eir_data.class != 0)
+		write_remote_class(&local, &eir_data.addr, eir_data.class);
+
+	/* TODO handle incomplete name? */
+	if (eir_data.name)
+		write_device_name(&local, &eir_data.addr, BDADDR_BREDR,
+								eir_data.name);
+
+	if (eir_data.hash)
+		btd_adapter_add_remote_oob_data(adapter, &eir_data.addr,
+					eir_data.hash, eir_data.randomizer);
+
+	/* TODO handle UUIDs? */
+
+	if (remote)
+		bacpy(remote, &eir_data.addr);
+
+	eir_data_free(&eir_data);
+
+	return 0;
+}
+
+static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
+							bdaddr_t *remote)
 {
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessageIter value;
+	DBusMessageIter entry;
+	const char *key;
+	int type;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	type = dbus_message_iter_get_arg_type(&dict);
+	if (type != DBUS_TYPE_DICT_ENTRY) {
+		if (!remote && type == DBUS_TYPE_INVALID)
+			return 1;
+
+		return -EINVAL;
+	}
+
+	dbus_message_iter_recurse(&dict, &entry);
+
+	if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+		return -EINVAL;
+
+	dbus_message_iter_get_basic(&entry, &key);
+	dbus_message_iter_next(&entry);
+
+	dbus_message_iter_recurse(&entry, &value);
+
+	/* All keys have byte array type values */
+	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	if (strcasecmp(key, "EIR") == 0) {
+		DBusMessageIter array;
+		uint8_t *eir;
+		int size;
+
+		dbus_message_iter_recurse(&value, &array);
+		dbus_message_iter_get_fixed_array(&array, &eir, &size);
+
+		return process_eir(adapter, eir, size, remote);
+	} else if (strcasecmp(key, "nokia.com:bt") == 0) {
+		/* TODO add support for Nokia BT 2.0 proprietary stuff */
+		return -ENOTSUP;
+	}
+
+	return -EINVAL;
+}
+
+static int check_adapter(struct btd_adapter *adapter)
+{
+	gboolean pairable;
+
+	if (!adapter)
+		return -ENOENT;
+
+	if (btd_adapter_check_oob_handler(adapter))
+		return -EINPROGRESS;
+
+	btd_adapter_get_mode(adapter, NULL, NULL, NULL, &pairable);
+
+	if (!pairable || !adapter_get_agent(adapter))
+		return -ENOENT;
+
+	if (!btd_adapter_ssp_enabled(adapter))
+		return -ENOTSUP;
+
+	return 0;
+}
+
+static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter;
+	struct agent *agent;
+	struct oob_handler *handler;
+	bdaddr_t remote;
+	int ret;
+
 	DBG("");
 
-	return error_failed(msg, ENOTSUP);
+	adapter = manager_get_default_adapter();
+	ret = check_adapter(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	ret = process_params(msg, adapter, &remote);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	/* already paired, reply immediately */
+	if (ret > 0)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	agent = adapter_get_agent(adapter);
+
+	ret = adapter_create_bonding(adapter, &remote, BDADDR_BREDR,
+					agent_get_io_capability(agent));
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	handler = g_new0(struct oob_handler, 1);
+	handler->bonding_cb = bonding_complete;
+	bacpy(&handler->remote_addr, &remote);
+	handler->user_data = dbus_message_ref(msg);
+
+	btd_adapter_set_oob_handler(adapter, handler);
+
+	return NULL;
 }
 
 static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
@@ -141,7 +370,7 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 {
 	DBG("");
 
-	return error_failed(msg, ENOTSUP);
+	return error_reply(msg, ENOTSUP);
 }
 
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
@@ -167,6 +396,8 @@ static const GDBusMethodTable neard_methods[] = {
 
 static void neard_appeared(DBusConnection *conn, void *user_data)
 {
+	struct btd_adapter *adapter;
+
 	DBG("");
 
 	if (!g_dbus_register_interface(conn, AGENT_PATH, AGENT_INTERFACE,
@@ -176,7 +407,16 @@ static void neard_appeared(DBusConnection *conn, void *user_data)
 		return;
 	}
 
-	register_agent();
+	/*
+	 * If there is pending action ongoing when neard appeared, possibly
+	 * due to neard crash or release before action was completed, postpone
+	 * register until action is finished.
+	 */
+	adapter = manager_get_default_adapter();
+	if (adapter && btd_adapter_check_oob_handler(adapter))
+		agent_register_postpone = TRUE;
+	else
+		register_agent();
 }
 
 static void neard_vanished(DBusConnection *conn, void *user_data)
-- 
1.7.9.5

