Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/7] Bluetooth: Remove unused hci_req_pending() function
Date: Sun, 15 Mar 2015 11:07:33 +0200
Message-Id: <1426410455-18368-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
References: <1426410455-18368-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_req_pending() function has no users anymore, so simply remove
it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 --
 net/bluetooth/hci_core.c         | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d090571a856f..33fa477839f5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1267,8 +1267,6 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
-bool hci_req_pending(struct hci_dev *hdev);
-
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 985c344dfcab..9f88b7c74a80 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3544,11 +3544,6 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-bool hci_req_pending(struct hci_dev *hdev)
-{
-	return (hdev->req_status == HCI_REQ_PEND);
-}
-
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
-- 
2.1.0

