Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Remove unneeded mgmt_write_scan_failed function
Date: Thu, 10 Jul 2014 12:09:09 +0300
Message-Id: <1404983349-6105-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Set Connectable/Discoverable mgmt handlers use a hci_request with a
proper callback to handle the HCI command sending. It makes therefore
little sense to have this extra function to be called from hci_event.c
for command failures.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_event.c        |  1 -
 net/bluetooth/mgmt.c             | 13 -------------
 3 files changed, 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b65efb22be54..7e9e95633a85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1288,7 +1288,6 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_update_adv_data(struct hci_dev *hdev);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
-void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 760bbd88f3c5..a62e918d2641 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -309,7 +309,6 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (status) {
-		mgmt_write_scan_failed(hdev, param, status);
 		hdev->discov_timeout = 0;
 		goto done;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1dad7bffc6af..7703b72653ff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6049,19 +6049,6 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
-void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
-{
-	u8 mgmt_err = mgmt_status(status);
-
-	if (scan & SCAN_PAGE)
-		mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev,
-				     cmd_status_rsp, &mgmt_err);
-
-	if (scan & SCAN_INQUIRY)
-		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev,
-				     cmd_status_rsp, &mgmt_err);
-}
-
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent)
 {
-- 
1.9.3

