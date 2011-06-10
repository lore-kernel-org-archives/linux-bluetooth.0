Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 03/16] Bluetooth: Remove pending discovery commands
Date: Fri, 10 Jun 2011 16:36:00 -0300
Message-Id: <1307734573-1630-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
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
index 18b9813..0f8126d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -53,8 +53,10 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
+	if (status) {
+		mgmt_stop_discovery_failed(hdev->id);
 		return;
+	}
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
@@ -63,6 +65,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_check_pending(hdev);
 
 	mgmt_discovering(hdev->id, 0);
+	mgmt_stop_discovery_complete(hdev->id);
 }
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
@@ -871,6 +874,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	if (status) {
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
+
+		mgmt_start_discovery_failed(hdev->id);
+
 		return;
 	}
 
@@ -1254,11 +1260,17 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
+	if (status) {
+		mgmt_start_discovery_failed(hdev->id);
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

