Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Handle HCI raw socket transition from unbound to bound
Date: Tue, 30 Aug 2016 05:00:40 +0200
Message-Id: <1472526040-21804-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case an unbound HCI raw socket is later on bound, ensure that the
monitor notification messages indicate a close and re-open. None of
the userspace tools use the socket this, but it is actually possible
to use an ioctl on an unbound socket and then later bind it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c2b2b1d7fe4d..f2c597facf0c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1049,6 +1049,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 	struct sockaddr_hci haddr;
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev = NULL;
+	struct sk_buff *skb;
 	int len, err = 0;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1088,27 +1089,34 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		}
 
 		hci_pi(sk)->channel = haddr.hci_channel;
-		hci_pi(sk)->hdev = hdev;
-
-		/* Only send the event to monitor when a new cookie has
-		 * been generated. An existing cookie means that an unbound
-		 * socket has seen an ioctl and that triggered the cookie
-		 * generation and sending of the monitor event.
-		 */
-		if (hci_sock_gen_cookie(sk)) {
-			struct sk_buff *skb;
-
-			if (capable(CAP_NET_ADMIN))
-				hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
-			/* Send event to monitor */
-			skb = create_monitor_ctrl_open(sk);
+		if (!hci_sock_gen_cookie(sk)) {
+			/* In the case when a cookie has already been assigned,
+			 * then there has been already an ioctl issued against
+			 * an unbound socket and with that triggerd an open
+			 * notification. Send a close notification first to
+			 * allow the state transition to bounded.
+			 */
+			skb = create_monitor_ctrl_close(sk);
 			if (skb) {
 				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
 						    HCI_SOCK_TRUSTED, NULL);
 				kfree_skb(skb);
 			}
 		}
+
+		if (capable(CAP_NET_ADMIN))
+			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
+		hci_pi(sk)->hdev = hdev;
+
+		/* Send event to monitor */
+		skb = create_monitor_ctrl_open(sk);
+		if (skb) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
+			kfree_skb(skb);
+		}
 		break;
 
 	case HCI_CHANNEL_USER:
@@ -1251,9 +1259,20 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * are changes to settings, class of device, name etc.
 		 */
 		if (hci_pi(sk)->channel == HCI_CHANNEL_CONTROL) {
-			struct sk_buff *skb;
-
-			hci_sock_gen_cookie(sk);
+			if (!hci_sock_gen_cookie(sk)) {
+				/* In the case when a cookie has already been
+				 * assigned, this socket will transtion from
+				 * a raw socket into a control socket. To
+				 * allow for a clean transtion, send the
+				 * close notification first.
+				 */
+				skb = create_monitor_ctrl_close(sk);
+				if (skb) {
+					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+							    HCI_SOCK_TRUSTED, NULL);
+					kfree_skb(skb);
+				}
+			}
 
 			/* Send event to monitor */
 			skb = create_monitor_ctrl_open(sk);
-- 
2.7.4

