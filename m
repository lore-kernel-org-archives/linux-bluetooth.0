Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jun 2012 00:09:35 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Cleanup dtl1_config
Message-ID: <20120619030935.GC1679@joana>
References: <1339612935-2851-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339612935-2851-1-git-send-email-devendra.aaru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Devendra,

* Devendra Naga <devendra.aaru@gmail.com> [2012-06-14 00:12:15 +0530]:

> the functions always return 0 on sucess and -ve error on failure.
> 
> This also removes variable i.
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  drivers/bluetooth/dtl1_cs.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index 6e8d961..f532ce2 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -586,22 +586,19 @@ static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
>  static int dtl1_config(struct pcmcia_device *link)
>  {
>  	dtl1_info_t *info = link->priv;
> -	int i;
>  
>  	/* Look for a generic full-sized window */
>  	link->resource[0]->end = 8;
>  	if (pcmcia_loop_config(link, dtl1_confcheck, NULL) < 0)
>  		goto failed;
>  
> -	i = pcmcia_request_irq(link, dtl1_interrupt);
> -	if (i != 0)
> +	if (pcmcia_request_irq(link, dtl1_interrupt))
>  		goto failed;

I think this change is wrong, instead you might return i (that should be
renamed to 'err') when the failed label is accessed. This way you improve the
error report of this function.

	Gustavo
