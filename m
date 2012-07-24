Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Use lmp_esco_capable where applicable
Date: Tue, 24 Jul 2012 15:03:49 -0300
Message-Id: <1343153033-898-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_ESCO bit checking by the helper macro
lmp_esco_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b120388..5722a38 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -686,7 +686,7 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 		hdev->esco_type |= (ESCO_HV3);
 	}
 
-	if (hdev->features[3] & LMP_ESCO)
+	if (lmp_esco_capable(hdev))
 		hdev->esco_type |= (ESCO_EV3);
 
 	if (hdev->features[4] & LMP_EV4)
-- 
1.7.11.2

