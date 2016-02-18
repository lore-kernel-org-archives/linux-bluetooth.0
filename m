Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 08:37:54 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 3/3] mwifiex: parse host wakeup configuration from
 device
Message-ID: <20160218143754.GV9654@rob-hp-laptop>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
 <1455614079-4263-3-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455614079-4263-3-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 01:14:39AM -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> This patch implement a framework for board specific wakeup.
> driver parse irq/gpio number from device tree, corresponding
> resources will be allocated, and used for host suspend/resume.
> driver private binding file is also updated in the patch.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v4: Replaced #ifdef with __maybe_unused(Arnd Bergmann)
> ---
>  .../bindings/net/wireless/marvell-sd8xxx.txt       | 10 +++
>  .../net/wireless/marvell/mwifiex/platform_drv.c    | 91 ++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> index c337fab..50138fd 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> @@ -14,6 +14,11 @@ Optional properties:
>    - marvell,wakeup-gpios : Chip's wakeup gpio pin number. This needs to be downloaded
>  			to to firmware. Chip notifies wifi wakeup signal to SOC
>  			through this pin.
> +  - interrupt-parent: phandle of the parent interrupt controller
> +  - interrupts : interrupt number to the cpu
> +  - gpios: specify SOC's wakeup GPIO

If you define the GPIO line as an interrupt, you shouldn't need it to be 
as GPIO too. Same on the BT side.

> +  - pinctrl-names : a pinctrl state named "default" must be defined
> +  - pinctrl-0 : pin control group to be used for this controller
>  
>  Example:
>  
> @@ -27,5 +32,10 @@ wlan {
>  	marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
>  0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01 ...>;
>  	marvell,wakeup-gpios = <3>;
> +	interrupt-parent = <&pio>;
> +	interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
> +	gpios = <&pio 38 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wake_pins>;
>  };
>  
