Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 1/5] Broadcom Bluetooth UART Device Tree bindings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433966720-17482-2-git-send-email-ifaenson@broadcom.com>
Date: Thu, 11 Jun 2015 11:39:44 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <ED07E6FA-6063-4B60-AD61-A4CA8EDB608C@holtmann.org>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com> <1433966720-17482-2-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Device Tree bindings to configure the Broadcom Bluetooth UART device.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 ++++++++++++++++++++++
> 1 file changed, 82 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> new file mode 100644
> index 0000000..2679819
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> @@ -0,0 +1,82 @@
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
> +  - pcmsyncmode : PCM sync mode. 0-slave, 1-master.
> +    Default: 0.

I think you meant pcm-syncmode here.

> +
> +
> +Example:
> +
> +	brcm4354_bt_uart: brcm4354-bt-uart {

Since in general the chips and firmware name refer to BCM4354, it might be a really good idea to use bcm4354 here and not confuse people further. I am just trying to avoid confusion here.

Regards

Marcel

