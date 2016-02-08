Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Feb 2016 16:05:09 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v3 1/2] bluetooth: btmrvl: register platform specific
 driver
Message-ID: <20160208220509.GA20229@rob-hp-laptop>
References: <1454927231-17662-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454927231-17662-1-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 08, 2016 at 02:27:10AM -0800, Amitkumar Karwar wrote:
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
> ---
>  Documentation/devicetree/bindings/btmrvl.txt |  8 ++--

This needs to move somewhere else.

>  drivers/bluetooth/Makefile                   |  1 +
>  drivers/bluetooth/btmrvl_drv.h               | 16 ++++++++
>  drivers/bluetooth/btmrvl_main.c              |  8 +++-
>  drivers/bluetooth/btmrvl_platform.c          | 60 ++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/bluetooth/btmrvl_platform.c
> 
> diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
> index 58f964b..25b804b 100644
> --- a/Documentation/devicetree/bindings/btmrvl.txt
> +++ b/Documentation/devicetree/bindings/btmrvl.txt
> @@ -3,7 +3,7 @@ btmrvl
>  
>  Required properties:
>  
> -  - compatible : must be "btmrvl,cfgdata"
> +  - compatible : must be "marvell,btmrvl"

While the new name is less worse than the old one, I'm not inclined to 
take any changes for this binding because it is problematic. Given you 
don't care this is an incompatible change, then the binding can be 
completely redone.

It should reflect the actual chip name (e.g. sd8???) and be a child node 
of its connection to the host (a UART). See UART slave discussions.

>  
>  Optional properties:
>  
> @@ -15,11 +15,11 @@ Optional properties:
>  
>  Example:
>  
> -GPIO pin 13 is configured as a wakeup source and GAP is set to 100 msecs
> -in below example.
> +GPIO pin 13 and gap 100ms are configured for host wakeup, calibration
> +data is also available in below example.
