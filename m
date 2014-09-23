Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/9] shared/gatt-client: Register "Service Changed" handler as part of init.
Date: Tue, 23 Sep 2014 13:47:11 -0700
Message-Id: <1411505237-10932-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes shared/gatt-client so that a struct bt_gatt_client
registers a handler for indications from the "Service Changed" characteristic
at the end of its init sequence if the characteristic was discovered. The
handles for the Service Changed characteristic value and the GATT service are
stored during discovery.
---
 src/shared/gatt-client.c | 103 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d0c12df..1a6fd86 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -41,6 +41,9 @@
 
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
 
+#define GATT_SVC_UUID	0x1801
+#define SVC_CHNGD_UUID	0x2a05
+
 struct chrc_data {
 	/* The public characteristic entry. */
 	bt_gatt_characteristic_t chrc_external;
@@ -100,6 +103,14 @@ struct bt_gatt_client {
 	unsigned int notify_id, ind_id;
 	bool in_notify;
 	bool need_notify_cleanup;
+
+	/* Handles of the GATT Service and the Service Changed characteristic
+	 * value handle. These will have the value 0 if they are not present on
+	 * the remote peripheral.
+	 */
+	uint16_t gatt_svc_handle;
+	uint16_t svc_chngd_val_handle;
+	unsigned int svc_chngd_ind_id;
 };
 
 static bool service_list_add_service(struct service_list **head,
@@ -387,6 +398,10 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 			goto done;
 		}
 
+		if (uuid_cmp(chrcs[i].chrc_external.uuid, SVC_CHNGD_UUID) == 0)
+			client->svc_chngd_val_handle =
+					chrcs[i].chrc_external.value_handle;
+
 		i++;
 	}
 
@@ -479,6 +494,9 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 			success = false;
 			goto done;
 		}
+
+		if (uuid_cmp(uuid, GATT_SVC_UUID) == 0)
+			client->gatt_svc_handle = start;
 	}
 
 	/* Complete the process if the service list is empty */
@@ -544,20 +562,95 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	discovery_op_unref(op);
 }
 
+static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	uint16_t start, end;
+
+	if (value_handle != client->svc_chngd_val_handle || length != 4)
+		return;
+
+	start = get_le16(value);
+	end = get_le16(value + 2);
+
+	util_debug(client->debug_callback, client->debug_data,
+			"Service Changed received - start: 0x%04x end: 0x%04x",
+			start, end);
+
+	/* TODO: Process changed services */
+}
+
+static void service_changed_register_cb(unsigned int id, uint16_t att_ecode,
+								void *user_data)
+{
+	bool success;
+	struct bt_gatt_client *client = user_data;
+
+	if (!id || att_ecode) {
+		util_debug(client->debug_callback, client->debug_data,
+			"Failed to register handler for \"Service Changed\"");
+		success = false;
+		goto done;
+	}
+
+	client->svc_chngd_ind_id = id;
+	client->ready = true;
+	success = true;
+	util_debug(client->debug_callback, client->debug_data,
+			"Registered handler for \"Service Changed\": %u", id);
+
+done:
+	if (client->ready_callback)
+		client->ready_callback(success, att_ecode, client->ready_data);
+}
+
 static void init_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
 	struct bt_gatt_client *client = op->client;
+	bool registered;
 
 	client->in_init = false;
 
-	if (success) {
-		client->svc_head = op->result_head;
-		client->svc_tail = op->result_tail;
+	if (!success)
+		goto fail;
+
+	client->svc_head = op->result_head;
+	client->svc_tail = op->result_tail;
+
+	if (!client->svc_chngd_val_handle) {
 		client->ready = true;
-	} else
-		service_list_clear(&op->result_head, &op->result_tail);
+		goto done;
+	}
+
+	/* Register an indication handler for the "Service Changed"
+	 * characteristic and report ready only if the handler is registered
+	 * successfully. Temporarily set "ready" to true so that we can register
+	 * the handler using the existing framework.
+	 */
+	client->ready = true;
+	registered = bt_gatt_client_register_notify(client,
+						client->svc_chngd_val_handle,
+						service_changed_register_cb,
+						service_changed_cb,
+						client, NULL);
+	client->ready = false;
+
+	if (registered)
+		return;
 
+	util_debug(client->debug_callback, client->debug_data,
+			"Failed to register handler for \"Service Changed\"");
+
+	client->svc_head = client->svc_tail = NULL;
+
+fail:
+	util_debug(client->debug_callback, client->debug_data,
+			"Failed to initialize gatt-client");
+	service_list_clear(&op->result_head, &op->result_tail);
+
+done:
 	if (client->ready_callback)
 		client->ready_callback(success, att_ecode, client->ready_data);
 }
-- 
2.1.0.rc2.206.gedb03e5

