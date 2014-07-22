Return-Path: <cyrus@holtmann.org>
From: Vignesh Raman <Vignesh_Raman@mentor.com>
To: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
	<gustavo@padovan.org>
CC: <Dean_Jenkins@mentor.com>, <Vitaly_Kuzmichev@mentor.com>
Subject: [PATCH v2] Bluetooth: Avoid use of session socket after the session gets freed
Date: Tue, 22 Jul 2014 19:24:25 +0530
Message-ID: <1406037265-16301-1-git-send-email-Vignesh_Raman@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The commits 08c30aca9e698faddebd34f81e1196295f9dc063 "Bluetooth: Remove
RFCOMM session refcnt" and 8ff52f7d04d9cc31f1e81dcf9a2ba6335ed34905
"Bluetooth: Return RFCOMM session ptrs to avoid freed session"
allow rfcomm_recv_ua and rfcomm_session_close to delete the session
(and free the corresponding socket) and propagate NULL session pointer
to the upper callers.

Additional fix is required to terminate the loop in rfcomm_process_rx
function to avoid use of freed 'sk' memory.

The issue is only reproducible with kernel option CONFIG_PAGE_POISONING
enabled making freed memory being changed and filled up with fixed char
value used to unmask use-after-free issues.

Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
Signed-off-by: Vitaly Kuzmichev <Vitaly_Kuzmichev@mentor.com>
Acked-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/rfcomm/core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 754b6fe..881f7de 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1909,10 +1909,13 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 	/* Get data directly from socket receive queue without copying it. */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
-		if (!skb_linearize(skb))
+		if (!skb_linearize(skb)) {
 			s = rfcomm_recv_frame(s, skb);
-		else
+			if (!s)
+				break;
+		} else {
 			kfree_skb(skb);
+		}
 	}
 
 	if (s && (sk->sk_state == BT_CLOSED))
-- 
1.7.9.5

