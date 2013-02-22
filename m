Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/14] Bluetooth: Introduce a hci_transaction_from_skb function
Date: Fri, 22 Feb 2013 15:12:31 +0200
Message-Id: <1361538759-13558-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
References: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To have a consistent content for hdev->cmd_q all entries need to follow
the semantics of HCI transactions. This means that even single commands
need to be dressed as transactions. This patch introduces a new function
to create a single-command transaction and converts the two places
needing this (hci_send_cmd and hci_sock_sendmsg) to use it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   11 +++++++++--
 net/bluetooth/hci_sock.c         |    3 +--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 777005c..8c2553f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1055,6 +1055,7 @@ void hci_transaction_init(struct hci_transaction *transaction,
 int hci_transaction_run(struct hci_transaction *transaction);
 int hci_transaction_cmd(struct hci_transaction *transaction, u16 opcode,
 			u32 plen, void *param);
+void hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b598981..93fa440 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2475,6 +2475,14 @@ int hci_transaction_run(struct hci_transaction *transaction)
 	return 0;
 }
 
+void hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	transaction_start(skb, NULL);
+
+	skb_queue_tail(&hdev->cmd_q, skb);
+	queue_work(hdev->workqueue, &hdev->cmd_work);
+}
+
 static struct sk_buff *prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				   void *param)
 {
@@ -2517,8 +2525,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hdev->init_last_cmd = opcode;
 
-	skb_queue_tail(&hdev->cmd_q, skb);
-	queue_work(hdev->workqueue, &hdev->cmd_work);
+	hci_transaction_from_skb(hdev, skb);
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 07f0739..cc18d22 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -859,8 +859,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
-			skb_queue_tail(&hdev->cmd_q, skb);
-			queue_work(hdev->workqueue, &hdev->cmd_work);
+			hci_transaction_from_skb(hdev, skb);
 		}
 	} else {
 		if (!capable(CAP_NET_RAW)) {
-- 
1.7.10.4

