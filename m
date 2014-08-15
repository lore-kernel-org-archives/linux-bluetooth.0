Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: Fix hci_conn reference counting for fixed channels
Date: Fri, 15 Aug 2014 21:06:53 +0300
Message-Id: <1408126019-29761-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
References: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that SMP has been converted to use fixed channels we've got a bit of
a problem with the hci_conn reference counting. So far the L2CAP code
has kept a reference for each L2CAP channel that was notified of the
connection. With SMP however this would mean that the connection is
never dropped even though there are no other users of it. Furthermore,
SMP already does its own hci_conn reference counting internally,
starting from a security or pairing request and ending with the key
distribution.

This patch makes L2CAP fixed channels default to the L2CAP core not
keeping a hci_conn reference for them. A new FLAG_HOLD_HCI_CONN flag is
added so that L2CAP users can declare an exception to this rule and hold
a reference even for their fixed channels. One such exception is the
L2CAP socket layer which does want a reference for each socket (e.g. an
ATT socket which uses a fixed channel).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 12 ++++++++++--
 net/bluetooth/l2cap_sock.c    |  8 ++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cedda399f9c0..1558eccb19db 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -711,6 +711,7 @@ enum {
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
+	FLAG_HOLD_HCI_CONN,
 };
 
 enum {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 777c41dbfdbe..a6559225bb50 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -546,7 +546,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	l2cap_chan_hold(chan);
 
-	hci_conn_hold(conn->hcon);
+	/* Only keep a reference for fixed channels if they requested it */
+	if (chan->chan_type != L2CAP_CHAN_FIXED ||
+	    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
+		hci_conn_hold(conn->hcon);
 
 	list_add(&chan->list, &conn->chan_l);
 }
@@ -577,7 +580,12 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		chan->conn = NULL;
 
-		if (chan->scid != L2CAP_CID_A2MP)
+		/* Reference was only held for non-fixed channels or
+		 * fixed channels that explicitly requested it using the
+		 * FLAG_HOLD_HCI_CONN flag.
+		 */
+		if (chan->chan_type != L2CAP_CHAN_FIXED ||
+		    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
 			hci_conn_drop(conn->hcon);
 
 		if (mgr && mgr->bredr_chan == chan)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ed06f88e6f10..75eff0056b42 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -146,6 +146,14 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	case L2CAP_CHAN_RAW:
 		chan->sec_level = BT_SECURITY_SDP;
 		break;
+	case L2CAP_CHAN_FIXED:
+		/* Fixed channels default to the L2CAP core not holding a
+		 * hci_conn reference for them. For fixed channels mapping to
+		 * L2CAP sockets we do want to hold a reference so set the
+		 * appropriate flag to request it.
+		 */
+		set_bit(FLAG_HOLD_HCI_CONN, &l2cap_pi(sk)->chan->flags);
+		break;
 	}
 
 	bacpy(&chan->src, &la.l2_bdaddr);
-- 
1.9.3

