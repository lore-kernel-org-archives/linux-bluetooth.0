Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 6/7] shared/gatt-client: Support cancel of prepare write
Date: Fri,  6 Mar 2015 17:48:57 +0100
Message-Id: <1425660538-25884-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support to cancel prepare write done from gatt client
---
 src/shared/gatt-client.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b3af611..b73f7fa 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1795,6 +1795,25 @@ static bool cancel_long_write_req(struct bt_gatt_client *client,
 
 }
 
+static void cancel_prep_write_cb(uint8_t opcode, const void *pdu, uint16_t len,
+								void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	client->reliable_write_session_id = 0;
+}
+
+static bool cancel_prep_write_session(struct bt_gatt_client *client,
+							struct request *req)
+{
+	uint8_t pdu = 0x00;
+
+	return !!bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
+							sizeof(pdu),
+							cancel_prep_write_cb,
+							client, NULL);
+}
+
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 {
 	struct request *req;
@@ -1809,13 +1828,17 @@ bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 
 	req->removed = true;
 
-	if (!bt_att_cancel(client->att, req->att_id) && !req->long_write)
+	if (!bt_att_cancel(client->att, req->att_id) && !req->long_write &&
+							!req->prep_write)
 		return false;
 
 	/* If this was a long-write, we need to abort all prepared writes */
 	if (req->long_write)
 		return cancel_long_write_req(client, req);
 
+	if (req->prep_write)
+		return cancel_prep_write_session(client, req);
+
 	return true;
 }
 
@@ -1829,6 +1852,9 @@ static void cancel_request(void *data)
 
 	if (req->long_write)
 		cancel_long_write_req(req->client, req);
+
+	if (req->prep_write)
+		cancel_prep_write_session(req->client, req);
 }
 
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
-- 
1.8.4

