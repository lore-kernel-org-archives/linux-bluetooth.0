Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/7] shared/gatt-client: Make usage of cancel_long_write_cb
Date: Fri,  6 Mar 2015 17:48:54 +0100
Message-Id: <1425660538-25884-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clear in_long_write flag when cancel write execute is done
---
 src/shared/gatt-client.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index af12860..acb6200 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1766,14 +1766,16 @@ static bool match_req_id(const void *a, const void *b)
 static void cancel_long_write_cb(uint8_t opcode, const void *pdu, uint16_t len,
 								void *user_data)
 {
-	/* Do nothing */
+	struct bt_gatt_client *client = user_data;
+
+	if (queue_isempty(client->long_write_queue))
+		client->in_long_write = false;
 }
 
 static bool cancel_long_write_req(struct bt_gatt_client *client,
 							struct request *req)
 {
 	uint8_t pdu = 0x00;
-	bool ret;
 
 	/*
 	 * att_id == 0 means that request has been queued and no prepare write
@@ -1781,17 +1783,13 @@ static bool cancel_long_write_req(struct bt_gatt_client *client,
 	 * Otherwise execute write needs to be send.
 	 */
 	if (!req->att_id)
-		ret = queue_remove(client->long_write_queue, req);
-	else
-		ret = !!bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
+		return queue_remove(client->long_write_queue, req);
+
+	return !!bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
 							sizeof(pdu),
 							cancel_long_write_cb,
-							NULL, NULL);
-
-	if (queue_isempty(client->long_write_queue))
-		client->in_long_write = false;
+							client, NULL);
 
-	return ret;
 }
 
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
-- 
1.8.4

