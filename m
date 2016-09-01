Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send control open and close messages for HCI user channels
Date: Thu,  1 Sep 2016 19:48:28 +0200
Message-Id: <1472752108-100322-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When opening and closing HCI user channel, send monitoring messages to
be able to trace its behavior.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 83e9fdb712e5..48f9471e7c85 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -493,6 +493,11 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 		ver[0] = BT_SUBSYS_VERSION;
 		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
 		break;
+	case HCI_CHANNEL_USER:
+		format = 0x0001;
+		ver[0] = BT_SUBSYS_VERSION;
+		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
+		break;
 	case HCI_CHANNEL_CONTROL:
 		format = 0x0002;
 		mgmt_fill_version_info(ver);
@@ -539,6 +544,7 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 
 	switch (hci_pi(sk)->channel) {
 	case HCI_CHANNEL_RAW:
+	case HCI_CHANNEL_USER:
 	case HCI_CHANNEL_CONTROL:
 		break;
 	default:
@@ -827,6 +833,7 @@ static int hci_sock_release(struct socket *sock)
 		atomic_dec(&monitor_promisc);
 		break;
 	case HCI_CHANNEL_RAW:
+	case HCI_CHANNEL_USER:
 	case HCI_CHANNEL_CONTROL:
 		/* Send event to monitor */
 		skb = create_monitor_ctrl_close(sk);
@@ -1179,8 +1186,36 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		}
 
 		hci_pi(sk)->channel = haddr.hci_channel;
+
+		if (!hci_sock_gen_cookie(sk)) {
+			/* In the case when a cookie has already been assigned,
+			 * this socket will transition from a raw socket into
+			 * an user channel socket. For a clean transition, send
+			 * the close notification first.
+			 */
+			skb = create_monitor_ctrl_close(sk);
+			if (skb) {
+				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+						    HCI_SOCK_TRUSTED, NULL);
+				kfree_skb(skb);
+			}
+		}
+
+		/* The user channel is restricted to CAP_NET_ADMIN
+		 * capabilities and with that implicitly trusted.
+		 */
+		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
 		hci_pi(sk)->hdev = hdev;
 
+		/* Send event to monitor */
+		skb = create_monitor_ctrl_open(sk);
+		if (skb) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
+			kfree_skb(skb);
+		}
+
 		atomic_inc(&hdev->promisc);
 		break;
 
-- 
2.7.4

