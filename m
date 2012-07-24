Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Use lmp_no_flush_capable where applicable
Date: Tue, 24 Jul 2012 15:03:53 -0300
Message-Id: <1343153033-898-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_NO_FLUSH bit checking by the helper
macro lmp_no_flush_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 060780c..2d8761b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -522,7 +522,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	if (hdev->features[6] & LMP_EXT_INQ)
 		events[5] |= 0x40; /* Extended Inquiry Result */
 
-	if (hdev->features[6] & LMP_NO_FLUSH)
+	if (lmp_no_flush_capable(hdev))
 		events[7] |= 0x01; /* Enhanced Flush Complete */
 
 	if (hdev->features[7] & LMP_LSTO)
-- 
1.7.11.2

