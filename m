Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/7] Bluetooth: Fix coding style in hci_sock.c
Date: Thu, 17 May 2012 00:36:22 -0300
Message-Id: <1337225786-11064-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337225786-11064-2-git-send-email-gustavo@padovan.org>
References: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
 <1337225786-11064-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Follow the net subsystem rules.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_sock.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5914623..bdf51d1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -113,7 +113,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		flt = &hci_pi(sk)->filter;
 
 		if (!test_bit((bt_cb(skb)->pkt_type == HCI_VENDOR_PKT) ?
-				0 : (bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS), &flt->type_mask))
+			      0 : (bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS),
+			      &flt->type_mask))
 			continue;
 
 		if (bt_cb(skb)->pkt_type == HCI_EVENT_PKT) {
@@ -747,7 +748,7 @@ static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_
 }
 
 static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-				struct msghdr *msg, size_t len, int flags)
+			    struct msghdr *msg, size_t len, int flags)
 {
 	int noblock = flags & MSG_DONTWAIT;
 	struct sock *sk = sock->sk;
@@ -857,8 +858,9 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		u16 ocf = hci_opcode_ocf(opcode);
 
 		if (((ogf > HCI_SFLT_MAX_OGF) ||
-				!hci_test_bit(ocf & HCI_FLT_OCF_BITS, &hci_sec_filter.ocf_mask[ogf])) &&
-					!capable(CAP_NET_RAW)) {
+		     !hci_test_bit(ocf & HCI_FLT_OCF_BITS,
+				   &hci_sec_filter.ocf_mask[ogf])) &&
+		    !capable(CAP_NET_RAW)) {
 			err = -EPERM;
 			goto drop;
 		}
-- 
1.7.10.1

