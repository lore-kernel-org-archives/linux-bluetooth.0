Return-Path: <cyrus@holtmann.org>
From: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Subject: [PATCH] Bluetooth: Allow unsegmented SDU retries on sock_queue_rcv_skb failure. In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error, l2cap_ertm_reassembly_sdu should not return 0 so as to insert the skb into BUSY_QUEUE for later retries.
Date: Thu, 28 Apr 2011 19:31:04 +0800
Message-ID: <1303990264-15387-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
---
 net/bluetooth/l2cap_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ca27f3a..3b2f140 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2784,8 +2784,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 			goto drop;
 
 		err = sock_queue_rcv_skb(sk, skb);
-		if (!err)
-			return err;
+		return err;
 
 		break;
 
-- 
1.7.1

