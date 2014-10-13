Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 4/5] shared/gatt-server: Support Exchange MTU request.
Date: Mon, 13 Oct 2014 14:10:01 -0700
Message-Id: <1413234602-20566-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1413234602-20566-1-git-send-email-armansito@chromium.org>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling for the exchange MTU request.
---
 src/shared/gatt-server.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 544e60e..c7b0873 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -34,29 +34,83 @@
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 #endif
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 struct bt_gatt_server {
 	struct gatt_db *db;
 	struct bt_att *att;
 	int ref_count;
 	uint16_t mtu;
 
+	unsigned int mtu_id;
+
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
 	void *debug_data;
 };
 
-static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
+static void gatt_server_unregister_handlers(struct bt_gatt_server *server)
 {
-	/* TODO */
-	return true;
+	bt_att_unregister(server->att, server->mtu_id);
 }
 
 static void gatt_server_cleanup(struct bt_gatt_server *server)
 {
+	gatt_server_unregister_handlers(server);
 	bt_att_unref(server->att);
 	server->att = NULL;
 }
 
+static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
+								uint8_t pdu[4])
+{
+	pdu[0] = opcode;
+	pdu[3] = ecode;
+	put_le16(handle, pdu + 1);
+}
+
+static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t client_rx_mtu;
+	uint16_t final_mtu;
+	uint8_t rsp_pdu[4];
+
+	if (length != 2) {
+		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, rsp_pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu,
+					sizeof(rsp_pdu), NULL, NULL, NULL);
+		return;
+	}
+
+	client_rx_mtu = get_le16(pdu);
+	final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
+
+	/* Respond with the server MTU */
+	put_le16(server->mtu, rsp_pdu);
+	bt_att_send(server->att, BT_ATT_OP_MTU_RSP, rsp_pdu, 2, NULL, NULL,
+									NULL);
+
+	/* Set MTU to be the minimum */
+	server->mtu = final_mtu;
+	bt_att_set_mtu(server->att, final_mtu);
+}
+
+static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
+{
+	/* EXCHANGE MTU request */
+	server->mtu_id = bt_att_register(server->att, BT_ATT_OP_MTU_REQ,
+								exchange_mtu_cb,
+								server, NULL);
+	if (!server->mtu_id)
+		return false;
+
+	return true;
+}
+
 struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 					struct bt_att *att, uint16_t mtu)
 {
-- 
2.1.0.rc2.206.gedb03e5

