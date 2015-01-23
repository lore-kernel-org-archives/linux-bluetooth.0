Return-Path: <cyrus@holtmann.org>
From: Romain Izard <romain.izard.pro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 1/2] shared/gatt-server: Avoid memory corruption
Date: Fri, 23 Jan 2015 15:25:15 +0100
Message-Id: <1422023116-30516-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When sending notification and indication data, the size of the allocated
packet is the smallest of the MTU and the payload size.

The copy procedure uses the payload size in all cases, which can lead to
memory corruption. Use the packet size instead.
---
 src/shared/gatt-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index b406ed6..dd9c88f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1506,7 +1506,7 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 		return false;
 
 	put_le16(handle, pdu);
-	memcpy(pdu + 2, value, length);
+	memcpy(pdu + 2, value, pdu_len - 2);
 
 	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_NOT, pdu,
 						pdu_len, NULL, NULL, NULL);
@@ -1571,7 +1571,7 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 	data->user_data = user_data;
 
 	put_le16(handle, pdu);
-	memcpy(pdu + 2, value, length);
+	memcpy(pdu + 2, value, pdu_len - 2);
 
 	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_IND, pdu,
 							pdu_len, conf_cb,
-- 
2.1.0

