Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/31] Bluetooth: Track LE L2CAP credits in l2cap_chan
Date: Wed,  4 Dec 2013 16:11:12 +0200
Message-Id: <1386166287-13693-17-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds tracking of L2CAP connection oriented channel local and
remote credits to struct l2cap_chan and ensures that connect requests
and responses contain the right values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 16 +++++++++++-----
 net/bluetooth/l2cap_sock.c    |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c60498907180..8c59ed17ee90 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -514,6 +514,9 @@ struct l2cap_chan {
 	__u16		monitor_timeout;
 	__u16		mps;
 
+	__u16		tx_credits;
+	__u16		rx_credits;
+
 	__u8		tx_state;
 	__u8		rx_state;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4ca6fbc777f0..8a1c528908fb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -495,6 +495,8 @@ void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 	chan->imtu = L2CAP_DEFAULT_MTU;
 	chan->omtu = L2CAP_LE_MIN_MTU;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
+	chan->tx_credits = 0;
+	chan->rx_credits = L2CAP_LE_MAX_CREDITS;
 }
 
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -643,7 +645,7 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 	rsp.dcid    = cpu_to_le16(chan->scid);
 	rsp.mtu     = cpu_to_le16(chan->imtu);
 	rsp.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
-	rsp.credits = __constant_cpu_to_le16(L2CAP_LE_MAX_CREDITS);
+	rsp.credits = cpu_to_le16(chan->rx_credits);
 	rsp.result  = cpu_to_le16(result);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
@@ -1212,7 +1214,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	req.scid    = cpu_to_le16(chan->scid);
 	req.mtu     = cpu_to_le16(chan->imtu);
 	req.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
-	req.credits = __constant_cpu_to_le16(L2CAP_LE_MAX_CREDITS);
+	req.credits = cpu_to_le16(chan->rx_credits);
 
 	chan->ident = l2cap_get_ident(conn);
 
@@ -3690,7 +3692,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 	rsp.dcid    = cpu_to_le16(chan->scid);
 	rsp.mtu     = cpu_to_le16(chan->imtu);
 	rsp.mps     = __constant_cpu_to_le16(L2CAP_LE_DEFAULT_MPS);
-	rsp.credits = __constant_cpu_to_le16(L2CAP_LE_MAX_CREDITS);
+	rsp.credits = cpu_to_le16(chan->rx_credits);
 	rsp.result  = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
@@ -5342,6 +5344,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		chan->dcid = dcid;
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
+		chan->tx_credits = credits;
 		l2cap_chan_ready(chan);
 		break;
 
@@ -5445,7 +5448,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	struct l2cap_le_conn_req *req = (struct l2cap_le_conn_req *) data;
 	struct l2cap_le_conn_rsp rsp;
 	struct l2cap_chan *chan, *pchan;
-	u16 dcid, scid, mtu, mps;
+	u16 dcid, scid, credits, mtu, mps;
 	__le16 psm;
 	u8 result;
 
@@ -5457,6 +5460,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	mps  = __le16_to_cpu(req->mps);
 	psm  = req->psm;
 	dcid = 0;
+	credits = 0;
 
 	if (mtu < 23 || mps < 23)
 		return -EPROTO;
@@ -5501,9 +5505,11 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->dcid = scid;
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
+	chan->tx_credits = __le16_to_cpu(req->credits);
 
 	__l2cap_chan_add(conn, chan);
 	dcid = chan->scid;
+	credits = chan->rx_credits;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
@@ -5535,7 +5541,7 @@ response:
 	}
 
 	rsp.dcid    = cpu_to_le16(dcid);
-	rsp.credits = __constant_cpu_to_le16(L2CAP_LE_MAX_CREDITS);
+	rsp.credits = cpu_to_le16(credits);
 	rsp.result  = cpu_to_le16(result);
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_LE_CONN_RSP, sizeof(rsp), &rsp);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 485ca349fed5..61e25bafdf43 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1321,6 +1321,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
 		chan->flags = pchan->flags;
+		chan->tx_credits = pchan->tx_credits;
+		chan->rx_credits = pchan->rx_credits;
 
 		security_sk_clone(parent, sk);
 	} else {
-- 
1.8.4.2

