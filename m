Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH 1/4] Bluetooth: btmrvl: remove memory allocation failure message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
Date: Thu, 15 Oct 2015 00:59:10 +0200
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>
Message-Id: <7332109E-2B64-4A42-90E6-33900F490B95@holtmann.org>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> These changes resolve below checkpatch warning
> 
> WARNING: Possible unnecessary 'out of memory' message
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 8 ++------
> drivers/bluetooth/btmrvl_sdio.c | 5 ++---
> 2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index 6ba2286..61d2f39 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -712,16 +712,12 @@ struct btmrvl_private *btmrvl_add_card(void *card)
> 	struct btmrvl_private *priv;
> 
> 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		BT_ERR("Can not allocate priv");
> +	if (!priv)
> 		goto err_priv;
> -	}

I do not get these checkpatch fixes. Why is the error messages unneeded?

Regards

Marcel

