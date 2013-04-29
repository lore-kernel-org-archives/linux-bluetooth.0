Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/13] Bluetooth: Simplify hci_conn_hold/drop logic for L2CAP
Date: Mon, 29 Apr 2013 19:35:43 +0300
Message-Id: <1367253345-12482-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The L2CAP code has been incrementing the hci_conn reference for each
l2cap_chan instance in the l2cap_conn list. Likewise, the reference is
dropped each time an l2cap_chan is removed from the list. The reference
counting policy with respect to removal has been clear and explicit in
the l2cap_chan_drop function, however for addition the function
calling 2cap_chan_add has always had to do a separate hci_conn_hold
call.

What made the counting even more hard to follow is that the
hci_connect() procedure increments the reference and the L2CAP layer
making this call took advantage of it to use it as its own reference.

This patch aims to clarify things by having the call to hci_conn_hold
inside __l2cap_chan_add, thereby removing the need to do it in the
functions calling __l2cap_chan_add. The reference count for hci_connect
is still kept as it's necessary for users such as mgmt_pair_device,
however for the L2CAP layer it means that an extra call to hci_conn_drop
must be performed once l2cap_chan_add has been done.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e373b9d..c78a510 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -545,6 +545,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	l2cap_chan_hold(chan);
 
+	hci_conn_hold(conn->hcon);
+
 	list_add(&chan->list, &conn->chan_l);
 }
 
@@ -1361,7 +1363,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	chan->dcid = L2CAP_CID_ATT;
 
-	hci_conn_hold(conn->hcon);
 	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
 
 	bacpy(&bt_sk(chan->sk)->src, conn->src);
@@ -1827,6 +1828,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	l2cap_chan_add(conn, chan);
 	l2cap_chan_lock(chan);
 
+	/* l2cap_chan_add takes its own ref so we can drop this one */
+	hci_conn_drop(hcon);
+
 	l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
@@ -3741,8 +3745,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	sk = chan->sk;
 
-	hci_conn_hold(conn->hcon);
-
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 	chan->psm  = psm;
-- 
1.7.10.4

