Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 08:38:03 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 1/3] mwifiex: register platform specific driver
Message-ID: <20160218143803.GX9654@rob-hp-laptop>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 01:14:37AM -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> Platform device and driver provides easy way to interact with
> device-tree-enabled system.
> 
> This patch registers platform driver and reorganise existing device
> tree specific code. Corresponding device tree binding file is also
> created.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v3: Don't update adapter->dt_node if mwifiex_plt_dev is NULL
> v4: Corrected the 'name' and 'compatible' property names.(Arnd Bergmann and Rob
>     Herring)
>     Patch description wraped in 72 columns(Rob Herring)
>     Moved DT binding file to bindings/net/wireless/(Rob Herring)
> ---
>  .../bindings/net/wireless/marvell-sd8xxx.txt       | 29 +++++++++++

Again, one patch for all the binding changes.

>  drivers/net/wireless/marvell/mwifiex/Makefile      |  1 +
>  drivers/net/wireless/marvell/mwifiex/main.c        |  2 +
>  drivers/net/wireless/marvell/mwifiex/main.h        | 14 +++++
>  .../net/wireless/marvell/mwifiex/platform_drv.c    | 59 ++++++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |  4 +-
>  6 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
>  create mode 100644 drivers/net/wireless/marvell/mwifiex/platform_drv.c
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> new file mode 100644
> index 0000000..f7671ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> @@ -0,0 +1,29 @@
> +Marvell Sd8xxx Wireless devices
> +------
> +
> +Required properties:
> +
> +  - name : must be "wlan"
> +  - compatible : must be "marvell,sd8xxx"

No wildcards as Arnd mentioned.

> +
> +Optional properties:
> +
> +  - marvell,caldata* : A series of properties with marvell,caldata prefix,
> +  		      represent Calibration data downloaded to the device during
> +		      initialization. This is an array of unsigned values.
> +
> +
> +Example:
> +
> +Tx power limit calibration data is configured in below example.
> +The calibration data is an array of unsigned values, the length
> +can vary between hw versions.
> +
> +wlan {

This also needs to be specified as a subnode of the SDIO controller.

> +	compatible = "marvell,sd8xxx";
> +
> +	marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
> +0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01 ...>;
> +
> +};
> +
