Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix registering HCI devices with duplicate name
Date: Wed, 11 Apr 2012 17:32:08 +0200
Message-Id: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding HCI devices hci_register_dev assigns the same name
hci1 for subsequently added AMP devices.

...
[ 6958.381886] sysfs: cannot create duplicate filename
        '/devices/virtual/bluetooth/hci1
...

Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..4becd28 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1741,7 +1741,7 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
-	int i, id, error;
+	int i, error, min_id, id = 0;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
@@ -1751,13 +1751,14 @@ int hci_register_dev(struct hci_dev *hdev)
 	/* Do not allow HCI_AMP devices to register at index 0,
 	 * so the index can be used as the AMP controller ID.
 	 */
-	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
+	min_id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
 
 	write_lock(&hci_dev_list_lock);
 
 	/* Find first available device id */
 	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
+		if (min_id >= id &&
+		    list_entry(p, struct hci_dev, list)->id != id)
 			break;
 		head = p; id++;
 	}
-- 
1.7.7.6

