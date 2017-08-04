Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1501576704-26423-2-git-send-email-loic.poulain@gmail.com>
Date: Fri, 4 Aug 2017 09:24:31 +0200
Cc: rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Message-Id: <FFCBE5D2-B32A-4715-A91E-899A87F31EBD@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <1501576704-26423-2-git-send-email-loic.poulain@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
> This allows to automatically insert the bcm43438 to the bluetooth
> subsystem instead of relying on userspace helpers (hciattach).
> 
> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
> of pl011/ttyAMA0.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
> v2: dt-bindings as separate patch
>    rebase on upcoming pi3 dts changes
> 
> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 20725ca..5abc1df 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -8,6 +8,11 @@
> 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
> 	model = "Raspberry Pi 3 Model B";
> 
> +	chosen {
> +		/* 8250 auxiliar UART instead of pl011 */
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};
> +
> 	memory {
> 		reg = <0 0x40000000>;
> 	};
> @@ -24,6 +29,11 @@
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
> 	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		max-speed = <921600>;
> +	};
> };
> 

can I get an ack on these patches? I like to take them through bluetooth-next tree.

Regards

Marcel

