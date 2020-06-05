Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D781520659
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgFEO2L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:28:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:50946 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgFEO2L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:28:11 -0400
IronPort-SDR: v0JiwPYPa5KD48QQaUnOKF8Geh5JBv0MPRW6Bgbfnn3HmgbT9xB94KC5TnQfV0SAvlJXlOfuLn
 lK9/uHfCK8Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:28:07 -0700
IronPort-SDR: E3z36Gl8Hqtcq/h5fSQ0JaWVoF/yFZoOlO8MmfwSHbcHBQ1jb1E/7YycdlEI3Q7qVmqLm+3lrj
 XNzqOsFvl8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471808327"
Received: from amit-h97m-d3h.iind.intel.com (HELO localhost.localdomain) ([10.223.96.198])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2020 07:28:05 -0700
From:   Amitsi5x <amitx.k.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amitx.k.singh@intel.com
Subject: [PATCH] bluetoothctl: Add support for discover characteristic by uuid
Date:   Fri,  5 Jun 2020 19:55:37 +0530
Message-Id: <20200605142541.28412-1-amitx.k.singh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: amit <amitx.k.singh@intel.com>

Changes made to add support for discovering gatt characteristic
by uuid.

Signed-off-by: amit <amitx.k.singh@intel.com>
---
 client/gatt.c            |  67 +++++++++++++++++++++
 client/gatt.h            |   1 +
 client/main.c            |  17 ++++++
 src/gatt-client.c        |  69 +++++++++++++++++++++
 src/shared/gatt-client.c | 125 +++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h |   8 +++
 6 files changed, 287 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 21e251d2e..53f875050 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -681,6 +681,73 @@ void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void charbyuuid_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+	DBusMessageIter iter, array;
+	uint8_t *value;
+	int len;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to read: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	dbus_message_iter_init(message, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		bt_shell_printf("Invalid response to read\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	if (len < 0) {
+		bt_shell_printf("Unable to parse value\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void charbyuuid_setup(DBusMessageIter *iter, void *user_data)
+{
+	char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+}
+
+static void charbyuuid_attribute(GDBusProxy *proxy, char *uuid)
+{
+	if (g_dbus_proxy_method_call(proxy, "CharByUUID", charbyuuid_setup, charbyuuid_reply,
+						uuid, NULL) == FALSE) {
+		bt_shell_printf("Failed to set uuid\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to read service handle %s\n", g_dbus_proxy_get_path(proxy));
+}
+
+void gatt_charbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[])
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(iface, "org.bluez.GattCharacteristic1")) {
+		charbyuuid_attribute(proxy, argv[1]);
+		return;
+	}
+
+	bt_shell_printf("Unable to read attribute %s\n",
+						g_dbus_proxy_get_path(proxy));
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void servbyuuid_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
diff --git a/client/gatt.h b/client/gatt.h
index 8757d6b48..692fb5758 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -34,6 +34,7 @@ void gatt_list_attributes(const char *device);
 GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
 char *gatt_attribute_generator(const char *text, int state);
 void gatt_servbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
+void gatt_charbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
diff --git a/client/main.c b/client/main.c
index 79a08728b..10e64e17b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2071,6 +2071,21 @@ static void cmd_attribute_info(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_char_by_uuid(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = find_attribute(argc, argv);
+	set_default_attribute(proxy);
+
+	if (!default_attr) {
+		bt_shell_printf("No attribute selected\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	gatt_charbyuuid_attribute(default_attr, argc, argv);
+}
+
 static void cmd_primary_by_uuid(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -2701,6 +2716,8 @@ static const struct bt_shell_menu gatt_menu = {
 				"List attributes", dev_generator },
 	{ "primary-by-uuid", "[UUID]", cmd_primary_by_uuid,
 				"Discover Primary Services by UUID" },
+	{ "char-by-uuid", "[UUID]", cmd_char_by_uuid,
+				"Discover Characteristic Services by UUID" },
 	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
diff --git a/src/gatt-client.c b/src/gatt-client.c
index daedae939..da811ea4f 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -444,6 +444,27 @@ static struct async_dbus_op *async_dbus_op_new(DBusMessage *msg, void *data)
 	return op;
 }
 
+static struct async_dbus_op *fetch_char_by_uuid(struct bt_gatt_client *gatt,
+					DBusMessage *msg,
+					char *uuid,
+					bt_gatt_client_char_by_uuid_callback_t callback,
+					void *data)
+{
+	struct async_dbus_op *op;
+
+	op = async_dbus_op_new(msg, data);
+	op->id = bt_gatt_client_char_by_uuid(gatt, uuid, callback,
+						async_dbus_op_ref(op),
+						async_dbus_op_unref);
+
+	if (op->id)
+		return op;
+
+	async_dbus_op_free(op);
+
+	return NULL;
+}
+
 static struct async_dbus_op *fetch_service_by_uuid(struct bt_gatt_client *gatt,
 					DBusMessage *msg,
 					char *uuid,
@@ -951,6 +972,51 @@ fail:
 	chrc->read_op = NULL;
 }
 
+static void characteristic_by_uuid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	struct characteristic *opchar = op->data;
+
+	if (!success)
+		goto fail;
+
+	async_dbus_op_reply(op, att_ecode, value, length);
+
+	return;
+
+fail:
+	async_dbus_op_reply(op, att_ecode, NULL, 0);
+	opchar->type_op = NULL;
+}
+
+static DBusMessage *chardiscover_by_uuid(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct characteristic *chardata = user_data;
+	struct bt_gatt_client *gatt = chardata->service->client->gatt;
+	DBusMessageIter iter;
+
+	char *uuid = 0;
+
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING)
+		dbus_message_iter_get_basic(&iter,&uuid);
+	else
+		return NULL;
+
+	chardata->type_op = fetch_char_by_uuid(gatt, msg,uuid, characteristic_by_uuid_cb, chardata);
+
+	if (!chardata->type_op)
+		return btd_error_failed(msg, "Failed to send read request");
+
+	return NULL;
+}
+
 static void serv_uuid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -1717,6 +1783,9 @@ static const GDBusPropertyTable characteristic_properties[] = {
 };
 
 static const GDBusMethodTable characteristic_methods[] = {
+	{ GDBUS_ASYNC_METHOD("CharByUUID", GDBUS_ARGS({ "options", "s" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					chardiscover_by_uuid) },
 	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "value", "ay" }),
 					characteristic_read_value) },
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 88257c054..8a696c77f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -131,6 +131,13 @@ struct request {
 	void (*destroy)(void *);
 };
 
+struct char_by_uuid_op
+{
+	bt_gatt_client_char_by_uuid_callback_t callback;
+	bt_gatt_client_destroy_func_t destroy;
+	void *user_data;
+};
+
 struct service_by_uuid_op
 {
 	bt_gatt_client_service_by_uuid_callback_t callback;
@@ -2585,6 +2592,16 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
 	return true;
 }
 
+static void destroy_char_by_uuid_op(void *data)
+{
+	struct char_by_uuid_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op);
+}
+
 static void destroy_service_by_uuid_op(void *data)
 {
 	struct service_by_uuid_op *op = data;
@@ -2595,6 +2612,39 @@ static void destroy_service_by_uuid_op(void *data)
 	free(op);
 }
 
+static void char_by_uuid_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct request *req = user_data;
+	struct char_by_uuid_op *op = req->data;
+	bool success;
+
+	uint8_t att_ecode = 0;
+	const uint8_t *value = NULL;
+	uint16_t value_len = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || (!pdu && length)) {
+		success = false;
+		goto done;
+	}
+
+	success = true;
+	value_len = length;
+
+	if (value_len)
+		value = pdu;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, value, length, op->user_data);
+}
+
 static void service_by_uuid_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
@@ -2675,6 +2725,81 @@ done:
 		op->callback(success, att_ecode, value, length, op->user_data);
 }
 
+unsigned int bt_gatt_client_char_by_uuid(struct bt_gatt_client *client,
+                                              char *uuid,
+                                              bt_gatt_client_char_by_uuid_callback_t callback,
+					      void *user_data,
+                                              bt_gatt_client_destroy_func_t destroy)
+{
+	struct request *req;
+	struct char_by_uuid_op *op;
+	unsigned char *pdu;
+	uint16_t len ;
+	uint16_t start_handle = 0x0001;
+	uint16_t end_handle = 0xffff;
+	bt_uuid_t btuuid;
+	uint8_t uuid128[16];
+
+	/* Length of pdu will be vary according to uuid type
+	for 2 byte uuid total length  is 8 (start handle(2) + end handle(2)  + uuid(2))
+	for 16 byte uuid total length  is 22 (start handle(2) + end handle(2)  + uuid(16))
+	*/
+	uint16_t pdu_len_16bit_uuid = 6;
+	uint16_t pdu_len_128bit_uuid = 20;
+
+	if (bt_string_to_uuid(&btuuid, uuid) < 0) {
+		return 0;
+	}
+
+	if (btuuid.type == BT_UUID16){
+		pdu = (unsigned char *) malloc(pdu_len_16bit_uuid);
+		len = pdu_len_16bit_uuid;
+	} else {
+		pdu = (unsigned char *) malloc(pdu_len_128bit_uuid);
+		len = pdu_len_128bit_uuid;
+	}
+
+	if (!client)
+		return 0;
+
+	op = new0(struct char_by_uuid_op, 1);
+	req = request_create(client);
+
+	if (!req) {
+		free(op);
+		return 0;
+	}
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+	req->data = op;
+	req->destroy = destroy_char_by_uuid_op;
+
+	put_le16(start_handle, pdu);
+	put_le16(end_handle, pdu+2);
+
+	if (btuuid.type == BT_UUID16)
+		put_le16(btuuid.value.u16, pdu+4);
+	else {
+		for (int i =0 ; i<16 ; i++)
+			uuid128[15-i]=btuuid.value.u128.data[i];
+		memcpy(pdu + 4, uuid128, 16);
+	}
+
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+							pdu, len,
+							char_by_uuid_cb, req,
+							request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
 unsigned int bt_gatt_client_service_by_uuid(struct bt_gatt_client *client,
 						char *uuid,
 						bt_gatt_client_service_by_uuid_callback_t callback,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 599e98556..f5d5169ce 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -45,6 +45,9 @@ typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_gatt_client_service_by_uuid_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
+typedef void (*bt_gatt_client_char_by_uuid_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
 typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
@@ -89,6 +92,11 @@ unsigned int bt_gatt_client_service_by_uuid(struct bt_gatt_client *client,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+unsigned int bt_gatt_client_char_by_uuid(struct bt_gatt_client *client,
+					char *uuid,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
 unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
-- 
2.17.1

