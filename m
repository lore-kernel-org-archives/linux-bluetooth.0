Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix clearing HCI_PSCAN flag
Date: Mon, 28 Jul 2014 15:45:31 +0300
Message-Id: <1406551531-16144-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes a typo in the hci_cc_write_scan_enable() function where
we want to clear the HCI_PSCAN flag if the SCAN_PAGE bit of the HCI
command parameter was not set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
This one should be applied before the following 5-patch set:
Subject: [PATCH v2 0/5] Bluetooth: Page scan fixes & improvements

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ba26fbfe481a..623501ddd1b8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -317,7 +317,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (param & SCAN_PAGE)
 		set_bit(HCI_PSCAN, &hdev->flags);
 	else
-		clear_bit(HCI_ISCAN, &hdev->flags);
+		clear_bit(HCI_PSCAN, &hdev->flags);
 
 done:
 	hci_dev_unlock(hdev);
-- 
1.9.3

