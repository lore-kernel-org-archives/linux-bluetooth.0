Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1432325420-12782-2-git-send-email-ifaenson@broadcom.com>
References: <1432325420-12782-1-git-send-email-ifaenson@broadcom.com> <1432325420-12782-2-git-send-email-ifaenson@broadcom.com>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 1 Jun 2015 19:18:38 -0500
Message-ID: <CAL_JsqLO+g56KYUocpWLpz4dDTP0fEXTa4RjJzeRsPvYjCyF4A@mail.gmail.com>
Subject: Re: [RFC v4 1/4] Broadcom Bluetooth UART Device Tree bindings
To: Ilya Faenson <ifaenson@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	"devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 22, 2015 at 3:10 PM, Ilya Faenson <ifaenson@broadcom.com> wrote:
> Device Tree bindings to configure the Broadcom Bluetooth UART device.
>
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
>  .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> new file mode 100644
> index 0000000..968421b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> @@ -0,0 +1,82 @@
> +btbcm
> +------
> +
> +Required properties:
> +
> +       - compatible : must be "brcm,brcm-bt-uart".
> +       - tty : tty device connected to this Bluetooth device.

Neil Brown has been working on generic bindings for tty/UART slaves
which should be used here.

> +
> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
> +
> +  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/off.
> +
> +  - baud-rate-before-config-download : initial Bluetooth device baud rate.
> +    Default: 3000000.

What's the baudrate after download? Why not just use standard
"baud-rate" if you only specify one rate?

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
> +  - PCMClockMode : PCM clock mode. 0-slave, 1-master.
> +    Default: 0.
> +
> +  - PCMFillMethod : PCM fill method. 0 to 3.
> +    Default: 2.
> +
> +  - PCMFillNum : PCM number of fill bits. 0 to 3.
> +    Default: 0.
> +
> +  - PCMFillValue : PCM fill value. 0 to 7.
> +    Default: 3.
> +
> +  - PCMInCallBitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512Kbps,
> +    3-1024Kbps, 4-2048Kbps.
> +    Default: 0.
> +
> +  - PCMLSBFirst : PCM LSB first. 0 or 1.
> +    Default: 0.
> +
> +  - PCMRightJustify : PCM Justify. 0-left, 1-right.
> +    Default: 0.
> +
> +  - PCMRouting : PCM routing. 0-PCM, 1-SCO over HCI.
> +    Default: 0.
> +
> +  - PCMShortFrameSync : PCM sync. 0-short, 1-long.
> +    Default: 0.
> +
> +  - PCMSyncMode : PCM sync mode. 0-slave, 1-master.

Please no CamelCase. These need better descriptions.

> +    Default: 0.
> +
> +
> +Example:
> +
> +       brcm4354_bt_uart: brcm4354-bt-uart {
> +               compatible = "brcm,brcm-bt-uart";
> +               bt-wake-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +               bt-host-wake-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> +               tty = "ttyS0";
> +               baud-rate-before-config-download = <3000000>;
> +               configure-sleep;
> +               configure-audio;
> +               PCMClockMode = <0>;
> +               PCMFillMethod = <2>;
> +               PCMFillNum = <0>;
> +               PCMFillValue = <3>;
> +               PCMInCallBitclock = <0>;
> +               PCMLSBFirst = <0>;
> +               PCMRightJustify = <0>;
> +               PCMRouting = <0>;
> +               PCMShortFrameSync = <0>;
> +               PCMSyncMode = <0>;
> +       };
> +
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree-spec" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
