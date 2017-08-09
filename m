Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com> <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 9 Aug 2017 18:10:04 -0500
Message-ID: <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial slave
To: Loic Poulain <loic.poulain@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 7, 2017 at 5:39 AM, Loic Poulain <loic.poulain@gmail.com> wrote:
> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
> This allows to automatically insert the bcm43438 to the bluetooth
> subsystem instead of relying on userspace helpers (hciattach).
>
> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
> of pl011/ttyAMA0.
>
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
>  v2: dt-bindings as separate patch
>      rebase on upcoming pi3 dts changes
>  v3: changes in bcm serdev drivers:
>      name refactoring and additional comments
>      Add generic host_set_baudrate method
>      Use agnostic device_property_read
>
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 20725ca..5abc1df 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -8,6 +8,11 @@
>         compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
>         model = "Raspberry Pi 3 Model B";
>
> +       chosen {
> +               /* 8250 auxiliar UART instead of pl011 */
> +               bootargs = "earlyprintk console=ttyS0,115200";

This is an unrelated change. "earlyprintk" is arm32 specific and only
works with a kernel built with a specific uart type and address. Also,
stdout-path property is preferred to set the default over "console".

> +       };
> +
>         memory {
>                 reg = <0 0x40000000>;
>         };
> @@ -24,6 +29,11 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
>         status = "okay";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               max-speed = <921600>;
> +       };
>  };
>
>  /* uart1 is mapped to the pin header */
> --
> 1.9.1
>
