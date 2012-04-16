Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix debug printing unallocated name
Date: Mon, 16 Apr 2012 16:32:04 +0300
Message-Id: <1334583124-15134-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334583124-15134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334583124-15134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It does make sense to print hdev name after allocation.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 26a6efc..c4dc263 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1742,8 +1742,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	struct list_head *head = &hci_dev_list, *p;
 	int i, id, error;
 
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
@@ -1763,6 +1761,9 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
+
+	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
+
 	list_add_tail(&hdev->list, head);
 
 	mutex_init(&hdev->lock);
-- 
1.7.9.5

