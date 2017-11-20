Return-Path: <robherring2@gmail.com>
Date: Mon, 20 Nov 2017 15:09:52 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, mark.rutland@arm.com,
	marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	gregkh@linuxfoundation.org, jslaby@suse.com, johan@kernel.org,
	linux-sunxi@googlegroups.com, linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net
Subject: Re: [RFC v1 8/8] dt-bindings: net: bluetooth: add support for
 Realtek Bluetooth chips
Message-ID: <20171120210952.7ky2r2oj7otn3umi@rob-hp-laptop>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-9-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117223543.32429-9-martin.blumenstingl@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 17, 2017 at 11:35:43PM +0100, Martin Blumenstingl wrote:
> This adds the documentation for Bluetooth functionality of the Realtek
> RTL8723BS and RTL8723DS.
> Both are SDIO wifi chips with an additional Bluetooth module which is
> connected via UART to the host.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/net/realtek-bluetooth.txt  | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> new file mode 100644
> index 000000000000..c919e06469f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> @@ -0,0 +1,31 @@
> +Realtek Bluetooth Chips
> +-----------------------
> +
> +This documents the binding structure and common properties for serial
> +attached Realtek devices.
> +
> +Serial attached Realtek devices shall be a child node of the host UART
> +device the slave device is attached to. See ../serial/slave-device.txt
> +for more information
> +
> +Required properties:
> +- compatible: should contain one of the following:
> +    * "realtek,rtl8723bs-bluetooth"
> +    * "realtek,rtl8723ds-bluetooth"
> +
> +Optional properties:
> +- disable-gpios: GPIO specifier, used to enable/disable the BT module

We generally use 'enable-gpios' or 'powerdown-gpios' even if the h/w 
name is somewhat different.

> +- reset-gpios: GPIO specifier, used to reset the BT module
> +
> +
> +Example:
> +
> +&uart {
> +	...
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bluetooth";
> +		disable-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> -- 
> 2.15.0
> 
