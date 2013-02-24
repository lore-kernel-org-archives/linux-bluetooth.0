Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 16/16] Bluetooth: hidp: handle kernel_sendmsg() errors correctly
Date: Sun, 24 Feb 2013 19:37:06 +0100
Message-Id: <1361731026-7428-17-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't push back the skbs if kernel_sendmsg() fails. Instead, we
terminate the connection and drop the skb. Only on EAGAIN we push it back
and return.
l2cap doesn't return EAGAIN, yet, but this guarantees we're safe if it
will at some time in the future.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 5d07589..807523c 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -636,13 +636,19 @@ static int hidp_send_frame(struct socket *sock, unsigned char *data, int len)
 static void hidp_process_intr_transmit(struct hidp_session *session)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	BT_DBG("session %p", session);
 
 	while ((skb = skb_dequeue(&session->intr_transmit))) {
-		if (hidp_send_frame(session->intr_sock, skb->data, skb->len) < 0) {
+		ret = hidp_send_frame(session->intr_sock, skb->data, skb->len);
+		if (ret == -EAGAIN) {
 			skb_queue_head(&session->intr_transmit, skb);
 			break;
+		} else if (ret < 0) {
+			hidp_session_terminate(session);
+			kfree_skb(skb);
+			break;
 		}
 
 		hidp_set_timer(session);
@@ -653,13 +659,19 @@ static void hidp_process_intr_transmit(struct hidp_session *session)
 static void hidp_process_ctrl_transmit(struct hidp_session *session)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	BT_DBG("session %p", session);
 
 	while ((skb = skb_dequeue(&session->ctrl_transmit))) {
-		if (hidp_send_frame(session->ctrl_sock, skb->data, skb->len) < 0) {
+		ret = hidp_send_frame(session->ctrl_sock, skb->data, skb->len);
+		if (ret == -EAGAIN) {
 			skb_queue_head(&session->ctrl_transmit, skb);
 			break;
+		} else if (ret < 0) {
+			hidp_session_terminate(session);
+			kfree_skb(skb);
+			break;
 		}
 
 		hidp_set_timer(session);
-- 
1.8.1.4
