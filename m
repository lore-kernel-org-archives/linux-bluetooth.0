Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix CID initialization for fixed channels
Date: Sat, 25 Jan 2014 17:10:09 -0500
Message-Id: <1390687809-14408-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
References: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Fixed channels have the same source and destination CID. Ensure that the
values get properly initialized when receiving incoming connections and
deriving values from the parent socket.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 --
 net/bluetooth/l2cap_sock.c | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3a9917be6c6e..f86e98c47094 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1466,8 +1466,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!chan)
 		goto clean;
 
-	chan->dcid = L2CAP_CID_ATT;
-
 	bacpy(&chan->src, &hcon->src);
 	bacpy(&chan->dst, &hcon->dst);
 	chan->src_type = bdaddr_type(hcon, hcon->src_type);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 588d43b1c18e..304fc8589af4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1470,6 +1470,11 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->tx_credits = pchan->tx_credits;
 		chan->rx_credits = pchan->rx_credits;
 
+		if (chan->chan_type == L2CAP_CHAN_FIXED) {
+			chan->scid = pchan->scid;
+			chan->dcid = pchan->scid;
+		}
+
 		security_sk_clone(parent, sk);
 	} else {
 		switch (sk->sk_type) {
-- 
1.8.5.3

