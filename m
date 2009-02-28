Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
From: Marcel Holtmann <marcel@holtmann.org>
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
In-Reply-To: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 22:35:37 +0100
Message-Id: <1235856937.6074.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philipp,

> pcmcia_loop_config returns 0 on success.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>  drivers/bluetooth/dtl1_cs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index 901bdd9..e0ee642 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
>  
>  	/* Look for a generic full-sized window */
>  	link->io.NumPorts1 = 8;
> -	if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
> +	if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
>  		goto failed;
>  
>  	i = pcmcia_request_irq(link, &link->irq);

can you check the other Bluetooth PCMCIA drivers, too. One of the PCMCIA
subsystem changes might have screwed this up and affects more drivers
than expected.

Regards

Marcel


