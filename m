Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
From: Marcel Holtmann <marcel@holtmann.org>
To: David Sainty <david.sainty@dtsp.co.nz>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-bluetooth@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <49A5CF77.6020306@dtsp.co.nz>
References: <49A5BEEF.9080603@gmail.com>
	 <1235601640.27004.5.camel@localhost.localdomain>
	 <49A5CF77.6020306@dtsp.co.nz>
Content-Type: text/plain
Date: Thu, 26 Feb 2009 00:43:06 +0100
Message-Id: <1235605386.27004.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> >> index 894b2cb..177f34b 100644
> >> --- a/drivers/bluetooth/hci_bcsp.c
> >> +++ b/drivers/bluetooth/hci_bcsp.c
> >> @@ -385,7 +385,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
> >>  
> >>  	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
> >>  
> >> -	if (i != pkts_to_be_removed)
> >> +	if (i <= pkts_to_be_removed)
> >>  		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
> >>  }
> >>     
> >
> > patch looks good, but can you please fill in the commit message with a
> > little bit more details and background.
> >   
> 
> Isn't there something wrong with this?  The patched code looks like it 
> will output apparently nonsensical messages like "Removed only 10 out of 
> 10 pkts".

yeah, that would make no real sense. I actually just thought about why
we have that error message at all. We might should remove the message
all together.

Regards

Marcel


