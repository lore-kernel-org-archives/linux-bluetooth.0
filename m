Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Add support for sending MGMT open and close to monitor
Date: Sat, 27 Aug 2016 20:23:40 +0200
Message-Id: <1472322221-86761-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This sends new notifications to the monitor support whenever a
management channel has been opened or closed. This allows tracing of
control channels really easily.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_mon.h |  2 +
 net/bluetooth/hci_sock.c        | 95 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 587d0131b349..9640790cbbcc 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -45,6 +45,8 @@ struct hci_mon_hdr {
 #define HCI_MON_VENDOR_DIAG	11
 #define HCI_MON_SYSTEM_NOTE	12
 #define HCI_MON_USER_LOGGING	13
+#define HCI_MON_CTRL_OPEN	14
+#define HCI_MON_CTRL_CLOSE	15
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4dce6dfdb0f2..ccbc3f711152 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -394,6 +394,59 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 	return skb;
 }
 
+static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+	u16 format = 0x0001;
+	u8 ver[3];
+	u32 flags;
+
+	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	mgmt_fill_version_info(ver);
+	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
+
+	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+	put_unaligned_le16(format, skb_put(skb, 2));
+	memcpy(skb_put(skb, sizeof(ver)), ver, sizeof(ver));
+	put_unaligned_le32(flags, skb_put(skb, 4));
+	*skb_put(skb, 1) = TASK_COMM_LEN;
+	memcpy(skb_put(skb, TASK_COMM_LEN), hci_pi(sk)->comm, TASK_COMM_LEN);
+
+	__net_timestamp(skb);
+
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
+	hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
+static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(4, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
+
+	__net_timestamp(skb);
+
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
+	hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	return skb;
+}
+
 static void __printf(2, 3)
 send_monitor_note(struct sock *sk, const char *fmt, ...)
 {
@@ -468,6 +521,29 @@ static void send_monitor_replay(struct sock *sk)
 	read_unlock(&hci_dev_list_lock);
 }
 
+static void send_monitor_control_replay(struct sock *mon_sk)
+{
+	struct sock *sk;
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, &hci_sk_list.head) {
+		struct sk_buff *skb;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_CONTROL)
+			continue;
+
+		skb = create_monitor_ctrl_open(sk);
+		if (!skb)
+			continue;
+
+		if (sock_queue_rcv_skb(mon_sk, skb))
+			kfree_skb(skb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+}
+
 /* Generate internal stack event */
 static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 {
@@ -595,6 +671,7 @@ static int hci_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
+	struct sk_buff *skb;
 	int id;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -611,6 +688,14 @@ static int hci_sock_release(struct socket *sock)
 	case HCI_CHANNEL_CONTROL:
 		id = hci_pi(sk)->cookie;
 
+		/* Send event to monitor */
+		skb = create_monitor_ctrl_close(sk);
+		if (skb) {
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
+			kfree_skb(skb);
+		}
+
 		hci_pi(sk)->cookie = 0xffffffff;
 		ida_simple_remove(&sock_cookie_ida, id);
 		break;
@@ -931,6 +1016,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		send_monitor_note(sk, "Bluetooth subsystem version %s",
 				  BT_SUBSYS_VERSION);
 		send_monitor_replay(sk);
+		send_monitor_control_replay(sk);
 
 		atomic_inc(&monitor_promisc);
 		break;
@@ -977,6 +1063,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * are changes to settings, class of device, name etc.
 		 */
 		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
+			struct sk_buff *skb;
 			int id;
 
 			id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
@@ -986,6 +1073,14 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			hci_pi(sk)->cookie = id;
 			get_task_comm(hci_pi(sk)->comm, current);
 
+			/* Send event to monitor */
+			skb = create_monitor_ctrl_open(sk);
+			if (skb) {
+				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+						    HCI_SOCK_TRUSTED, NULL);
+				kfree_skb(skb);
+			}
+
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_GENERIC_EVENTS);
-- 
2.7.4

