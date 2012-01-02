Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Queue adv_work on system workqueue
Date: Mon,  2 Jan 2012 19:18:11 -0300
Message-Id: <1325542691-6235-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
References: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch queues hdev->adv_work on the system-wide workqueue
instead of on hdev->workqueue. This way we keep only tx/rx works
on hdev->workqueue.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 871a864..3184f17 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1047,8 +1047,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	case LE_SCANNING_DISABLED:
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		queue_delayed_work(hdev->workqueue, &hdev->adv_work,
-							ADV_CLEAR_TIMEOUT);
+		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
 		break;
 
 	default:
-- 
1.7.8.1

