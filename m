Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 06/26] Bluetooth: Remove useless HCI_PENDING_CLASS flag
Date: Wed, 13 Mar 2013 11:11:57 -0700
Message-Id: <1363198337-3896-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that class related operations are tracked through asynchronous HCI
requests this flag is no longer needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 -
 net/bluetooth/hci_event.c   |    3 +--
 net/bluetooth/mgmt.c        |    4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f12c25f..1e723c7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -119,7 +119,6 @@ enum {
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
-	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
 };
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d11b87b..5f2d008 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -194,8 +194,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_RESET, &hdev->flags);
 
 	/* Reset all non-persistent flags */
-	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
-			     BIT(HCI_PERIODIC_INQ));
+	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ));
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a0bbb9..3e3cb01 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -652,8 +652,6 @@ static void update_class(struct hci_request *req)
 		return;
 
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-
-	set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
 }
 
 static void service_cache_off(struct work_struct *work)
@@ -3762,8 +3760,6 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
 	int err = 0;
 
-	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
-
 	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
-- 
1.7.10.4

