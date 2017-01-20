Return-Path: <briannorris@chromium.org>
Date: Fri, 20 Jan 2017 11:19:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-bluetooth@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] btmrvl: use dt's irqflags for wakeup pin
Message-ID: <20170120191947.GA84521@google.com>
References: <1484910860-7690-1-git-send-email-jeffy.chen@rock-chips.com>
 <1484910860-7690-3-git-send-email-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484910860-7690-3-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 20, 2017 at 07:14:20PM +0800, Jeffy Chen wrote:
> Use irqflags parsed from dt.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/bluetooth/btmrvl_sdio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 796f719..23711fe 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -101,8 +101,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
>  		} else {
>  			ret = devm_request_irq(dev, cfg->irq_bt,
>  					       btmrvl_wake_irq_bt,
> -					       IRQF_TRIGGER_LOW,

IRQF_TRIGGER_LOW is often accurate, since Marvell devices seem to always
physically use an active low signal here. But there could always be some
kind of inverter logic on the board, for instance, so it makes sense to
just let the device tree specify these flags for us.

Also, I don't actually see any in-tree users of this yet (at least, I
see no proper "marvell,sd*-bt" compatible properties), so I don't see
anyone who might have specified this incorrectly yet...

So:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> -					       "bt_wake", cfg);
> +					       0, "bt_wake", cfg);
>  			if (ret) {
>  				dev_err(dev,
>  					"Failed to request irq_bt %d (%d)\n",
> -- 
> 2.1.4
> 
> 
