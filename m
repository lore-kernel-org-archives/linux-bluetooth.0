Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Use lmp_rswitch_capable where applicable
Date: Tue, 24 Jul 2012 15:03:50 -0300
Message-Id: <1343153033-898-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_RSWITCH bit checking by the helper macro
lmp_rswitch_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5722a38..5c71c85 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -623,7 +623,7 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 	struct hci_cp_write_def_link_policy cp;
 	u16 link_policy = 0;
 
-	if (hdev->features[0] & LMP_RSWITCH)
+	if (lmp_rswitch_capable(hdev))
 		link_policy |= HCI_LP_RSWITCH;
 	if (hdev->features[0] & LMP_HOLD)
 		link_policy |= HCI_LP_HOLD;
-- 
1.7.11.2

