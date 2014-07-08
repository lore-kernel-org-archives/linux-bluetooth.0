Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix check for re-enabling advertising
Date: Tue,  8 Jul 2014 16:05:05 +0300
Message-Id: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are many different places that can disable LE scanning but we only
want to re-enable advertising in hci_cc_le_set_scan_enable() for a very
specific use case, which is when the active scanning part of Start
Discovery is complete. Because of this, fix the discovery state check to
test for the exact state.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5d3095d7d4b0..2b3d366e5d98 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1188,7 +1188,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				       &hdev->dev_flags))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
-			 hdev->discovery.state != DISCOVERY_STARTING)
+			 hdev->discovery.state == DISCOVERY_FINDING)
 			mgmt_reenable_advertising(hdev);
 
 		break;
-- 
1.9.3

