Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 15/18] Bluetooth: hidp: merge hidp_process_{ctrl,intr}_transmit()
Date: Fri,  5 Apr 2013 14:57:47 +0200
Message-Id: <1365166670-3271-16-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Both hidp_process_ctrl_transmit() and hidp_process_intr_transmit() are
exactly the same apart from the transmit-queue and socket pointers.
Therefore, pass them as argument and merge both functions into one so we
avoid 25 lines of code-duplication.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 73bcc63..a566dc2 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -633,40 +633,20 @@ static int hidp_send_frame(struct socket *sock, unsigned char *data, int len)
 	return kernel_sendmsg(sock, &msg, &iv, 1, len);
 }
 
-static void hidp_process_intr_transmit(struct hidp_session *session)
+/* dequeue message from @transmit and send via @sock */
+static void hidp_process_transmit(struct hidp_session *session,
+				  struct sk_buff_head *transmit,
+				  struct socket *sock)
 {
 	struct sk_buff *skb;
 	int ret;
 
 	BT_DBG("session %p", session);
 
-	while ((skb = skb_dequeue(&session->intr_transmit))) {
-		ret = hidp_send_frame(session->intr_sock, skb->data, skb->len);
+	while ((skb = skb_dequeue(transmit))) {
+		ret = hidp_send_frame(sock, skb->data, skb->len);
 		if (ret == -EAGAIN) {
-			skb_queue_head(&session->intr_transmit, skb);
-			break;
-		} else if (ret < 0) {
-			hidp_session_terminate(session);
-			kfree_skb(skb);
-			break;
-		}
-
-		hidp_set_timer(session);
-		kfree_skb(skb);
-	}
-}
-
-static void hidp_process_ctrl_transmit(struct hidp_session *session)
-{
-	struct sk_buff *skb;
-	int ret;
-
-	BT_DBG("session %p", session);
-
-	while ((skb = skb_dequeue(&session->ctrl_transmit))) {
-		ret = hidp_send_frame(session->ctrl_sock, skb->data, skb->len);
-		if (ret == -EAGAIN) {
-			skb_queue_head(&session->ctrl_transmit, skb);
+			skb_queue_head(transmit, skb);
 			break;
 		} else if (ret < 0) {
 			hidp_session_terminate(session);
@@ -1221,7 +1201,8 @@ static void hidp_session_run(struct hidp_session *session)
 		}
 
 		/* send pending intr-skbs */
-		hidp_process_intr_transmit(session);
+		hidp_process_transmit(session, &session->intr_transmit,
+				      session->intr_sock);
 
 		/* parse incoming ctrl-skbs */
 		while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {
@@ -1233,7 +1214,8 @@ static void hidp_session_run(struct hidp_session *session)
 		}
 
 		/* send pending ctrl-skbs */
-		hidp_process_ctrl_transmit(session);
+		hidp_process_transmit(session, &session->ctrl_transmit,
+				      session->ctrl_sock);
 
 		schedule();
 	}
-- 
1.8.2
