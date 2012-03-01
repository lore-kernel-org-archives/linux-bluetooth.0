Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:40:33 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] Bluetooth: change min_t() cast in hci_reassembly()
Message-ID: <20120301014033.GC26492@x220>
References: <20120228065759.GD20506@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228065759.GD20506@elgon.mountain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On Tue, Feb 28, 2012, Dan Carpenter wrote:
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
> +		len = min_t(uint, scb->expect, count);
>  
>  		memcpy(skb_put(skb, len), data, len);

Applied to my bluetooth-next tree. Thanks.

Johan
