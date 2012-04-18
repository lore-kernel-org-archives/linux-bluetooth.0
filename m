Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH v3] Bluetooth: Fix registering hci with duplicate name
Date: Wed, 18 Apr 2012 12:13:04 -0300
Message-Id: <1334761984-5400-1-git-send-email-ulisses@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

When adding HCI devices hci_register_dev assigns the same name
hci1 for subsequently added AMP devices.

...
[ 6958.381886] sysfs: cannot create duplicate filename
       '/devices/virtual/bluetooth/hci1
...

We assume id starts with the number we'll try to add the new device
and keep iterating until we find the proper place. The only difference
is we start with 0 for BR/EDR device and 1 for AMP devices (thus AMP
devices will never receive register as index 0). Then every hdev->id in
the _ordered_ list <= to the id we want we increment id and move the
variable head. In the end we'll have id as the first available one and
head is where you need to add hdev after to keep the list ordered.

Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---

v3 - really add new hdev after head to keep the list ordered.
v2 - only increment id when we find it's already there in the list.

---
 net/bluetooth/hci_core.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c4dc263..2b98c33 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1739,24 +1739,28 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
-	struct list_head *head = &hci_dev_list, *p;
+	struct list_head *head, *p;
 	int i, id, error;
 
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
+	write_lock(&hci_dev_list_lock);
+
 	/* Do not allow HCI_AMP devices to register at index 0,
 	 * so the index can be used as the AMP controller ID.
 	 */
 	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
-
-	write_lock(&hci_dev_list_lock);
+	head = &hci_dev_list;
 
 	/* Find first available device id */
 	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
+		int nid = list_entry(p, struct hci_dev, list)->id;
+		if (nid > id)
 			break;
-		head = p; id++;
+		if (nid == id)
+			id++;
+		head = p;
 	}
 
 	sprintf(hdev->name, "hci%d", id);
@@ -1764,7 +1768,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	list_add_tail(&hdev->list, head);
+	list_add(&hdev->list, head);
 
 	mutex_init(&hdev->lock);
 
-- 
1.7.10
