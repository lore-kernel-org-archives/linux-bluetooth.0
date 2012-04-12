Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix registering HCI devices with duplicate name
Date: Thu, 12 Apr 2012 14:39:57 +0300
Message-Id: <1334230797-11212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
References: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When adding HCI devices hci_register_dev assigns the same name
hci1 for subsequently added AMP devices. This is modified version
of Marcel Holtmann patch.

...
[ 6958.381886] sysfs: cannot create duplicate filename
        '/devices/virtual/bluetooth/hci1
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..99e93cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1741,7 +1741,7 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
-	int i, id, error;
+	int i, error, min_id, id = 0;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
@@ -1751,20 +1751,22 @@ int hci_register_dev(struct hci_dev *hdev)
 	/* Do not allow HCI_AMP devices to register at index 0,
 	 * so the index can be used as the AMP controller ID.
 	 */
-	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
+	min_id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
 
 	write_lock(&hci_dev_list_lock);
 
 	/* Find first available device id */
 	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
+		struct hci_dev *hdev = list_entry(p, struct hci_dev, list);
+		if (min_id <= id && hdev->id != id)
 			break;
+
 		head = p; id++;
 	}
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
-	list_add_tail(&hdev->list, head);
+	list_add(&hdev->list, head);
 
 	mutex_init(&hdev->lock);
 
-- 
1.7.9.1

