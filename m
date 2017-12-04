Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] gatt: Add all services as records
Date: Mon,  4 Dec 2017 10:10:54 -0200
Message-Id: <20171204121054.29186-3-luiz.dentz@gmail.com>
In-Reply-To: <20171204121054.29186-1-luiz.dentz@gmail.com>
References: <20171204121054.29186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses services changes to trigger the addition/removal of the SDP
records.
---
 src/gatt-database.c | 63 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 76ec1cde1..143f2aa7f 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -69,14 +69,19 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+struct gatt_record {
+	struct btd_gatt_database *database;
+	uint32_t handle;
+	struct gatt_db_attribute *attr;
+};
+
 struct btd_gatt_database {
 	struct btd_adapter *adapter;
 	struct gatt_db *db;
 	unsigned int db_id;
 	GIOChannel *le_io;
 	GIOChannel *l2cap_io;
-	uint32_t gap_handle;
-	uint32_t gatt_handle;
+	struct queue *records;
 	struct queue *device_states;
 	struct queue *ccc_callbacks;
 	struct gatt_db_attribute *svc_chngd;
@@ -520,6 +525,14 @@ static void app_free(void *data)
 	free(app);
 }
 
+static void gatt_record_free(void *data)
+{
+	struct gatt_record *rec = data;
+
+	adapter_service_remove(rec->database->adapter, rec->handle);
+	free(rec);
+}
+
 static void gatt_database_free(void *data)
 {
 	struct btd_gatt_database *database = data;
@@ -534,16 +547,10 @@ static void gatt_database_free(void *data)
 		g_io_channel_unref(database->l2cap_io);
 	}
 
-	if (database->gatt_handle)
-		adapter_service_remove(database->adapter,
-							database->gatt_handle);
-
-	if (database->gap_handle)
-		adapter_service_remove(database->adapter, database->gap_handle);
-
 	/* TODO: Persistently store CCC states before freeing them */
 	gatt_db_unregister(database->db, database->db_id);
 
+	queue_destroy(database->records, gatt_record_free);
 	queue_destroy(database->device_states, device_state_free);
 	queue_destroy(database->apps, app_free);
 	queue_destroy(database->profiles, profile_free);
@@ -707,9 +714,10 @@ static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 	return record;
 }
 
-static uint32_t database_add_record(struct btd_gatt_database *database,
+static void database_add_record(struct btd_gatt_database *database,
 					struct gatt_db_attribute *attr)
 {
+	struct gatt_record *rec;
 	sdp_record_t *record;
 	uint16_t start, end;
 	uuid_t svc, gap_uuid;
@@ -734,14 +742,14 @@ static uint32_t database_add_record(struct btd_gatt_database *database,
 		sdp_uuid128_create(&svc, (void *) &uuid.value.u128);
 		break;
 	case BT_UUID_UNSPEC:
-		return 0;
+		return;
 	}
 
 	gatt_db_attribute_get_service_handles(attr, &start, &end);
 
 	record = record_new(&svc, start, end);
 	if (!record)
-		return 0;
+		return;
 
 	if (name != NULL)
 		sdp_set_info_attr(record, name, "BlueZ", NULL);
@@ -753,11 +761,16 @@ static uint32_t database_add_record(struct btd_gatt_database *database,
 				"http://www.bluez.org/");
 	}
 
-	if (adapter_service_add(database->adapter, record) == 0)
-		return record->handle;
+	if (adapter_service_add(database->adapter, record) < 0) {
+		sdp_record_free(record);
+		return;
+	}
 
-	sdp_record_free(record);
-	return 0;
+	rec = new0(struct gatt_record, 1);
+	rec->database = database;
+	rec->handle = record->handle;
+	rec->attr = attr;
+	queue_push_tail(database->records, rec);
 }
 
 static void populate_gap_service(struct btd_gatt_database *database)
@@ -768,7 +781,6 @@ static void populate_gap_service(struct btd_gatt_database *database)
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
 	service = gatt_db_add_service(database->db, &uuid, true, 5);
-	database->gap_handle = database_add_record(database, service);
 
 	/*
 	 * Device Name characteristic.
@@ -922,7 +934,6 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
 	service = gatt_db_add_service(database->db, &uuid, true, 4);
-	database->gatt_handle = database_add_record(database, service);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
@@ -1073,6 +1084,8 @@ static void gatt_db_service_added(struct gatt_db_attribute *attrib,
 
 	DBG("GATT Service added to local database");
 
+	database_add_record(database, attrib);
+
 	send_service_changed(database, attrib);
 }
 
@@ -1095,13 +1108,26 @@ static void remove_device_ccc(void *data, void *user_data)
 	queue_remove_all(state->ccc_states, ccc_match_service, user_data, free);
 }
 
+static bool match_gatt_record(const void *data, const void *user_data)
+{
+	const struct gatt_record *rec = data;
+	const struct gatt_db_attribute *attr = user_data;
+
+	return (rec->attr == attr);
+}
+
 static void gatt_db_service_removed(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
 	struct btd_gatt_database *database = user_data;
+	struct gatt_record *rec;
 
 	DBG("Local GATT service removed");
 
+	rec = queue_remove_if(database->records, match_gatt_record, attrib);
+	if (rec)
+		gatt_record_free(rec);
+
 	send_service_changed(database, attrib);
 
 	queue_foreach(database->device_states, remove_device_ccc, attrib);
@@ -2972,6 +2998,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	database = new0(struct btd_gatt_database, 1);
 	database->adapter = btd_adapter_ref(adapter);
 	database->db = gatt_db_new();
+	database->records = queue_new();
 	database->device_states = queue_new();
 	database->apps = queue_new();
 	database->profiles = queue_new();
-- 
2.13.6

