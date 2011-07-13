Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/3] Bluetooth: Linearize skbs for use in BNEP, CMTP, HIDP, and RFCOMM
Date: Wed, 13 Jul 2011 10:58:37 -0700
Message-Id: <1310579919-24546-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fragmented skbs are only encountered when receiving ERTM or streaming
mode L2CAP data.  BNEP, CMTP, HIDP, and RFCOMM generally use basic
mode, but they need to handle fragments without crashing.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/bnep/core.c   |    5 ++++-
 net/bluetooth/cmtp/core.c   |    5 ++++-
 net/bluetooth/hidp/core.c   |   10 ++++++++--
 net/bluetooth/rfcomm/core.c |    5 ++++-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index ca39fcf..dfadb65 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -490,7 +490,10 @@ static int bnep_session(void *arg)
 		/* RX */
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
index c5b11af..2487b84 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -300,7 +300,10 @@ static int cmtp_session(void *arg)
 
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
index c405a95..2506509 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -715,12 +715,18 @@ static int hidp_session(void *arg)
 
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
index 5759bb7..6bbd317 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1855,7 +1855,10 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
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
1.7.6

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

