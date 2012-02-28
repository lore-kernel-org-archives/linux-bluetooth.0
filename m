Return-Path: <cyrus@holtmann.org>
Message-ID: <1330446030.3392.80.camel@aeonflux>
Subject: Re: [patch] Bluetooth: change min_t() cast in hci_reassembly()
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Tue, 28 Feb 2012 08:20:30 -0800
In-Reply-To: <20120228065759.GD20506@elgon.mountain>
References: <20120228065759.GD20506@elgon.mountain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> "count" is type int so the cast to __u16 truncates the high bits away
> and triggers a Smatch static checker warning.  It looks like a high
> value of count could cause a forever loop, but I didn't follow it
> through to see if count is capped somewhere.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e6cbb8a..db484a8 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1966,7 +1966,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
>  
>  	while (count) {
>  		scb = (void *) skb->cb;
> -		len = min_t(__u16, scb->expect, count);

this is a good idea since essentially packets are max u16.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


