Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 5/7] Bluetooth: Handle fragmented skbs in bt_sock_stream_recvmsg()
Date: Tue, 10 Aug 2010 12:15:02 -0700
Message-Id: <1281467704-5378-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When reading L2CAP skbuffs, add the ability to copy from
fragmented skbuffs generated during ERTM or streaming mode
reassembly.  This defers extra copying of L2CAP payloads
until the final, unavoidable copy to userspace.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/af_bluetooth.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 77a26fe..5e0375b 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -342,7 +342,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 		}
 
 		chunk = min_t(unsigned int, skb->len, size);
-		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
+		if (skb_copy_datagram_iovec(skb, 0, msg->msg_iov, chunk)) {
 			skb_queue_head(&sk->sk_receive_queue, skb);
 			if (!copied)
 				copied = -EFAULT;
@@ -354,7 +354,33 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
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
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
