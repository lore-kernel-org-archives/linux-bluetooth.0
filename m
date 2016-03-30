Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1459344056-5234-1-git-send-email-akarwar@marvell.com>
References: <1459344056-5234-1-git-send-email-akarwar@marvell.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Mar 2016 09:06:48 -0500
Message-ID: <CAL_JsqKk+S7SfxBT3c-Z2hAFjZLW03jNeLJQsMDFJ0ZfJuDmRQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt: bindings: add MARVELL's bt-sd8xxx wireless device
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Xinming Hu <huxm@marvell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 30, 2016 at 8:20 AM, Amitkumar Karwar <akarwar@marvell.com> wrote:
> From: Xinming Hu <huxm@marvell.com>
>
> Add device tree binding documentation for MARVELL's bluetooth sdio
> (sd8897 and sd8997) chip.
>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---

[...]

> diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> new file mode 100644
> index 0000000..172ba83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -0,0 +1,57 @@
> +Marvell 8897/8997 (sd8897/sd8997) bluetooth SDIO devices
> +------
> +
> +Required properties:
> +
> +  - compatible : should be one of the following:
> +       * "marvell,sd8897-bt"
> +       * "marvell,sd8997-bt"
> +
> +Optional properties:
> +
> +  - btmrvl,cal-data : Calibration data downloaded to the device during
> +                     initialization. This is an array of 28 values(u8).

btmrvl is not a vendor. These should all be "marvell".

> +
> +  - btmrvl,wakeup-pin : 'wakeup-pin' represent wakeup pin number of the bluetooth
> +                     chip. firmware will use the pin to wakeup host system.
> +  - btmrvl,wakeup-gap : wakeup gap (in msecs) represent wakeup latency of the host

Add units suffix (-msec).

> +                     platform. The value will be configure to fiwmware.

s/fiwmware/firmware/

> +                     This is needed to work chip's sleep feature as expected.
> +  - interrupt-parent: phandle of the parent interrupt controller
> +  - interrupts : interrupt pin number to the cpu. driver will request an irq based on
> +                this interrupt number. during system suspend, the irq will be enabled
> +                as system wakeup source, so that the bluetooth chip can wakeup host
> +                platform under certain condition. during system resume, the irq will
> +                be disabled to make sure unnecessary interrupt is not received.
> +
> +Example:
> +
> +IRQ pin 119 is used as system wakeup source interrupt.
> +wakeup pin 13 and gap 100ms are configured so that firmware can wakeup host
> +using this device side pin and wakeup latency.
> +calibration data is also available in below example.
> +
> +&mmc3 {
> +       status = "okay";
> +       vmmc-supply = <&wlan_en_reg>;
> +       bus-width = <4>;
> +       cap-power-off-card;
> +       keep-power-in-suspend;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       btmrvl: btmrvl@2 {

Use a generic node name: bluetooth@2

> +               compatible = "marvell,sd8897-bt";
> +               reg = <2>;
> +               interrupt-parent = <&pio>;
> +               interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
> +
> +               btmrvl,cal-data = /bits/ 8 <
> +                       0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
> +                       0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
> +                       0x00 0x00 0xf0 0x00>;
> +               btmrvl,wakeup-pin = <0x0d>;
> +               btmrvl,wakeup-gap = <0x64>;
> +       };
> +};
> +
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
