Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 4/7] Bluetooth: Linearize received L2CAP skbuffs.
Date: Tue, 10 Aug 2010 12:15:01 -0700
Message-Id: <1281467704-5378-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Fragmented skbs are only encountered by in-kernel protocols and
profiles when receiving ERTM or streaming mode L2CAP data.  BNEP,
CMTP, HIDP, and RFCOMM generally use basic mode, so will not
generally need the extra memcpy's necessary to put the L2CAP
payload in to a linear buffer.  However, it is possible to
use enhanced L2CAP in these modes so the possibility needs
to be handled.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/bnep/core.c   |    5 ++++-
 net/bluetooth/cmtp/core.c   |    5 ++++-
 net/bluetooth/hidp/core.c   |   10 ++++++++--
 net/bluetooth/rfcomm/core.c |    5 ++++-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index f10b41f..9f60443 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -481,7 +481,10 @@ static int bnep_session(void *arg)
 		// RX
 		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 			skb_orphan(skb);
-			bnep_rx_frame(s, skb);
+			if (!skb_linearize(skb))
+				bnep_rx_frame(s, skb);
+			else
+				kfree_skb(skb);
 		}
 
 		if (sk->sk_state != BT_CONNECTED)
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index d4c6af0..48ac812 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -293,7 +293,10 @@ static int cmtp_session(void *arg)
 
 		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 			skb_orphan(skb);
-			cmtp_recv_frame(session, skb);
+			if (!skb_linearize(skb))
+				cmtp_recv_frame(session, skb);
+			else
+				kfree_skb(skb);
 		}
 
 		cmtp_process_transmit(session);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bfe641b..097ff25 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -571,12 +571,18 @@ static int hidp_session(void *arg)
 
 		while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {
 			skb_orphan(skb);
-			hidp_recv_ctrl_frame(session, skb);
+			if (!skb_linearize(skb))
+				hidp_recv_ctrl_frame(session, skb);
+			else
+				kfree_skb(skb);
 		}
 
 		while ((skb = skb_dequeue(&intr_sk->sk_receive_queue))) {
 			skb_orphan(skb);
-			hidp_recv_intr_frame(session, skb);
+			if (!skb_linearize(skb))
+				hidp_recv_intr_frame(session, skb);
+			else
+				kfree_skb(skb);
 		}
 
 		hidp_process_transmit(session);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7dca91b..ee27f59 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1845,7 +1845,10 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 	/* Get data directly from socket receive queue without copying it. */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
-		rfcomm_recv_frame(s, skb);
+		if (!skb_linearize(skb))
+			rfcomm_recv_frame(s, skb);
+		else
+			kfree_skb(skb);
 	}
 
 	if (sk->sk_state == BT_CLOSED) {
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
