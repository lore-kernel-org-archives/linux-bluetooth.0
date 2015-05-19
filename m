Return-Path: <cyrus@holtmann.org>
Message-ID: <555B00ED.1000805@broadcom.com>
Date: Tue, 19 May 2015 11:22:53 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v3 1/4] Broadcom Bluetooth UART Device Tree bindings
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com> <1431553823-25670-2-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431553823-25670-2-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/13/15 23:50, Ilya Faenson wrote:
> Device Tree bindings to configure the Broadcom Bluetooth UART device.

As Marcel indicated this patch needs to be reviewed by devicetree folks 
as well so add following to the commit message:

Cc: devicetree-spec@vger.kernel.org
Cc: devicetree@vger.kernel.org
> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
> ---
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    | 54 ++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> new file mode 100644
> index 0000000..cc9f225
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> @@ -0,0 +1,54 @@
> +btbcm
> +------
> +
> +Required properties:
> +
> +	- compatible : must be "brcm,brcm-bt-uart".

The devicetree folks will probably want to see a specific device id 
here. Not sure where there are means to obtain that from the device 
itself, which could be an argument not to use it.

> +	- tty : tty device connected to this Bluetooth device.
> +
> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
> +
> +  - reg-on-gpios : reg-on output GPIO to be used to power device on/off.

Maybe use bt-reg-on-gpios for sake of consistency with other gpio 
properties.

> +  - baud-rate-before-config-download : initial Bluetooth device baud rate.
> +    Default: 3000000.
> +
> +  - manual-fc : flow control UART in suspend / resume scenarios.
> +    Default: 0.
> +
> +  - configure-sleep : configure suspend / resume flag.
> +    Default: 0.
> +
> +  - configure-audio : configure platform PCM SCO flag.
> +    Default: 0.
> +
> +  - PCM* : SCO PCM platform parameters. Work with Broadcom on setting.

What does "Work with Broadcom on setting" mean here?

> +    Defaults: see the example below.

Devicetree properties that are for a specific device should be have 
vendor prefix. I can imagine some of the properties are generic to any 
bt device and/or bt-behind-uart.

> +Example:
> +
> +	bcm4354_bt_uart: bcm4354-bt-uart {
> +		compatible = "bcm-bt-uart,bcm4354-bt-uart";

This compatible string here should match the described compatible 
property above.

> +		bt-wake-gpios =<&gpio4 30 GPIO_ACTIVE_HIGH>;
> +		bt-host-wake-gpios =<&gpio4 31 GPIO_ACTIVE_HIGH>;
> +		tty = "ttyS0";
> +		baud-rate-before-config-download =<3000000>;
> +		configure-sleep =<1>;
> +		configure-audio =<1>;

Are these configure flags boolean. If so you can drop the assignment. 
The presence of the property itself can be used.

Regards,
Arend

> +		PCMClockMode =<0>;
> +		PCMFillMethod =<2>;
> +		PCMFillNum =<0>;
> +		PCMFillValue =<3>;
> +		PCMInCallBitclock =<0>;
> +		PCMLSBFirst =<0>;
> +		PCMRightJustify =<0>;
> +		PCMRouting =<0>;
> +		PCMShortFrameSync =<0>;
> +		PCMSyncMode =<0>;
> +	};
> +
