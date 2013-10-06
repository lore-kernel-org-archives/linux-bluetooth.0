Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Simplify device type check for AMP discover response
Date: Sun,  6 Oct 2013 02:08:35 -0700
Message-Id: <1381050516-44319-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When counting the number for AMP controllers, a positive check is
used. To be consistent, use the same check when actually adding
the data for the AMP contollers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index ad8bda3..9410e27 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -78,24 +78,20 @@ u8 __next_ident(struct amp_mgr *mgr)
 /* hci_dev_list shall be locked */
 static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl)
 {
-	int i = 0;
 	struct hci_dev *hdev;
+	int i = 1;
 
 	cl[0].id = AMP_ID_BREDR;
 	cl[0].type = AMP_TYPE_BREDR;
 	cl[0].status = AMP_STATUS_BLUETOOTH_ONLY;
 
 	list_for_each_entry(hdev, &hci_dev_list, list) {
-		/* Iterate through AMP controllers */
-		if (hdev->dev_type != HCI_AMP)
-			continue;
-
-		/* Starting from second entry */
-		++i;
-
-		cl[i].id = hdev->id;
-		cl[i].type = hdev->amp_type;
-		cl[i].status = hdev->amp_status;
+		if (hdev->dev_type == HCI_AMP) {
+			cl[i].id = hdev->id;
+			cl[i].type = hdev->amp_type;
+			cl[i].status = hdev->amp_status;
+			i++;
+		}
 	}
 }
 
-- 
1.8.3.1

