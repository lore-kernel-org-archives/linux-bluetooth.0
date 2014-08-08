Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Move SMP initialization after HCI init
Date: Fri,  8 Aug 2014 09:32:51 +0300
Message-Id: <1407479572-4868-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

First of all, it's wasteful to initialize SMP if it's never going to be
used (e.g. on non-LE controllers). Second of all, when we move to use
l2cap_chan we need to know the real local address, meaning we must have
completed at least part of the HCI init. This patch moves the SMP
initialization to after the HCI init procedure and makes it depend on
whether the controller actually supports LE.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1f691c50abbc..9eb2869b183b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1926,6 +1926,8 @@ static int __hci_init(struct hci_dev *hdev)
 		debugfs_create_u16("discov_interleaved_timeout", 0644,
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
+
+		hci_register_smp(hdev);
 	}
 
 	return 0;
@@ -4127,13 +4129,9 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	dev_set_name(&hdev->dev, "%s", hdev->name);
 
-	error = hci_register_smp(hdev);
-	if (error)
-		goto err_wqueue;
-
 	error = device_add(&hdev->dev);
 	if (error < 0)
-		goto err_smp;
+		goto err_wqueue;
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
@@ -4175,8 +4173,6 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	return id;
 
-err_smp:
-	hci_unregister_smp(hdev);
 err_wqueue:
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
-- 
1.9.3

