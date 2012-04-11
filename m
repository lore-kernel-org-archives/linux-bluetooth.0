Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3] Bluetooth: Fix registering hci with duplicate name
Date: Wed, 11 Apr 2012 15:01:54 +0300
Message-Id: <1334145714-12662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When adding HCI devices hci_register_dev assigns the same name
hci1 for subsequently added AMP devices. Find free device id
the same way as it is done in netdev.

...
[ 6958.381886] sysfs: cannot create duplicate filename
	'/devices/virtual/bluetooth/hci1
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..e08d822 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1740,14 +1740,20 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
-	struct list_head *head = &hci_dev_list, *p;
+	struct list_head *head = &hci_dev_list;
+	struct hci_dev *d;
 	int i, id, error;
+	unsigned long *inuse;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
+	inuse = (unsigned long *) get_zeroed_page(GFP_KERNEL);
+	if (!inuse)
+		return -ENOMEM;
+
 	/* Do not allow HCI_AMP devices to register at index 0,
 	 * so the index can be used as the AMP controller ID.
 	 */
@@ -1755,16 +1761,25 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	write_lock(&hci_dev_list_lock);
 
-	/* Find first available device id */
-	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
-			break;
-		head = p; id++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		set_bit(d->id, inuse);
+
+	i = find_first_zero_bit(inuse, sizeof(*inuse));
+	free_page((unsigned long) inuse);
+
+	id = max_t(int, i, id);
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
-	list_add_tail(&hdev->list, head);
+
+	/* keep hci_dev_list ordered */
+	list_for_each_entry(d, &hci_dev_list, list)
+		if (d->id + 1 == id) {
+			head = &d->list;
+			break;
+		}
+
+	list_add(&hdev->list, head);
 
 	mutex_init(&hdev->lock);
 
-- 
1.7.9.1

