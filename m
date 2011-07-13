Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/3] Bluetooth: Handle fragmented skbs in bt_sock_stream_recvmsg()
Date: Wed, 13 Jul 2011 10:58:38 -0700
Message-Id: <1310579919-24546-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM reassembly will be more efficient when skbs are linked together
rather than copying every incoming data byte. The existing stream recv
function assumes skbs are linear, so it needs to know how to handle
fragments before reassembly is changed.

bt_sock_recvmsg() already handles fragmented skbs.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/af_bluetooth.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8add9b4..9a43520 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -349,7 +349,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 		}
 
 		chunk = min_t(unsigned int, skb->len, size);
-		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
+		if (skb_copy_datagram_iovec(skb, 0, msg->msg_iov, chunk)) {
 			skb_queue_head(&sk->sk_receive_queue, skb);
 			if (!copied)
 				copied = -EFAULT;
@@ -361,7 +361,33 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 		sock_recv_ts_and_drops(msg, sk, skb);
 
 		if (!(flags & MSG_PEEK)) {
-			skb_pull(skb, chunk);
+			int skb_len = skb_headlen(skb);
+
+			if (chunk <= skb_len) {
+				__skb_pull(skb, chunk);
+			} else {
+				struct sk_buff *frag;
+
+				__skb_pull(skb, skb_len);
+				chunk -= skb_len;
+
+				skb_walk_frags(skb, frag) {
+					if (chunk <= frag->len) {
+						/* Pulling partial data */
+						skb->len -= chunk;
+						skb->data_len -= chunk;
+						__skb_pull(frag, chunk);
+						break;
+					} else if (frag->len) {
+						/* Pulling all frag data */
+						chunk -= frag->len;
+						skb->len -= frag->len;
+						skb->data_len -= frag->len;
+						__skb_pull(frag, frag->len);
+					}
+				}
+			}
+
 			if (skb->len) {
 				skb_queue_head(&sk->sk_receive_queue, skb);
 				break;
-- 
1.7.6

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

