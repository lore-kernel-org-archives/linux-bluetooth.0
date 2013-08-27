Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Introduce new HCI socket channel for user operation
Date: Mon, 26 Aug 2013 21:40:52 -0700
Message-Id: <1377578452-7316-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introcuces a new HCI socket channel that allows user
applications to take control over a specific HCI device. The application
gains exclusive access to this device and forces the kernel to stay away
and not manage it. In case of the management interface it will actually
hide the device.

Such operation is useful for security testing tools that need to operate
underneath the Bluetooth stack and need full control over a device. The
advantage here is that the kernel still provides the service of hardware
abstraction and HCI level access. The use of Bluetooth drivers for
hardware access also means that sniffing tools like btmon or hcidump
are still working and the whole set of transaction can be traced with
existing tools.

With the new channel it is possible to send HCI commands, ACL and SCO
data packets and receive HCI events, ACL and SCO packets from the
device. The format follows the well established H:4 protocol.

The new HCI user channel can only be established when a device has been
through its setup routine and is currently powered down. This is
enforced to not cause any problems with current operations. In addition
only one user channel per HCI device is allowed. It is exclusive access
for one user application. Access to this channel is limited to process
with CAP_NET_RAW capability.

Using this new facility does not require any external library or special
ioctl or socket filters. Just create the socket and bind it. After that
the file descriptor is ready to speak H:4 protocol.

        struct sockaddr_hci addr;
        int fd;

        fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);

        memset(&addr, 0, sizeof(addr));
        addr.hci_family = AF_BLUETOOTH;
        addr.hci_dev = 0;
        addr.hci_channel = HCI_CHANNEL_USER;

        bind(fd, (struct sockaddr *) &addr, sizeof(addr));

The example shows on how to create a user channel for hci0 device. Error
handling has been left out of the example. However with the limitations
mentioned above it is advised to handle errors. Binding of the user
cahnnel socket can fail for various reasons. Specifically if the device
is currently activated by BlueZ or if the access permissions are not
present.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_sock.c    | 86 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 128157d..30c88b5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1571,6 +1571,7 @@ struct sockaddr_hci {
 #define HCI_DEV_NONE	0xffff
 
 #define HCI_CHANNEL_RAW		0
+#define HCI_CHANNEL_USER	1
 #define HCI_CHANNEL_MONITOR	2
 #define HCI_CHANNEL_CONTROL	3
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 59e68f1..c09e976 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -126,11 +126,20 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		if (skb->sk == sk)
 			continue;
 
-		if (hci_pi(sk)->channel != HCI_CHANNEL_RAW)
-			continue;
-
-		if (is_filtered_packet(sk, skb))
+		if (hci_pi(sk)->channel == HCI_CHANNEL_RAW) {
+			if (is_filtered_packet(sk, skb))
+				continue;
+		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
+			if (!bt_cb(skb)->incoming)
+				continue;
+			if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
+			    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+			    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT)
+				continue;
+		} else {
+			/* Don't send frame to other channel types */
 			continue;
+		}
 
 		if (!skb_copy) {
 			/* Create a private copy with headroom */
@@ -444,6 +453,12 @@ static int hci_sock_release(struct socket *sock)
 	bt_sock_unlink(&hci_sk_list, sk);
 
 	if (hdev) {
+		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
+			mgmt_index_added(hdev);
+			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
+			hci_dev_close(hdev->id);
+		}
+
 		atomic_dec(&hdev->promisc);
 		hci_dev_put(hdev);
 	}
@@ -661,6 +676,56 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		hci_pi(sk)->hdev = hdev;
 		break;
 
+	case HCI_CHANNEL_USER:
+		if (hci_pi(sk)->hdev) {
+			err = -EALREADY;
+			goto done;
+		}
+
+		if (haddr.hci_dev == HCI_DEV_NONE) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (!capable(CAP_NET_RAW)) {
+			err = -EPERM;
+			goto done;
+		}
+
+		hdev = hci_dev_get(haddr.hci_dev);
+		if (!hdev) {
+			err = -ENODEV;
+			goto done;
+		}
+
+		if (test_bit(HCI_UP, &hdev->flags) ||
+		    test_bit(HCI_INIT, &hdev->flags) ||
+		    test_bit(HCI_SETUP, &hdev->dev_flags)) {
+			err = -EBUSY;
+			hci_dev_put(hdev);
+			goto done;
+		}
+
+		if (test_and_set_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+			err = -EUSERS;
+			hci_dev_put(hdev);
+			goto done;
+		}
+
+		mgmt_index_removed(hdev);
+
+		err = hci_dev_open(hdev->id);
+		if (err) {
+			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
+			hci_dev_put(hdev);
+			goto done;
+		}
+
+		atomic_inc(&hdev->promisc);
+
+		hci_pi(sk)->hdev = hdev;
+		break;
+
 	case HCI_CHANNEL_CONTROL:
 		if (haddr.hci_dev != HCI_DEV_NONE) {
 			err = -EINVAL;
@@ -807,6 +872,7 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	case HCI_CHANNEL_RAW:
 		hci_sock_cmsg(sk, msg, skb);
 		break;
+	case HCI_CHANNEL_USER:
 	case HCI_CHANNEL_CONTROL:
 	case HCI_CHANNEL_MONITOR:
 		sock_recv_timestamp(msg, sk, skb);
@@ -841,6 +907,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	switch (hci_pi(sk)->channel) {
 	case HCI_CHANNEL_RAW:
+	case HCI_CHANNEL_USER:
 		break;
 	case HCI_CHANNEL_CONTROL:
 		err = mgmt_control(sk, msg, len);
@@ -877,7 +944,8 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	skb_pull(skb, 1);
 	skb->dev = (void *) hdev;
 
-	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+	if (hci_pi(sk)->channel == HCI_CHANNEL_RAW &&
+	    bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
 		u16 opcode = get_unaligned_le16(skb->data);
 		u16 ogf = hci_opcode_ogf(opcode);
 		u16 ocf = hci_opcode_ocf(opcode);
@@ -908,6 +976,14 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			goto drop;
 		}
 
+		if (hci_pi(sk)->channel == HCI_CHANNEL_USER &&
+		    bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
+		    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+			err = -EINVAL;
+			goto drop;
+		}
+
 		skb_queue_tail(&hdev->raw_q, skb);
 		queue_work(hdev->workqueue, &hdev->tx_work);
 	}
-- 
1.8.3.1

