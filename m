Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 01/13] dt-bindings: net: bluetooth: add support for
 Realtek Bluetooth chips
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180527190457.2632-2-hdegoede@redhat.com>
Date: Wed, 30 May 2018 08:42:50 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <7A22F14E-9F45-4779-B7E5-CEB330A5601E@holtmann.org>
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-2-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> This adds the documentation for Bluetooth functionality of the Realtek
> RTL8723BS and RTL8723DS.
> Both are SDIO wifi chips with an additional Bluetooth module which is
> connected via UART to the host.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> .../bindings/net/realtek-bluetooth.txt        | 41 +++++++++++++++++++
> 1 file changed, 41 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> new file mode 100644
> index 000000000000..1491329c4cd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> @@ -0,0 +1,41 @@
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
> +- realtek,config-data: Bluetooth chipset configuration data which is
> +			needed for communication (it typically contains
> +			board specific settings like the baudrate and
> +			whether flow-control is used).
> +			This is an array of u8 values.
> +- enable-gpios: GPIO specifier, used to enable/disable the BT module
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
> +		enable-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +		realtek,config-data = /bits/ 8 <
> +			0x55 0xab 0x23 0x87 0x29 0x00 0xf4 0x00 0x01 0x01 0xf6 0x00
> +			0x02 0x81 0x00 0xfa 0x00 0x02 0x12 0x80 0x0c 0x00 0x10 0x02
> +			0x80 0x92 0x04 0x50 0xc5 0xea 0x19 0xe1 0x1b 0xfd 0xaf 0x5f
> +			0x01 0xa4 0x0b 0xd9 0x00 0x01 0x0f 0xe4 0x00 0x01 0x08>;
> +	};
> +};

we actually need to agree on this config-data. As I wrote in an earlier email some time ago, the actual config-data files are just memory portions that will overload the default config area. I wrote tools/rtlfw.c to parse these.

So now I wonder if we can just read the current configuration and run with that when no extra blob is provided. That way it would always work and we might just give the config-data filename here. Mostly this is the for PCM and UART settings anyway.

Regards

Marcel

