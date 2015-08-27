Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/5] Bluetooth: hci_intel: Retrieve host-wake IRQ
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55DF4899.9000907@intel.com>
Date: Thu, 27 Aug 2015 10:47:29 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <B4697A1C-E912-44CE-A748-858E23A84256@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <94E2FA7D-93BE-48A5-8A23-FB35EECE009D@holtmann.org> <55DF4899.9000907@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> +	idev->irq = platform_get_irq(pdev, 0);
>>> +	if (idev->irq < 0) {
>>> +		struct gpio_desc *host_wake;
>>> +
>>> +		dev_err(&pdev->dev, "No IRQ, falling back to gpio-irq\n");
>>> +
>>> +		host_wake = devm_gpiod_get_optional(&pdev->dev, "host-wake",
>>> +						    GPIOD_IN);
>>> +		if (IS_ERR(host_wake)) {
>>> +			dev_err(&pdev->dev, "Unable to retrieve IRQ\n");
>>> +			goto no_irq;
>>> +		}
>>> +
>>> +		idev->irq = gpiod_to_irq(host_wake);
>>> +		if (idev->irq < 0) {
>>> +			dev_err(&pdev->dev, "No corresponding irq for gpio\n");
>>> +			goto no_irq;
>>> +		}
>>> +	}
>>> +
>>> +	err = devm_request_threaded_irq(&pdev->dev, idev->irq, NULL, intel_irq,
>>> +					IRQF_ONESHOT, "bt-host-wake", idev);
>>> +	if (err) {
>>> +		dev_err(&pdev->dev, "unable to allocate irq\n");
>>> +		return err;
>>> +	}
>>> +
>>> +	device_init_wakeup(&pdev->dev, true);
>> 
>> do you really want to do this in probe? Meaning that as soon as we boot, we claim this interrupt. Isn't it better to do this when the line discipline gets attached.
> 
> 
> Is it ok to move the irq request/free in intel_set_power?

I would assume so.

Regards

Marcel

