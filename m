Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 9/9] Bluetooth: Move parts of fixed channel initialization to l2cap_add_scid
Date: Thu,  7 Aug 2014 22:56:50 +0300
Message-Id: <1407441410-13312-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
References: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_add_scid function is used for registering a fixed L2CAP
channel. Instead of having separate initialization of the channel type
and outgoing MTU in l2cap_sock.c it's more intuitive to do these things
in the l2cap_add_scid function itself (and thereby make the
functionality available to other users besides l2cap_sock.c).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 net/bluetooth/l2cap_sock.c | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09eb4e3e8ab2..344a29c53227 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -210,6 +210,10 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
 {
 	write_lock(&chan_list_lock);
 
+	/* Override the defaults (which are for conn-oriented) */
+	chan->omtu = L2CAP_DEFAULT_MTU;
+	chan->chan_type = L2CAP_CHAN_FIXED;
+
 	chan->scid = scid;
 
 	write_unlock(&chan_list_lock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5a42f6a818c0..ed06f88e6f10 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -99,15 +99,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
-	if (la.l2_cid) {
-		/* When the socket gets created it defaults to
-		 * CHAN_CONN_ORIENTED, so we need to overwrite the
-		 * default here.
-		 */
-		chan->chan_type = L2CAP_CHAN_FIXED;
-		chan->omtu = L2CAP_DEFAULT_MTU;
-	}
-
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
 		/* We only allow ATT user space socket */
 		if (la.l2_cid &&
-- 
1.9.3

