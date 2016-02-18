Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 08:37:57 -0600
From: Rob Herring <robh@kernel.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 2/3] mwifiex: parse chip specific gpio from device tree
Message-ID: <20160218143757.GW9654@rob-hp-laptop>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
 <1455614079-4263-2-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455614079-4263-2-git-send-email-akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 01:14:38AM -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> This patch parse chip specific gpio parameter from device
> tree. Corresponding binding file is also updated.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v4: Renamed "mwifiex,chip-gpio" to "marvell,wakeup-gpios"(Rob Herring/
>     Arnd Bergmann)
> ---
>  .../devicetree/bindings/net/wireless/marvell-sd8xxx.txt          | 6 ++++--

Combine this with the DT change in the next patch.

>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c                   | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> index f7671ae..c337fab 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> @@ -11,7 +11,9 @@ Optional properties:
>    - marvell,caldata* : A series of properties with marvell,caldata prefix,
>    		      represent Calibration data downloaded to the device during
>  		      initialization. This is an array of unsigned values.
> -
> +  - marvell,wakeup-gpios : Chip's wakeup gpio pin number. This needs to be downloaded
> +			to to firmware. Chip notifies wifi wakeup signal to SOC
> +			through this pin.

This is still confusing that it is not a GPIO from the host. I'd suggest 
"marvell,wakeup-pin"
