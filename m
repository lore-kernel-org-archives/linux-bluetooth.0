Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 07/18] neard: Implement PushOOB function
Date: Fri, 21 Sep 2012 14:36:24 +0200
Message-ID: <1348230995-8967-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements PushOOB function which allows neard to pass data used
for discovery and pairing. Only EIR data type is supported.

---
 plugins/neard.c |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 235 insertions(+), 6 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 3f8d054..dd6a422 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -36,6 +36,12 @@
 #include "log.h"
 #include "dbus-common.h"
 #include "adapter.h"
+#include "manager.h"
+#include "device.h"
+#include "eir.h"
+#include "storage.h"
+#include "agent.h"
+#include "oob.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
@@ -47,10 +53,32 @@
 static guint watcher_id = 0;
 static gboolean agent_registered = FALSE;
 
-static DBusMessage *error_failed(DBusMessage *msg, int error)
+static struct btd_adapter *pending_adapter = NULL;
+static DBusMessage *pending_msg = NULL;
+
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
@@ -128,12 +156,199 @@ unregister:
 							AGENT_INTERFACE);
 }
 
-static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg,
-							void *user_data)
+static void pairing_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+							uint8_t status)
+{
+	DBusMessage *reply;
+	char address[18];
+
+	ba2str(bdaddr, address);
+	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), address);
+
+	if (!pending_adapter || pending_adapter != adapter)
+		return;
+
+	if (status)
+		reply = error_reply(pending_msg, EIO);
+	else
+		reply = g_dbus_create_reply(pending_msg, DBUS_TYPE_INVALID);
+
+	dbus_message_unref(pending_msg);
+	pending_msg = NULL;
+	pending_adapter = NULL;
+
+	if (!g_dbus_send_message(btd_get_dbus_connection(), reply))
+		error("D-Bus send failed");
+}
+
+static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
+								gboolean pair)
+{
+	struct btd_device *device;
+	struct agent *agent;
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
+	eir_data_free(&eir_data);
+
+	if (!pair)
+		return 1;
+
+	agent = adapter_get_agent(adapter);
+
+	return adapter_create_bonding(adapter, &eir_data.addr, BDADDR_BREDR,
+					agent_get_io_capability(agent));
+}
+
+static int process_params(DBusMessageIter *iter, struct btd_adapter *adapter,
+								gboolean pair)
+{
+	DBusMessageIter dict;
+	DBusMessageIter value;
+	DBusMessageIter entry;
+	const char *key;
+	int type;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	type = dbus_message_iter_get_arg_type(&dict);
+	if (type != DBUS_TYPE_DICT_ENTRY) {
+		if (!pair && type == DBUS_TYPE_INVALID)
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
+		return process_eir(adapter, eir, size, TRUE);
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
+	if (pending_adapter)
+		return -EINPROGRESS;
+
+	if (!adapter)
+		return -ENOENT;
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
 {
+	struct btd_adapter *adapter;
+	DBusMessageIter iter;
+	int ret;
+
 	DBG("");
 
-	return error_failed(msg, ENOTSUP);
+	adapter = manager_get_default_adapter();
+	ret = check_adapter(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	dbus_message_iter_init(msg, &iter);
+
+	ret = process_params(&iter, adapter, TRUE);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	/* already paired, reply immediately */
+	if (ret > 0)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	pending_adapter = adapter;
+	pending_msg = dbus_message_ref(msg);
+	return NULL;
 }
 
 static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
@@ -141,7 +356,7 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 {
 	DBG("");
 
-	return error_failed(msg, ENOTSUP);
+	return error_reply(msg, ENOTSUP);
 }
 
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
@@ -189,8 +404,20 @@ static void neard_vanished(DBusConnection *conn, void *user_data)
 		g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
 		agent_registered = FALSE;
 	}
+
+	if (pending_msg) {
+		dbus_message_unref(pending_msg);
+		pending_msg = NULL;
+	}
+
+	pending_adapter = NULL;
 }
 
+static struct oob_handler neard_handler = {
+	.read_local_cb = NULL,
+	.pairing_cb = pairing_complete,
+};
+
 static int neard_init(void)
 {
 	DBG("Setup neard plugin");
@@ -201,6 +428,8 @@ static int neard_init(void)
 	if (watcher_id == 0)
 		return -ENOMEM;
 
+	oob_register_cb(&neard_handler);
+
 	return 0;
 }
 
-- 
1.7.9.5

