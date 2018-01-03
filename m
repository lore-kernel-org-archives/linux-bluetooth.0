Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1514984939.7000.571.camel@linux.intel.com>
Subject: Re: [PATCH v2 06/10] Bluetooth: hci_bcm: Silence IRQ printk
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Frederic Danis
 <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy
 <leif.liddy@gmail.com>,  Daniel Roschka <danielroschka@phoenitydawn.de>,
 Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang"
 <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 15:08:59 +0200
In-Reply-To: <ae2d4efbe3ffbaf8b979f1b8a192cbb17d97499d.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
	 <ae2d4efbe3ffbaf8b979f1b8a192cbb17d97499d.1514916630.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> The host wake IRQ is optional, but if none is found, "BCM irq: -22" is
> logged which may irritate users.  This is really a debug message, so
> use
> dev_dbg() instead of dev_info().  If users are interested in the IRQ,
> they can always consult /proc/interrupts.

I object to do in the way how it's done in this patch. See below.

> 
> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/bluetooth/hci_bcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 01d0943b7bbb..632939d413df 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -798,7 +798,7 @@ static int bcm_get_resources(struct bcm_device
> *dev)
>  		dev->irq = gpiod_to_irq(gpio);
>  	}
>  
> -	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
> +	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);

Perhaps, instead you may add same check

if (dev->irq > 0)
 dev_info(...);
else
 dev_info(..., "BCM irq not in use\n");

?

>  	return 0;
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
