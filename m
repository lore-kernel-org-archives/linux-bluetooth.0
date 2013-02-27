Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 15/16] Bluetooth: Remove useless HCI_PENDING_CLASS flag
Date: Wed, 27 Feb 2013 09:57:23 +0200
Message-Id: <1361951844-13719-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that class related operations are tracked through HCI transactions
this flag is no longer needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 -
 net/bluetooth/hci_event.c   |    3 +--
 net/bluetooth/mgmt.c        |   11 ++---------
 3 files changed, 3 insertions(+), 12 deletions(-)

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
index d63efc8..8ab12fb 100644
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
index d035bee..f73c7da 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -636,7 +636,6 @@ static int update_class(struct hci_transaction *transaction)
 {
 	struct hci_dev *hdev = transaction->hdev;
 	u8 cod[3];
-	int err;
 
 	BT_DBG("%s", hdev->name);
 
@@ -653,12 +652,8 @@ static int update_class(struct hci_transaction *transaction)
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return 0;
 
-	err = hci_transaction_cmd(transaction, HCI_OP_WRITE_CLASS_OF_DEV,
-				  sizeof(cod), cod);
-	if (err == 0)
-		set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
-
-	return err;
+	return hci_transaction_cmd(transaction, HCI_OP_WRITE_CLASS_OF_DEV,
+				   sizeof(cod), cod);
 }
 
 static void service_cache_off(struct work_struct *work)
@@ -3748,8 +3743,6 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
 	int err = 0;
 
-	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
-
 	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
-- 
1.7.10.4

