Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] Bluetooth: Use queue in the device list
Date: Wed, 16 Nov 2011 17:30:20 +0200
Message-Id: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use queue instead of stack discipline for device list. When processing
dev_list with list_for_each* devices will be prosessed in order they
were added (Usually BR/EDR first and AMP later).

Also output from hciconfig looks nicer :-)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cf18f6d..aee76fd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1452,7 +1452,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
-	list_add(&hdev->list, head);
+	list_add_tail(&hdev->list, head);
 
 	atomic_set(&hdev->refcnt, 1);
 	spin_lock_init(&hdev->lock);
-- 
1.7.4.1

