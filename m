Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Mar 2016 19:55:35 -0500
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	linux-kernel@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	devicetree@vger.kernel.org, Wei-Ning Huang <wnhuang@chromium.org>,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v5 1/2] dt: bindings: add MARVELL's bt-sd8xxx wireless
 device
Message-ID: <20160320005535.GA13586@rob-hp-laptop>
References: <1458299084-31976-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458299084-31976-1-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 18, 2016 at 04:04:43AM -0700, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> Add device tree binding documentation for MARVELL's bluetooth sdio
> (sd8897 and sd8997) chip.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> Listing changelist for both 1/2 and 2/2 here
> v2: Fixed build error reported by kbuild test robot
> drivers/bluetooth/btmrvl_platform.c:141:22: error:
> 'btmrvl_plt_pm_ops' undeclared here (not in a function)
> 
> v3: Add NULL check for 'btmrvl_plt_dev'
> 
> v4: Moved the bindings file to bindings/net/
>     Corrected the name of 'name' and 'compatible' properties(Rob Herring)
> 
> v5: Comments for wlan patches were applicable here as well. Like all binding
>     changes in single file, specifying node as a child of SDIO controller.
> ---
>  Documentation/devicetree/bindings/btmrvl.txt       | 29 ------------
>  .../devicetree/bindings/net/marvell-bt-sd8xxx.txt  | 55 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/btmrvl.txt
>  create mode 100644 Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> 
> diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
> deleted file mode 100644
> index 58f964b..0000000
> --- a/Documentation/devicetree/bindings/btmrvl.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -btmrvl
> -------
> -
> -Required properties:
> -
> -  - compatible : must be "btmrvl,cfgdata"
> -
> -Optional properties:
> -
> -  - btmrvl,cal-data : Calibration data downloaded to the device during
> -		      initialization. This is an array of 28 values(u8).
> -
> -  - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
> -		      configured.
> -
> -Example:
> -
> -GPIO pin 13 is configured as a wakeup source and GAP is set to 100 msecs
> -in below example.
> -
> -btmrvl {
> -	compatible = "btmrvl,cfgdata";
> -
> -	btmrvl,cal-data = /bits/ 8 <
> -		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
> -		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
> -		0x00 0x00 0xf0 0x00>;
> -	btmrvl,gpio-gap = <0x0d64>;
> -};
> diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> new file mode 100644
> index 0000000..b031431
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -0,0 +1,55 @@
> +Marvell 8897/8997 (sd8897/sd8997) bluetooth SDIO devices
> +------
> +
> +Required properties:
> +
> +  - compatible : should be one of the following:
> +	* "marvell,bt-sd8897"
> +	* "marvell,bt-sd8997"

<chip>-bt would be preferred order.

> +
> +Optional properties:
> +
> +  - btmrvl,cal-data : Calibration data downloaded to the device during
> +		      initialization. This is an array of 28 values(u8).
> +
> +  - btmrvl,wakeuppin-gap : wakeup pin and gap (in msecs) combination to be
> +		      configured to firmware. 'wakeuppin' is a wakeup pin number
> +		      of bluetooth chip. 'gap' is a wakeup latency of a host platform.
> +		      This is needed to work chip's sleep feature as expected.

Make this 2 properties.

> +  - interrupt-parent: phandle of the parent interrupt controller
> +  - interrupts : interrupt pin number to the cpu. driver will request an irq based on
> +  		 this interrupt number. during system suspend, the irq will be enabled
> +  		 as system wakeup source, so that the bluetooth chip can wakeup host
> +  		 platform under certain condition. during system resume, the irq will
> +  		 be disabled to make sure unnecessary interrupt is not received.
> +
> +Example:
> +
> +IRQ pin 119 is used as system wakeup source interrupt.
> +wakeuppin 13 and gap 100ms are configured so that firmware can wakeup host
> +using this device side pin and wakeup latency.
> +calibration data is also available in below example.
> +
> +&mmc3 {
> +	status = "okay";
> +	vmmc-supply = <&wlan_en_reg>;
> +	bus-width = <4>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	btmrvl: btmrvl@3 {
> +		compatible = "marvell,bt-sd8897";
> +		reg = <2>;

Same unit-address and reg mismatch.

> +		interrupt-parent = <&pio>;
> +		interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
> +
> +		btmrvl,cal-data = /bits/ 8 <
> +			0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
> +			0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
> +			0x00 0x00 0xf0 0x00>;
> +		btmrvl,wakeuppin-gap = <0x0d64>;
> +	};
> +};
> +
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
