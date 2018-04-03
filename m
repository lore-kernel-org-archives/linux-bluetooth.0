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
 <8f97d9b8-ce7d-fa77-cf12-31c12025b0f1@redhat.com>
 <20180324141909.GA2013@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <4c95557d-3f68-825d-e50a-9ff6c5c72e0a@redhat.com>
Date: Tue, 3 Apr 2018 14:55:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180324141909.GA2013@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 24-03-18 15:19, Lukas Wunner wrote:
> On Sat, Mar 24, 2018 at 12:07:10PM +0100, Hans de Goede wrote:
>> On 24-03-18 09:02, Lukas Wunner wrote:
>>> On Mon, Mar 19, 2018 at 10:02:36PM +0100, Hans de Goede wrote:
>>>> The pm_runtime_set_suspended() call in bcm_close() is intended as a
>>>> counterpart to the pm_runtime_set_active() call from bcm_request_irq()
>>>> (which gets called from bcm_setup()).
>>>>
>>>> The pm_runtime_set_active() call only happens if our pre-requisites for
>>>> doing runtime-pm are met. This commit adds the same check to the
>>>> pm_runtime_set_suspended() call to avoid the runtime-pm state getting
>>>> stuck in suspended after after a bcm_close().
>>>
>>> Have you actually observed the state getting stuck in suspended?
>>> I'm asking because I don't quite see how this could happen:
>>> pm_runtime_set_suspended() becomes a no-op unless runtime PM is disabled.
>>> Now, a few lines further up in bcm_close(), pm_runtime_disable() is only
>>> called under the conditions you're adding here.  If it's not called,
>>> pm_runtime_set_suspended() doesn't have any effect anyway so adding the
>>> conditions is pointless.  Am I missing something?
>>
>> All devices start with runtime-pm disabled and on devices without
>> an IRQ we never enable it. So when the pm_runtime_set_suspended()
>> gets called runtime-pm is still in its initial disabled state.
> 
> Okay but the device's initial state is set to RPM_SUSPENDED by
> pm_runtime_init() and AFAICS neither the platform nor acpi buses
> subsequently set it to RPM_ACTIVE, so the device is in suspended
> state anyway, unless I've overlooked some detail.

Ah, no you're right, I assumed that devices would default to
RPM_ACTIVE (which corresponds to value 0), but you are right
they are set to suspended by default.

So this patch can be dropped.

Marcel: It would still be nice to get the second patch from
this series merged.

> Which raises another question, bcm_suspend() only calls
> bcm_suspend_device() if it's runtime active.  So devices
> without IRQ, which are always in runtime suspended state,
> are apparently never orderly put to sleep on ->suspend.

No that is not a problem, pm_runtime_active() is defined as:

static inline bool pm_runtime_active(struct device *dev)
{
         return dev->power.runtime_status == RPM_ACTIVE
                 || dev->power.disable_depth;
}

On devices without an IRQ we never enable runtime_pm, so
dev->power.disable_depth stays at its initial value of 1 and
this function will return 1.

> Also, if the device is always in suspended state, there's nothing
> that keeps the UART in active state.  Has anyone ever actually
> tested if this driver works without IRQ?

AFAIK the code deciding to suspend parents also uses
pm_runtime_active()

The reason why I was worried about the suspended status field is
because there also is pm_runtime_status_suspended() which only
checks the status field, but I guess that is only used in
special cases.

>>> Related:  I notice that bcm_resume() calls pm_runtime_set_active().
>>> Doesn't that have the effect that if the device is not opened and
>>> the system goes to sleep, the device is kept in runtime active state
>>> after resume and thus prevents the UART from runtime suspending until
>>> the device is opened?
>>
>> AFAIK this just tells runtime pm that we've woken up the device
>> (which we have), so that it does not call bcm_resume_device() *again*
>> on the first runtime_pm_get().
> 
> That's odd, by default the PM core runtime resumes a device before
> going to system sleep, the only exception is if the devices uses
> the "direct_complete" procedure, which requires that ->prepare
> returns a positive int.  The platform bus doesn't even have a
> ->prepare hook, so never uses direct complete AFAICS, and the acpi
> bus uses direct_complete only under certain conditions and even then
> devices seem to be resumed to runtime active state when the system wakes,
> according to the code comment in acpi_subsys_resume_noirq().
> 
> So the pm_runtime_set_active() in bcm_resume() looks odd to me.

This code precedes my involvement in the driver, I agree this looks
a bit weird.

>> The pm_runtime_enable() will start the
>> autosuspend timer I believe (I could be wrong I'm not an expert on this)
>> and then we will autosuspend again after the timer expires.
> 
> No, pm_runtime_enable() doesn't do that, but device_complete calls
> pm_runtime_put() as the last step when coming out of system sleep,
> and that will start the autosuspend timer.

Ok.

Regards,

Hans
