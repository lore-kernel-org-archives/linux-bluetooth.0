Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: L2CAP: Fix setting chan src info before adding PSM/CID
Date: Tue, 26 Jan 2016 17:19:11 -0500
Message-Id: <1453846751-5925-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
References: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

At least the l2cap_add_psm() routine depends on the source address
type being properly set to know what auto-allocation ranges to use, so
the assignment to l2cap_chan needs to happen before this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f401592e5837..e4cae72895a7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -125,6 +125,9 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			goto done;
 	}
 
+	bacpy(&chan->src, &la.l2_bdaddr);
+	chan->src_type = la.l2_bdaddr_type;
+
 	if (la.l2_cid)
 		err = l2cap_add_scid(chan, __le16_to_cpu(la.l2_cid));
 	else
@@ -156,9 +159,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		break;
 	}
 
-	bacpy(&chan->src, &la.l2_bdaddr);
-	chan->src_type = la.l2_bdaddr_type;
-
 	if (chan->psm && bdaddr_type_is_le(chan->src_type))
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-- 
2.5.0

