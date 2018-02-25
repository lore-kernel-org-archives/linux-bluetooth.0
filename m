Return-Path: <foo00@h08.hostsharing.net>
Date: Sun, 25 Feb 2018 16:15:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Loic Poulain <loic.poulain@gmail.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Phil Elwell <phil@raspberrypi.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: hci_bcm: Make shutdown and device wake
 GPIO optional
Message-ID: <20180225151505.GA17726@wunner.de>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Feb 25, 2018 at 03:10:52PM +0100, Stefan Wahren wrote:
> According to the devicetree binding the shutdown and device wake
> GPIOs are optional. Since commit 3e81a4ca51a1 ("Bluetooth: hci_bcm:
> Mandate presence of shutdown and device wake GPIO") this driver
> won't probe anymore on Raspberry Pi 3 and Zero W (no device wake GPIO
> connected). So fix this regression by reverting this commit partially.

Okay when submitting 3e81a4ca51a1 I missed that gpiod_set_value()
becomes a no-op if the gpio_desc is NULL, I thought it would oops.


> -	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
> -					    GPIOD_OUT_LOW);
> +	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
> +						     "device-wakeup",
> +						     GPIOD_OUT_LOW);

The "device-wakeup" would still fit within 80 chars on the preceding line.
Otherwise this is

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

>  	if (IS_ERR(dev->device_wakeup))
>  		return PTR_ERR(dev->device_wakeup);
>  
> -	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
> +	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
> +						GPIOD_OUT_LOW);
>  	if (IS_ERR(dev->shutdown))
>  		return PTR_ERR(dev->shutdown);
>  
