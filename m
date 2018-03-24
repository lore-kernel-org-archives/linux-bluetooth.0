Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Don't change runtime-status when
 not using runtime-pm
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20180319210237.26205-1-hdegoede@redhat.com>
 <20180324080213.GB15184@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8f97d9b8-ce7d-fa77-cf12-31c12025b0f1@redhat.com>
Date: Sat, 24 Mar 2018 12:07:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180324080213.GB15184@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 24-03-18 09:02, Lukas Wunner wrote:
> On Mon, Mar 19, 2018 at 10:02:36PM +0100, Hans de Goede wrote:
>> The pm_runtime_set_suspended() call in bcm_close() is intended as a
>> counterpart to the pm_runtime_set_active() call from bcm_request_irq()
>> (which gets called from bcm_setup()).
>>
>> The pm_runtime_set_active() call only happens if our pre-requisites for
>> doing runtime-pm are met. This commit adds the same check to the
>> pm_runtime_set_suspended() call to avoid the runtime-pm state getting
>> stuck in suspended after after a bcm_close().
> 
> Have you actually observed the state getting stuck in suspended?

No, that would require an open / close / open cycle which normally
never happens, this patch is purely for correctness sake not to
fix an actual observed problem.

> I'm asking because I don't quite see how this could happen:
> pm_runtime_set_suspended() becomes a no-op unless runtime PM is disabled.
> Now, a few lines further up in bcm_close(), pm_runtime_disable() is only
> called under the conditions you're adding here.  If it's not called,
> pm_runtime_set_suspended() doesn't have any effect anyway so adding the
> conditions is pointless.  Am I missing something?

All devices start with runtime-pm disabled and on devices without
an IRQ we never enable it. So when the pm_runtime_set_suspended()
gets called runtime-pm is still in its initial disabled state.

> Related:  I notice that bcm_resume() calls pm_runtime_set_active().
> Doesn't that have the effect that if the device is not opened and
> the system goes to sleep, the device is kept in runtime active state
> after resume and thus prevents the UART from runtime suspending until
> the device is opened?

AFAIK this just tells runtime pm that we've woken up the device
(which we have), so that it does not call bcm_resume_device() *again*
on the first runtime_pm_get(). The pm_runtime_enable() will start the
autosuspend timer I believe (I could be wrong I'm not an expert on this)
and then we will autosuspend again after the timer expires.

> Another thing that I find utterly confusing:  We set up the sleep
> parameters on ->setup if and only if the device has an IRQ.
> The sleep parameters influence how the wake pin is used (polarity etc).
> However we toggle the pin *before* setting up the sleep parameters,
> namely by calling bcm_gpio_set_power() in bcm_open(), bcm_probe() and
> bcm_serdev_probe().  Is that actually correct?  Shouldn't we avoid
> toggling the wake pin until the sleep parameters have been set up?
> Would it be conceivable that the sleep parameters are somehow botched
> when the device comes out of power-on reset, such that toggling the
> wake pin before setting the sleep parameters to sane values causes
> the device to become unresponsive or something like that?

A valid question, to which I've no answer, it seems that the device
either defaults to bt_wake_active = 1 (as we set it later), or to
sleep_mode = 0 (disabled) so what we set the device-wakeup gpio to
does not matter as it does not sleep.

I'm afraid we lack documentation here, an other interesting observation
is that we set:

         sleep_params.host_wake_active = !bcm->dev->irq_active_low;

So theoretically if we chose the IRQ to be active-low or active-high
does not matter, because we tell the bluetooth device what we want,
yet on a whole bunch of Bay Trail devices things do not work unless
we force the IRQ to be active-low (trigger on falling edge), suggesting
that the firmware ignores this bit.

Regards,

Hans





> 
> Thanks,
> 
> Lukas
> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/bluetooth/hci_bcm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index eee33b0e4d67..06e2434c9b3d 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -464,7 +464,7 @@ static int bcm_close(struct hci_uart *hu)
>>   		err = bcm_gpio_set_power(bdev, false);
>>   		if (err)
>>   			bt_dev_err(hu->hdev, "Failed to power down");
>> -		else
>> +		else if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0)
>>   			pm_runtime_set_suspended(bdev->dev);
>>   	}
>>   	mutex_unlock(&bcm_device_lock);
>> -- 
>> 2.14.3
>>
