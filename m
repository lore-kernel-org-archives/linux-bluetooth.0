Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove debug statement for features complete event
Date: Thu, 31 Oct 2013 04:54:32 -0700
Message-Id: <1383220473-33584-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The complete list of local features are available through debugfs and
so there is no need to add a debug print here.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5935f748c0f9..d75d51ff4fdd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -538,12 +538,6 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 
 	if (hdev->features[0][5] & LMP_EDR_3S_ESCO)
 		hdev->esco_type |= (ESCO_2EV5 | ESCO_3EV5);
-
-	BT_DBG("%s features 0x%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x", hdev->name,
-	       hdev->features[0][0], hdev->features[0][1],
-	       hdev->features[0][2], hdev->features[0][3],
-	       hdev->features[0][4], hdev->features[0][5],
-	       hdev->features[0][6], hdev->features[0][7]);
 }
 
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
-- 
1.8.3.1

