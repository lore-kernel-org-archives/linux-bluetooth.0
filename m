Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 9 Aug 2017 18:16:53 -0500
Message-ID: <CAL_Jsq+akZpqXMPnSh8KRVchWJpFTrzFi6LpOpJ9FYDCrY1hPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: bluetooth: Add broadcom-bluetooth
To: Loic Poulain <loic.poulain@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 7, 2017 at 5:39 AM, Loic Poulain <loic.poulain@gmail.com> wrote:
> Add binding document for serial bluetooth chips using
> Broadcom protocol.
>
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
>  v2: dt-bindings as separate patch
>      rebase on upcoming pi3 dts changes
>  v3: changes in bcm serdev drivers:
>      name refactoring and additional comments
>      Add generic host_set_baudrate method
>      Use agnostic device_property_read
>  .../devicetree/bindings/net/broadcom-bluetooth.txt | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> new file mode 100644
> index 0000000..c51ea1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -0,0 +1,29 @@
> +Broadcom Bluetooth Chips
> +---------------------
> +
> +This documents the binding structure and common properties for serial
> +attached Broadcom devices.
> +
> +Serial attached Broadcom devices shall be a child node of the host UART
> +device the slave device is attached to.
> +
> +Required properties:
> +
> + - compatible: should contain one of the following:
> +   * "brcm,bcm43438-bt"
> +
> +Optional properties:

Most Broadcom devices have a couple of GPIOs needing control. Maybe
they are tied off active on RPi3, but you should document them here
even if the driver doesn't yet need them. I think they are the same as
the Nokia BT IIRC. Same goes for any input clocks.

> +
> + - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Example:
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2_pins>;
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               max-speed = <921600>;
> +       };
> +};
> --
> 1.9.1
>
