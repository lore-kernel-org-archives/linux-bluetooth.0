Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Move HCI_ADVERTISING handling into mgmt.c
Date: Mon, 24 Feb 2014 14:52:17 +0200
Message-Id: <1393246342-27980-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon need to make decisions on toggling the HCI_ADVERTISING flag
based on pending mgmt_set_powered commands. Therefore, move the handling
from hci_event.c into mgmt.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 8 ++------
 net/bluetooth/mgmt.c             | 8 ++++++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d2d756753714..6ff882e727d4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1174,6 +1174,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
+void mgmt_advertising(struct hci_dev *hdev, u8 advertising);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 064d619344b3..dea465ba276b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -991,12 +991,8 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
-		if (*sent)
-			set_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		else
-			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-	}
+	if (!status)
+		mgmt_advertising(hdev, *sent);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9865e523df20..d39e57e9fed6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4832,6 +4832,14 @@ void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 		new_settings(hdev, NULL);
 }
 
+void mgmt_advertising(struct hci_dev *hdev, u8 advertising)
+{
+	if (advertising)
+		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
+	else
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+}
+
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	u8 mgmt_err = mgmt_status(status);
-- 
1.8.5.3

