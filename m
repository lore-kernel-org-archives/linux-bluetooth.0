Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 28/32] Bluetooth: Fix clearing of chan->omtu for LE CoC channels
Date: Thu,  5 Dec 2013 15:11:26 +0200
Message-Id: <1386249090-10236-29-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The outgoing MTU should only be set upon channel creation to the initial
minimum value (23) or from a remote connect req/rsp PDU.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ce34f1518f96..e6bf5ed16313 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -516,12 +516,12 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (conn->hcon->type == LE_LINK) {
-			/* LE connection */
-			chan->omtu = L2CAP_DEFAULT_MTU;
-			if (chan->dcid == L2CAP_CID_ATT)
+			if (chan->dcid == L2CAP_CID_ATT) {
+				chan->omtu = L2CAP_DEFAULT_MTU;
 				chan->scid = L2CAP_CID_ATT;
-			else
+			} else {
 				chan->scid = l2cap_alloc_cid(conn);
+			}
 		} else {
 			/* Alloc CID for connection-oriented socket */
 			chan->scid = l2cap_alloc_cid(conn);
-- 
1.8.4.2

