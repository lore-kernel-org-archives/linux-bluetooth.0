Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/gatt: Add support for GATT over BR/EDR
Date: Wed,  9 Jul 2014 14:41:36 +0200
Message-Id: <1404909698-12242-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds listening on both LE and BR/EDR and SDP records for GAP
and GATT.
---
 android/gatt.c | 217 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 168 insertions(+), 49 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1e2366d..bb9ea0b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -35,6 +35,7 @@
 #include "ipc.h"
 #include "ipc-common.h"
 #include "lib/sdp.h"
+#include "lib/sdp_lib.h"
 #include "lib/uuid.h"
 #include "bluetooth.h"
 #include "gatt.h"
@@ -190,7 +191,11 @@ static struct gatt_db *gatt_db = NULL;
 
 static uint16_t service_changed_handle = 0;
 
-static GIOChannel *listening_io = NULL;
+static GIOChannel *le_io = NULL;
+static GIOChannel *bredr_io = NULL;
+
+static uint32_t gatt_sdp_handle = 0;
+static uint32_t gap_sdp_handle = 0;
 
 static struct bt_crypto *crypto = NULL;
 
@@ -5882,9 +5887,64 @@ done:
 	entry->state  = REQUEST_DONE;
 }
 
+static sdp_record_t *get_sdp_record(uuid_t *uuid, uint16_t start, uint16_t end,
+							const char *name)
+{
+	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
+	uuid_t root_uuid, proto_uuid, l2cap;
+	sdp_record_t *record;
+	sdp_data_t *psm, *sh, *eh;
+	uint16_t lp = ATT_PSM;
+
+	record = sdp_record_alloc();
+	if (record == NULL)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+	sdp_list_free(root, NULL);
+
+	svclass_id = sdp_list_append(NULL, uuid);
+	sdp_set_service_classes(record, svclass_id);
+	sdp_list_free(svclass_id, NULL);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&proto_uuid, ATT_UUID);
+	proto[1] = sdp_list_append(NULL, &proto_uuid);
+	sh = sdp_data_alloc(SDP_UINT16, &start);
+	proto[1] = sdp_list_append(proto[1], sh);
+	eh = sdp_data_alloc(SDP_UINT16, &end);
+	proto[1] = sdp_list_append(proto[1], eh);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, name, "BlueZ for Android", NULL);
+
+	sdp_data_free(psm);
+	sdp_data_free(sh);
+	sdp_data_free(eh);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+
+	return record;
+}
+
 static void register_gap_service(void)
 {
+	uint16_t start, end;
+	sdp_record_t *rec;
 	bt_uuid_t uuid;
+	uuid_t svc;
 
 	/* GAP UUID */
 	bt_uuid16_create(&uuid, 0x1800);
@@ -5918,6 +5978,24 @@ static void register_gap_service(void)
 							NULL);
 
 	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
+
+	/* SDP */
+	start = gap_srvc_data.srvc;
+	end = gatt_db_get_end_handle(gatt_db, gap_srvc_data.srvc);
+	sdp_uuid16_create(&svc, GENERIC_ACCESS_SVCLASS_ID);
+	rec = get_sdp_record(&svc, start, end, "Generic Access Profile");
+	if (!rec) {
+		error("gatt: Failed to get GAP SDP records");
+		return;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("gatt: Failed to register GAP SDP record");
+		sdp_record_free(rec);
+		return;
+	}
+
+	gap_sdp_handle = rec->handle;
 }
 
 /* TODO: Get those data from device possible via androig/bluetooth.c */
@@ -6087,8 +6165,10 @@ static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
 
 static void register_gatt_service(void)
 {
+	uint16_t srvc_handle, end_handle;
+	sdp_record_t *rec;
 	bt_uuid_t uuid;
-	uint16_t srvc_handle;
+	uuid_t svc;
 
 	DBG("");
 
@@ -6108,22 +6188,44 @@ static void register_gatt_service(void)
 					gatt_srvc_change_write_cb, NULL);
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
+
+	/* SDP */
+	end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
+	sdp_uuid16_create(&svc, GENERIC_ATTRIB_PROFILE_ID);
+	rec = get_sdp_record(&svc, srvc_handle, end_handle,
+						"Generic Attribute Profile");
+	if (!rec) {
+		error("gatt: Failed to get GATT SDP records");
+		return;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("gatt: Failed to register GATT SDP record");
+		sdp_record_free(rec);
+		return;
+	}
+
+	gatt_sdp_handle = rec->handle;
 }
 
-static bool start_listening_io(void)
+static bool start_listening(void)
 {
-	GError *gerr = NULL;
+	/* BR/EDR socket */
+	bredr_io = bt_io_listen(NULL, connect_confirm, NULL, NULL, NULL,
+					BT_IO_OPT_SOURCE_TYPE, BDADDR_BREDR,
+					BT_IO_OPT_PSM, ATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
 
-	/* For now only listen on BLE */
-	listening_io = bt_io_listen(NULL, connect_confirm,
-					&listening_io, NULL, &gerr,
+	/* LE socket */
+	le_io = bt_io_listen(NULL, connect_confirm, NULL, NULL, NULL,
 					BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (!listening_io) {
-		error("gatt: Failed to start listening IO (%s)", gerr->message);
-		g_error_free(gerr);
+
+	if (!le_io && !bredr_io) {
+		error("gatt: Failed to start listening IO");
 		return false;
 	}
 
@@ -6134,26 +6236,13 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
-	if (!start_listening_io())
+	if (!start_listening())
 		return false;
 
-	if (!bt_le_register(le_device_found_handler)) {
-		error("gatt: bt_le_register failed");
-
-		g_io_channel_unref(listening_io);
-		listening_io = NULL;
-
-		return false;
-	}
-
 	crypto = bt_crypto_new();
 	if (!crypto) {
 		error("gatt: Failed to setup crypto");
-
-		g_io_channel_unref(listening_io);
-		listening_io = NULL;
-
-		return false;
+		goto failed;
 	}
 
 	gatt_devices = queue_new();
@@ -6165,28 +6254,12 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (!gatt_devices || !gatt_apps || !listen_apps || !app_connections ||
 								!gatt_db) {
 		error("gatt: Failed to allocate memory for queues");
+		goto failed;
+	}
 
-		queue_destroy(gatt_apps, NULL);
-		gatt_apps = NULL;
-
-		queue_destroy(gatt_devices, NULL);
-		gatt_devices = NULL;
-
-		queue_destroy(app_connections, NULL);
-		app_connections = NULL;
-
-		queue_destroy(listen_apps, NULL);
-		listen_apps = NULL;
-
-		gatt_db_destroy(gatt_db);
-		gatt_db = NULL;
-
-		g_io_channel_unref(listening_io);
-		listening_io = NULL;
-
-		bt_crypto_unref(crypto);
-
-		return false;
+	if (!bt_le_register(le_device_found_handler)) {
+		error("gatt: bt_le_register failed");
+		goto failed;
 	}
 
 	bacpy(&adapter_addr, addr);
@@ -6200,7 +6273,41 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	register_device_info_service();
 	register_gatt_service();
 
+	info("gatt: LE: %s BR/EDR: %s", le_io ? "enabled" : "disabled",
+					bredr_io ? "enabled" : "disabled");
+
 	return true;
+
+failed:
+	queue_destroy(gatt_apps, NULL);
+	gatt_apps = NULL;
+
+	queue_destroy(gatt_devices, NULL);
+	gatt_devices = NULL;
+
+	queue_destroy(app_connections, NULL);
+	app_connections = NULL;
+
+	queue_destroy(listen_apps, NULL);
+	listen_apps = NULL;
+
+	gatt_db_destroy(gatt_db);
+	gatt_db = NULL;
+
+	bt_crypto_unref(crypto);
+	crypto = NULL;
+
+	if (le_io) {
+		g_io_channel_unref(le_io);
+		le_io = NULL;
+	}
+
+	if (bredr_io) {
+		g_io_channel_unref(bredr_io);
+		bredr_io = NULL;
+	}
+
+	return false;
 }
 
 void bt_gatt_unregister(void)
@@ -6225,8 +6332,21 @@ void bt_gatt_unregister(void)
 	gatt_db_destroy(gatt_db);
 	gatt_db = NULL;
 
-	g_io_channel_unref(listening_io);
-	listening_io = NULL;
+	g_io_channel_unref(le_io);
+	le_io = NULL;
+
+	g_io_channel_unref(bredr_io);
+	bredr_io = NULL;
+
+	if (gap_sdp_handle) {
+		bt_adapter_remove_record(gap_sdp_handle);
+		gap_sdp_handle = 0;
+	}
+
+	if (gatt_sdp_handle) {
+		bt_adapter_remove_record(gatt_sdp_handle);
+		gatt_sdp_handle = 0;
+	}
 
 	bt_crypto_unref(crypto);
 	crypto = NULL;
@@ -6234,7 +6354,6 @@ void bt_gatt_unregister(void)
 	bt_le_unregister();
 }
 
-
 unsigned int bt_gatt_register_app(const char *uuid, gatt_type_t type,
 							gatt_conn_cb_t func)
 {
-- 
1.9.1

