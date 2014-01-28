Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Always use l2cap_chan->psm for returning PSM to user space
Date: Tue, 28 Jan 2014 15:16:51 -0800
Message-Id: <1390951011-30576-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_chan->psm value is always set to a valid value for a
connection oriented channel. The l2cap_chan->sport is used for tracking
local PSM allocations but will not always have a proper value, such as
with connected sockets derived from a listening socket. This patch fixes
the sock_getname callback to always use chan->psm when returning address
information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a0b8c7aa448e..6ca14c411b89 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -373,13 +373,13 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 	addr->sa_family = AF_BLUETOOTH;
 	*len = sizeof(struct sockaddr_l2);
 
+	la->l2_psm = chan->psm;
+
 	if (peer) {
-		la->l2_psm = chan->psm;
 		bacpy(&la->l2_bdaddr, &chan->dst);
 		la->l2_cid = cpu_to_le16(chan->dcid);
 		la->l2_bdaddr_type = chan->dst_type;
 	} else {
-		la->l2_psm = chan->sport;
 		bacpy(&la->l2_bdaddr, &chan->src);
 		la->l2_cid = cpu_to_le16(chan->scid);
 		la->l2_bdaddr_type = chan->src_type;
-- 
1.8.5.3

