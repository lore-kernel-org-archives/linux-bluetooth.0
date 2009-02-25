Return-Path: <cyrus@holtmann.org>
Message-ID: <49A5CC03.7020906@gmail.com>
Date: Wed, 25 Feb 2009 23:53:55 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
References: <49A5BEEF.9080603@gmail.com> <1235601640.27004.5.camel@localhost.localdomain>
In-Reply-To: <1235601640.27004.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> i reaches pkts_to_be_removed + 1

> patch looks good, but can you please fill in the commit message with a
> little bit more details and background.

This was found by code inspection by the way, and not tested.

how about:
------------------------------>8-------------8<---------------------------------
When all packets are removed 'i' reaches pkts_to_be_removed + 1, so the
error message was printed upon success, and not when the last packet
wasn't removed.

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
 
