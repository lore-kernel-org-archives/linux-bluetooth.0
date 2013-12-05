Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/32] Bluetooth: Update l2cap_global_chan_by_psm() to take a link type
Date: Thu,  5 Dec 2013 15:11:01 +0200
Message-Id: <1386249090-10236-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once connection oriented L2CAP channels become possible for LE we need
to be able to specify the link type we're interested in when looking up
L2CAP channels. Therefore, add a link_type parameter to the
l2cap_global_chan_by_psm() function which gets compared to the address
type associated with each l2cap_chan.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70be2eb8ed03..03b641c2f39d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1703,7 +1703,8 @@ EXPORT_SYMBOL(l2cap_conn_put);
  */
 static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 						   bdaddr_t *src,
-						   bdaddr_t *dst)
+						   bdaddr_t *dst,
+						   u8 link_type)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -1713,6 +1714,12 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 		if (state && c->state != state)
 			continue;
 
+		if (link_type == ACL_LINK && c->src_type != BDADDR_BREDR)
+			continue;
+
+		if (link_type == LE_LINK && c->src_type == BDADDR_BREDR)
+			continue;
+
 		if (c->psm == psm) {
 			int src_match, dst_match;
 			int src_any, dst_any;
@@ -3713,7 +3720,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
-					 &conn->hcon->dst);
+					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
 		goto sendresp;
@@ -6380,7 +6387,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
-	chan = l2cap_global_chan_by_psm(0, psm, &hcon->src, &hcon->dst);
+	chan = l2cap_global_chan_by_psm(0, psm, &hcon->src, &hcon->dst,
+					ACL_LINK);
 	if (!chan)
 		goto drop;
 
-- 
1.8.4.2

