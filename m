Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/2] Bluetooth: Fix debug printing unallocated name
Date: Fri, 13 Apr 2012 14:21:39 +0300
Message-Id: <1334316099-18492-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It does make sense to print hdev name after allocation.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9596a82..a3c955f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1744,8 +1744,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	int i, id, error;
 	unsigned long *inuse;
 
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
@@ -1768,6 +1766,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
 
+	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
+
 	list_add_tail(&hdev->list, &hci_dev_list);
 
 	mutex_init(&hdev->lock);
-- 
1.7.9.5

