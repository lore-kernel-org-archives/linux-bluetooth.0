Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH v2] Bluetooth: Fix registering hci with duplicate name
Date: Tue, 17 Apr 2012 10:41:27 -0300
Message-Id: <1334670087-2622-1-git-send-email-ulisses@profusion.mobi>
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

v2 - only increment id when we find it's already there in the list.

---
 net/bluetooth/hci_core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c4dc263..e2202a1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1754,9 +1754,12 @@ int hci_register_dev(struct hci_dev *hdev)
 
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
-- 
1.7.10
