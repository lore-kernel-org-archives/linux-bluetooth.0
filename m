Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA695C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E420659
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFEO2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:28:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:50946 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgFEO2L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:28:11 -0400
IronPort-SDR: +Z3TZGgFeHexTJNzvfYU/loD7WYZqSdmRr5hhv5yYmDlwCDRUcuMEsK9NC6OifieSXeuYlCU+D
 6N5ji+X+xo4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:28:09 -0700
IronPort-SDR: D0ST8XI8ZhTWtUmWkW418DOz0LDjNkMOLZxntTLXJjefzjaqKhdrPUEw4IgQC+8KzY/0hPD1oN
 jySWxZL4uk8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471808341"
Received: from amit-h97m-d3h.iind.intel.com (HELO localhost.localdomain) ([10.223.96.198])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2020 07:28:07 -0700
From:   Amitsi5x <amitx.k.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amitx.k.singh@intel.com
Subject: [PATCH] bluetoothctl:Add support for discover service by uuid
Date:   Fri,  5 Jun 2020 19:55:38 +0530
Message-Id: <20200605142541.28412-2-amitx.k.singh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605142541.28412-1-amitx.k.singh@intel.com>
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: amit <amitx.k.singh@intel.com>

Changes made to add support for discovering gatt service
by uuid in bluetoothctl.

Signed-off-by: amit <amitx.k.singh@intel.com>
---
 client/gatt.c            |  70 ++++++++++++++++++++++
 client/gatt.h            |   2 +-
 client/main.c            |  17 ++++++
 src/gatt-client.c        |  79 +++++++++++++++++++++++-
 src/shared/gatt-client.c | 126 +++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h |   8 +++
 6 files changed, 298 insertions(+), 4 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index e5bab6dd0..21e251d2e 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -681,6 +681,76 @@ void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void servbyuuid_reply(DBusMessage *message, void *user_data)
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
+
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
+	bt_shell_hexdump(value, len);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void servbyuuid_setup(DBusMessageIter *iter, void *user_data)
+{
+	char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+}
+
+static void servbyuuid_attribute(GDBusProxy *proxy, char *uuid)
+{
+	if (g_dbus_proxy_method_call(proxy, "ServiceByUUID", servbyuuid_setup, servbyuuid_reply,
+						uuid, NULL) == FALSE) {
+		bt_shell_printf("Failed to set uuid\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to read service handle %s\n", g_dbus_proxy_get_path(proxy));
+}
+
+void gatt_servbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[])
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(iface, "org.bluez.GattService1")) {
+		servbyuuid_attribute(proxy, argv[1]);
+		return;
+	}
+
+	bt_shell_printf("Unable to read attribute %s\n",
+						g_dbus_proxy_get_path(proxy));
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void write_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
diff --git a/client/gatt.h b/client/gatt.h
index 09ca618d3..8757d6b48 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -33,7 +33,7 @@ void gatt_remove_descriptor(GDBusProxy *proxy);
 void gatt_list_attributes(const char *device);
 GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
 char *gatt_attribute_generator(const char *text, int state);
-
+void gatt_servbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
diff --git a/client/main.c b/client/main.c
index 422da5593..79a08728b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2071,6 +2071,21 @@ static void cmd_attribute_info(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_primary_by_uuid(int argc, char *argv[])
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
+	gatt_servbyuuid_attribute(default_attr, argc, argv);
+}
+
 static void cmd_read(int argc, char *argv[])
 {
 	if (!default_attr) {
@@ -2684,6 +2699,8 @@ static const struct bt_shell_menu gatt_menu = {
 	.entries = {
 	{ "list-attributes", "[dev/local]", cmd_list_attributes,
 				"List attributes", dev_generator },
+	{ "primary-by-uuid", "[UUID]", cmd_primary_by_uuid,
+				"Discover Primary Services by UUID" },
 	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2ae258da0..daedae939 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -81,6 +81,7 @@ struct service {
 	char *path;
 	struct queue *chrcs;
 	struct queue *incl_services;
+	struct async_dbus_op *type_op;
 };
 
 typedef bool (*async_dbus_op_complete_t)(void *data);
@@ -118,7 +119,7 @@ struct characteristic {
 
 	struct async_dbus_op *read_op;
 	struct async_dbus_op *write_op;
-
+	struct async_dbus_op *type_op;
 	struct queue *descs;
 
 	bool notifying;
@@ -440,10 +441,30 @@ static struct async_dbus_op *async_dbus_op_new(DBusMessage *msg, void *data)
 	op->msgs = queue_new();
 	queue_push_tail(op->msgs, dbus_message_ref(msg));
 	op->data = data;
-
 	return op;
 }
 
+static struct async_dbus_op *fetch_service_by_uuid(struct bt_gatt_client *gatt,
+					DBusMessage *msg,
+					char *uuid,
+					bt_gatt_client_service_by_uuid_callback_t callback,
+					void *data)
+{
+	struct async_dbus_op *op;
+
+	op = async_dbus_op_new(msg, data);
+	op->id = bt_gatt_client_service_by_uuid(gatt, uuid, callback,
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
 static struct async_dbus_op *read_value(struct bt_gatt_client *gatt,
 					DBusMessage *msg, uint16_t handle,
 					uint16_t offset,
@@ -930,6 +951,51 @@ fail:
 	chrc->read_op = NULL;
 }
 
+static void serv_uuid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	struct service *serv = op->data;
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
+	serv->type_op = NULL;
+}
+
+static DBusMessage *service_by_uuid(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct service *serv = user_data;
+	struct bt_gatt_client *gatt = serv->client->gatt;
+	DBusMessageIter iter;
+	char *uuid;
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
+	serv->type_op = fetch_service_by_uuid(gatt, msg, uuid,
+							serv_uuid_cb, serv);
+
+	if (!serv->type_op)
+		return btd_error_failed(msg, "Failed to send service by uuid");
+
+	return NULL;
+}
+
 static DBusMessage *characteristic_read_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1845,6 +1911,13 @@ static const GDBusPropertyTable service_properties[] = {
 	{ }
 };
 
+static const GDBusMethodTable service_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ServiceByUUID", GDBUS_ARGS({ "options", "s" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					service_by_uuid) },
+	{ }
+};
+
 static void service_free(void *data)
 {
 	struct service *service = data;
@@ -1878,7 +1951,7 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(), service->path,
 						GATT_SERVICE_IFACE,
-						NULL, NULL,
+						service_methods, NULL,
 						service_properties,
 						service, service_free)) {
 		error("Unable to register GATT service with handle 0x%04x for "
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3cb6ae443..88257c054 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -131,6 +131,13 @@ struct request {
 	void (*destroy)(void *);
 };
 
+struct service_by_uuid_op
+{
+	bt_gatt_client_service_by_uuid_callback_t callback;
+	bt_gatt_client_destroy_func_t destroy;
+	void *user_data;
+};
+
 static struct request *request_ref(struct request *req)
 {
 	__sync_fetch_and_add(&req->ref_count, 1);
@@ -2578,6 +2585,49 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
 	return true;
 }
 
+static void destroy_service_by_uuid_op(void *data)
+{
+	struct service_by_uuid_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op);
+}
+
+static void service_by_uuid_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct request *req = user_data;
+	struct service_by_uuid_op *op = req->data;
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
+	if (opcode != BT_ATT_OP_FIND_BY_TYPE_RSP || (!pdu && length)) {
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
 struct read_op {
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
@@ -2625,6 +2675,82 @@ done:
 		op->callback(success, att_ecode, value, length, op->user_data);
 }
 
+unsigned int bt_gatt_client_service_by_uuid(struct bt_gatt_client *client,
+						char *uuid,
+						bt_gatt_client_service_by_uuid_callback_t callback,
+						void *user_data,
+						bt_gatt_client_destroy_func_t destroy)
+{
+	struct request *req;
+	struct service_by_uuid_op *op;
+	unsigned char *pdu;
+	uint16_t len ;
+	uint16_t start_handle = 0x0001;
+	uint16_t end_handle = 0xffff;
+	uint16_t primart_uuid = GATT_PRIM_SVC_UUID;
+	bt_uuid_t btuuid;
+	uint8_t uuid128[16];
+
+	/* Length of pdu will be vary according to uuid type
+	for 2 byte uuid total length  is 8 (start handle(2) + end handle(2) + type(2) + uuid(2))
+	for 16 byte uuid total length  is 22 (start handle(2) + end handle(2) + type(2) + uuid(16))
+	*/
+	uint16_t pdu_len_16bit_uuid = 8;
+	uint16_t pdu_len_128bit_uuid = 22;
+
+	if (bt_string_to_uuid(&btuuid, uuid) < 0) {
+		return 0;
+	}
+
+	if (btuuid.type == BT_UUID16){
+		pdu = (unsigned char *) malloc(pdu_len_16bit_uuid);
+		len = pdu_len_16bit_uuid;
+	}
+	else {
+		pdu = (unsigned char *) malloc(pdu_len_128bit_uuid);
+		len = pdu_len_128bit_uuid;
+	}
+	if (!client)
+		return 0;
+	op = new0(struct service_by_uuid_op, 1);
+	req = request_create(client);
+	if (!req) {
+		free(op);
+		return 0;
+	}
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+	req->data = op;
+	req->destroy = destroy_service_by_uuid_op;
+
+	put_le16(start_handle, pdu);
+	put_le16(end_handle, pdu+2);
+	put_le16(primart_uuid, pdu+4);
+
+	/* Checking uuid type 16 bit or 128 bit , conversion as required*/
+	if (btuuid.type == BT_UUID16)
+		put_le16(btuuid.value.u16, pdu+6);
+	else {
+		bswap_128(&btuuid.value.u128.data[0], &uuid128[0]);
+		memcpy(pdu + 6, uuid128, 16);
+	}
+
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_FIND_BY_TYPE_REQ,
+							pdu, len,
+							service_by_uuid_cb, req,
+							request_unref);
+
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
 unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 10900168b..599e98556 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -42,6 +42,9 @@ typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_gatt_client_service_by_uuid_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
 typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
@@ -81,6 +84,11 @@ uint8_t bt_gatt_client_get_features(struct bt_gatt_client *client);
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id);
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client);
 
+unsigned int bt_gatt_client_service_by_uuid(struct bt_gatt_client *client,
+					char *uuid,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
 unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
-- 
2.17.1

