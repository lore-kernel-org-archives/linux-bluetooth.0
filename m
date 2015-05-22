Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Arend Van Spriel <arend@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC v3 1/4] Broadcom Bluetooth UART Device Tree bindings
Date: Fri, 22 May 2015 19:05:20 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9425A6D9@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
 <1431553823-25670-2-git-send-email-ifaenson@broadcom.com>
 <555B00ED.1000805@broadcom.com>
In-Reply-To: <555B00ED.1000805@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arend,

-----Original Message-----
From: Arend van Spriel [mailto:arend@broadcom.com]=20
Sent: Tuesday, May 19, 2015 5:23 AM
To: Ilya Faenson
Cc: Marcel Holtmann; linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v3 1/4] Broadcom Bluetooth UART Device Tree bindings

On 05/13/15 23:50, Ilya Faenson wrote:
> Device Tree bindings to configure the Broadcom Bluetooth UART device.

As Marcel indicated this patch needs to be reviewed by devicetree folks=20
as well so add following to the commit message:

IF: Will do, thanks.

Cc: devicetree-spec@vger.kernel.org
Cc: devicetree@vger.kernel.org
> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
> ---
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    | 54 +++++++++++++++=
+++++++
>   1 file changed, 54 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbc=
m.txt
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/=
Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
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

The devicetree folks will probably want to see a specific device id=20
here. Not sure where there are means to obtain that from the device=20
itself, which could be an argument not to use it.

IF: Scores of BT UART chips will be supported so we don't all of them
to be listed. Specific chip will be listed in the device node name - see
the example.

> +	- tty : tty device connected to this Bluetooth device.
> +
> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interr=
upt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume d=
evice.
> +
> +  - reg-on-gpios : reg-on output GPIO to be used to power device on/off.

Maybe use bt-reg-on-gpios for sake of consistency with other gpio=20
properties.

IF: Will change.

> +  - baud-rate-before-config-download : initial Bluetooth device baud rat=
e.
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

IF: Will add individual PCM property descriptions.

> +    Defaults: see the example below.

Devicetree properties that are for a specific device should be have=20
vendor prefix. I can imagine some of the properties are generic to any=20
bt device and/or bt-behind-uart.

IF: All these properties apply to all Broadcom BT UART devices.

> +Example:
> +
> +	bcm4354_bt_uart: bcm4354-bt-uart {
> +		compatible =3D "bcm-bt-uart,bcm4354-bt-uart";

This compatible string here should match the described compatible=20
property above.

IF: Will change (it's a doc issue only).

> +		bt-wake-gpios =3D<&gpio4 30 GPIO_ACTIVE_HIGH>;
> +		bt-host-wake-gpios =3D<&gpio4 31 GPIO_ACTIVE_HIGH>;
> +		tty =3D "ttyS0";
> +		baud-rate-before-config-download =3D<3000000>;
> +		configure-sleep =3D<1>;
> +		configure-audio =3D<1>;

Are these configure flags boolean. If so you can drop the assignment.=20
The presence of the property itself can be used.

IF: Will change.

Regards,
Arend

> +		PCMClockMode =3D<0>;
> +		PCMFillMethod =3D<2>;
> +		PCMFillNum =3D<0>;
> +		PCMFillValue =3D<3>;
> +		PCMInCallBitclock =3D<0>;
> +		PCMLSBFirst =3D<0>;
> +		PCMRightJustify =3D<0>;
> +		PCMRouting =3D<0>;
> +		PCMShortFrameSync =3D<0>;
> +		PCMSyncMode =3D<0>;
> +	};
> +
