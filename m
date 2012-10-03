Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 18/18] neard: Implement RequestOOB function
Date: Wed, 3 Oct 2012 15:18:31 +0200
Message-ID: <1349270311-31103-19-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is used by neard to request data to be transmitted over
OOB channel. It also allows neard to provide data to be used in OOB
pairing without initializing pairing it self.

---
 plugins/neard.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index d44e5c2..632d454 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -41,6 +41,7 @@
 #include "eir.h"
 #include "storage.h"
 #include "agent.h"
+#include "hcid.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
@@ -53,6 +54,9 @@ static guint watcher_id = 0;
 static gboolean agent_registered = FALSE;
 static gboolean agent_register_postpone = FALSE;
 
+/* For NFC mimetype limits max OOB EIR size */
+#define NFC_OOB_EIR_MAX UINT8_MAX
+
 static DBusMessage *error_reply(DBusMessage *msg, int error)
 {
 	switch (error) {
@@ -153,6 +157,67 @@ unregister:
 							AGENT_INTERFACE);
 }
 
+static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
+					uint8_t *randomizer, void *user_data)
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
+	if (hash && randomizer) {
+		int len;
+		uint8_t eir[NFC_OOB_EIR_MAX];
+		uint8_t *peir = eir;
+		bdaddr_t addr;
+		DBusMessageIter iter;
+		DBusMessageIter dict;
+
+		adapter_get_address(adapter, &addr);
+
+		len = eir_create_oob(&addr, btd_adapter_get_name(adapter),
+				btd_adapter_get_class(adapter), hash,
+				randomizer, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version,
+				main_opts.did_source,
+				btd_adapter_get_services(adapter), eir);
+
+		reply = dbus_message_new_method_return(msg);
+
+		dbus_message_iter_init_append(reply, &iter);
+
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+		dict_append_array(&dict, "EIR", DBUS_TYPE_BYTE, &peir, len);
+
+		dbus_message_iter_close_container(&iter, &dict);
+
+	} else {
+		reply = error_reply(msg, EIO);
+	}
+
+	dbus_message_unref(msg);
+
+	if (!g_dbus_send_message(btd_get_dbus_connection(), reply))
+		error("D-Bus send failed");
+}
+
 static void bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint8_t status, void *user_data)
 {
@@ -368,9 +433,32 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
+	struct btd_adapter *adapter;
+	struct oob_handler *handler;
+	int ret;
+
 	DBG("");
 
-	return error_reply(msg, ENOTSUP);
+	adapter = manager_get_default_adapter();
+	ret = check_adapter(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	ret = process_params(msg, adapter, NULL);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	ret = btd_adapter_read_local_oob_data(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	handler = g_new0(struct oob_handler, 1);
+	handler->read_local_cb = read_local_complete;
+	handler->user_data = dbus_message_ref(msg);
+
+	btd_adapter_set_oob_handler(adapter, handler);
+
+	return NULL;
 }
 
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.9.5

