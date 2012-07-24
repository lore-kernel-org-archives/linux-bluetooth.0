Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Use lmp_sniff_capable where applicable
Date: Tue, 24 Jul 2012 15:03:51 -0300
Message-Id: <1343153033-898-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_SNIFF bit checking by the helper macro
lmp_sniff_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5c71c85..eb9024a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -627,7 +627,7 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 		link_policy |= HCI_LP_RSWITCH;
 	if (hdev->features[0] & LMP_HOLD)
 		link_policy |= HCI_LP_HOLD;
-	if (hdev->features[0] & LMP_SNIFF)
+	if (lmp_sniff_capable(hdev))
 		link_policy |= HCI_LP_SNIFF;
 	if (hdev->features[1] & LMP_PARK)
 		link_policy |= HCI_LP_PARK;
-- 
1.7.11.2

