Return-Path: <cyrus@holtmann.org>
From: <doronkeren@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Doron Keren <doronkeren@ti.com>
Subject: [PATCH] Bluetooth: Fix kernel crash on rfcomm disconnects.
Date: Wed, 13 Jun 2012 10:32:18 +0300
Message-ID: <1339572738-24345-1-git-send-email-doronkeren@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Doron Keren <doronkeren@ti.com>

When receiving rfcomm-disconnect-request, and right after receiving
l2cap-disconnect-request. The rfcomm disconnect function calls
rfcomm_session_close() function. The l2cap-disconnect-request closed
the socket. The rfcomm_process_rx funcion at the end, checks
if the socket is closed and calls again to rfcomm_session_close()
function, that lead to kernel crash, because the rfcomm session list
is already deleted on the first call. The bug is fixed by adding
to the socket state check, test that the session state is
not already closed.

The bug can be reproduced by turning on the Bluetooth and push
some file from another Bluetooth device (PC/Phone).
The kernel crash log-
rfcomm_process_rx: session c5d37340 state 1 qlen 1
rfcomm_recv_disc: session c5d37340 state 1 dlci 0
rfcomm_session_close: session c5d37340 state 9 err 104
l2cap_disconnect_req: scid 0x0041 dcid 0x0040
__l2cap_state_change: chan c6703000 BT_CONNECTED -> BT_CLOSED
rfcomm_l2state_change: c675f800 state 9
rfcomm_session_del: session c5d37340 state 9 list next=c7321a80, prev=bf05b838
rfcomm_session_close: session c5d37340 state 9 err 104
rfcomm_session_del: session c5d37340 state 9 list next=c5d376c0, prev=00200200
Unable to handle kernel paging request at virtual address 00200200
PC is at rfcomm_session_del+0x58/0x94 [rfcomm]

---
 net/bluetooth/rfcomm/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index c75107e..077890f 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1861,7 +1861,7 @@ static void rfcomm_process_rx(struct rfcomm_session *s)
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
+	if ((sk->sk_state == BT_CLOSED) && (s->state != BT_CLOSED)) {
 		if (!s->initiator)
 			rfcomm_session_put(s);
 
-- 
1.7.5.4

