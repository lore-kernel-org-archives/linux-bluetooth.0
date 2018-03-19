Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Properly handle service changes when offline
Date: Mon, 19 Mar 2018 14:44:27 +0200
Message-Id: <20180319124427.26418-2-luiz.dentz@gmail.com>
In-Reply-To: <20180319124427.26418-1-luiz.dentz@gmail.com>
References: <20180319124427.26418-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If remote peer is disconnected the indication shall be cached so when
the peer connects again it receives the changes.
---
 src/device.c        |  9 ++++--
 src/gatt-database.c | 89 ++++++++++++++++++++++++++++++++++++++++++++---------
 src/gatt-database.h |  2 ++
 3 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7c7196ca1..bf5441543 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4825,8 +4825,11 @@ static void gatt_client_init(struct btd_device *device)
 	btd_gatt_client_connected(device->client_dbus);
 }
 
-static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
+static void gatt_server_init(struct btd_device *device,
+				struct btd_gatt_database *database)
 {
+	struct gatt_db *db = btd_gatt_database_get_db(database);
+
 	if (!db) {
 		error("No local GATT database exists for this adapter");
 		return;
@@ -4839,6 +4842,8 @@ static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
 		error("Failed to initialize bt_gatt_server");
 
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
+
+	btd_gatt_database_att_connected(database, device->att);
 }
 
 static bool local_counter(uint32_t *sign_cnt, void *user_data)
@@ -4938,7 +4943,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 								dstaddr);
 
 	gatt_client_init(dev);
-	gatt_server_init(dev, btd_gatt_database_get_db(database));
+	gatt_server_init(dev, database);
 
 	/*
 	 * Remove the device from the connect_list and give the passive
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 82f376568..92d0cd248 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -155,12 +155,22 @@ struct pending_op {
 	struct iovec data;
 };
 
+struct notify {
+	struct btd_gatt_database *database;
+	uint16_t handle, ccc_handle;
+	uint8_t *value;
+	uint16_t len;
+	bt_gatt_server_conf_func_t conf;
+	void *user_data;
+};
+
 struct device_state {
 	struct btd_gatt_database *db;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 	unsigned int disc_id;
 	struct queue *ccc_states;
+	struct notify *pending;
 };
 
 typedef uint8_t (*btd_gatt_database_ccc_write_t) (struct bt_att *att,
@@ -273,6 +283,12 @@ static void device_state_free(void *data)
 	struct device_state *state = data;
 
 	queue_destroy(state->ccc_states, free);
+
+	if (state->pending) {
+		free(state->pending->value);
+		free(state->pending);
+	}
+
 	free(state);
 }
 
@@ -951,15 +967,6 @@ static void register_core_services(struct btd_gatt_database *database)
 	populate_gatt_service(database);
 }
 
-struct notify {
-	struct btd_gatt_database *database;
-	uint16_t handle, ccc_handle;
-	const uint8_t *value;
-	uint16_t len;
-	bt_gatt_server_conf_func_t conf;
-	void *user_data;
-};
-
 static void conf_cb(void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -971,6 +978,41 @@ static void conf_cb(void *user_data)
 	}
 }
 
+static void service_changed_conf(void *user_data)
+{
+	DBG("");
+}
+
+static void state_set_pending(struct device_state *state, struct notify *notify)
+{
+	uint16_t start, end, old_start, old_end;
+
+	if (notify->conf != service_changed_conf)
+		return;
+
+	if (state->pending) {
+		old_start = get_le16(state->pending->value);
+		old_end = get_le16(state->pending->value + 2);
+
+		start = get_le16(notify->value);
+		end = get_le16(notify->value + 2);
+
+		if (start < old_start)
+			put_le16(start, state->pending->value);
+
+		if (end > old_end)
+			put_le16(end, state->pending->value + 2);
+
+		return;
+	}
+
+	/* Copy notify contents to pending */
+	state->pending = new0(struct notify, 1);
+	memcpy(state->pending, notify, sizeof(*notify));
+	state->pending->value = malloc(notify->len);
+	memcpy(state->pending->value, notify->value, notify->len);
+}
+
 static void send_notification_to_device(void *data, void *user_data)
 {
 	struct device_state *device_state = data;
@@ -996,6 +1038,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	if (!server) {
 		if (!device_is_paired(device, device_state->bdaddr_type))
 			goto remove;
+		state_set_pending(device_state, notify);
 		return;
 	}
 
@@ -1027,13 +1070,8 @@ remove:
 	}
 }
 
-static void service_changed_conf(void *user_data)
-{
-	DBG("");
-}
-
 static void send_notification_to_devices(struct btd_gatt_database *database,
-					uint16_t handle, const uint8_t *value,
+					uint16_t handle, uint8_t *value,
 					uint16_t len, uint16_t ccc_handle,
 					bt_gatt_server_conf_func_t conf,
 					void *user_data)
@@ -3080,3 +3118,24 @@ struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database)
 
 	return database->db;
 }
+
+void btd_gatt_database_att_connected(struct btd_gatt_database *database,
+						struct bt_att *att)
+{
+	struct device_state *state;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return;
+
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (!state || !state->pending)
+		return;
+
+	send_notification_to_device(state, state->pending);
+
+	free(state->pending->value);
+	free(state->pending);
+	state->pending = NULL;
+}
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 0d9106b11..0da33f604 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -23,3 +23,5 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter);
 void btd_gatt_database_destroy(struct btd_gatt_database *database);
 
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
+void btd_gatt_database_att_connected(struct btd_gatt_database *database,
+						struct bt_att *att);
-- 
2.14.3

