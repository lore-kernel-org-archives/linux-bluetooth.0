Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: BCM43430 BT driver almost working...
To: Ian Molton <ian@mnementh.co.uk>
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <5ab11044-dd06-9aef-b355-86e5b58a7a6e@intel.com>
Date: Fri, 30 Jun 2017 19:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

On 30/06/2017 18:35, Ian Molton wrote:

>> bcm_setup_sleep enable low power mode, so I think problem is
>> that the wakeup gpio is not correctly drove.
>> -> Are you sure that you don't toggle the power gpio instead of the
>> wakeup one.
>
> Possibly not - AFAIK, I only have one GPIO on this board, so I *assume*
> its the power one. I'll see if I can find out if wakeup/irq are connected.
>
> *HOWEVER* the code checks for success of bcm_request_irq() when deciding
> to execute bcm_setup_sleep(). This makes sense to me, as I'd expect the
> hardware to want to interrupt the host when it wakes up.

Yes, but there is no IRQ assigned to your bcm_device.
Actually seems you find an other "issue", the bcm_request_irq() returns
an error only on request_irq failure. However in your case, you never
assigned the bcm->irq, so bcm_request_irq does not even try to request
the irq and returns success.

You should try the following:

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index be53238..586f3d0 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -185,22 +185,24 @@ static int bcm_request_irq(struct bcm_data *bcm)
  		goto unlock;
  	}

-	if (bdev->irq > 0) {
-		err = devm_request_irq(&bdev->pdev->dev, bdev->irq,
-				       bcm_host_wake, IRQF_TRIGGER_RISING,
-				       "host_wake", bdev);
-		if (err)
-			goto unlock;
-
-		device_init_wakeup(&bdev->pdev->dev, true);
-
-		pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
-						 BCM_AUTOSUSPEND_DELAY);
-		pm_runtime_use_autosuspend(&bdev->pdev->dev);
-		pm_runtime_set_active(&bdev->pdev->dev);
-		pm_runtime_enable(&bdev->pdev->dev);
+	if (bdev->irq <= 0) {
+		err = -EOPNOTSUPP;
+		goto unlock;
  	}

+	err = devm_request_irq(&bdev->pdev->dev, bdev->irq, bcm_host_wake,
+			       IRQF_TRIGGER_RISING, "host_wake", bdev);
+	if (err)
+		goto unlock;
+
+	device_init_wakeup(&bdev->pdev->dev, true);
+
+	pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
+					 BCM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&bdev->pdev->dev);
+	pm_runtime_set_active(&bdev->pdev->dev);
+	pm_runtime_enable(&bdev->pdev->dev);
+
  unlock:
  	mutex_unlock(&bcm_device_lock);


Regards,
Loic
