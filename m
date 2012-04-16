Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH] Bluetooth: Fix registering hci with duplicate name
Date: Mon, 16 Apr 2012 14:08:34 -0300
Message-Id: <1334596114-2263-1-git-send-email-ulisses@profusion.mobi>
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

Andrei, it'd be good if you could test it with AMP and add a tested-by as well, please.

Thanks.

---
 net/bluetooth/hci_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c4dc263..f24d3d8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1754,7 +1754,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	/* Find first available device id */
 	list_for_each(p, &hci_dev_list) {
-		if (list_entry(p, struct hci_dev, list)->id != id)
+		if (list_entry(p, struct hci_dev, list)->id > id)
 			break;
 		head = p; id++;
 	}
-- 
1.7.10
