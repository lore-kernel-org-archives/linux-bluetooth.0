Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 27/31] Bluetooth: Limit LE MPS to the MTU value
Date: Wed,  4 Dec 2013 16:11:23 +0200
Message-Id: <1386166287-13693-28-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It doesn't make sense to have an MPS value greater than the configured
MTU value since we will then not be able to fill up the packets to their
full possible size. We need to set the MPS both in flowctl_init()
as well as flowctl_start() since the imtu may change after init() but
start() is only called after we've sent the LE Connection Request PDU
which depends on having a valid MPS value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 20b8dcf05edd..58fbb78a703f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -497,6 +497,11 @@ void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
 	chan->tx_credits = 0;
 	chan->rx_credits = L2CAP_LE_MAX_CREDITS;
+
+	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
+		chan->mps = chan->imtu;
+	else
+		chan->mps = L2CAP_LE_DEFAULT_MPS;
 }
 
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -645,7 +650,7 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 
 	rsp.dcid    = cpu_to_le16(chan->scid);
 	rsp.mtu     = cpu_to_le16(chan->imtu);
-	rsp.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
+	rsp.mps     = cpu_to_le16(chan->mps);
 	rsp.credits = cpu_to_le16(chan->rx_credits);
 	rsp.result  = cpu_to_le16(result);
 
@@ -1201,6 +1206,11 @@ static void l2cap_le_flowctl_start(struct l2cap_chan *chan)
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
 
+	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
+		chan->mps = chan->imtu;
+	else
+		chan->mps = L2CAP_LE_DEFAULT_MPS;
+
 	skb_queue_head_init(&chan->tx_q);
 
 	if (!chan->tx_credits)
@@ -1232,7 +1242,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	req.psm     = chan->psm;
 	req.scid    = cpu_to_le16(chan->scid);
 	req.mtu     = cpu_to_le16(chan->imtu);
-	req.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
+	req.mps     = cpu_to_le16(chan->mps);
 	req.credits = cpu_to_le16(chan->rx_credits);
 
 	chan->ident = l2cap_get_ident(conn);
@@ -3826,7 +3836,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 
 	rsp.dcid    = cpu_to_le16(chan->scid);
 	rsp.mtu     = cpu_to_le16(chan->imtu);
-	rsp.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
+	rsp.mps     = cpu_to_le16(chan->mps);
 	rsp.credits = cpu_to_le16(chan->rx_credits);
 	rsp.result  = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
 
@@ -5669,7 +5679,7 @@ response_unlock:
 response:
 	if (chan) {
 		rsp.mtu = cpu_to_le16(chan->imtu);
-		rsp.mps = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
+		rsp.mps = cpu_to_le16(chan->mps);
 	} else {
 		rsp.mtu = 0;
 		rsp.mps = 0;
-- 
1.8.4.2

