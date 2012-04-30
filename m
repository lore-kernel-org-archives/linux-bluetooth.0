Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Balance locking in L2CAP
Date: Mon, 30 Apr 2012 14:55:15 +0300
Message-Id: <1335786916-9845-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After applying commit 62065ab3d37d7e71f44fb986ade6a285fa4c50fa locks
get unbalanced. That commit required another patch to be applied.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 99e5c88..057bb1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5053,6 +5053,9 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			release_sock(sk);
 		}
 
+		if (chan)
+			l2cap_chan_unlock(chan);
+
 		/* Allocate skb for the complete frame (with header) */
 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
 		if (!conn->rx_skb)
-- 
1.7.9.5

