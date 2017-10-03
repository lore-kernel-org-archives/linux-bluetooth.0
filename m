Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Remove support of ATT over BR/EDR
Date: Tue,  3 Oct 2017 15:25:56 +0300
Message-Id: <20171003122556.18437-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ATT over BR/EDR requires bearer specific access types in order to pass
tests such as:

  4.5.71 TP/GAR/CL/BI-34-C [Read Characteristic Value – Invalid Transport
  Access over BR/EDR]
  Verify Generic Attribute Profile client behavior when an attempt to use
  BR/EDR transport to execute the Read Characteristic Value procedure on
  a characteristic contained within a service defined for use only over
  LE transport.

On top of that the CCC are considerer bearer specific so for each bearer
supported we would have to maintain different storages:

  In the case where multiple ATT bearers from the same device are supported
  by the GATT server, each ATT bearer shall be considered to have a separate
  GATT client instance. Therefore each GATT client shall have a separate
  Client Characteristic Configuration.
---
 src/gatt-database.c | 120 ----------------------------------------------------
 1 file changed, 120 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0c84b2569..a00fffd28 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -73,9 +73,6 @@ struct btd_gatt_database {
 	struct gatt_db *db;
 	unsigned int db_id;
 	GIOChannel *le_io;
-	GIOChannel *l2cap_io;
-	uint32_t gap_handle;
-	uint32_t gatt_handle;
 	struct queue *device_states;
 	struct queue *ccc_callbacks;
 	struct gatt_db_attribute *svc_chngd;
@@ -447,18 +444,6 @@ static void gatt_database_free(void *data)
 		g_io_channel_unref(database->le_io);
 	}
 
-	if (database->l2cap_io) {
-		g_io_channel_shutdown(database->l2cap_io, FALSE, NULL);
-		g_io_channel_unref(database->l2cap_io);
-	}
-
-	if (database->gatt_handle)
-		adapter_service_remove(database->adapter,
-							database->gatt_handle);
-
-	if (database->gap_handle)
-		adapter_service_remove(database->adapter, database->gap_handle);
-
 	/* TODO: Persistently store CCC states before freeing them */
 	gatt_db_unregister(database->db, database->db_id);
 
@@ -570,94 +555,6 @@ done:
 	gatt_db_attribute_read_result(attrib, id, error, value, len);
 }
 
-static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
-{
-	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
-	uuid_t root_uuid, proto_uuid, l2cap;
-	sdp_record_t *record;
-	sdp_data_t *psm, *sh, *eh;
-	uint16_t lp = ATT_PSM;
-
-	if (uuid == NULL)
-		return NULL;
-
-	if (start > end)
-		return NULL;
-
-	record = sdp_record_alloc();
-	if (record == NULL)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-	sdp_list_free(root, NULL);
-
-	svclass_id = sdp_list_append(NULL, uuid);
-	sdp_set_service_classes(record, svclass_id);
-	sdp_list_free(svclass_id, NULL);
-
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto[0] = sdp_list_append(proto[0], psm);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&proto_uuid, ATT_UUID);
-	proto[1] = sdp_list_append(NULL, &proto_uuid);
-	sh = sdp_data_alloc(SDP_UINT16, &start);
-	proto[1] = sdp_list_append(proto[1], sh);
-	eh = sdp_data_alloc(SDP_UINT16, &end);
-	proto[1] = sdp_list_append(proto[1], eh);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_data_free(psm);
-	sdp_data_free(sh);
-	sdp_data_free(eh);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(aproto, NULL);
-
-	return record;
-}
-
-static uint32_t database_add_record(struct btd_gatt_database *database,
-					uint16_t uuid,
-					struct gatt_db_attribute *attr,
-					const char *name)
-{
-	sdp_record_t *record;
-	uint16_t start, end;
-	uuid_t svc, gap_uuid;
-
-	sdp_uuid16_create(&svc, uuid);
-	gatt_db_attribute_get_service_handles(attr, &start, &end);
-
-	record = record_new(&svc, start, end);
-	if (!record)
-		return 0;
-
-	if (name != NULL)
-		sdp_set_info_attr(record, name, "BlueZ", NULL);
-
-	sdp_uuid16_create(&gap_uuid, UUID_GAP);
-	if (sdp_uuid_cmp(&svc, &gap_uuid) == 0) {
-		sdp_set_url_attr(record, "http://www.bluez.org/",
-				"http://www.bluez.org/",
-				"http://www.bluez.org/");
-	}
-
-	if (adapter_service_add(database->adapter, record) == 0)
-		return record->handle;
-
-	sdp_record_free(record);
-	return 0;
-}
-
 static void populate_gap_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
@@ -666,8 +563,6 @@ static void populate_gap_service(struct btd_gatt_database *database)
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
 	service = gatt_db_add_service(database->db, &uuid, true, 5);
-	database->gap_handle = database_add_record(database, UUID_GAP, service,
-						"Generic Access Profile");
 
 	/*
 	 * Device Name characteristic.
@@ -850,9 +745,6 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
 	service = gatt_db_add_service(database->db, &uuid, true, 4);
-	database->gatt_handle = database_add_record(database, UUID_GATT,
-						service,
-						"Generic Attribute Profile");
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
@@ -2894,18 +2786,6 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 		goto fail;
 	}
 
-	/* BR/EDR socket */
-	database->l2cap_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, addr,
-					BT_IO_OPT_PSM, ATT_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
-	if (database->l2cap_io == NULL) {
-		error("Failed to start listening: %s", gerr->message);
-		g_error_free(gerr);
-		goto fail;
-	}
-
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						GATT_MANAGER_IFACE,
-- 
2.13.6

