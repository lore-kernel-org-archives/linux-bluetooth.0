Return-Path: <cyrus@holtmann.org>
Message-ID: <49A5BEEF.9080603@gmail.com>
Date: Wed, 25 Feb 2009 22:58:07 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

i reaches pkts_to_be_removed + 1

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 894b2cb..177f34b 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -385,7 +385,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
-	if (i != pkts_to_be_removed)
+	if (i <= pkts_to_be_removed)
 		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
 }
 
