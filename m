Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: fix memory leak Marvell BT-over-SDIO driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100204095551.8d6a8c40.yuasa@linux-mips.org>
References: <20100204095551.8d6a8c40.yuasa@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 19:09:31 -0800
Message-ID: <1265252971.31341.150.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yoichi,

> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index f36defa..57d965b 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -808,6 +808,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
>  
>  exit:
>  	sdio_release_host(card->func);
> +	kfree(tmpbuf);
>  
>  	return ret;
>  }

patch has been applied. Thanks.

Regards

Marcel


