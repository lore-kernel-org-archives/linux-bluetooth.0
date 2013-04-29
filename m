Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/13] Bluetooth: Fix hardcoding ATT CID in __l2cap_chan_add()
Date: Mon, 29 Apr 2013 19:35:38 +0300
Message-Id: <1367253345-12482-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since in the future more than the ATT CID may be permissible we should
not be hardcoding it for all LE connections in __l2cap_chan_add().
Instead, the source ATT CID should only be set if the destination is
also ATT, and in other cases we should just use the existing dynamic CID
allocation function.

Assigning scid based on dcid means that whenever __l2cap_chan_add() is
called that chan->dcid is properly initialized. l2cap_le_conn_ready()
wasn't initializing is properly so this is also taken care of in this
patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fd8d3059..dd7f9b3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -504,8 +504,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_DEFAULT_MTU;
-			chan->scid = L2CAP_CID_ATT;
-			chan->dcid = L2CAP_CID_ATT;
+			if (chan->dcid == L2CAP_CID_ATT)
+				chan->scid = L2CAP_CID_ATT;
+			else
+				chan->scid = l2cap_alloc_cid(conn);
 		} else {
 			/* Alloc CID for connection-oriented socket */
 			chan->scid = l2cap_alloc_cid(conn);
@@ -1357,6 +1359,8 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!chan)
 		goto clean;
 
+	chan->dcid = L2CAP_CID_ATT;
+
 	sk = chan->sk;
 
 	hci_conn_hold(conn->hcon);
-- 
1.7.10.4

