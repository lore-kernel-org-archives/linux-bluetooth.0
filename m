Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Don't change runtime-status when
 not using runtime-pm
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4c95557d-3f68-825d-e50a-9ff6c5c72e0a@redhat.com>
Date: Tue, 3 Apr 2018 16:16:28 +0200
Cc: Lukas Wunner <lukas@wunner.de>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <C2E1C50D-55B8-4769-A641-17A87780FAE4@holtmann.org>
References: <20180319210237.26205-1-hdegoede@redhat.com>
 <20180324080213.GB15184@wunner.de>
 <8f97d9b8-ce7d-fa77-cf12-31c12025b0f1@redhat.com>
 <20180324141909.GA2013@wunner.de>
 <4c95557d-3f68-825d-e50a-9ff6c5c72e0a@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

>>>>> The pm_runtime_set_suspended() call in bcm_close() is intended as a
>>>>> counterpart to the pm_runtime_set_active() call from bcm_request_irq()
>>>>> (which gets called from bcm_setup()).
>>>>> 
>>>>> The pm_runtime_set_active() call only happens if our pre-requisites for
>>>>> doing runtime-pm are met. This commit adds the same check to the
>>>>> pm_runtime_set_suspended() call to avoid the runtime-pm state getting
>>>>> stuck in suspended after after a bcm_close().
>>>> 
>>>> Have you actually observed the state getting stuck in suspended?
>>>> I'm asking because I don't quite see how this could happen:
>>>> pm_runtime_set_suspended() becomes a no-op unless runtime PM is disabled.
>>>> Now, a few lines further up in bcm_close(), pm_runtime_disable() is only
>>>> called under the conditions you're adding here.  If it's not called,
>>>> pm_runtime_set_suspended() doesn't have any effect anyway so adding the
>>>> conditions is pointless.  Am I missing something?
>>> 
>>> All devices start with runtime-pm disabled and on devices without
>>> an IRQ we never enable it. So when the pm_runtime_set_suspended()
>>> gets called runtime-pm is still in its initial disabled state.
>> Okay but the device's initial state is set to RPM_SUSPENDED by
>> pm_runtime_init() and AFAICS neither the platform nor acpi buses
>> subsequently set it to RPM_ACTIVE, so the device is in suspended
>> state anyway, unless I've overlooked some detail.
> 
> Ah, no you're right, I assumed that devices would default to
> RPM_ACTIVE (which corresponds to value 0), but you are right
> they are set to suspended by default.
> 
> So this patch can be dropped.
> 
> Marcel: It would still be nice to get the second patch from
> this series merged.

can you resent that patch? And should it also go into stable?

Regards

Marcel

