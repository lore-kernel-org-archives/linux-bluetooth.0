Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] neard: Append hash/randomizer in EIR only if remote provided it
Date: Mon, 19 Nov 2012 16:03:58 +0100
Message-ID: <1353337438-21865-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
References: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read local OOB data for RequestOOB reply only if remote also provided
hash and randomizer in EIR. This will allow for faster reply when only
discovery is done OOB. It is also required to pass NFC handover test
related to Bluetooth just-works pairing.
---
 plugins/neard.c |   89 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 4627f52..f8d023c 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -158,6 +158,46 @@ unregister:
 							AGENT_INTERFACE);
 }
 
+static DBusMessage *create_request_oob_reply(struct btd_adapter *adapter,
+							uint8_t *hash,
+							uint8_t *randomizer,
+							DBusMessage *msg)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	uint8_t eir[NFC_OOB_EIR_MAX];
+	uint8_t *peir = eir;
+	int len;
+
+	len = eir_create_oob(adapter_get_address(adapter),
+				btd_adapter_get_name(adapter),
+				btd_adapter_get_class(adapter), hash,
+				randomizer, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version,
+				main_opts.did_source,
+				btd_adapter_get_services(adapter), eir);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+				&dict);
+
+	dict_append_array(&dict, "EIR", DBUS_TYPE_BYTE, &peir, len);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
 					uint8_t *randomizer, void *user_data)
 {
@@ -177,39 +217,10 @@ static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
 		return;
 	}
 
-	if (hash && randomizer) {
-		int len;
-		uint8_t eir[NFC_OOB_EIR_MAX];
-		uint8_t *peir = eir;
-		DBusMessageIter iter;
-		DBusMessageIter dict;
-
-		len = eir_create_oob(adapter_get_address(adapter),
-				btd_adapter_get_name(adapter),
-				btd_adapter_get_class(adapter), hash,
-				randomizer, main_opts.did_vendor,
-				main_opts.did_product, main_opts.did_version,
-				main_opts.did_source,
-				btd_adapter_get_services(adapter), eir);
-
-		reply = dbus_message_new_method_return(msg);
-
-		dbus_message_iter_init_append(reply, &iter);
-
-		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-
-		dict_append_array(&dict, "EIR", DBUS_TYPE_BYTE, &peir, len);
-
-		dbus_message_iter_close_container(&iter, &dict);
-
-	} else {
+	if (hash && randomizer)
+		reply = create_request_oob_reply(adapter, hash, randomizer, msg);
+	else
 		reply = error_reply(msg, EIO);
-	}
 
 	dbus_message_unref(msg);
 
@@ -273,7 +284,7 @@ static int check_device(struct btd_adapter *adapter, const char *address)
 	return 0;
 }
 
-/* returns 1 if pairing is not needed */
+/* returns 1 if action (pairing or reading local data) is not needed */
 static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 							bdaddr_t *remote)
 {
@@ -317,9 +328,16 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 	if (remote)
 		bacpy(remote, &eir_data.addr);
 
+	/*
+	 * In RequestOOB reply append local hash and randomizer only if
+	 * received EIR also contained it.
+	 */
+	if (!remote && !eir_data.hash)
+		ret = 1;
+
 	eir_data_free(&eir_data);
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -651,6 +669,9 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	if (ret < 0)
 		return error_reply(msg, -ret);
 
+	if (ret == 1)
+		return create_request_oob_reply(adapter, NULL, NULL, msg);
+
 	ret = btd_adapter_read_local_oob_data(adapter);
 	if (ret < 0)
 		return error_reply(msg, -ret);
-- 
1.7.9.5

