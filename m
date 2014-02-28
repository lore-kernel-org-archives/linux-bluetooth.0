Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix trying to disable scanning twice
Date: Fri, 28 Feb 2014 20:26:12 +0200
Message-Id: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The discovery process has a timer for disabling scanning, however
scanning might be disabled through other means too like the auto-connect
process.  We should therefore ensure that the timer is never active
after sending a HCI command to disable scanning.

There was some existing code in stop_scan_complete trying to avoid the
timer when a connect request interrupts a discovery procedure, but the
other way around was not covered. This patch covers both scenarios by
canceling the timer as soon as we get a successful command complete for
the disabling HCI command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  | 1 -
 net/bluetooth/hci_event.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7e47e4240c95..5330fcfde93d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -628,7 +628,6 @@ static void stop_scan_complete(struct hci_dev *hdev, u8 status)
 	/* Since we may have prematurely stopped discovery procedure, we should
 	 * update discovery state.
 	 */
-	cancel_delayed_work(&hdev->le_scan_disable);
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
 	hci_req_init(&req, hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a1075c713a9d..e3335b03c992 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1018,6 +1018,11 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCAN_DISABLE:
+		/* Cancel this timer so that we don't try to disable scanning
+		 * when it's already disabled.
+		 */
+		cancel_delayed_work(&hdev->le_scan_disable);
+
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 		break;
 
-- 
1.8.5.3

