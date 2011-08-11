Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 11 Aug 2011 16:35:34 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Dan Carpenter <error27@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] bluetooth: unlock if allocation fails in
 hci_blacklist_add()
Message-ID: <20110811193533.GB19699@joana>
References: <20110803142244.GL3839@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110803142244.GL3839@shale.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <error27@gmail.com> [2011-08-03 17:22:45 +0300]:

> There was a small typo here so we never actually hit the goto which
> would call hci_dev_unlock_bh().
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index baaf5eb..56943ad 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1326,7 +1326,7 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  
>  	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
>  	if (!entry) {
> -		return -ENOMEM;
> +		err = -ENOMEM;
>  		goto err;
>  	}

Patch has been applied, thanks.

	Gustavo
