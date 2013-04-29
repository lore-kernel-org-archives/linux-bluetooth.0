Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/13] Bluetooth: Fix multiple LE socket handling
Date: Mon, 29 Apr 2013 19:35:45 +0300
Message-Id: <1367253345-12482-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE ATT server socket needs to be superseded by any ATT client
sockets. Previously this was done by looking at the hcon->out variable
(indicating whether the connection is outgoing or incoming) which is a
too crude way of determining whether the server socket needs to be
picked or not (an outgoing connection doesn't necessarily mean that an
ATT client socket has triggered it).

This patch extends the ATT server socket lookup function
(l2cap_le_conn_ready) to be used for all LE connections (regardless of
the hcon->out value) and adds an internal check into the function for
the existence of any ATT client sockets (in which case the server socket
should be skipped). For this to work reliably all lookups must be done
while the l2cap_conn->chan_lock is held, meaning also that the call to
l2cap_chan_add needs to be changed to its lockless __l2cap_chan_add
counterpart.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d510550..05e6255 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1353,6 +1353,10 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!pchan)
 		return;
 
+	/* Client ATT sockets should override the server one */
+	if (__l2cap_get_chan_by_dcid(conn, L2CAP_CID_ATT))
+		return;
+
 	parent = pchan->sk;
 
 	lock_sock(parent);
@@ -1366,7 +1370,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	bacpy(&bt_sk(chan->sk)->src, conn->src);
 	bacpy(&bt_sk(chan->sk)->dst, conn->dst);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 clean:
 	release_sock(parent);
@@ -1379,9 +1383,6 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	if (!hcon->out && hcon->type == LE_LINK)
-		l2cap_le_conn_ready(conn);
-
 	/* For outgoing pairing which doesn't necessarily have an
 	 * associated socket (e.g. mgmt_pair_device).
 	 */
@@ -1390,6 +1391,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	mutex_lock(&conn->chan_lock);
 
+	if (hcon->type == LE_LINK)
+		l2cap_le_conn_ready(conn);
+
 	list_for_each_entry(chan, &conn->chan_l, list) {
 
 		l2cap_chan_lock(chan);
-- 
1.7.10.4

