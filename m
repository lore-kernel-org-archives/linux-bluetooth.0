Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 09/13] shared/gatt-client: Implement initial service discovery.
Date: Thu, 28 Aug 2014 14:25:21 -0700
Message-Id: <1409261125-6673-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1409261125-6673-1-git-send-email-armansito@chromium.org>
References: <1409261125-6673-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code implements the following portion of attribute discovery:

  - Initial MTU exchange.
  - Primary service discovery.

Discovery results aren't stored yet.
---
 src/shared/gatt-client.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7c2b7c6..7a76234 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -23,17 +23,168 @@
 
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
 	int ref_count;
 
+	bt_gatt_client_callback_t ready_callback;
+	bt_gatt_client_destroy_func_t ready_destroy;
+	void *ready_data;
+
 	bt_gatt_client_debug_func_t debug_callback;
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bool in_init;
+};
+
+struct async_op {
+	struct bt_gatt_client *client;
+	int ref_count;
 };
 
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
+	if (client->ready_callback)
+		client->ready_callback(success, att_ecode, client->ready_data);
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
+		if (client->ready_callback)
+			client->ready_callback(success, att_ecode,
+							client->ready_data);
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
+	if (client->ready_callback)
+		client->ready_callback(success, att_ecode, client->ready_data);
+
+	async_op_unref(op);
+}
+
+static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
+{
+	struct async_op *op;
+
+	if (client->in_init)
+		return false;
+
+	op = new0(struct async_op, 1);
+	if (!op)
+		return false;
+
+	op->client = client;
+
+	/* Configure the MTU */
+	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
+							exchange_mtu_cb,
+							async_op_ref(op),
+							async_op_unref)) {
+		if (client->ready_callback)
+			client->ready_callback(false, 0, client->ready_data);
+
+		free(op);
+	}
+
+	client->in_init = true;
+
+	return true;
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_gatt_client *client;
@@ -47,7 +198,7 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 
 	client->att = bt_att_ref(att);
 
-	/* TODO: Initiate MTU exchange and service discovery. */
+	gatt_client_init(client, mtu);
 
 	return bt_gatt_client_ref(client);
 }
@@ -70,6 +221,9 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	if (__sync_sub_and_fetch(&client->ref_count, 1))
 		return;
 
+	if (client->ready_destroy)
+		client->ready_destroy(client->ready_data);
+
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
 
@@ -82,7 +236,17 @@ bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
-	/* TODO */
+	if (!client)
+		return false;
+
+	if (client->ready_destroy)
+		client->ready_destroy(client->ready_data);
+
+	client->ready_callback = callback;
+	client->ready_destroy = destroy;
+	client->ready_data = user_data;
+
+	return true;
 }
 
 bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
-- 
2.1.0.rc2.206.gedb03e5

