Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/gatt-server: Fix crash on read multiple
Date: Tue, 13 Mar 2018 08:47:27 +0100
Message-Id: <20180313074727.4600-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When read multiple includes external characteristic, call to
gatt_db_attribute_read's complete callback is asynchronous.

Fix following crash:
Use of uninitialised value of size 8
   at 0x49718A: read_multiple_complete_cb (gatt-server.c:994)
   by 0x498999: pending_read_result (gatt-db.c:136)
   by 0x49A84B: gatt_db_attribute_read_result (gatt-db.c:1787)
   by 0x451F4C: read_reply_cb (gatt-database.c:1712)
   by 0x48B221: method_call_reply (client.c:972)
   by 0x53AB601: ??? (in /usr/lib64/libdbus-1.so.3.19.3)
   by 0x53AEF7E: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.3)
   by 0x486FEF: message_dispatch (mainloop.c:72)
   by 0x50CB576: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CEB76: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CEF1F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CF231: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.3)

Invalid read of size 8
   at 0x49718A: read_multiple_complete_cb (gatt-server.c:994)
   by 0x498999: pending_read_result (gatt-db.c:136)
   by 0x49A84B: gatt_db_attribute_read_result (gatt-db.c:1787)
   by 0x451F4C: read_reply_cb (gatt-database.c:1712)
   by 0x48B221: method_call_reply (client.c:972)
   by 0x53AB601: ??? (in /usr/lib64/libdbus-1.so.3.19.3)
   by 0x53AEF7E: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.3)
   by 0x486FEF: message_dispatch (mainloop.c:72)
   by 0x50CB576: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CEB76: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CEF1F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
   by 0x50CF231: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.3)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 src/shared/gatt-server.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index a986c5295..faa56abeb 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -965,10 +965,8 @@ struct read_multiple_resp_data {
 static void read_multiple_resp_data_free(struct read_multiple_resp_data *data)
 {
 	free(data->handles);
-	data->handles = NULL;
-
 	free(data->rsp_data);
-	data->rsp_data = NULL;
+	free(data);
 }
 
 static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
@@ -1045,38 +1043,38 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
-	struct read_multiple_resp_data data;
+	struct read_multiple_resp_data *data = NULL;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 	size_t i = 0;
 
-	data.handles = NULL;
-	data.rsp_data = NULL;
-
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
-	data.server = server;
-	data.num_handles = length / 2;
-	data.cur_handle = 0;
-	data.mtu = bt_att_get_mtu(server->att);
-	data.length = 0;
-	data.rsp_data = malloc(data.mtu - 1);
-
-	if (!data.rsp_data)
+	data = new0(struct read_multiple_resp_data, 1);
+	data->handles = NULL;
+	data->rsp_data = NULL;
+	data->server = server;
+	data->num_handles = length / 2;
+	data->cur_handle = 0;
+	data->mtu = bt_att_get_mtu(server->att);
+	data->length = 0;
+	data->rsp_data = malloc(data->mtu - 1);
+
+	if (!data->rsp_data)
 		goto error;
 
-	data.handles = new0(uint16_t, data.num_handles);
+	data->handles = new0(uint16_t, data->num_handles);
 
-	for (i = 0; i < data.num_handles; i++)
-		data.handles[i] = get_le16(pdu + i * 2);
+	for (i = 0; i < data->num_handles; i++)
+		data->handles[i] = get_le16(pdu + i * 2);
 
 	util_debug(server->debug_callback, server->debug_data,
 			"Read Multiple Req - %zu handles, 1st: 0x%04x",
-			data.num_handles, data.handles[0]);
+			data->num_handles, data->handles[0]);
 
-	attr = gatt_db_get_attribute(server->db, data.handles[0]);
+	attr = gatt_db_get_attribute(server->db, data->handles[0]);
 
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -1084,11 +1082,13 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 	}
 
 	if (gatt_db_attribute_read(attr, 0, opcode, server->att,
-					read_multiple_complete_cb, &data))
+					read_multiple_complete_cb, data))
 		return;
 
 error:
-	read_multiple_resp_data_free(&data);
+	if (data)
+		read_multiple_resp_data_free(data);
+
 	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
-- 
2.14.3

