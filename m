Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 11/11] shared/gatt-server: Check for ext. charact. prop. on reliable session
Date: Fri, 27 Nov 2015 12:11:50 +0100
Message-Id: <1448622711-17562-12-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch we make sure that reliable session is done on
characteristics which does support it.
---
 src/shared/gatt-server.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2bd90b0..b939bed 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -72,6 +72,8 @@ struct prep_write_data {
 	uint16_t handle;
 	uint16_t offset;
 	uint16_t length;
+
+	bool reliable_supported;
 };
 
 static void prep_write_data_destroy(void *user_data)
@@ -1088,6 +1090,22 @@ error:
 	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
+static bool is_reliable_supported(const struct bt_gatt_server  *server,
+							uint16_t handle)
+{
+	struct gatt_db_attribute *attr;
+	uint8_t ext_prop;
+
+	attr = gatt_db_get_attribute(server->db, handle);
+	if (!attr)
+		return false;
+
+	if (!gatt_db_attribute_get_characteristic_extended_prop(attr, &ext_prop))
+		return false;
+
+	return (ext_prop & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE);
+}
+
 static bool create_and_store_prep_data(struct bt_gatt_server *server,
 						uint16_t handle, uint16_t offset,
 						uint16_t length, uint8_t *value)
@@ -1109,6 +1127,12 @@ static bool create_and_store_prep_data(struct bt_gatt_server *server,
 	prep_data->handle = handle;
 	prep_data->offset = offset;
 
+	/*
+	 * Handle is the value handle. We need characteristic declariation
+	 * handle which in BlueZ is handle_value -1
+	 */
+	prep_data->reliable_supported =  is_reliable_supported( server,
+								handle -1);
 	queue_push_tail(server->prep_queue, prep_data);
 
 	return true;
@@ -1285,6 +1309,14 @@ error:
 								ehandle, err);
 }
 
+static bool find_no_reliable_characteristic(const void *data,
+						const void *match_data)
+{
+	const struct prep_write_data *prep_data = data;
+
+	return !prep_data->reliable_supported;
+}
+
 static void exec_write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1292,6 +1324,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	uint8_t flags;
 	uint8_t ecode;
 	bool write;
+	uint16_t ehandle = 0;
 
 	if (length != 1) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1320,6 +1353,19 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 		return;
 	}
 
+	/* If there is more than one prep request, we are in reliable session */
+	if (queue_length(server->prep_queue) > 1) {
+		struct prep_write_data *prep_data;
+
+		prep_data = queue_find(server->prep_queue,
+					find_no_reliable_characteristic, NULL);
+		if (prep_data) {
+			ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+			ehandle = prep_data->handle;
+			goto error;
+		}
+	}
+
 	exec_next_prep_write(server, 0, 0);
 
 	return;
@@ -1327,7 +1373,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 error:
 	queue_remove_all(server->prep_queue, NULL, NULL,
 						prep_write_data_destroy);
-	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
+	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
 }
 
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
-- 
2.5.0

