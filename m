Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Assure BREDR HCI device first in the list
Date: Tue, 15 Nov 2011 14:58:59 +0200
Message-Id: <1321361939-24024-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Using different list_add to make sure that BR/EDR HCI device is the
first device in the hci_dev_list. This is needed for e.g. A2MP Discover
Command which requires that "entry for Controller ID 0x00 (Primary
BR/EDR controller) shall always be sent and shall be the first entry
in the Controller List.
Also output from hciconfig looks nicer :-)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 02a6f15..bf24218 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1501,7 +1501,11 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
-	list_add(&hdev->list, head);
+
+	if (hdev->dev_type == HCI_BREDR)
+		list_add(&hdev->list, head);
+	else
+		list_add_tail(&hdev->list, head);
 
 	atomic_set(&hdev->refcnt, 1);
 	spin_lock_init(&hdev->lock);
-- 
1.7.4.1

