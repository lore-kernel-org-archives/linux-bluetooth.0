Return-Path: <cyrus@holtmann.org>
Message-ID: <49ABD302.3000305@gmail.com>
Date: Mon, 02 Mar 2009 13:37:22 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: David Sainty <david.sainty@dtsp.co.nz>,
 linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
References: <49A5BEEF.9080603@gmail.com>	 <1235601640.27004.5.camel@localhost.localdomain>	 <49A5CF77.6020306@dtsp.co.nz> <1235605386.27004.16.camel@localhost.localdomain>
In-Reply-To: <1235605386.27004.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>


>> Isn't there something wrong with this?  The patched code looks like it 
>> will output apparently nonsensical messages like "Removed only 10 out of 
>> 10 pkts".
> 
> yeah, that would make no real sense. I actually just thought about why
> we have that error message at all. We should remove the message all together.
------------------------------>8-------------8<---------------------------------
When all packets are removed 'i' reaches pkts_to_be_removed + 1, so the error
message was printed upon success, and not when the last packet wasn't removed.
Since it results in nonsensical messages, it was decided to remove the test
altogether.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 894b2cb..52c6bdc 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -384,9 +384,6 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 		del_timer(&bcsp->tbcsp);
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
-
-	if (i != pkts_to_be_removed)
-		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
 }
 
 /* Handle BCSP link-establishment packets. When we
