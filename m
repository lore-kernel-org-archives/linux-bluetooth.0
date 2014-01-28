Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix consistency of local vs remote PSM reporting
Date: Tue, 28 Jan 2014 14:13:37 -0800
Message-Id: <1390947217-21874-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're the initiators of a connection the PSM resides on the remote
side and when we're acceptors on the local side. Since the PSM isn't
defined for the initiating side for all practical purposes it should
have the value 0 if requested by user space.

The l2cap_chan structure contains two values for a PSM, psm and sport,
which are used to return the value for getsockname() and getpeername().
However, the values returned haven't really been consistent. When we
initiate an outgoing connection the sport value should be set to 0, and
when we receive an incoming connect request the sport of the newly
created l2cap_chan should reflect the targetted PSM.

It's important the chan->psm has always a valid value since there are
several code paths that rely on it being set regardless of acceptor or
initiator use cases.

This patch updates the relevant outgoing and incoming connection paths
to ensure that the psm and sport l2cap_chan members have the appropriate
values in all cases.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d2ef49b54aa2..a5519a8dcb65 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3774,7 +3774,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
 	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
-	chan->psm  = psm;
+	chan->psm = psm;
+	chan->sport = psm;
 	chan->dcid = scid;
 	chan->local_amp_id = amp_id;
 
@@ -5421,7 +5422,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
 	chan->dst_type = bdaddr_type(conn->hcon, conn->hcon->dst_type);
-	chan->psm  = psm;
+	chan->psm = psm;
+	chan->sport = psm;
 	chan->dcid = scid;
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
@@ -7083,6 +7085,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->dst_type = dst_type;
 
 	chan->psm = psm;
+	chan->sport = 0;
 	chan->dcid = cid;
 
 	auth_type = l2cap_get_auth_type(chan);
-- 
1.8.5.3

