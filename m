Return-Path: <cyrus@holtmann.org>
Message-ID: <55EEB508.1000907@linux.intel.com>
Date: Tue, 08 Sep 2015 12:14:32 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
	Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] Bluetooth: hci_bcm: Add suspend/resume runtime
 PM functions
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com> <1441373747-23042-5-git-send-email-frederic.danis@linux.intel.com> <CBC77539-71FB-4A84-B849-A9987BD29488@holtmann.org> <55EDABA9.5050207@linux.intel.com> <E0D3336E15B58B4294723AC879BA5E9429247F@IRVEXCHMB15.corp.ad.broadcom.com>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9429247F@IRVEXCHMB15.corp.ad.broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Ilya,

On 07/09/2015 23:32, Ilya Faenson wrote:
<snip>
>>> @@ -726,7 +826,10 @@ MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
>>> >>#endif
>>> >>
>>> >>/* Platform suspend and resume callbacks */
>>> >>-static SIMPLE_DEV_PM_OPS(bcm_pm_ops, bcm_suspend, bcm_resume);
>>> >>+static const struct dev_pm_ops bcm_pm_ops = {
>>> >>+	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
>>> >>+	SET_RUNTIME_PM_OPS(bcm_runtime_suspend, bcm_runtime_resume, NULL)
>> >
>> >I think you really need to explain why runtime suspend and system sleep is actually different for Broadcom based devices. Since for the Intel ones it turned out to be the same (at least for now).
> I dissociate system sleep and runtime suspend functions for the
> following reasons:
>
> 1) IRQ is enabled as a wake source only during system sleep, while this
> is not needed for runtime suspend.
>
> IF: The ideal implementation should suspend both the UART and the BT device at runtime. UART should be suspended in a state where the device is flow-controlled so the device is unable to send. BT device GPIO based interrupt is then needed for runtime resume initiated by the device. Upon the interrupt, your code will resume the UART and allow the device to transmit again. If you leave the UART on w/o flow-controlling the device in suspend you in fact don't need that interrupt . However, OEMs will not like that due to the unnecessary UART power consumption. Speaking from experience.:-)

Sorry if I was not quite clear enough.

Both bcm_runtime_suspend() and bcm_suspend() enable flow control and 
deassert device_wakeup GPIO in the same way, so that device can resume 
the link via the irq.
The bcm_suspend just adds the capability for the IRQ to wake-up the 
platform (if device_may_wakeup). On resume we disable only this 
capability, meaning that IRQ remains enabled.

>
> Thanks,
>   -Ilya
>
> 2) runtime suspend functions do not need to protect usage of dev->hu as
> these functions are called with a valid dev->hu (these functions are
> disabled before dev->hu is set to NULL when BCM driver is closed).
> System sleep functions need this protection as they can be called even
> when driver is not opened, and need to ensure that dev->hu is valid
> until GPIO and UART flow control management is performed.
>
> Common part (GPIO and UART flow control management) for runtime suspend
> and system sleep moved to __bcm_suspend() and __bcm_resume() in previous
> patch.

Regards

Fred
