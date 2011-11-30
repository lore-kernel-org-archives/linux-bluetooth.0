Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 2/3] Bluetooth: AMP: Initialize and free amp_pending
Date: Wed, 30 Nov 2011 15:54:31 +0200
Message-Id: <1322661272-32027-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

amp_pending is used as a callback when receiving HCI response event.
Idea is taken from mgmt interface (mgmt_pending).
---
 net/bluetooth/hci_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fa33b27..331061f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -60,6 +60,8 @@ static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
 
+void amp_pending_remove_all(struct hci_dev *hdev);
+
 static DEFINE_RWLOCK(hci_task_lock);
 
 /* HCI device list */
@@ -1559,6 +1561,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 
+	INIT_LIST_HEAD(&hdev->amp_pending);
+
 	INIT_LIST_HEAD(&hdev->blacklist);
 
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -1640,6 +1644,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 					!test_bit(HCI_SETUP, &hdev->flags)) {
 		hci_dev_lock_bh(hdev);
 		mgmt_index_removed(hdev);
+		amp_pending_remove_all(hdev);
 		hci_dev_unlock_bh(hdev);
 	}
 
@@ -1647,6 +1652,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	 * pending list */
 	BUG_ON(!list_empty(&hdev->mgmt_pending));
 
+	BUG_ON(!list_empty(&hdev->amp_pending));
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
-- 
1.7.4.1

