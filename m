Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
Date: Sun, 25 Feb 2018 21:17:12 +0100
Cc: Loic Poulain <loic.poulain@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Message-Id: <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
> This allows to automatically insert the bcm43438 to the bluetooth
> subsystem instead of relying on patched userspace helpers (hciattach).
> 
> In order to keep a debug UART we need to switch to uart1.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> index cf53436..b7f79f1 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> @@ -131,6 +131,18 @@
> 
> &uart0 {
> 	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_gpio14>;
> +	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		max-speed = <2000000>;
> +		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
> +	};
> +};

is the shutdown GPIO working as expected with this hardware. So even module unload and reload works fine? Meaning we are getting back to the 115200 default baud rate on the UART? Or is this actually the device-wakeup GPIO?

Regards

Marcel

