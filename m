Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for controller specific logging
Date: Sun, 18 Oct 2015 19:59:36 +0200
Message-Id: <1445191176-110152-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To enable controller specific logging, the userspace daemon has to have
the ability to log per controller. To facilitate this support, provide
a dedicated logging channel. Messages in this channel will be included
in the monitor queue and with that also forwarded to monitoring tools
along with the actual hardware traces.

All messages from the logging channel are timestamped and with that
allow an easy correlation between userspace messages and hardware
events. This will increase the ability to debug problems faster.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_mon.h  |  4 ++
 include/net/bluetooth/hci_sock.h |  1 +
 net/bluetooth/hci_sock.c         | 86 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 2b67567cf28d..41ff65127260 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -43,6 +43,10 @@ struct hci_mon_hdr {
 #define HCI_MON_CLOSE_INDEX	9
 #define HCI_MON_INDEX_INFO	10
 #define HCI_MON_VENDOR_DIAG	11
+#define HCI_MON_USER_DEBUG	12
+#define HCI_MON_USER_INFO	13
+#define HCI_MON_USER_WARN	14
+#define HCI_MON_USER_ERROR	15
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 9a46d665c1b5..8e9138acdae1 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -45,6 +45,7 @@ struct sockaddr_hci {
 #define HCI_CHANNEL_USER	1
 #define HCI_CHANNEL_MONITOR	2
 #define HCI_CHANNEL_CONTROL	3
+#define HCI_CHANNEL_LOGGING	4
 
 struct hci_filter {
 	unsigned long type_mask;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1f4665a124f6..0172ac54671a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -869,6 +869,18 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		atomic_inc(&monitor_promisc);
 		break;
 
+	case HCI_CHANNEL_LOGGING:
+		if (haddr.hci_dev != HCI_DEV_NONE) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (!capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			goto done;
+		}
+		break;
+
 	default:
 		if (!hci_mgmt_chan_find(haddr.hci_channel)) {
 			err = -EINVAL;
@@ -993,7 +1005,10 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (flags & (MSG_OOB))
+	if (flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
+	if (hci_pi(sk)->channel == HCI_CHANNEL_LOGGING)
 		return -EOPNOTSUPP;
 
 	if (sk->sk_state == BT_CLOSED)
@@ -1142,6 +1157,72 @@ done:
 	return err;
 }
 
+static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+	struct hci_dev *hdev;
+	u16 index;
+	int err;
+
+	if (len < sizeof(*hdr))
+		return -EINVAL;
+
+	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		return err;
+
+	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
+		err = -EFAULT;
+		goto drop;
+	}
+
+	hdr = (void *)skb->data;
+
+	if (skb->data[len - 1] != 0x00) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	if (__le16_to_cpu(hdr->len) != len - sizeof(*hdr)) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	switch (__le16_to_cpu(hdr->opcode)) {
+	case HCI_MON_USER_DEBUG:
+	case HCI_MON_USER_INFO:
+	case HCI_MON_USER_WARN:
+	case HCI_MON_USER_ERROR:
+		break;
+	default:
+		err = -EINVAL;
+		goto drop;
+	}
+
+	index = __le16_to_cpu(hdr->index);
+
+	if (index != MGMT_INDEX_NONE) {
+		hdev = hci_dev_get(index);
+		if (!hdev) {
+			err = -ENODEV;
+			goto drop;
+		}
+	} else {
+		hdev = NULL;
+	}
+
+	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
+	err = len;
+
+	if (hdev)
+		hci_dev_put(hdev);
+
+drop:
+	kfree_skb(skb);
+	return err;
+}
+
 static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
@@ -1171,6 +1252,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	case HCI_CHANNEL_MONITOR:
 		err = -EOPNOTSUPP;
 		goto done;
+	case HCI_CHANNEL_LOGGING:
+		err = hci_logging_frame(sk, msg, len);
+		goto done;
 	default:
 		mutex_lock(&mgmt_chan_list_lock);
 		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
-- 
2.4.3

