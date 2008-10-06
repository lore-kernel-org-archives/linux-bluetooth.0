Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH V2] btsdio: fix tx error path
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1223293223-21162-1-git-send-email-tomas.winkler@intel.com>
References: <1223293223-21162-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 14:01:43 +0200
Message-Id: <1223294503.11272.158.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> This patch fixes accumulating of the header
> in case packet was requeued in the error path.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btsdio.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index 58630cc..c422e89 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -91,6 +91,7 @@ static int btsdio_tx_packet(struct btsdio_data *data, struct sk_buff *skb)
>  
>  	err = sdio_writesb(data->func, REG_TDAT, skb->data, skb->len);
>  	if (err < 0) {
> +		skb_pull(skb, 4);
>  		sdio_writeb(data->func, 0x01, REG_PC_WRT, NULL);
>  		return err;
>  	}

thanks, but I already fixed that one manually in my tree :)

Regards

Marcel


