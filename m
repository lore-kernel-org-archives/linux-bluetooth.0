Return-Path: <foo00@h08.hostsharing.net>
Date: Mon, 8 Jan 2018 05:06:58 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 09/13] Bluetooth: hci_bcm: Handle errors properly
Message-ID: <20180108040658.GA13972@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
 <4cf1ba614b554d096448d3705e95140fac346193.1515348092.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4cf1ba614b554d096448d3705e95140fac346193.1515348092.git.lukas@wunner.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 07, 2018 at 08:16:32PM +0100, Lukas Wunner wrote:
> @@ -406,8 +440,10 @@ static int bcm_close(struct hci_uart *hu)
>  			device_init_wakeup(bdev->dev, false);
>  		}
>  
> -		bcm_gpio_set_power(bdev, false);
> -		if (bdev->irq > 0) {
> +		err = bcm_gpio_set_power(bdev, false);
> +		if (err) {
> +			bt_dev_err(hu->hdev, "Failed to power down");
> +		} else if (bdev->irq > 0) {
>  			pm_runtime_disable(bdev->dev);
>  			pm_runtime_set_suspended(bdev->dev);
>  		}

Hm, I realize I've botched this (again):  If a valid IRQ was found
but bcm_gpio_set_power() fails here, then the pm_runtime_enable()
in bcm_request_irq() isn't balanced. :-(

So pm_runtime_disable() needs to be called even if err != 0
(but only if bdev->irq > 0).

Lukas
