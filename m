Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E942634F2@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com>
 <1434576658-20730-2-git-send-email-ifaenson@broadcom.com> <E0D3336E15B58B4294723AC879BA5E942634F2@IRVEXCHMB15.corp.ad.broadcom.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 18 Jun 2015 10:02:58 -0500
Message-ID: <CAL_JsqK9kup3sm3qgDLqtT8ajrN1ee6zfXwOoZqoq9cXQNwE_w@mail.gmail.com>
Subject: Re: FW: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree bindings
To: Ilya Faenson <ifaenson@broadcom.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, Arend Van Spriel <arend@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 17, 2015 at 6:11 PM, Ilya Faenson <ifaenson@broadcom.com> wrote:
> + devicetree lists

Please use get_maintainers.pl.

> -----Original Message-----
> From: Ilya Faenson [mailto:ifaenson@broadcom.com]
> Sent: Wednesday, June 17, 2015 5:31 PM
> To: Marcel Holtmann
> Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel; Ilya Faenson
> Subject: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree bindings
>
> Device Tree bindings to configure the Broadcom Bluetooth UART device.
>
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---

Change history from the last v4 version?

>  .../devicetree/bindings/net/bluetooth/btbcm.txt    | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
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
> +       - compatible : must be "brcm,brcm-bt-uart".

You need to describe the chip, not the interface.

> +       - tty : tty device connected to this Bluetooth device.

"tty" is a bit of a Linuxism and "ttyS0" certainly is. Further, there
is no guarantee which uart is assigned ttyS0.

This should be a phandle to the connected uart if not a sub node of
the uart. This is complicated since these chips have multiple host
connections. It needs to go under either uart or SDIO host and have a
reference back to the one it is not under. Given the SDIO interface is
discoverable (although sideband gpios and regulators are not), I would
put this under the uart node as that is never discoverable.

As I've mentioned previously, there's several cases of bindings for
UART slave devices being posted. This all needs to be coordinated to
use a common structure.

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

Can be boolean?

I don't really follow the description.

> +
> +  - configure-sleep : configure suspend / resume flag.
> +    Default: false.

Please describe better what this does. Perhaps "idle-sleep-en" would be better.

> +
> +  - idle-timeout : Number of seconds of inactivity before suspending.

idle-timeout-sec

Is this only applicable when configure-sleep is set?

You mix the terms sleep and suspend a lot. Can you be more consistent.

> +    Default: 5.
> +
> +  - configure-audio : configure platform PCM SCO flag.
> +    Default: false.

So ignore the rest of the settings if not set? Perhaps combine with pcm-routing:

<blank> - no audio
audio-mode = "pcm";
audio-mode = "hci"; (or "sco-hci"?)

> +
> +  - pcm-clockmode : PCM clock mode. 0-slave, 1-master.
> +    Default: 0.

Can be boolean (property present or not): pcm-clock-mode-master

> +
> +  - pcm-fillmethod : PCM fill method. 0 to 3.

pcm-fill-method

> +    Default: 2.
> +
> +  - pcm-fillnum : PCM number of fill bits. 0 to 3.
> +    Default: 0.

pcm-fill-bits

> +
> +  - pcm-fillvalue : PCM fill value. 0 to 7.
> +    Default: 3.

pcm-fill-value

> +
> +  - pcm-incallbitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512Kbps,
> +    3-1024Kbps, 4-2048Kbps.

pcm-incall-bitclock-hz

Use the actual rate rather than an enumeration. It is a simple div by
128k and log2 to convert in the driver. This makes the property more
compatible with other chips.

What does incall mean? What is the bit rate when not in a call?

> +    Default: 0.
> +
> +  - pcm-lsbfirst : PCM LSB first. 0 or 1.
> +    Default: 0.

Can be boolean

> +
> +  - pcm-rightjustify : PCM Justify. 0-left, 1-right.
> +    Default: 0.

Can be boolean

> +  - pcm-routing : PCM routing. 0-PCM, 1-SCO over HCI.
> +    Default: 0.

Can be boolean: pcm-routing-hci

> +
> +  - pcm-shortframesync : PCM sync. 0-short, 1-long.
> +    Default: 0.

Can be boolean

> +
> +  - pcm-syncmode : PCM sync mode. 0-slave, 1-master.
> +    Default: 0.

Can be boolean: pcm-sync-mode-master

Rob
