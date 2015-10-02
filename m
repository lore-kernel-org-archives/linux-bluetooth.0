Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	grzegorz.kolodziejczyk@tieto.com,
	viro@zeniv.linux.org.uk,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] bnep:Fix variable assignment to function return value in the function bnep_rx_extenstion
Date: Fri,  2 Oct 2015 11:37:55 -0400
Message-Id: <1443800275-23972-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes variable assignment for the variable err that returns
to the caller of bnep_rx_extension has finish all its intended work
or has failed by returning a error code to be properly assigned to
the return value of the call to the function bnep_rx_control due to
this function being able to fail and callers of bnep_rx_extension
needing to be able to properly be signaled when this occurs.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 1641367..09cecb3a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -270,7 +270,7 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
 		switch (h->type & BNEP_TYPE_MASK) {
 		case BNEP_EXT_CONTROL:
-			bnep_rx_control(s, skb->data, skb->len);
+			err = bnep_rx_control(s, skb->data, skb->len);
 			break;
 
 		default:
-- 
2.1.4
