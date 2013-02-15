Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12 v3] Bluetooth: Remove unused hdev->init_last_cmd
Date: Fri, 15 Feb 2013 11:51:59 +0200
Message-Id: <1360921920-14080-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This variable is no longer needed as the functionality is provided by
the HCI transaction framework.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_core.c         |    4 ----
 2 files changed, 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe7df9e..4c14d31 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -261,8 +261,6 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
-	__u16			init_last_cmd;
-
 	struct list_head	mgmt_pending;
 
 	struct discovery_state	discovery;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ddda5e7..35b9bb5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -750,7 +750,6 @@ int hci_dev_open(__u16 dev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		set_bit(HCI_INIT, &hdev->flags);
-		hdev->init_last_cmd = 0;
 
 		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
@@ -2312,9 +2311,6 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
 	skb->dev = (void *) hdev;
 
-	if (test_bit(HCI_INIT, &hdev->flags))
-		hdev->init_last_cmd = opcode;
-
 	err = 0;
 
 	hci_transaction_lock(hdev);
-- 
1.7.10.4

