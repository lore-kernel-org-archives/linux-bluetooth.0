Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add LE features to debugfs if available
Date: Sat, 19 Oct 2013 02:25:33 -0700
Message-Id: <1382174733-25708-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For LE capable controllers at the special LE features page to the
debugfs list with all the other features pages.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8aae80b..bfd0e0e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -65,13 +65,20 @@ static int features_show(struct seq_file *f, void *ptr)
 
 	hci_dev_lock(hdev);
 	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
-		seq_printf(f, "Page %u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
+		seq_printf(f, "%2u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
 			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n", p,
 			   hdev->features[p][0], hdev->features[p][1],
 			   hdev->features[p][2], hdev->features[p][3],
 			   hdev->features[p][4], hdev->features[p][5],
 			   hdev->features[p][6], hdev->features[p][7]);
 	}
+	if (lmp_le_capable(hdev))
+		seq_printf(f, "LE: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
+			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n",
+			   hdev->le_features[0], hdev->le_features[1],
+			   hdev->le_features[2], hdev->le_features[3],
+			   hdev->le_features[4], hdev->le_features[5],
+			   hdev->le_features[6], hdev->le_features[7]);
 	hci_dev_unlock(hdev);
 
 	return 0;
-- 
1.8.3.1

