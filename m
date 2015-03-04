Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 1/7] core/gatt: Make CCC addition API public
Date: Tue,  3 Mar 2015 20:30:05 -0800
Message-Id: <1425443411-11958-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1425443411-11958-1-git-send-email-armansito@chromium.org>
References: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the btd_gatt_database_add_ccc function to the
database's public API. The signature has been extended to accept
a callback that gets invoked to notify the upper layer when a CCC write
is performed. The result is cached by the database on a per-device basis
while the callback is invoked for all writes from all devices.
---
 src/gatt-database.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-------
 src/gatt-database.h |  11 +++++
 2 files changed, 124 insertions(+), 16 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index fa10ce8..db21d49 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -70,6 +70,7 @@ struct btd_gatt_database {
 	uint32_t gap_handle;
 	uint32_t gatt_handle;
 	struct queue *device_states;
+	struct queue *ccc_callbacks;
 	struct gatt_db_attribute *svc_chngd;
 	struct gatt_db_attribute *svc_chngd_ccc;
 	struct queue *services;
@@ -114,11 +115,48 @@ struct ccc_state {
 	uint8_t value[2];
 };
 
+struct ccc_cb_data {
+	uint16_t handle;
+	btd_gatt_database_ccc_write_t callback;
+	btd_gatt_database_destroy_t destroy;
+	void *user_data;
+};
+
 struct device_info {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 };
 
+static void ccc_cb_free(void *data)
+{
+	struct ccc_cb_data *ccc_cb = data;
+
+	if (ccc_cb->destroy)
+		ccc_cb->destroy(ccc_cb->user_data);
+
+	free(ccc_cb);
+}
+
+static bool ccc_cb_match_service(const void *data, const void *match_data)
+{
+	const struct ccc_cb_data *ccc_cb = data;
+	const struct gatt_db_attribute *attrib = match_data;
+	uint16_t start, end;
+
+	if (!gatt_db_attribute_get_service_handles(attrib, &start, &end))
+		return false;
+
+	return ccc_cb->handle >= start && ccc_cb->handle <= end;
+}
+
+static bool ccc_cb_match_handle(const void *data, const void *match_data)
+{
+	const struct ccc_cb_data *ccc_cb = data;
+	uint16_t handle = PTR_TO_UINT(match_data);
+
+	return ccc_cb->handle == handle;
+}
+
 static bool dev_state_match(const void *a, const void *b)
 {
 	const struct device_state *dev_state = a;
@@ -319,6 +357,10 @@ static void gatt_database_free(void *data)
 	/* TODO: Persistently store CCC states before freeing them */
 	queue_destroy(database->device_states, device_state_free);
 	queue_destroy(database->services, service_free);
+	queue_destroy(database->ccc_callbacks, ccc_cb_free);
+	database->device_states = NULL;
+	database->ccc_callbacks = NULL;
+
 	gatt_db_unregister(database->db, database->db_id);
 	gatt_db_unref(database->db);
 	btd_adapter_unref(database->adapter);
@@ -611,6 +653,7 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 {
 	struct btd_gatt_database *database = user_data;
 	struct ccc_state *ccc;
+	struct ccc_cb_data *ccc_cb;
 	uint16_t handle;
 	uint8_t ecode = 0;
 	bdaddr_t bdaddr;
@@ -641,23 +684,74 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	/*
-	 * TODO: Perform this after checking with a callback to the upper
-	 * layer.
-	 */
-	ccc->value[0] = value[0];
-	ccc->value[1] = value[1];
+	ccc_cb = queue_find(database->ccc_callbacks, ccc_cb_match_handle,
+			UINT_TO_PTR(gatt_db_attribute_get_handle(attrib)));
+	if (!ccc_cb) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	/* If value is identical, then just succeed */
+	if (ccc->value[0] == value[0] && ccc->value[1] == value[1])
+		goto done;
+
+	if (ccc_cb->callback)
+		ecode = ccc_cb->callback(get_le16(value), ccc_cb->user_data);
+
+	if (!ecode) {
+		ccc->value[0] = value[0];
+		ccc->value[1] = value[1];
+	}
 
 done:
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
 
 static struct gatt_db_attribute *
-gatt_database_add_ccc(struct btd_gatt_database *database,
-							uint16_t service_handle)
+service_add_ccc(struct gatt_db_attribute *service,
+				struct btd_gatt_database *database,
+				btd_gatt_database_ccc_write_t write_callback,
+				void *user_data,
+				btd_gatt_database_destroy_t destroy)
+{
+	struct gatt_db_attribute *ccc;
+	struct ccc_cb_data *ccc_cb;
+	bt_uuid_t uuid;
+
+	ccc_cb = new0(struct ccc_cb_data, 1);
+	if (!ccc_cb) {
+		error("Could not allocate memory for callback data");
+		return NULL;
+	}
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	ccc = gatt_db_service_add_descriptor(service, &uuid,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
+	if (!ccc) {
+		error("Failed to create CCC entry in database");
+		free(ccc_cb);
+		return NULL;
+	}
+
+	ccc_cb->handle = gatt_db_attribute_get_handle(ccc);
+	ccc_cb->callback = write_callback;
+	ccc_cb->destroy = destroy;
+	ccc_cb->user_data = user_data;
+
+	queue_push_tail(database->ccc_callbacks, ccc_cb);
+
+	return ccc;
+}
+
+struct gatt_db_attribute *
+btd_gatt_database_add_ccc(struct btd_gatt_database *database,
+				uint16_t service_handle,
+				btd_gatt_database_ccc_write_t write_callback,
+				void *user_data,
+				btd_gatt_database_destroy_t destroy)
 {
 	struct gatt_db_attribute *service;
-	bt_uuid_t uuid;
 
 	if (!database || !service_handle)
 		return NULL;
@@ -668,17 +762,14 @@ gatt_database_add_ccc(struct btd_gatt_database *database,
 		return NULL;
 	}
 
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	return gatt_db_service_add_descriptor(service, &uuid,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
+	return service_add_ccc(service, database, write_callback, user_data,
+								destroy);
 }
 
 static void populate_gatt_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *service;
-	uint16_t start_handle;
 
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
@@ -686,14 +777,14 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	database->gatt_handle = database_add_record(database, UUID_GATT,
 						service,
 						"Generic Attribute Profile");
-	gatt_db_attribute_get_service_handles(service, &start_handle, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
 				BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
 				NULL, NULL, database);
 
-	database->svc_chngd_ccc = gatt_database_add_ccc(database, start_handle);
+	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
+									NULL);
 
 	gatt_db_service_set_active(service, true);
 }
@@ -845,6 +936,8 @@ static void gatt_db_service_removed(struct gatt_db_attribute *attrib,
 	send_service_changed(database, attrib);
 
 	queue_foreach(database->device_states, remove_device_ccc, attrib);
+	queue_remove_all(database->ccc_callbacks, ccc_cb_match_service, attrib,
+								ccc_cb_free);
 }
 
 static bool match_service_path(const void *a, const void *b)
@@ -1648,6 +1741,10 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	if (!database->services)
 		goto fail;
 
+	database->ccc_callbacks = queue_new();
+	if (!database->ccc_callbacks)
+		goto fail;
+
 	database->db_id = gatt_db_register(database->db, gatt_db_service_added,
 							gatt_db_service_removed,
 							database, NULL);
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 0d9106b..163b601 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -23,3 +23,14 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter);
 void btd_gatt_database_destroy(struct btd_gatt_database *database);
 
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
+
+typedef uint8_t (*btd_gatt_database_ccc_write_t) (uint16_t value,
+							void *user_data);
+typedef void (*btd_gatt_database_destroy_t) (void *data);
+
+struct gatt_db_attribute *
+btd_gatt_database_add_ccc(struct btd_gatt_database *database,
+				uint16_t service_handle,
+				btd_gatt_database_ccc_write_t write_callback,
+				void *user_data,
+				btd_gatt_database_destroy_t destroy);
-- 
2.2.0.rc0.207.ga3a616c

