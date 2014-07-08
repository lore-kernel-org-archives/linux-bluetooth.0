Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Remove unnecessary mgmt_advertising function
Date: Tue,  8 Jul 2014 15:07:48 +0300
Message-Id: <1404821273-28005-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the real advertising state is now tracked with its own flag we can
simply set/unset the HCI_ADVERTISING flag in the
set_advertising_complete function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_event.c        |  2 --
 net/bluetooth/mgmt.c             | 17 +++++------------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5701d15779dd..c98de309967e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1292,7 +1292,6 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
-void mgmt_advertising(struct hci_dev *hdev, u8 advertising);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 10f8de9400bc..8fbf604ba228 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1080,8 +1080,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		clear_bit(HCI_LE_ADV, &hdev->dev_flags);
 	}
 
-	mgmt_advertising(hdev, *sent);
-
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9cc7108f4c45..dda1eb124208 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4034,6 +4034,11 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
 		return;
 	}
 
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
+	else
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+
 	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, settings_rsp,
 			     &match);
 
@@ -5978,18 +5983,6 @@ void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 		new_settings(hdev, NULL);
 }
 
-void mgmt_advertising(struct hci_dev *hdev, u8 advertising)
-{
-	/* Powering off may stop advertising - don't let that interfere */
-	if (!advertising && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
-		return;
-
-	if (advertising)
-		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
-	else
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-}
-
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	u8 mgmt_err = mgmt_status(status);
-- 
1.9.3

