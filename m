Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/2] Bluetooth: Fix registering hci with duplicate name
Date: Fri, 13 Apr 2012 14:21:38 +0300
Message-Id: <1334316099-18492-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When adding HCI devices hci_register_dev may assigns the same name
hciX for subsequently added HCI devices. Use bitmask to find free
device ID the same way as it is done in other subsystems.

...
[ 6958.381886] sysfs: cannot create duplicate filename
	'/devices/virtual/bluetooth/hci1
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_core.c    |   28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 346f087..38b837b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -56,6 +56,9 @@
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
+/* First BR/EDR Controller shall have ID = 0 */
+#define HCI_BREDR_ID	0
+
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_NO_RESET,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..9596a82 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1740,31 +1740,35 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
-	struct list_head *head = &hci_dev_list, *p;
+	struct hci_dev *d;
 	int i, id, error;
+	unsigned long *inuse;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
-	/* Do not allow HCI_AMP devices to register at index 0,
-	 * so the index can be used as the AMP controller ID.
-	 */
-	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
+	inuse = (unsigned long *) get_zeroed_page(GFP_KERNEL);
+	if (!inuse)
+		return -ENOMEM;
 
 	write_lock(&hci_dev_list_lock);
 
-	/* Find first available device id */
-	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
-			break;
-		head = p; id++;
-	}
+	/* Index HCI_BREDR_ID reserved for BR/EDR controllers */
+	if (hdev->dev_type != HCI_BREDR)
+		set_bit(HCI_BREDR_ID, inuse);
+
+	list_for_each_entry(d, &hci_dev_list, list)
+		set_bit(d->id, inuse);
+
+	id = find_first_zero_bit(inuse, PAGE_SIZE * 8);
+	free_page((unsigned long) inuse);
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
-	list_add_tail(&hdev->list, head);
+
+	list_add_tail(&hdev->list, &hci_dev_list);
 
 	mutex_init(&hdev->lock);
 
-- 
1.7.9.5

