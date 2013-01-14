Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Use req_workqueue for hci_request operations
Date: Mon, 14 Jan 2013 22:33:51 +0200
Message-Id: <1358195633-29303-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts work assignment relying on hci_request() from the
system-global work queue to the per-HCI device specific work queue
(hdev->req_workqueue) intended for hci_request() related tasks.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    5 +++--
 net/bluetooth/mgmt.c     |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f73907a..545553b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1146,7 +1146,8 @@ static void hci_power_on(struct work_struct *work)
 		return;
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		schedule_delayed_work(&hdev->power_off, HCI_AUTO_OFF_TIMEOUT);
+		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
+				   HCI_AUTO_OFF_TIMEOUT);
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
@@ -1830,7 +1831,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_notify(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	schedule_work(&hdev->power_on);
+	queue_work(hdev->req_workqueue, &hdev->power_on);
 
 	return id;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37add53..54114ff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -812,9 +812,9 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (cp->val)
-		schedule_work(&hdev->power_on);
+		queue_work(hdev->req_workqueue, &hdev->power_on);
 	else
-		schedule_work(&hdev->power_off.work);
+		queue_work(hdev->req_workqueue, &hdev->power_off.work);
 
 	err = 0;
 
-- 
1.7.10.4

