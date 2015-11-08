Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: Add support for controller specific logging
Date: Sun,  8 Nov 2015 07:47:13 +0100
Message-Id: <1446965233-40420-3-git-send-email-marcel@holtmann.org>
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
 include/net/bluetooth/hci_mon.h  |   1 +
 include/net/bluetooth/hci_sock.h |   1 +
 net/bluetooth/hci_sock.c         | 102 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index c91bb23eb29e..587d0131b349 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -44,6 +44,7 @@ struct hci_mon_hdr {
 #define HCI_MON_INDEX_INFO	10
 #define HCI_MON_VENDOR_DIAG	11
 #define HCI_MON_SYSTEM_NOTE	12
+#define HCI_MON_USER_LOGGING	13
 
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
index 710265c35d16..41f579ba447b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -906,6 +906,18 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
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
@@ -1033,6 +1045,9 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	if (hci_pi(sk)->channel == HCI_CHANNEL_LOGGING)
+		return -EOPNOTSUPP;
+
 	if (sk->sk_state == BT_CLOSED)
 		return 0;
 
@@ -1179,6 +1194,90 @@ done:
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
+	/* The logging frame consists at minimum of the standard header,
+	 * the priority byte, the ident length byte and at least one string
+	 * terminator NUL byte. Anything shorter are invalid packets.
+	 */
+	if (len < sizeof(*hdr) + 3)
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
+	if (__le16_to_cpu(hdr->len) != len - sizeof(*hdr)) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	if (__le16_to_cpu(hdr->opcode) == 0x0000) {
+		__u8 priority = skb->data[sizeof(*hdr)];
+		__u8 ident_len = skb->data[sizeof(*hdr) + 1];
+
+		/* Only the priorities 0-7 are valid and with that any other
+		 * value results in an invalid packet.
+		 *
+		 * The priority byte is followed by an ident length byte and
+		 * the NUL terminated ident string. Check that the ident
+		 * length is not overflowing the packet and also that the
+		 * ident string itself is NUL terminated. In case the ident
+		 * length is zero, the length value actually doubles as NUL
+		 * terminator identifier.
+		 *
+		 * The message follows the ident string (if present) and
+		 * must be NUL terminated. Otherwise it is not a valid packet.
+		 */
+		if (priority > 7 || skb->data[len - 1] != 0x00 ||
+		    ident_len > len - sizeof(*hdr) - 3 ||
+		    skb->data[sizeof(*hdr) + ident_len + 1] != 0x00) {
+			err = -EINVAL;
+			goto drop;
+		}
+	} else {
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
+	hdr->opcode = cpu_to_le16(HCI_MON_USER_LOGGING);
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
@@ -1208,6 +1307,9 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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
2.5.0

