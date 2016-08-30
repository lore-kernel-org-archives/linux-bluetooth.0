Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Send control open and close messages for HCI raw sockets
Date: Tue, 30 Aug 2016 05:00:39 +0200
Message-Id: <1472526040-21804-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When opening and closing HCI raw sockets their main usage is for legacy
userspace. To track interaction with the modern mgmt interface, send
open and close monitoring messages for these action.

The HCI raw sockets is special since it supports unbound ioctl operation
and for that special case delay the notification message until at least
one ioctl has been executed. The difference between a bound and unbound
socket will be detailed by the fact the HCI index is present or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d5581ca7a07e..c2b2b1d7fe4d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -488,6 +488,11 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 		return NULL;
 
 	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_RAW:
+		format = 0x0000;
+		ver[0] = BT_SUBSYS_VERSION;
+		put_unaligned_le16(BT_SUBSYS_REVISION, ver + 1);
+		break;
 	case HCI_CHANNEL_CONTROL:
 		format = 0x0001;
 		mgmt_fill_version_info(ver);
@@ -533,6 +538,7 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 		return NULL;
 
 	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_RAW:
 	case HCI_CHANNEL_CONTROL:
 		break;
 	default:
@@ -820,6 +826,7 @@ static int hci_sock_release(struct socket *sock)
 	case HCI_CHANNEL_MONITOR:
 		atomic_dec(&monitor_promisc);
 		break;
+	case HCI_CHANNEL_RAW:
 	case HCI_CHANNEL_CONTROL:
 		/* Send event to monitor */
 		skb = create_monitor_ctrl_close(sk);
@@ -958,6 +965,27 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 		goto done;
 	}
 
+	/* When calling an ioctl on an unbound raw socket, then ensure
+	 * that the monitor gets informed. Ensure that the resulting event
+	 * is only send once by checking if the cookie exists or not. The
+	 * socket cookie will be only ever generated once for the lifetime
+	 * of a given socket.
+	 */
+	if (hci_sock_gen_cookie(sk)) {
+		struct sk_buff *skb;
+
+		if (capable(CAP_NET_ADMIN))
+			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
+		/* Send event to monitor */
+		skb = create_monitor_ctrl_open(sk);
+		if (skb) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
+			kfree_skb(skb);
+		}
+	}
+
 	release_sock(sk);
 
 	switch (cmd) {
@@ -1061,6 +1089,26 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		hci_pi(sk)->channel = haddr.hci_channel;
 		hci_pi(sk)->hdev = hdev;
+
+		/* Only send the event to monitor when a new cookie has
+		 * been generated. An existing cookie means that an unbound
+		 * socket has seen an ioctl and that triggered the cookie
+		 * generation and sending of the monitor event.
+		 */
+		if (hci_sock_gen_cookie(sk)) {
+			struct sk_buff *skb;
+
+			if (capable(CAP_NET_ADMIN))
+				hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
+			/* Send event to monitor */
+			skb = create_monitor_ctrl_open(sk);
+			if (skb) {
+				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+						    HCI_SOCK_TRUSTED, NULL);
+				kfree_skb(skb);
+			}
+		}
 		break;
 
 	case HCI_CHANNEL_USER:
-- 
2.7.4

