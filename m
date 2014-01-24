Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Switch ATT channels to use L2CAP_CHAN_FIXED
Date: Fri, 24 Jan 2014 10:35:41 +0200
Message-Id: <1390552541-11729-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390552541-11729-1-git-send-email-johan.hedberg@gmail.com>
References: <1390552541-11729-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

ATT channels are not connection oriented so having them use
L2CAP_CHAN_CONN_ORIENTED is quite confusing. Instead, use the new
L2CAP_CHAN_FIXED type and ensure that the MTU and CID values get
properly set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 21 +++++++++------------
 net/bluetooth/l2cap_sock.c |  9 +++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cd28057d2903..e5c5c7427c41 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -498,18 +498,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
-		if (conn->hcon->type == LE_LINK) {
-			if (chan->dcid == L2CAP_CID_ATT) {
-				chan->omtu = L2CAP_DEFAULT_MTU;
-				chan->scid = L2CAP_CID_ATT;
-			} else {
-				chan->scid = l2cap_alloc_cid(conn);
-			}
-		} else {
-			/* Alloc CID for connection-oriented socket */
-			chan->scid = l2cap_alloc_cid(conn);
+		/* Alloc CID for connection-oriented socket */
+		chan->scid = l2cap_alloc_cid(conn);
+		if (conn->hcon->type == ACL_LINK)
 			chan->omtu = L2CAP_DEFAULT_MTU;
-		}
 		break;
 
 	case L2CAP_CHAN_CONN_LESS:
@@ -7025,7 +7017,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
-	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && !(psm || cid)) {
+	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && !psm) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (chan->chan_type == L2CAP_CHAN_FIXED && !cid) {
 		err = -EINVAL;
 		goto done;
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4aa6704f0b33..3f8e2a223474 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -101,6 +101,15 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
+	if (la.l2_cid) {
+		/* When the socket gets created it defaults to
+		 * CHAN_CONN_ORIENTED, so we need to overwrite the
+		 * default here.
+		 */
+		chan->chan_type = L2CAP_CHAN_FIXED;
+		chan->omtu = L2CAP_DEFAULT_MTU;
+	}
+
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
 		if (!enable_lecoc && la.l2_psm)
 			return -EINVAL;
-- 
1.8.5.3

