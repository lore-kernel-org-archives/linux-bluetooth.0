Return-Path: <cyrus@holtmann.org>
From: wesley.kuo@intel.com
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCHv2] Bluetooth: Fix remote name event return directly.
Date: Wed, 13 May 2015 10:33:15 +0800
Message-Id: <1431484395-29634-1-git-send-email-wesley.kuo@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wesley Kuo <wesley.kuo@intel.com>

This patch fixes hci_remote_name_evt dose not resolve name during
discovery status is RESOLVING. Before simultaneous dual mode scan enabled,
hci_check_pending_name will set discovery status to STOPPED eventually.

Signed-off-by: Wesley Kuo <wesley.kuo@intel.com>
---
 net/bluetooth/hci_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..755a147 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2853,9 +2853,11 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 			 * state. If we were running both LE and BR/EDR inquiry
 			 * simultaneously, and BR/EDR inquiry is already
 			 * finished, stop discovery, otherwise BR/EDR inquiry
-			 * will stop discovery when finished.
+			 * will stop discovery when finished. If we will resolve
+			 * remote device name, do not change discovery state.
 			 */
-			if (!test_bit(HCI_INQUIRY, &hdev->flags))
+			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
+			    hdev->discovery.state != DISCOVERY_RESOLVING)
 				hci_discovery_set_state(hdev,
 							DISCOVERY_STOPPED);
 		} else {
-- 
1.7.9.5

