Return-Path: <cyrus@holtmann.org>
Message-ID: <5581E7C6.6060408@broadcom.com>
Date: Wed, 17 Jun 2015 23:33:58 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree bindings
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com> <1434576658-20730-2-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434576658-20730-2-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/17/15 23:30, Ilya Faenson wrote:
> Device Tree bindings to configure the Broadcom Bluetooth UART device.

As Marcel mentioned we really want DT people to Ack this one so better 
Cc: DT mailing list.

Regards,
Arend

> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
> ---
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    | 86 ++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> new file mode 100644
> index 0000000..5dbcd57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> @@ -0,0 +1,86 @@
> +btbcm
> +------
> +
> +Required properties:
> +
> +	- compatible : must be "brcm,brcm-bt-uart".
> +	- tty : tty device connected to this Bluetooth device.
> +
> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
> +
> +  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/off.
> +
> +  - oper-speed : Bluetooth device operational baud rate.
> +    Default: 3000000.
> +
> +  - manual-fc : flow control UART in suspend / resume scenarios.
> +    Default: 0.
> +
> +  - configure-sleep : configure suspend / resume flag.
> +    Default: false.
> +
> +  - idle-timeout : Number of seconds of inactivity before suspending.
> +    Default: 5.
> +
> +  - configure-audio : configure platform PCM SCO flag.
> +    Default: false.
> +
> +  - pcm-clockmode : PCM clock mode. 0-slave, 1-master.
> +    Default: 0.
> +
> +  - pcm-fillmethod : PCM fill method. 0 to 3.
> +    Default: 2.
> +
> +  - pcm-fillnum : PCM number of fill bits. 0 to 3.
> +    Default: 0.
> +
> +  - pcm-fillvalue : PCM fill value. 0 to 7.
> +    Default: 3.
> +
> +  - pcm-incallbitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512Kbps,
> +    3-1024Kbps, 4-2048Kbps.
> +    Default: 0.
> +
> +  - pcm-lsbfirst : PCM LSB first. 0 or 1.
> +    Default: 0.
> +
> +  - pcm-rightjustify : PCM Justify. 0-left, 1-right.
> +    Default: 0.
> +
> +  - pcm-routing : PCM routing. 0-PCM, 1-SCO over HCI.
> +    Default: 0.
> +
> +  - pcm-shortframesync : PCM sync. 0-short, 1-long.
> +    Default: 0.
> +
> +  - pcm-syncmode : PCM sync mode. 0-slave, 1-master.
> +    Default: 0.
> +
> +
> +Example:
> +
> +	bcm4354_bt_uart: bcm4354-bt-uart {
> +		compatible = "brcm,brcm-bt-uart";
> +		bt-wake-gpios =<&gpio4 30 GPIO_ACTIVE_HIGH>;
> +		bt-host-wake-gpios =<&gpio4 31 GPIO_ACTIVE_HIGH>;
> +		tty = "ttyS0";
> +		oper-speed =<3000000>;
> +		configure-sleep;
> +		idle-timeout =<5>;
> +		configure-audio;
> +		pcm-clockmode =<0>;
> +		pcm-fillmethod =<2>;
> +		pcm-fillnum =<0>;
> +		pcm-fillvalue =<3>;
> +		pcm-incallbitclock =<0>;
> +		pcm-lsbfirst =<0>;
> +		pcm-rightjustify =<0>;
> +		pcm-routing =<0>;
> +		pcm-shortframesync =<0>;
> +		pcm-syncmode =<0>;
> +	};
> +
