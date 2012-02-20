Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add support for HCI monitor channel
Date: Mon, 20 Feb 2012 15:15:18 +0100
Message-Id: <1329747318-21874-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI monitor channel can be used to monitor all packets and events
from the Bluetooth subsystem. The monitor is not bound to any specific
HCI device and allows even capturing multiple devices at the same time.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/hci_mon.h  |   51 ++++++++++
 net/bluetooth/hci_core.c         |   13 ++-
 net/bluetooth/hci_sock.c         |  202 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 265 insertions(+), 3 deletions(-)
 create mode 100644 include/net/bluetooth/hci_mon.h

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1b634e1..60a4727 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1320,6 +1320,7 @@ struct sockaddr_hci {
 
 #define HCI_CHANNEL_RAW		0
 #define HCI_CHANNEL_CONTROL	1
+#define HCI_CHANNEL_MONITOR	2
 
 struct hci_filter {
 	unsigned long type_mask;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 41adae5..094b5db 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -950,6 +950,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
+void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
new file mode 100644
index 0000000..07a25c9
--- /dev/null
+++ b/include/net/bluetooth/hci_mon.h
@@ -0,0 +1,51 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2011-2012  Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#ifndef __HCI_MON_H
+#define __HCI_MON_H
+
+struct hci_mon_hdr {
+	__le16	opcode;
+	__le16	index;
+	__le16	len;
+} __packed;
+#define HCI_MON_HDR_SIZE 6
+
+#define HCI_MON_NEW_INDEX	0
+#define HCI_MON_DEL_INDEX	1
+#define HCI_MON_COMMAND_PKT	2
+#define HCI_MON_EVENT_PKT	3
+#define HCI_MON_ACL_TX_PKT	4
+#define HCI_MON_ACL_RX_PKT	5
+#define HCI_MON_SCO_TX_PKT	6
+#define HCI_MON_SCO_RX_PKT	7
+
+struct hci_mon_new_index {
+	__u8	type;
+	__u8	bus;
+	bdaddr_t bdaddr;
+	char	name[8];
+} __packed;
+#define HCI_MON_NEW_INDEX_SIZE 16
+
+#endif /* __HCI_MON_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4721728..87ff7ff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2113,10 +2113,14 @@ static int hci_send_frame(struct sk_buff *skb)
 
 	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
-	if (atomic_read(&hdev->promisc)) {
-		/* Time stamp */
-		__net_timestamp(skb);
+	/* Time stamp */
+	__net_timestamp(skb);
 
+	/* Send copy to monitor */
+	hci_send_to_monitor(hdev, skb);
+
+	if (atomic_read(&hdev->promisc)) {
+		/* Send copy to the sockets */
 		hci_send_to_sock(hdev, skb);
 	}
 
@@ -2802,6 +2806,9 @@ static void hci_rx_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	while ((skb = skb_dequeue(&hdev->rx_q))) {
+		/* Send copy to monitor */
+		hci_send_to_monitor(hdev, skb);
+
 		if (atomic_read(&hdev->promisc)) {
 			/* Send copy to the sockets */
 			hci_send_to_sock(hdev, skb);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 14727cb..82e73b0 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -48,9 +48,12 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_mon.h>
 
 static bool enable_mgmt;
 
+static atomic_t monitor_promisc = ATOMIC_INIT(0);
+
 /* ----- HCI socket interface ----- */
 
 static inline int hci_test_bit(int nr, void *addr)
@@ -189,6 +192,174 @@ void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
 	read_unlock(&hci_sk_list.lock);
 }
 
+/* Send frame to monitor socket */
+void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+	struct sk_buff *skb_copy = NULL;
+	__le16 opcode;
+
+	if (!atomic_read(&monitor_promisc))
+		return;
+
+	BT_DBG("hdev %p len %d", hdev, skb->len);
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		opcode = __constant_cpu_to_le16(HCI_MON_COMMAND_PKT);
+		break;
+	case HCI_EVENT_PKT:
+		opcode = __constant_cpu_to_le16(HCI_MON_EVENT_PKT);
+		break;
+	case HCI_ACLDATA_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = __constant_cpu_to_le16(HCI_MON_ACL_RX_PKT);
+		else
+			opcode = __constant_cpu_to_le16(HCI_MON_ACL_TX_PKT);
+		break;
+	case HCI_SCODATA_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = __constant_cpu_to_le16(HCI_MON_SCO_RX_PKT);
+		else
+			opcode = __constant_cpu_to_le16(HCI_MON_SCO_TX_PKT);
+		break;
+	default:
+		return;
+	}
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, node, &hci_sk_list.head) {
+		struct sk_buff *nskb;
+
+		if (sk->sk_state != BT_BOUND)
+			continue;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_MONITOR)
+			continue;
+
+		if (!skb_copy) {
+			struct hci_mon_hdr *hdr;
+
+			/* Create a private copy with headroom */
+			skb_copy = __pskb_copy(skb, HCI_MON_HDR_SIZE, GFP_ATOMIC);
+			if (!skb_copy)
+				continue;
+
+			/* Put header before the data */
+			hdr = (void *) skb_push(skb_copy, HCI_MON_HDR_SIZE);
+			hdr->opcode = opcode;
+			hdr->index = cpu_to_le16(hdev->id);
+			hdr->len = cpu_to_le16(skb->len);
+		}
+
+		nskb = skb_clone(skb_copy, GFP_ATOMIC);
+		if (!nskb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, nskb))
+			kfree_skb(nskb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+
+	kfree_skb(skb_copy);
+}
+
+static void send_monitor_event(struct sk_buff *skb)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+
+	BT_DBG("len %d", skb->len);
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, node, &hci_sk_list.head) {
+		struct sk_buff *nskb;
+
+		if (sk->sk_state != BT_BOUND)
+			continue;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_MONITOR)
+			continue;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, nskb))
+			kfree_skb(nskb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+}
+
+static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
+{
+	struct hci_mon_hdr *hdr;
+	struct hci_mon_new_index *ni;
+	struct sk_buff *skb;
+	__le16 opcode;
+
+	switch (event) {
+	case HCI_DEV_REG:
+		skb = bt_skb_alloc(HCI_MON_NEW_INDEX_SIZE, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		ni = (void *) skb_put(skb, HCI_MON_NEW_INDEX_SIZE);
+		ni->type = hdev->dev_type;
+		ni->bus = hdev->bus;
+		bacpy(&ni->bdaddr, &hdev->bdaddr);
+		memcpy(ni->name, hdev->name, 8);
+
+		opcode = __constant_cpu_to_le16(HCI_MON_NEW_INDEX);
+		break;
+
+	case HCI_DEV_UNREG:
+		skb = bt_skb_alloc(0, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		opcode = __constant_cpu_to_le16(HCI_MON_DEL_INDEX);
+		break;
+
+	default:
+		return NULL;
+	}
+
+	__net_timestamp(skb);
+
+	hdr = (void *) skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = opcode;
+	hdr->index = cpu_to_le16(hdev->id);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
+static void send_monitor_replay(struct sock *sk)
+{
+	struct hci_dev *hdev;
+
+	read_lock(&hci_dev_list_lock);
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		struct sk_buff *skb;
+
+		skb = create_monitor_event(hdev, HCI_DEV_REG);
+		if (!skb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, skb))
+			kfree_skb(skb);
+	}
+
+	read_unlock(&hci_dev_list_lock);
+}
+
 /* Generate internal stack event */
 static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 {
@@ -223,6 +394,17 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 
 	BT_DBG("hdev %s event %d", hdev->name, event);
 
+	/* Send event to monitor */
+	if (atomic_read(&monitor_promisc)) {
+		struct sk_buff *skb;
+
+		skb = create_monitor_event(hdev, event);
+		if (skb) {
+			send_monitor_event(skb);
+			kfree_skb(skb);
+		}
+	}
+
 	/* Send event to sockets */
 	ev.event  = event;
 	ev.dev_id = hdev->id;
@@ -262,6 +444,9 @@ static int hci_sock_release(struct socket *sock)
 
 	hdev = hci_pi(sk)->hdev;
 
+	if (hci_pi(sk)->channel == HCI_CHANNEL_MONITOR)
+		atomic_dec(&monitor_promisc);
+
 	bt_sock_unlink(&hci_sk_list, sk);
 
 	if (hdev) {
@@ -474,6 +659,17 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
 		break;
 
+	case HCI_CHANNEL_MONITOR:
+		if (haddr.hci_dev != HCI_DEV_NONE) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		send_monitor_replay(sk);
+
+		atomic_inc(&monitor_promisc);
+		break;
+
 	default:
 		err = -EINVAL;
 		goto done;
@@ -578,6 +774,9 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	case HCI_CHANNEL_RAW:
 		hci_sock_cmsg(sk, msg, skb);
 		break;
+	case HCI_CHANNEL_MONITOR:
+		sock_recv_timestamp(msg, sk, skb);
+		break;
 	}
 
 	skb_free_datagram(sk, skb);
@@ -612,6 +811,9 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	case HCI_CHANNEL_CONTROL:
 		err = mgmt_control(sk, msg, len);
 		goto done;
+	case HCI_CHANNEL_MONITOR:
+		err = -EOPNOTSUPP;
+		goto done;
 	default:
 		err = -EINVAL;
 		goto done;
-- 
1.7.7.6

