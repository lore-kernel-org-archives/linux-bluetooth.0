Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Inquiry with RSSI event mask
Date: Thu, 26 Apr 2012 09:47:46 +0300
Message-Id: <1335422866-15474-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The right bit for "Inquiry with RSSI" is 0x02 and not 0x04 (which means
"Read Remote Extended Features Complete").

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ec6c195..e3c4c1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -521,7 +521,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	events[5] |= 0x10; /* Synchronous Connection Changed */
 
 	if (hdev->features[3] & LMP_RSSI_INQ)
-		events[4] |= 0x04; /* Inquiry Result with RSSI */
+		events[4] |= 0x02; /* Inquiry Result with RSSI */
 
 	if (hdev->features[5] & LMP_SNIFF_SUBR)
 		events[5] |= 0x20; /* Sniff Subrating */
-- 
1.7.10

