Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/13] Bluetooth: Remove useless sk variable in l2cap_le_conn_ready
Date: Mon, 29 Apr 2013 19:35:41 +0300
Message-Id: <1367253345-12482-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The sk variable is of quite little use since it's only used to simplify
access in the two bt_sk() calls.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 881be61..aa4bc70 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1340,7 +1340,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *parent;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1361,13 +1361,11 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	chan->dcid = L2CAP_CID_ATT;
 
-	sk = chan->sk;
-
 	hci_conn_hold(conn->hcon);
 	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
 
-	bacpy(&bt_sk(sk)->src, conn->src);
-	bacpy(&bt_sk(sk)->dst, conn->dst);
+	bacpy(&bt_sk(chan->sk)->src, conn->src);
+	bacpy(&bt_sk(chan->sk)->dst, conn->dst);
 
 	l2cap_chan_add(conn, chan);
 
-- 
1.7.10.4

