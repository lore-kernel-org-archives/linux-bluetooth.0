Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix address in unmergeable device found events
Date: Sat, 29 Mar 2014 08:39:53 +0200
Message-Id: <1396075193-29925-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When sending out a device found event caused by an advertising report in
the situation where we couldn't store the report as a pending one, the
code was incorrectly trying to use the address and address type from the
pending data. Since the pending data is cleared in the previous line
this causes a potentially incorrect address type and an address of
BDADDR_ANY. This patch fixes the call to use the address information
correctly from the received advertising report.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ddb518c62ed1..84acc4aabc5f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4081,9 +4081,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 * the pending report and send out a device found event.
 		 */
 		clear_pending_adv_report(hdev);
-		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-				  d->last_adv_addr_type, NULL, rssi, 0, 1,
-				  data, len, NULL, 0);
+		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
+				  rssi, 0, 1, data, len, NULL, 0);
 		return;
 	}
 
-- 
1.9.0

