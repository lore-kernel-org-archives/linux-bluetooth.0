Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix HCI User Channel permission check in hci_sock_sendmsg
Date: Tue, 17 Dec 2013 03:21:25 -0800
Message-Id: <1387279285-60237-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI User Channel is an admin operation which enforces CAP_NET_ADMIN
when binding the socket. Problem now is that it then requires also
CAP_NET_RAW when calling into hci_sock_sendmsg. This is not intended
and just an oversight since general HCI sockets (which do not require
special permission to bind) and HCI User Channel share the same code
path here.

Remove the extra CAP_NET_RAW check for HCI User Channel write operation
since the permission check has already been enforced when binding the
socket. This also makes it possible to open HCI User Channel from a
privileged process and then hand the file descriptor to an unprivilged
process.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6a6c8bb4fd72..7552f9e3089c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -940,8 +940,22 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	bt_cb(skb)->pkt_type = *((unsigned char *) skb->data);
 	skb_pull(skb, 1);
 
-	if (hci_pi(sk)->channel == HCI_CHANNEL_RAW &&
-	    bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+	if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
+		/* No permission check is needed for user channel
+		 * since that gets enforced when binding the socket.
+		 *
+		 * However check that the packet type is valid.
+		 */
+		if (bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
+		    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+			err = -EINVAL;
+			goto drop;
+		}
+
+		skb_queue_tail(&hdev->raw_q, skb);
+		queue_work(hdev->workqueue, &hdev->tx_work);
+	} else if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
 		u16 opcode = get_unaligned_le16(skb->data);
 		u16 ogf = hci_opcode_ogf(opcode);
 		u16 ocf = hci_opcode_ocf(opcode);
@@ -972,14 +986,6 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			goto drop;
 		}
 
-		if (hci_pi(sk)->channel == HCI_CHANNEL_USER &&
-		    bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
-		    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
-			err = -EINVAL;
-			goto drop;
-		}
-
 		skb_queue_tail(&hdev->raw_q, skb);
 		queue_work(hdev->workqueue, &hdev->tx_work);
 	}
-- 
1.8.3.1

