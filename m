Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Trivial refactoring in __l2cap_chan_add
Date: Thu, 31 May 2012 20:59:54 -0300
Message-Id: <1338508794-12534-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All cases in switch statement set chan->omtu to L2CAP_DEFAULT_MTU.
This patch moves the assignments to outside the switch statement.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..0ba8875 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -449,13 +449,11 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
-			chan->omtu = L2CAP_DEFAULT_MTU;
 			chan->scid = L2CAP_CID_LE_DATA;
 			chan->dcid = L2CAP_CID_LE_DATA;
 		} else {
 			/* Alloc CID for connection-oriented socket */
 			chan->scid = l2cap_alloc_cid(conn);
-			chan->omtu = L2CAP_DEFAULT_MTU;
 		}
 		break;
 
@@ -463,7 +461,6 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		/* Connectionless socket */
 		chan->scid = L2CAP_CID_CONN_LESS;
 		chan->dcid = L2CAP_CID_CONN_LESS;
-		chan->omtu = L2CAP_DEFAULT_MTU;
 		break;
 
 	case L2CAP_CHAN_CONN_FIX_A2MP:
@@ -477,9 +474,9 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		/* Raw socket can send/recv signalling messages only */
 		chan->scid = L2CAP_CID_SIGNALING;
 		chan->dcid = L2CAP_CID_SIGNALING;
-		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
+	chan->omtu		= L2CAP_DEFAULT_MTU;
 	chan->local_id		= L2CAP_BESTEFFORT_ID;
 	chan->local_stype	= L2CAP_SERV_BESTEFFORT;
 	chan->local_msdu	= L2CAP_DEFAULT_MAX_SDU_SIZE;
-- 
1.7.10.2

