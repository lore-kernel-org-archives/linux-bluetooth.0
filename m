Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Remove useless HCI_PENDING_CLASS flag
Date: Wed,  6 Mar 2013 09:16:31 +0200
Message-Id: <1362554191-21753-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
References: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that class related operations are tracked through asynchronous HCI
requests this flag is no longer needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 -
 net/bluetooth/hci_event.c   |    3 +--
 net/bluetooth/mgmt.c        |    9 +--------
 3 files changed, 2 insertions(+), 11 deletions(-)

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
index e89707f..6135d68 100644
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
index 92437f9..5428641 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -635,7 +635,6 @@ static int update_class(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 cod[3];
-	int err;
 
 	BT_DBG("%s", hdev->name);
 
@@ -652,11 +651,7 @@ static int update_class(struct hci_request *req)
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return 0;
 
-	err = hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-	if (err == 0)
-		set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
-
-	return err;
+	return hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
 static void service_cache_off(struct work_struct *work)
@@ -3728,8 +3723,6 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
 	int err = 0;
 
-	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
-
 	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
-- 
1.7.10.4

