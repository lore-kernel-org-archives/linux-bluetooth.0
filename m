Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix adv_work delay
Date: Mon,  2 Jan 2012 19:18:10 -0300
Message-Id: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the adv_work delay. It should be set to ADV_
CLEAR_TIMEOUT instead of (jiffies + ADV_CLEAR_TIMEOUT) since
queue_delayed_work() receives the number of jiffies to wait
before queueing. It also removes the unnecessary cancel_delayed_
work_sync() call in case LE scan has been disabled.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 919e3c0..871a864 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1047,9 +1047,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	case LE_SCANNING_DISABLED:
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		cancel_delayed_work_sync(&hdev->adv_work);
 		queue_delayed_work(hdev->workqueue, &hdev->adv_work,
-						 jiffies + ADV_CLEAR_TIMEOUT);
+							ADV_CLEAR_TIMEOUT);
 		break;
 
 	default:
-- 
1.7.8.1

