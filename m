Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
From: Marcel Holtmann <marcel@holtmann.org>
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <49A5BEEF.9080603@gmail.com>
References: <49A5BEEF.9080603@gmail.com>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 23:40:39 +0100
Message-Id: <1235601640.27004.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roel,

> i reaches pkts_to_be_removed + 1
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 894b2cb..177f34b 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -385,7 +385,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
>  
>  	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
>  
> -	if (i != pkts_to_be_removed)
> +	if (i <= pkts_to_be_removed)
>  		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
>  }

patch looks good, but can you please fill in the commit message with a
little bit more details and background.

Regards

Marcel


