Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 08:37:46 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 2/2] bluetooth: btmrvl: parse host wakeup
 configuration from device tree
Message-ID: <20160218143746.GU9654@rob-hp-laptop>
References: <1455616555-4729-1-git-send-email-akarwar@marvell.com>
 <1455616555-4729-2-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455616555-4729-2-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 01:55:55AM -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> This patch implements a framework for board specific wakeup.
> driver parse irq/gpio number from device tree, corresponding
> resources will be allocated, and used for host suspend/resume.
> Device tree binding file is also updated in the patch.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: Fixed build error reported by kbuild test robot
> drivers/bluetooth/btmrvl_platform.c:141:22: error:
> 'btmrvl_plt_pm_ops' undeclared here (not in a function)
> ---
>  .../devicetree/bindings/net/marvell-bt-sd8xxx.txt  | 17 +++-

Please put all the binding changes into a single patch.

>  drivers/bluetooth/btmrvl_platform.c                | 91 ++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> index 516b636..fdc87c4 100644
> --- a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -12,11 +12,19 @@ Optional properties:
>  
>    - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
>  		      configured.
> +  - interrupt-parent: phandle of the parent interrupt controller
> +  - interrupts : interrupt number to the cpu
> +  - gpios: specify GPIO respectively. gpio here is board specific pin.
> +	   while above gpio-gap represents the device side pin used to
> +	   wakeup host.

wakeup-gpios instead.

> +  - pinctrl-names : a pinctrl state named "default" must be defined
> +  - pinctrl-0 : pin control group to be used for this controller
>  
>  Example:
>  
> -GPIO pin 13 and gap 100ms are configured for host wakeup, calibration
> -data is also available in below example.
> +GPIO pin 119 and gap 100ms are configured for host wakeup,
> +pin 13 is configured so that firmware can wakeup host using this device side
> +pin, calibration data is also available in below example.
>  
>  bluetooth {
>  	compatible = "marvell,bt-sd8xxx";
> @@ -26,4 +34,9 @@ bluetooth {
>  		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
>  		0x00 0x00 0xf0 0x00>;
>  	btmrvl,gpio-gap = <0x0d64>;
> +	interrupt-parent = <&pio>;
> +	interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
> +	gpios = <&pio 119 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wake_pins>;
>  };
> diff --git a/drivers/bluetooth/btmrvl_platform.c b/drivers/bluetooth/btmrvl_platform.c
