Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add mising hci_skb_opcode for raw socket commands
Date: Fri,  6 Nov 2015 07:42:20 +0100
Message-Id: <1446792140-20425-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When HCI commands are injected via the raw socket, the core was not
including the decoded opcode value. So ensure that it is actually set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 19b23013c4f6..32caa6271a92 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1242,6 +1242,11 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto drop;
 		}
 
+		/* Since the opcode has already been extracted here, store
+		 * a copy of the value for later use by the drivers.
+		 */
+		hci_skb_opcode(skb) = opcode;
+
 		if (ogf == 0x3f) {
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
-- 
2.5.0

