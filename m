Return-Path: <ian@mnementh.co.uk>
Subject: Re: BCM43430 BT driver almost working...
To: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
 <5ab11044-dd06-9aef-b355-86e5b58a7a6e@intel.com>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <0f4e3b7f-e290-3b5b-207c-7f51f38aeef1@mnementh.co.uk>
Date: Fri, 30 Jun 2017 22:13:46 +0100
MIME-Version: 1.0
In-Reply-To: <5ab11044-dd06-9aef-b355-86e5b58a7a6e@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 30/06/17 18:59, Loic Poulain wrote:
> Yes, but there is no IRQ assigned to your bcm_device.
> Actually seems you find an other "issue", the bcm_request_irq() returns
> an error only on request_irq failure. However in your case, you never
> assigned the bcm->irq, so bcm_request_irq does not even try to request
> the irq and returns success.

Yes, thats what I was getting at.

I solved it by setting err to -EINVAL to begin with, rather than 0, as a
temporary hack, as I wasn't sure of the original functions intent.

Your solution is cleaner, so I've tested it, it works.

> You should try the following:
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index be53238..586f3d0 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -185,22 +185,24 @@ static int bcm_request_irq(struct bcm_data *bcm)
>          goto unlock;
>      }
> 
> -    if (bdev->irq > 0) {
> -        err = devm_request_irq(&bdev->pdev->dev, bdev->irq,
> -                       bcm_host_wake, IRQF_TRIGGER_RISING,
> -                       "host_wake", bdev);
> -        if (err)
> -            goto unlock;
> -
> -        device_init_wakeup(&bdev->pdev->dev, true);
> -
> -        pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
> -                         BCM_AUTOSUSPEND_DELAY);
> -        pm_runtime_use_autosuspend(&bdev->pdev->dev);
> -        pm_runtime_set_active(&bdev->pdev->dev);
> -        pm_runtime_enable(&bdev->pdev->dev);
> +    if (bdev->irq <= 0) {
> +        err = -EOPNOTSUPP;
> +        goto unlock;
>      }
> 
> +    err = devm_request_irq(&bdev->pdev->dev, bdev->irq, bcm_host_wake,
> +                   IRQF_TRIGGER_RISING, "host_wake", bdev);
> +    if (err)
> +        goto unlock;
> +
> +    device_init_wakeup(&bdev->pdev->dev, true);
> +
> +    pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
> +                     BCM_AUTOSUSPEND_DELAY);
> +    pm_runtime_use_autosuspend(&bdev->pdev->dev);
> +    pm_runtime_set_active(&bdev->pdev->dev);
> +    pm_runtime_enable(&bdev->pdev->dev);
> +
>  unlock:
>      mutex_unlock(&bcm_device_lock);
> 
