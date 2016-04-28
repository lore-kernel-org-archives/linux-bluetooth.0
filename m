Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 15:50:14 -0500
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Wei-Ning Huang <wnhuang@chromium.org>,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v8 1/2] dt: bindings: add MARVELL's bt-sd8xxx wireless
 device
Message-ID: <20160428205014.GA4893@rob-hp-laptop>
References: <1461679047-22631-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461679047-22631-1-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 26, 2016 at 06:57:26AM -0700, Amitkumar Karwar wrote:
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
> 
> v6: a)Use <chip>-bt order for compatible attribute(Rob Herring)
>     b)Split wakeuppin-gap to wakeup-pin and wakeup-gap(Rob Herring) 
>     c)Use sdio function number for both the unit address and reg(Rob Herring)
> 
> v7: a)Use suggested vendor name and generic node name(Rob Herring)
> v8: a)Nodes are renamed as per suggestions from Rob Herring
>       btmrvl,* -> marvell,*
>       "wakeup-gap-msec" -> "wakeup-gap-ms"
> ---
>  Documentation/devicetree/bindings/btmrvl.txt       | 29 -----------
>  .../devicetree/bindings/net/marvell-bt-sd8xxx.txt  | 56 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/btmrvl.txt
>  create mode 100644 Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt

Thanks for getting this old binding fixed.

Acked-by: Rob Herring <robh@kernel.org>
