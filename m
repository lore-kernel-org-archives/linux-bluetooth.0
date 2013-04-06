Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 12/16] Bluetooth: hidp: handle kernel_sendmsg() errors correctly
Date: Sat,  6 Apr 2013 20:28:48 +0200
Message-Id: <1365272932-571-13-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't push back the skbs if kernel_sendmsg() fails. Instead, we
terminate the connection and drop the skb. Only on EAGAIN we push it back
and return.
l2cap doesn't return EAGAIN, yet, but this guarantees we're safe if it
will at some time in the future.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 481bbb8..3f6ef06 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -639,13 +639,19 @@ static int hidp_send_frame(struct socket *sock, unsigned char *data, int len)
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
@@ -656,13 +662,19 @@ static void hidp_process_intr_transmit(struct hidp_session *session)
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
1.8.2

