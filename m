Return-Path: <cyrus@holtmann.org>
From: Romain Izard <romain.izard.pro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 2/2] shared/gatt-server: Fix notification & indication packet size
Date: Fri, 23 Jan 2015 15:25:16 +0100
Message-Id: <1422023116-30516-2-git-send-email-romain.izard.pro@gmail.com>
In-Reply-To: <1422023116-30516-1-git-send-email-romain.izard.pro@gmail.com>
References: <1422023116-30516-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For both Handle Value Notification & Handle Value Indication, the size
of the payload is limited to (ATT_MTU - 3) bytes, as indicated in Vol 3,
part F, section 3.4.7.1 & 3.4.7.2 of the Bluetooth 4.2 specification.

In the function, the first reserved byte is implicit and corresponds to
the opcode, while the 2 next bytes are explicit and contain the
attribute handle.

Ensure that the truncation of large payloads is done with the correct
value.
---
 src/shared/gatt-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index dd9c88f..c7974fb 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1500,7 +1500,7 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	if (!server || (length && !value))
 		return false;
 
-	pdu_len = MIN(bt_att_get_mtu(server->att), length + 2);
+	pdu_len = MIN(bt_att_get_mtu(server->att) - 1, length + 2);
 	pdu = malloc(pdu_len);
 	if (!pdu)
 		return false;
@@ -1555,7 +1555,7 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 	if (!server || (length && !value))
 		return false;
 
-	pdu_len = MIN(bt_att_get_mtu(server->att), length + 2);
+	pdu_len = MIN(bt_att_get_mtu(server->att) - 1, length + 2);
 	pdu = malloc(pdu_len);
 	if (!pdu)
 		return false;
-- 
2.1.0

