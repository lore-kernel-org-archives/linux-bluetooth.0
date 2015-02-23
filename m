Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/gatt-client: Add support for signed write
Date: Mon, 23 Feb 2015 20:13:59 +0200
Message-Id: <1424715241-4980-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
References: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-client.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ac2692f..a966dd0 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2129,10 +2129,6 @@ unsigned int bt_gatt_client_write_without_response(
 	if (!client)
 		return 0;
 
-	/* TODO: Support this once bt_att_send supports signed writes. */
-	if (signed_write)
-		return 0;
-
 	req = request_create(client);
 	if (!req)
 		return 0;
@@ -2140,9 +2136,10 @@ unsigned int bt_gatt_client_write_without_response(
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_CMD,
-							pdu, sizeof(pdu),
-							NULL, NULL, NULL);
+	req->att_id = bt_att_send(client->att,
+				signed_write ?  BT_ATT_OP_SIGNED_WRITE_CMD :
+				BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
+				NULL, NULL, NULL);
 	if (!req->att_id) {
 		request_unref(req);
 		return 0;
-- 
2.1.0

