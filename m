Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/12 v3] Bluetooth: Add hci_transaction_from_skb function
Date: Fri, 15 Feb 2013 11:51:52 +0200
Message-Id: <1360921920-14080-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function is needed for situations where a transaction needs to be
constructed straight from an skb. This happens e.g. when going through
the HCI driver initialization commands in hci_init_req() or when
receiving commands from user space through a raw HCI socket.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 54efaa2..b5c6f99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1063,6 +1063,7 @@ int hci_complete_transaction(struct hci_dev *hdev,
 			     void (*complete)(struct hci_dev *hdev,
 					      __u16 last_cmd, int status));
 bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+int hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8923a1f..6569248 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2276,6 +2276,34 @@ unlock:
 	return err;
 }
 
+static int __transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_transaction *transaction;
+
+	transaction = kzalloc(sizeof(*transaction), GFP_KERNEL);
+	if (!transaction)
+		return -ENOMEM;
+
+	skb_queue_head_init(&transaction->cmd_q);
+
+	skb_queue_tail(&transaction->cmd_q, skb);
+
+	__transaction_add(hdev, transaction);
+
+	return 0;
+}
+
+int hci_transaction_from_skb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int err;
+
+	hci_transaction_lock(hdev);
+	err = __transaction_from_skb(hdev, skb);
+	hci_transaction_unlock(hdev);
+
+	return err;
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 {
-- 
1.7.10.4

