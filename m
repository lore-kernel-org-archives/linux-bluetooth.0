Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 18/18] neard: Implement RequestOOB function
Date: Fri, 21 Sep 2012 12:02:30 +0200
Message-ID: <1348221750-15345-19-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is used by neard to request data to be transmitted over
OOB channel. It also allows neard to provide data to be used in OOB
pairing without initializing pairing it self.

---
 plugins/neard.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 630a79b..1b0e029 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -42,6 +42,7 @@
 #include "storage.h"
 #include "agent.h"
 #include "oob.h"
+#include "hcid.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
@@ -59,6 +60,9 @@ static gboolean agent_registered = FALSE;
 static struct btd_adapter *pending_adapter = NULL;
 static DBusMessage *pending_msg = NULL;
 
+/* For NFC mimetype limits max OOB EIR size */
+#define NFC_OOB_EIR_MAX UINT8_MAX
+
 static DBusMessage *error_reply(DBusMessage *msg, int error)
 {
 	switch (error) {
@@ -156,6 +160,60 @@ unregister:
 	g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
 }
 
+static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
+							uint8_t *randomizer)
+{
+	DBusMessage *reply;
+
+	DBG("hci%u", adapter_get_dev_id(adapter));
+
+	if (pending_adapter != adapter)
+		return;
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
+		reply = dbus_message_new_method_return(pending_msg);
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
+		reply = error_reply(pending_msg, EIO);
+	}
+
+	dbus_message_unref(pending_msg);
+	pending_msg = NULL;
+	pending_adapter = NULL;
+
+	if (!g_dbus_send_message(conn, reply))
+		error("D-Bus send failed");
+}
+
 static void pairing_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							uint8_t status)
 {
@@ -293,7 +351,7 @@ static int process_params(DBusMessageIter *iter, struct btd_adapter *adapter,
 		dbus_message_iter_recurse(&value, &array);
 		dbus_message_iter_get_fixed_array(&array, &eir, &size);
 
-		return process_eir(adapter, eir, size, TRUE);
+		return process_eir(adapter, eir, size, pair);
 	} else if (strcasecmp(key, "nokia.com:bt") == 0) {
 		/* TODO add support for Nokia BT 2.0 proprietary stuff */
 		return -ENOTSUP;
@@ -354,9 +412,30 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
+	struct btd_adapter *adapter;
+	DBusMessageIter iter;
+	int ret;
+
 	DBG("");
 
-	return error_reply(msg, ENOTSUP);
+	adapter = manager_get_default_adapter();
+	ret = check_adapter(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	dbus_message_iter_init(msg, &iter);
+
+	ret = process_params(&iter, adapter, FALSE);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	ret = btd_adapter_read_local_oob_data(adapter);
+	if (ret < 0)
+		return error_reply(msg, -ret);
+
+	pending_adapter = adapter;
+	pending_msg = dbus_message_ref(msg);
+	return NULL;
 }
 
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
@@ -419,7 +498,7 @@ static void neard_vanished(DBusConnection *conn, void *user_data)
 }
 
 static struct oob_handler neard_handler = {
-	.read_local_cb = NULL,
+	.read_local_cb = read_local_complete,
 	.pairing_cb = pairing_complete,
 };
 
-- 
1.7.9.5

