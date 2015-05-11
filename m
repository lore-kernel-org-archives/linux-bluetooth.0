Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [RFC 1/2] Bluetooth UART Device Tree bindings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431030329-22929-2-git-send-email-ifaenson@broadcom.com>
Date: Mon, 11 May 2015 21:14:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <67402AFC-4646-4C56-904B-462282E98666@holtmann.org>
References: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com> <1431030329-22929-2-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Device Tree bindings to configure the Bluetooth UART device.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> .../devicetree/bindings/net/bluetooth/btbcm.txt    | 54 ++++++++++++++++++++++
> 1 file changed, 54 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
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
> +	- tty : tty device connected to this Bluetooth device.
> +
> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
> +
> +  - reg-on-gpios : reg-on output GPIO to be used to power device on/off.
> +
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
> +    Defaults: see the example below.

I think at some point this needs to be reviewed by the DT guys as well. They surely want to have some say in the naming and how to deal with the Bluetooth devices behind UART controllers.

Regards

Marcel

