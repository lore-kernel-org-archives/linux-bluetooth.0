Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 29 Apr 2016 16:51:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix null gpio desc pointer
 dereference
Message-ID: <20160429135110.GB31177@kuha.fi.intel.com>
References: <1461862105-23970-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461862105-23970-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 28, 2016 at 06:48:25PM +0200, Loic Poulain wrote:
> gpiod_get_optional can return either ERR_PTR or NULL pointer.
> NULL case is not tested and then dereferenced later in desc_to_gpio.
> Fix this by using non optional version which returns ERR_PTR in any
> error case (this is not an optional gpio).
> Use the same non optional version for the host-wake gpio.

So shouldn't there be:

Fixes: 765ea3abd116 ("Bluetooth: hci_intel: Retrieve host-wake IRQ")

> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>  drivers/bluetooth/hci_intel.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 91d6051..f6f2b01 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -1210,8 +1210,7 @@ static int intel_probe(struct platform_device *pdev)
>  
>  	idev->pdev = pdev;
>  
> -	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
> -					      GPIOD_OUT_LOW);
> +	idev->reset = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(idev->reset)) {
>  		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
>  		return PTR_ERR(idev->reset);
> @@ -1223,8 +1222,7 @@ static int intel_probe(struct platform_device *pdev)
>  
>  		dev_err(&pdev->dev, "No IRQ, falling back to gpio-irq\n");
>  
> -		host_wake = devm_gpiod_get_optional(&pdev->dev, "host-wake",
> -						    GPIOD_IN);
> +		host_wake = devm_gpiod_get(&pdev->dev, "host-wake", GPIOD_IN);
>  		if (IS_ERR(host_wake)) {
>  			dev_err(&pdev->dev, "Unable to retrieve IRQ\n");
>  			goto no_irq;
> -- 
> 1.9.1

Thanks,

-- 
heikki
