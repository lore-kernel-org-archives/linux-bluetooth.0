Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix variable assignment for switch case in the function a2mp_chan_recv_cb
Date: Tue, 18 Aug 2015 11:49:50 -0400
Message-Id: <1439912990-15773-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the issue with not assigning the variable err to the return
value of the call to the function a2mp_command_rej for the switch case
A2MP_COMMAND_REJ as this function call can fail and thus callers of
a2mp_chan_recv_cb should be signaled when this internal function call
fails in order for them to handle this failure when calling the function
a2mp_chan_recv_cb.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/a2mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5a04eb1..5e1f240 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -612,7 +612,7 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		switch (hdr->code) {
 		case A2MP_COMMAND_REJ:
-			a2mp_command_rej(mgr, skb, hdr);
+			err = a2mp_command_rej(mgr, skb, hdr);
 			break;
 
 		case A2MP_DISCOVER_REQ:
-- 
2.1.4
