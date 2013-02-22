Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unused hdev->init_last_cmd
Date: Fri, 22 Feb 2013 18:39:01 +0200
Message-Id: <1361551141-7240-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This variable is no longer needed (due to the transaction framweork and
the conversion of hci_request to use it), so it can be safely removed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
I forgot this one from my patch set while redoing it. It should be
applied after the other commands in the set (well, at least after
"Convert hci_request to use HCI transaction framework").

 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_core.c         |    6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 805551b..c9827f9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -250,8 +250,6 @@ struct hci_dev {
 
 	transaction_complete_t	transaction_complete;
 
-	__u16			init_last_cmd;
-
 	struct list_head	mgmt_pending;
 
 	struct discovery_state	discovery;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d8598d4..ff8f088 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1042,10 +1042,7 @@ int hci_dev_open(__u16 dev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		set_bit(HCI_INIT, &hdev->flags);
-		hdev->init_last_cmd = 0;
-
 		ret = __hci_init(hdev);
-
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -2548,9 +2545,6 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 		return -ENOMEM;
 	}
 
-	if (test_bit(HCI_INIT, &hdev->flags))
-		hdev->init_last_cmd = opcode;
-
 	hci_transaction_from_skb(hdev, skb);
 
 	return 0;
-- 
1.7.10.4

