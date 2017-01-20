Return-Path: <briannorris@chromium.org>
Date: Fri, 20 Jan 2017 11:27:25 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-bluetooth@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] btmrvl: set irq_bt to -1 when failed to parse it
Message-ID: <20170120192724.GB84521@google.com>
References: <1484910860-7690-1-git-send-email-jeffy.chen@rock-chips.com>
 <1484910860-7690-2-git-send-email-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484910860-7690-2-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 20, 2017 at 07:14:19PM +0800, Jeffy Chen wrote:
> The irq_of_parse_and_map will return 0 as a invalid irq.

irq_of_parse_and_map() is weird to me. In general, Linux IRQ numbers
*can* be 0, but it looks like the OF framework understands that
device-tree based interrupts will not get mapped to a virtual IRQ number
of 0, so it's fine to use '0' as the error value?

In that case, I guess this is the most sensible solution...

> Set irq_bt to -1 in this case, so that the btmrvl resume/suspend code
> would not get confused.

More specifically: the suspend/resume code would have tried to
enable/disable IRQ 0.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
> 
>  drivers/bluetooth/btmrvl_sdio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index c738bae..796f719 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -97,6 +97,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
>  		cfg->irq_bt = irq_of_parse_and_map(card->plt_of_node, 0);
>  		if (!cfg->irq_bt) {
>  			dev_err(dev, "fail to parse irq_bt from device tree");
> +			cfg->irq_bt = -1;
>  		} else {
>  			ret = devm_request_irq(dev, cfg->irq_bt,
>  					       btmrvl_wake_irq_bt,
> -- 
> 2.1.4
> 
> 
