Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514995722.7000.578.camel@linux.intel.com>
Subject: Re: [PATCH v2 09/10] Bluetooth: hci_bcm: Handle errors properly
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 18:08:42 +0200
In-Reply-To: <a91a911d570345ea15935f3db8ddd66aa8986661.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
         <a91a911d570345ea15935f3db8ddd66aa8986661.1514916630.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> A significant portion of this driver lacks error handling.  As a first
> step, add error paths to bcm_gpio_set_power(), bcm_open(),
> bcm_close(),
> bcm_suspend_device(), bcm_resume_device(), bcm_resume(), bcm_probe()
> and
> bcm_serdev_probe().  (I've also scrutinized bcm_suspend() but think
> it's
> fine as is.)
> 
> Those are all the functions accessing the device wake and shutdown
> GPIO.
> On Apple Macs the pins are accessed through ACPI methods, which may
> fail
> for various reasons, hence proper error handling is necessary.  Non-
> Macs
> access the pins directly, which may fail as well but the GPIO core
> does
> not yet pass back errors to consumers.
> 

> +	int err = 0;

Obviously redundant assignment.

> +
> +	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {
> +		err = clk_prepare_enable(dev->clk);
> +		if (err)
> +			return err;
> +	}
>  
>  	gpiod_set_value(dev->shutdown, powered);

> +	err = bcm_gpio_set_device_wakeup(dev, powered);
> +	if (err)
> +		goto err_revert_shutdown;

> +#ifdef CONFIG_PM
> +	bcm->dev->hu = NULL;
> +#endif

Hmm... There is no field in !PM case?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
