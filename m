Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 08/11] shared/gatt-client: Implement initial service discovery.
Date: Wed, 20 Aug 2014 13:15:34 -0700
Message-Id: <1408565737-8187-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1408565737-8187-1-git-send-email-armansito@chromium.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code implements the following portion of attribute discovery:

  - Initial MTU exchange.
  - Primary service discovery.

Discovery results aren't stored yet.
---
 src/shared/TODO          |   1 -
 src/shared/gatt-client.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-client.h |   3 +-
 3 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/src/shared/TODO b/src/shared/TODO
index d59e153..6f51890 100644
--- a/src/shared/TODO
+++ b/src/shared/TODO
@@ -1,7 +1,6 @@
 TODOs for shared/gatt-client
 
 * Add high-level abstraction for services, characteristics, and descriptors.
-* Implement service discovery.
 * Implement characteristic discovery.
 * Implement descriptor discovery.
 * Handle request timeouts.
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a0d85e3..a46ff4e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -23,8 +23,14 @@
 
 #include "src/shared/att.h"
 #include "src/shared/gatt-client.h"
+#include "lib/uuid.h"
+#include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
 
+#ifndef MAX
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
 struct bt_gatt_client {
 	struct bt_att *att;
 	bool persist;
@@ -32,6 +38,8 @@ struct bt_gatt_client {
 	bt_gatt_client_debug_func_t debug_callback;
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bool in_init;
 };
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att)
@@ -97,12 +105,153 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 
 	return true;
 }
+
+struct async_op {
+	struct bt_gatt_client *client;
+	int ref_count;
+	bt_gatt_client_callback_t callback;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+static struct async_op *async_op_ref(struct async_op *op)
+{
+	__sync_fetch_and_add(&op->ref_count, 1);
+
+	return op;
+}
+
+static void async_op_unref(void *data)
+{
+	struct async_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(data);
+}
+
+static void discover_primary_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct async_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	struct bt_gatt_iter iter;
+	uint16_t start, end;
+	uint8_t uuid[16];
+	char uuid_str[MAX_LEN_UUID_STR];
+	bt_uuid_t tmp;
+
+	if (!success) {
+		util_debug(client->debug_callback, client->debug_data,
+					"Primary service discovery failed."
+					" ATT ECODE: 0x%02x", att_ecode);
+		goto done;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result)) {
+		success = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	util_debug(client->debug_callback, client->debug_data,
+					"Primary services found: %u",
+					bt_gatt_result_service_count(result));
+
+	while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
+		/* TODO: discover characteristics and store the service. */
+
+		/* Log debug message. */
+		tmp.type = BT_UUID128;
+		memcpy(tmp.value.u128.data, uuid, sizeof(uuid));
+		bt_uuid_to_string(&tmp, uuid_str, sizeof(uuid_str));
+		util_debug(client->debug_callback, client->debug_data,
+				"start: 0x%04x, end: 0x%04x, uuid: %s",
+				start, end, uuid_str);
+	}
+
+done:
+	client->in_init = false;
+
+	if (op->callback)
+		op->callback(success, att_ecode, op->user_data);
+}
+
+static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	struct async_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+
+	if (!success) {
+		util_debug(client->debug_callback, client->debug_data,
+				"MTU Exchange failed. ATT ECODE: 0x%02x",
+				att_ecode);
+
+		client->in_init = false;
+
+		if (op->callback)
+			op->callback(success, att_ecode, op->user_data);
+
+		return;
+	}
+
+	util_debug(client->debug_callback, client->debug_data,
+					"MTU exchange complete, with MTU: %u",
+					bt_att_get_mtu(client->att));
+
+	if (bt_gatt_discover_primary_services(client->att, NULL,
+							discover_primary_cb,
+							async_op_ref(op),
+							async_op_unref))
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+			"Failed to initiate primary service discovery");
+
+	client->in_init = false;
+
+	if (op->callback)
+		op->callback(false, 0, op->user_data);
+
+	async_op_unref(op);
+}
+
 bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
-	// TODO
+	struct async_op *op;
+
+	if (!client || client->in_init)
+		return false;
+
+	op = new0(struct async_op, 1);
+	if (!op)
+		return false;
+
+	op->client = client;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	/* Configure the MTU */
+	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
+							exchange_mtu_cb,
+							async_op_ref(op),
+							async_op_unref)) {
+		free(op);
+		return false;
+	}
+
+	client->in_init = true;
+
+	return true;
 }
 
 unsigned int bt_gatt_client_register_service_changed(
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 4038b1e..7a46cca 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -35,7 +35,8 @@ bool bt_gatt_client_set_persist(struct bt_gatt_client *client,
 struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
 
 typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
-typedef void (*bt_gatt_client_callback_t)(void *user_data);
+typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
+							void *user_data);
 typedef void (*bt_gatt_client_service_changed_func_t)(uint16_t handle,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
-- 
2.1.0.rc2.206.gedb03e5

