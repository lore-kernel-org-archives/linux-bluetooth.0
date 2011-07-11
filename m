Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 03/16] Bluetooth: Remove pending discovery commands
Date: Mon, 11 Jul 2011 18:11:46 -0300
Message-Id: <1310418719-12296-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discovery commands are added to the pending list but they aren't
removed.

This patch removes MGMT_OP_START_DISCOVERY and MGMT_OP_STOP_DISCOVERY
commands from pending command list when they terminate.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf0efe5..ea9e105 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -55,8 +55,10 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
+	if (status) {
+		mgmt_stop_discovery_failed(hdev->id, bt_to_errno(status));
 		return;
+	}
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
@@ -65,6 +67,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_check_pending(hdev);
 
 	mgmt_discovering(hdev->id, 0);
+	mgmt_stop_discovery_complete(hdev->id);
 }
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
@@ -952,6 +955,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	if (status) {
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
+
+		mgmt_start_discovery_failed(hdev->id, bt_to_errno(status));
+
 		return;
 	}
 
@@ -1340,11 +1346,17 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
+	if (status) {
+		mgmt_start_discovery_failed(hdev->id, bt_to_errno(status));
+		return;
+	}
+
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	mgmt_discovering(hdev->id, 0);
+	mgmt_start_discovery_complete(hdev->id);
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.4.1

