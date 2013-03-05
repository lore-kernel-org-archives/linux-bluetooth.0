Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/11] Bluetooth: Remove unused hdev->init_last_cmd
Date: Tue,  5 Mar 2013 20:37:50 +0200
Message-Id: <1362508671-6460-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This variable is no longer needed (due to async HCI request support and
the conversion of hci_req_sync to use it), so it can be safely removed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_core.c         |    6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3f124f4..3a9cbf2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -248,8 +248,6 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
-	__u16			init_last_cmd;
-
 	struct list_head	mgmt_pending;
 
 	struct discovery_state	discovery;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9116dad..b6d44a2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1015,10 +1015,7 @@ int hci_dev_open(__u16 dev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		set_bit(HCI_INIT, &hdev->flags);
-		hdev->init_last_cmd = 0;
-
 		ret = __hci_init(hdev);
-
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -2509,9 +2506,6 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 		return -ENOMEM;
 	}
 
-	if (test_bit(HCI_INIT, &hdev->flags))
-		hdev->init_last_cmd = opcode;
-
 	/* Stand-alone HCI commands must be flaged as
 	 * single-command requests.
 	 */
-- 
1.7.10.4

