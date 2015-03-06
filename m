Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/7] shared/gatt-client: Add helper to cancel long write request
Date: Fri,  6 Mar 2015 14:10:40 +0100
Message-Id: <1425647445-19722-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425647445-19722-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425647445-19722-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c | 61 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b8c4bd8..af12860 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1769,10 +1769,34 @@ static void cancel_long_write_cb(uint8_t opcode, const void *pdu, uint16_t len,
 	/* Do nothing */
 }
 
+static bool cancel_long_write_req(struct bt_gatt_client *client,
+							struct request *req)
+{
+	uint8_t pdu = 0x00;
+	bool ret;
+
+	/*
+	 * att_id == 0 means that request has been queued and no prepare write
+	 * has been sent so far.Let's just remove if from the queue.
+	 * Otherwise execute write needs to be send.
+	 */
+	if (!req->att_id)
+		ret = queue_remove(client->long_write_queue, req);
+	else
+		ret = !!bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
+							sizeof(pdu),
+							cancel_long_write_cb,
+							NULL, NULL);
+
+	if (queue_isempty(client->long_write_queue))
+		client->in_long_write = false;
+
+	return ret;
+}
+
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 {
 	struct request *req;
-	uint8_t pdu = 0x00;
 
 	if (!client || !id || !client->att)
 		return false;
@@ -1788,19 +1812,8 @@ bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 		return false;
 
 	/* If this was a long-write, we need to abort all prepared writes */
-	if (!req->long_write)
-		return true;
-
-	if (!req->att_id)
-		queue_remove(client->long_write_queue, req);
-	else
-		bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ,
-							&pdu, sizeof(pdu),
-							cancel_long_write_cb,
-							NULL, NULL);
-
-	if (queue_isempty(client->long_write_queue))
-		client->in_long_write = false;
+	if (req->long_write)
+		return cancel_long_write_req(client, req);
 
 	return true;
 }
@@ -1808,27 +1821,13 @@ bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 static void cancel_request(void *data)
 {
 	struct request *req = data;
-	uint8_t pdu = 0x00;
 
 	req->removed = true;
 
-	if (!req->long_write) {
-		bt_att_cancel(req->client->att, req->att_id);
-		return;
-	}
-
-	if (!req->att_id)
-		queue_remove(req->client->long_write_queue, req);
-
-	if (queue_isempty(req->client->long_write_queue))
-		req->client->in_long_write = false;
-
-	bt_att_send(req->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
-							&pdu, sizeof(pdu),
-							cancel_long_write_cb,
-							NULL, NULL);
-
 	bt_att_cancel(req->client->att, req->att_id);
+
+	if (req->long_write)
+		cancel_long_write_req(req->client, req);
 }
 
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
-- 
1.8.4

