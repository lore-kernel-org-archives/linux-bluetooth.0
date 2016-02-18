Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 08:37:40 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 1/2] bluetooth: btmrvl: register platform specific
 driver
Message-ID: <20160218143740.GT9654@rob-hp-laptop>
References: <1455616555-4729-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455616555-4729-1-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 01:55:54AM -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> Platform device and driver provide easy way to
> interact with device-tree-enabled system.
> 
> This patch registers platform driver and reorganise
> existing device tree specific code.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v3: Add NULL check for 'btmrvl_plt_dev'
> v4: Moved the bindings file to bindings/net/
>     Corrected the name of 'name' and 'compatible' properties(Rob Herring)
> ---
>  Documentation/devicetree/bindings/btmrvl.txt       | 29 -----------
>  .../devicetree/bindings/net/marvell-bt-sd8xxx.txt  | 29 +++++++++++
>  drivers/bluetooth/Makefile                         |  1 +
>  drivers/bluetooth/btmrvl_drv.h                     | 16 ++++++
>  drivers/bluetooth/btmrvl_main.c                    |  8 ++-
>  drivers/bluetooth/btmrvl_platform.c                | 60 ++++++++++++++++++++++
>  6 files changed, 113 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/btmrvl.txt
>  create mode 100644 Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
>  create mode 100644 drivers/bluetooth/btmrvl_platform.c
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
> index 0000000..516b636
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -0,0 +1,29 @@
> +Marvell bluetooth sdio driver
> +------
> +
> +Required properties:
> +
> +  - compatible : must be "marvell,bt-sd8xxx"

List specific models, not wildcards.

> +
> +Optional properties:
> +
> +  - btmrvl,cal-data : Calibration data downloaded to the device during
> +		      initialization. This is an array of 28 values(u8).
> +
> +  - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
> +		      configured.

This needs a better explanation.

> +
> +Example:
> +
> +GPIO pin 13 and gap 100ms are configured for host wakeup, calibration
> +data is also available in below example.
> +
> +bluetooth {

This needs to follow the SDIO bus binding and be a child node of the 
SDIO controller.

> +	compatible = "marvell,bt-sd8xxx";
> +
> +	btmrvl,cal-data = /bits/ 8 <
> +		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
> +		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
> +		0x00 0x00 0xf0 0x00>;
> +	btmrvl,gpio-gap = <0x0d64>;
> +};
