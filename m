Return-Path: <cyrus@holtmann.org>
From: Ruiyi Zhang <Ruiyi.Zhang@Atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Ruiyi Zhang <Ruiyi.Zhang@Atheros.com>
Subject: [PATCH v3] Bluetooth: Allow unsegmented SDU retries on sock_queue_rcv_skb failure.
Date: Fri, 13 May 2011 13:07:52 +0800
Message-ID: <7f3edf43a88fbbcd8ef1797450b43eda889e2c9a.1305256769.git.Ruiyi.Zhang@Atheros.com>
In-Reply-To: <20110511175555.GE22065@joana>
References: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com> <1304657051-26453-1-git-send-email-Ruiyi.zhang@atheros.com> <20110511175555.GE22065@joana>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error,
l2cap_ertm_reassembly_sdu should not return 0 so as to insert the
skb into BUSY_QUEUE for later retries.

Signed-off-by: Ruiyi Zhang <Ruiyi.Zhang@Atheros.com>
---
 net/bluetooth/l2cap_core.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5ab4a2..a99e5d7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2928,11 +2928,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
-		err = sock_queue_rcv_skb(chan->sk, skb);
-		if (!err)
-			return err;
-
-		break;
+		return sock_queue_rcv_skb(chan->sk, skb);
 
 	case L2CAP_SDU_START:
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
-- 
1.7.1

