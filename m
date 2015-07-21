Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 10/15] soletta/heartrate: Add a node-type for the Heartrate profile
Date: Tue, 21 Jul 2015 20:16:43 -0300
Message-Id: <1437520608-22444-11-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This simple node type exports a node with only a input port that
receives pulses that will be exported via the Heartrate service as beats
per minute.
---
 peripheral/soletta/heartrate-genspec.json |  31 ++++
 peripheral/soletta/heartrate.c            | 270 ++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)
 create mode 100644 peripheral/soletta/heartrate-genspec.json
 create mode 100644 peripheral/soletta/heartrate.c

diff --git a/peripheral/soletta/heartrate-genspec.json b/peripheral/soletta/heartrate-genspec.json
new file mode 100644
index 0000000..2b9c90a
--- /dev/null
+++ b/peripheral/soletta/heartrate-genspec.json
@@ -0,0 +1,31 @@
+{
+  "$schema": "http://solettaproject.github.io/soletta/schemas/node-type-genspec.schema",
+  "name": "Bluetooth",
+  "meta": {
+    "author": "Intel Corporation",
+    "version": "1"
+  },
+  "types": [
+    {
+      "category": "output/hw",
+      "description": "Bluetooth Smart Heart Rate Profile server",
+      "in_ports": [
+        {
+          "data_type": "any",
+          "description": "each packet is a beat",
+          "methods": {
+            "process": "heartrate_in_process"
+          },
+          "name": "IN"
+        }
+      ],
+      "methods": {
+        "close": "heartrate_close",
+        "open": "heartrate_open"
+      },
+      "name": "heartrate",
+      "private_data_type": "heartrate_data",
+      "url": "http://soletta.org/doc/latest/node_types/heartrate.html"
+    }
+  ]
+}
diff --git a/peripheral/soletta/heartrate.c b/peripheral/soletta/heartrate.c
new file mode 100644
index 0000000..4f6fbfa
--- /dev/null
+++ b/peripheral/soletta/heartrate.c
@@ -0,0 +1,270 @@
+#include "heartrate-gen.h"
+
+#include <errno.h>
+#include <stdio.h>
+#include <bluetooth.h>
+#include <l2cap.h>
+
+#include <uuid.h>
+
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/timeout.h"
+#include "src/shared/util.h"
+
+#include "peripheral/gap.h"
+#include "peripheral/gatt.h"
+
+#include <sol-flow.h>
+#include <sol-log.h>
+
+/* In seconds */
+#define WINDOW_SIZE 5
+
+struct heartrate_data {
+	struct gatt_db_attribute *service;
+	struct queue *to_notify;
+	int notifier;
+	int beats_per_window;
+	unsigned int disconnect_watch;
+	uint16_t handle;
+};
+
+static struct queue *sensors;
+
+static struct gatt_db *gatt_db;
+
+static int heartrate_in_process(struct sol_flow_node *node, void *data,
+				uint16_t port, uint16_t conn_id,
+				const struct sol_flow_packet *packet)
+{
+	struct heartrate_data *hr = data;
+
+	if (queue_isempty(hr->to_notify))
+		return 0;
+
+	hr->beats_per_window++;
+
+	return 0;
+}
+
+static bool bluetooth_init(void)
+{
+	gap_start();
+
+	sensors = queue_new();
+	if (!sensors)
+		return false;
+
+	return true;
+}
+
+static bool match_att(const void *data, const void *match_data) {
+	return data == match_data;
+}
+
+static void ccc_read(struct gatt_db_attribute *attrib, unsigned int id,
+		     uint16_t offset, uint8_t opcode, struct bt_att *att,
+		     void *user_data)
+{
+	struct heartrate_data *hr = user_data;
+	uint8_t value[2] = { 0 };
+
+	if (queue_find(hr->to_notify, match_att, att))
+		value[0] = 0x01;
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+static void remove_att(void *data, void *user_data)
+{
+	struct heartrate_data *hr = data;
+	struct bt_att *att = user_data;
+
+	if (!queue_find(hr->to_notify, match_att, att))
+		return;
+
+	queue_remove(hr->to_notify, att);
+
+	bt_att_unref(att);
+
+	if (queue_isempty(hr->to_notify)) {
+		timeout_remove(hr->notifier);
+		hr->notifier = -1;
+	}
+}
+
+static void remove_notify_cb(int err, void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	queue_foreach(sensors, remove_att, att);
+}
+
+static bool send_notification(void *user_data)
+{
+	struct heartrate_data *hr = user_data;
+	const struct queue_entry *e;
+	uint8_t pdu[4];
+
+	e = queue_get_entries(hr->to_notify);
+	if (!e)
+		return true;
+
+	put_le16(hr->handle, &pdu[0]);
+
+	pdu[2] = 0x06;
+	pdu[3] = hr->beats_per_window * (60 / WINDOW_SIZE);
+
+	hr->beats_per_window = 0;
+
+	while (e) {
+		struct bt_att *att = e->data;
+		bt_att_send(att, BT_ATT_OP_HANDLE_VAL_NOT, pdu, sizeof(pdu), NULL, NULL, NULL);
+		e = e->next;
+	}
+
+	return true;
+}
+
+static void enable_notification(struct heartrate_data *hr, struct bt_att *att)
+{
+	if (queue_find(hr->to_notify, match_att, att)) {
+		return;
+	}
+
+	if (!queue_push_tail(hr->to_notify, bt_att_ref(att))) {
+		bt_att_unref(att);
+		return;
+	}
+
+	hr->disconnect_watch = bt_att_register_disconnect(att, remove_notify_cb, att, NULL);
+
+	if (hr->notifier != -1)
+		return;
+
+	hr->notifier = timeout_add(WINDOW_SIZE * 1000, send_notification, hr, NULL);
+}
+
+static void disable_notification(struct heartrate_data *hr, struct bt_att *att)
+{
+	if (!queue_remove(hr->to_notify, att))
+		return;
+
+	bt_att_unref(att);
+
+	if (queue_isempty(hr->to_notify)) {
+		timeout_remove(hr->notifier);
+		hr->notifier = -1;
+	}
+}
+
+static void ccc_write(struct gatt_db_attribute *attrib, unsigned int id,
+		      uint16_t offset, const uint8_t *value, size_t len,
+		      uint8_t opcode, struct bt_att *att, void *user_data)
+{
+	struct heartrate_data *hr = user_data;
+	uint8_t ecode = 0;
+
+	if (!value || len != 2) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	if (offset) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	if (value[0] == 0x01)
+		enable_notification(hr, att);
+	else if (value[0] == 0x00)
+		disable_notification(hr, att);
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static void heartrate_register(struct gatt_db *db, void *user_data)
+{
+	struct heartrate_data *hr = user_data;
+	struct gatt_db_attribute *service, *chr;
+	bt_uuid_t uuid;
+
+	gatt_db = gatt_db_ref(db);
+
+	bt_uuid16_create(&uuid, 0x180d);
+
+	service = gatt_db_add_service(gatt_db, &uuid, true, 6);
+
+	/* Heart Rate Measurement characteristic */
+	bt_uuid16_create(&uuid, 0x2a37);
+	chr = gatt_db_service_add_characteristic(service, &uuid,
+						 BT_ATT_PERM_NONE,
+						 BT_GATT_CHRC_PROP_NOTIFY,
+						 NULL, NULL, NULL);
+	hr->handle = gatt_db_attribute_get_handle(chr);
+
+	/* Heart Rate CCC descriptor */
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	gatt_db_service_add_descriptor(chr, &uuid,
+				       BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				       ccc_read, ccc_write, hr);
+
+	hr->service = service;
+
+	gatt_db_service_set_active(service, true);
+}
+
+static int heartrate_open(struct sol_flow_node *node, void *data,
+			  const struct sol_flow_node_options *options)
+{
+	static bool initialized = false;
+	struct heartrate_data *hr = data;
+
+	if (!initialized) {
+		initialized = bluetooth_init();
+
+		if (!initialized) {
+			SOL_WRN("Could not initialize Bluetooth module");
+			return -EINVAL;
+		}
+	}
+
+	/* FIXME: remove when supporting multiple locations */
+	if (!queue_isempty(sensors))
+		return 0;
+
+	hr->to_notify = queue_new();
+	hr->notifier = -1;
+
+	gatt_server_add_service(heartrate_register, hr);
+
+	queue_push_tail(sensors, hr);
+
+	return 0;
+}
+
+static void heartrate_close(struct sol_flow_node *node, void *data)
+{
+	struct heartrate_data *hr = data;
+
+	if (hr->service)
+		gatt_db_remove_service(gatt_db, hr->service);
+
+	hr->service = NULL;
+
+	queue_destroy(hr->to_notify, (queue_destroy_func_t) bt_att_unref);
+
+	if (hr->notifier >= 0)
+		timeout_remove(hr->notifier);
+
+	hr->notifier = -1;
+
+	queue_remove(sensors, hr);
+
+	gatt_db_unref(gatt_db);
+}
+
+#include "heartrate-gen.c"
-- 
2.4.6

