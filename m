Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Bluetooth: Utilize %*ph specifier
Date: Mon, 11 Dec 2017 12:10:33 +0200
Message-Id: <20171211101033.60971-1-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of open coding byte-by-byte printing, re-use %*ph specifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/bluetooth/hci_debugfs.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 63df63ebfb24..e204bfdb5ba2 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -106,21 +106,10 @@ static int features_show(struct seq_file *f, void *ptr)
 	u8 p;
 
 	hci_dev_lock(hdev);
-	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
-		seq_printf(f, "%2u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
-			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n", p,
-			   hdev->features[p][0], hdev->features[p][1],
-			   hdev->features[p][2], hdev->features[p][3],
-			   hdev->features[p][4], hdev->features[p][5],
-			   hdev->features[p][6], hdev->features[p][7]);
-	}
+	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++)
+		seq_printf(f, "%2u: %8ph\n", p, hdev->features[p]);
 	if (lmp_le_capable(hdev))
-		seq_printf(f, "LE: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
-			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n",
-			   hdev->le_features[0], hdev->le_features[1],
-			   hdev->le_features[2], hdev->le_features[3],
-			   hdev->le_features[4], hdev->le_features[5],
-			   hdev->le_features[6], hdev->le_features[7]);
+		seq_printf(f, "LE: %8ph\n", hdev->le_features);
 	hci_dev_unlock(hdev);
 
 	return 0;
-- 
2.15.0

