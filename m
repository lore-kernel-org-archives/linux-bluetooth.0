Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix casting coding style within HCI sockets
Date: Sat,  7 Nov 2015 13:56:55 +0100
Message-Id: <1446901017-114430-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI sockets code has still some old casting coding style. Fix this
to match with the rest of the code.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 32caa6271a92..18a41eae295c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -294,7 +294,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	/* Put header before the data */
-	hdr = (void *) skb_push(skb_copy, HCI_MON_HDR_SIZE);
+	hdr = (void *)skb_push(skb_copy, HCI_MON_HDR_SIZE);
 	hdr->opcode = opcode;
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
@@ -375,7 +375,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 
 	__net_timestamp(skb);
 
-	hdr = (void *) skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
 	hdr->opcode = opcode;
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
@@ -436,11 +436,11 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	if (!skb)
 		return;
 
-	hdr = (void *) skb_put(skb, HCI_EVENT_HDR_SIZE);
+	hdr = (void *)skb_put(skb, HCI_EVENT_HDR_SIZE);
 	hdr->evt  = HCI_EV_STACK_INTERNAL;
 	hdr->plen = sizeof(*ev) + dlen;
 
-	ev  = (void *) skb_put(skb, sizeof(*ev) + dlen);
+	ev  = (void *)skb_put(skb, sizeof(*ev) + dlen);
 	ev->type = type;
 	memcpy(ev->data, data, dlen);
 
@@ -653,20 +653,20 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 		return -EOPNOTSUPP;
 
 	case HCIGETCONNINFO:
-		return hci_get_conn_info(hdev, (void __user *) arg);
+		return hci_get_conn_info(hdev, (void __user *)arg);
 
 	case HCIGETAUTHINFO:
-		return hci_get_auth_info(hdev, (void __user *) arg);
+		return hci_get_auth_info(hdev, (void __user *)arg);
 
 	case HCIBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		return hci_sock_blacklist_add(hdev, (void __user *) arg);
+		return hci_sock_blacklist_add(hdev, (void __user *)arg);
 
 	case HCIUNBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		return hci_sock_blacklist_del(hdev, (void __user *) arg);
+		return hci_sock_blacklist_del(hdev, (void __user *)arg);
 	}
 
 	return -ENOIOCTLCMD;
@@ -675,7 +675,7 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 			  unsigned long arg)
 {
-	void __user *argp = (void __user *) arg;
+	void __user *argp = (void __user *)arg;
 	struct sock *sk = sock->sk;
 	int err;
 
@@ -926,7 +926,7 @@ done:
 static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
 			    int *addr_len, int peer)
 {
-	struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
+	struct sockaddr_hci *haddr = (struct sockaddr_hci *)addr;
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
 	int err = 0;
@@ -991,8 +991,8 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 	}
 }
 
-static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
-			    int flags)
+static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+			    size_t len, int flags)
 {
 	int noblock = flags & MSG_DONTWAIT;
 	struct sock *sk = sock->sk;
@@ -1211,7 +1211,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto drop;
 	}
 
-	hci_skb_pkt_type(skb) = *((unsigned char *) skb->data);
+	hci_skb_pkt_type(skb) = skb->data[0];
 	skb_pull(skb, 1);
 
 	if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-- 
2.5.0

