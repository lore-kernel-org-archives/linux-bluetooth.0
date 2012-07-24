Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Use lmp_sniffsubr_capable where applicable
Date: Tue, 24 Jul 2012 15:03:52 -0300
Message-Id: <1343153033-898-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_SNIFF_SUBR bit checking by the helper
macro lmp_sniffsubr_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eb9024a..060780c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -513,7 +513,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	if (hdev->features[3] & LMP_RSSI_INQ)
 		events[4] |= 0x02; /* Inquiry Result with RSSI */
 
-	if (hdev->features[5] & LMP_SNIFF_SUBR)
+	if (lmp_sniffsubr_capable(hdev))
 		events[5] |= 0x20; /* Sniff Subrating */
 
 	if (hdev->features[5] & LMP_PAUSE_ENC)
-- 
1.7.11.2

