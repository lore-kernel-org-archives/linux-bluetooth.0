Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Return the correct address type for L2CAP sockets
Date: Sun, 13 Oct 2013 08:50:41 -0700
Message-Id: <1381679441-57025-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP sockets can use BR/EDR public, LE public and LE random
addresses for various combinations of source and destination
devices. So make sure that getsockname(), getpeername() and
accept() return the correct address type.

For this the address type of the source and destination is stored
with the L2CAP channel information. The stored address type is
not the one specific for the HCI protocol. It is the address
type used for the L2CAP sockets and the management interface.

The underlying HCI connections store the HCI address type. If
needed, it gets converted to the socket address type.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  5 +++--
 net/bluetooth/l2cap_core.c    | 18 ++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 26b5066..a27d51d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -445,8 +445,11 @@ struct l2cap_chan {
 	__u8		state;
 
 	bdaddr_t	dst;
+	__u8		dst_type;
 	bdaddr_t	src;
+	__u8		src_type;
 	__le16		psm;
+	__le16		sport;
 	__u16		dcid;
 	__u16		scid;
 
@@ -457,8 +460,6 @@ struct l2cap_chan {
 	__u8		chan_type;
 	__u8		chan_policy;
 
-	__le16		sport;
-
 	__u8		sec_level;
 
 	__u8		ident;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index be3e0f8..769c379 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,18 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		     struct sk_buff_head *skbs, u8 event);
 
+static inline __u8 bdaddr_type(struct hci_conn *hcon, __u8 type)
+{
+	if (hcon->type == LE_LINK) {
+		if (type == ADDR_LE_DEV_PUBLIC)
+			return BDADDR_LE_PUBLIC;
+		else
+			return BDADDR_LE_RANDOM;
+	}
+
+	return BDADDR_BREDR;
+}
+
 /* ---- L2CAP channels ---- */
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
@@ -1398,6 +1410,8 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
+	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
+	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
 
 	__l2cap_chan_add(conn, chan);
 
@@ -1818,6 +1832,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	/* Set destination address and psm */
 	bacpy(&chan->dst, dst);
+	chan->dst_type = dst_type;
 
 	chan->psm = psm;
 	chan->dcid = cid;
@@ -1851,6 +1866,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	/* Update source addr of the socket */
 	bacpy(&chan->src, &hcon->src);
+	chan->src_type = bdaddr_type(hcon, hcon->src_type);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_add(conn, chan);
@@ -3791,6 +3807,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
+	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
+	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
 	chan->psm  = psm;
 	chan->dcid = scid;
 	chan->local_amp_id = amp_id;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9fe80d2..6262e23 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -113,6 +113,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	}
 
 	bacpy(&chan->src, &la.l2_bdaddr);
+	chan->src_type = la.l2_bdaddr_type;
 
 	chan->state = BT_BOUND;
 	sk->sk_state = BT_BOUND;
@@ -276,10 +277,12 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 		la->l2_psm = chan->psm;
 		bacpy(&la->l2_bdaddr, &chan->dst);
 		la->l2_cid = cpu_to_le16(chan->dcid);
+		la->l2_bdaddr_type = chan->dst_type;
 	} else {
 		la->l2_psm = chan->sport;
 		bacpy(&la->l2_bdaddr, &chan->src);
 		la->l2_cid = cpu_to_le16(chan->scid);
+		la->l2_bdaddr_type = chan->src_type;
 	}
 
 	return 0;
-- 
1.8.3.1

