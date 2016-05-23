Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mikhail Krivtsov <mikhail.krivtsov@gmail.com>
Subject: gatt client clones break indication/confirmation
To: linux-bluetooth@vger.kernel.org
Message-ID: <5742D40A.4080903@gmail.com>
Date: Mon, 23 May 2016 12:57:30 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020105030502090203030201"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020105030502090203030201
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

When bt_gatt_client receives 'indication' it sends 'confirmation'.
'confirmation' sending was broken after adding support for 'clones' of
bt_gatt_client. In addition to first bt_gatt_client each clone also
sends 'confirmation'.

# > ACL Data RX: Handle 69 flags 0x02 dlen 27
#       ATT: Handle Value Indication (0x1d) len 22
#         Handle: 0x001f
#           Data: 68656c6c6f2027302e302e302e303a3532353332
# < ACL Data TX: Handle 69 flags 0x00 dlen 5
#       ATT: Handle Value Confirmation (0x1e) len 0
# < ACL Data TX: Handle 69 flags 0x00 dlen 5
#       ATT: Handle Value Confirmation (0x1e) len 0

Extra confirmation sent by clone confuses remote side. When bluetooth
daemon receives extra confirmation it breaks connection.

Attached patch fixes the issue limiting confirmation sending to single
bt_gatt_client.


--------------020105030502090203030201
Content-Type: text/x-patch;
 name="0001-shared-gatt-client_Fix_sending_confirmation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-shared-gatt-client_Fix_sending_confirmation.patch"

>>From e470089b4b5788ab5d2ec9af21bffee4f9240c97 Mon Sep 17 00:00:00 2001
From: "Mikhail I. Krivtsov" <mikhail.krivtsov@gmail.com>
Date: Sat, 14 May 2016 11:37:30 +0300
Subject: [PATCH] shared/gatt-client: Fix sending confirmation

Confirmation shall be sent from topmost parent only.
Extra confirmation sent by clone confuses remote side.

> ACL Data RX: Handle 69 flags 0x02 dlen 27
      ATT: Handle Value Indication (0x1d) len 22
        Handle: 0x001f
          Data: 68656c6c6f2027302e302e302e303a3532353332
< ACL Data TX: Handle 69 flags 0x00 dlen 5
      ATT: Handle Value Confirmation (0x1e) len 0
< ACL Data TX: Handle 69 flags 0x00 dlen 5
      ATT: Handle Value Confirmation (0x1e) len 0
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 84689f6..adabfe3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1745,7 +1745,7 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 
 	queue_foreach(client->notify_list, notify_handler, &pdu_data);
 
-	if (opcode == BT_ATT_OP_HANDLE_VAL_IND)
+	if (opcode == BT_ATT_OP_HANDLE_VAL_IND && !client->parent)
 		bt_att_send(client->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
 							NULL, NULL, NULL);
 
-- 
2.7.3



--------------020105030502090203030201--
