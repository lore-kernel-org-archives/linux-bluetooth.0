Return-Path: <cyrus@holtmann.org>
From: wesley.kuo@intel.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix remote name event return directly.
Date: Tue, 12 May 2015 18:17:17 +0800
Message-Id: <1431425837-25244-1-git-send-email-wesley.kuo@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: wesleyku <wesley.kuo@intel.com>

This patch fixes hci_remote_name_evt dose not resolve name during
discovery status is RESOLVING. Before simultaneous dual mode scan enabled,
hci_check_pending_name will set discovery status to STOPPED eventually.

Signed-off-by: wesleyku <wesley.kuo@intel.com>
---
 net/bluetooth/hci_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..69fda7e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2855,7 +2855,8 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 			 * finished, stop discovery, otherwise BR/EDR inquiry
 			 * will stop discovery when finished.
 			 */
-			if (!test_bit(HCI_INQUIRY, &hdev->flags))
+			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
+			    hdev->discovery.state != DISCOVERY_RESOLVING)
 				hci_discovery_set_state(hdev,
 							DISCOVERY_STOPPED);
 		} else {
-- 
1.7.9.5

