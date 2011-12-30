Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/4] attrib-server: Move GAP attributes inside gatt_server struct
Date: Fri, 30 Dec 2011 12:45:06 +0100
Message-Id: <1325245509-14359-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 623c91a..36a398f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -62,6 +62,8 @@ struct gatt_server {
 	uint32_t gap_sdp_handle;
 	GSList *database;
 	GSList *clients;
+	uint16_t name_handle;
+	uint16_t appearance_handle;
 };
 
 struct gatt_channel {
@@ -82,10 +84,6 @@ struct group_elem {
 	uint16_t len;
 };
 
-/* GAP attribute handles */
-static uint16_t name_handle = 0x0000;
-static uint16_t appearance_handle = 0x0000;
-
 static bt_uuid_t prim_uuid = {
 			.type = BT_UUID16,
 			.value.u16 = GATT_PRIM_SVC_UUID
@@ -1138,24 +1136,24 @@ static gboolean register_core_services(struct gatt_server *server)
 								atval, 2);
 
 	/* GAP service: device name characteristic */
-	name_handle = 0x0006;
+	server->name_handle = 0x0006;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(name_handle, &atval[1]);
+	att_put_u16(server->name_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add_new(server, 0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
 
 	/* GAP service: device name attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	attrib_db_add_new(server, name_handle, &uuid, ATT_NONE,
+	attrib_db_add_new(server, server->name_handle, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, NULL, 0);
 
 	/* GAP service: device appearance characteristic */
-	appearance_handle = 0x0008;
+	server->appearance_handle = 0x0008;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(appearance_handle, &atval[1]);
+	att_put_u16(server->appearance_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
 	attrib_db_add_new(server, 0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 5);
@@ -1163,7 +1161,7 @@ static gboolean register_core_services(struct gatt_server *server)
 	/* GAP service: device appearance attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	att_put_u16(appearance, &atval[0]);
-	attrib_db_add_new(server, appearance_handle, &uuid, ATT_NONE,
+	attrib_db_add_new(server, server->appearance_handle, &uuid, ATT_NONE,
 						ATT_NOT_PERMITTED, atval, 2);
 	server->gap_sdp_handle = attrib_create_sdp_new(server, 0x0001,
 						"Generic Access Profile");
@@ -1392,16 +1390,24 @@ int attrib_db_del(struct btd_adapter *adapter, uint16_t handle)
 int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 						const uint8_t *value, int len)
 {
+	struct gatt_server *server;
 	uint16_t handle;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
+		return -ENOENT;
+
+	server = l->data;
 
 	/* FIXME: Missing Privacy and Reconnection Address */
 
 	switch (uuid) {
 	case GATT_CHARAC_DEVICE_NAME:
-		handle = name_handle;
+		handle = server->name_handle;
 		break;
 	case GATT_CHARAC_APPEARANCE:
-		handle = appearance_handle;
+		handle = server->appearance_handle;
 		break;
 	default:
 		return -ENOSYS;
-- 
1.7.8.1

