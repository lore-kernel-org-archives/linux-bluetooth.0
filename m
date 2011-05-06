Return-Path: <cyrus@holtmann.org>
From: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Subject: [PATCH v2] Bluetooth: Allow unsegmented SDU retries on sock_queue_rcv_skb failure.
Date: Fri, 6 May 2011 12:44:11 +0800
Message-ID: <1304657051-26453-1-git-send-email-Ruiyi.zhang@atheros.com>
In-Reply-To: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
References: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error,
l2cap_ertm_reassembly_sdu should not return 0 so as to insert the
skb into BUSY_QUEUE for later retries.

Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
---
 net/bluetooth/l2cap_core.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2c8dd44..623421c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2784,11 +2784,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
 		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
-		err = sock_queue_rcv_skb(sk, skb);
-		if (!err)
-			return err;
-
-		break;
+		return sock_queue_rcv_skb(sk, skb);
 
 	case L2CAP_SDU_START:
 		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
-- 
1.7.1

