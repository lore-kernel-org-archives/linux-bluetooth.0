Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm:
 Streamline runtime PM code"
To: Marcel Holtmann <marcel@holtmann.org>, Lukas Wunner <lukas@wunner.de>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Robert R. Howell" <rhowell@uwyo.edu>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-2-hdegoede@redhat.com>
 <20180314221603.GB28738@wunner.de>
 <807b74cb-2222-2d47-12c2-0415a9027102@redhat.com>
 <20180314223813.GD28738@wunner.de>
 <066d03cc-6dd0-7eca-f8cc-78e81277459c@redhat.com>
 <20180315081408.GC4615@wunner.de>
 <2F4B2A06-7ABD-49D6-BCC8-2885F87FE00B@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <df3b7e84-1cd9-f0a4-623e-bc770dec6442@redhat.com>
Date: Thu, 15 Mar 2018 14:49:50 +0100
MIME-Version: 1.0
In-Reply-To: <2F4B2A06-7ABD-49D6-BCC8-2885F87FE00B@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15-03-18 14:15, Marcel Holtmann wrote:
> Hi Lukas,
> 
>>>>> We're quite far into the cycle already and this is a serious regression,
>>>>> also nothing of great value is lost by the revert, the original commit
>>>>> was a minor cleanup which turns out to have bad side-effects, a simple
>>>>> revert really is the best solution here, esp. in this point of the cycle.
>>>>
>>>> Just an hour ago he sent me the patch to look over it.  And we're at
>>>> least two and a half weeks away from v4.16.
>>>
>>> No we are *only* two and a half weeks away from v4.16 (worst case scenario)
>>> and Linus does not like getting last minute fixes.
>>
>> That doesn't preclude allowing a few hours to discuss things.
>> There is never such a rush.  In the present case, a new contributor
>> was willing to debug the issue and submit a patch.  Onboarding new
>> contributors is important and IMO it's worth waiting a few days for
>> them to sort things out, even if it means a regression stays present
>> a little longer.  I'm sorry that it meant you wasted time debugging
>> it in parallel.
>>
>> That said, when submitting the patch I clearly failed to notice that
>> for devices using autosuspend, pm_request_resume() doesn't update
>> the last usage timestamp.  While that could be fixed by calling
>> pm_runtime_mark_last_busy() before pm_request_resume(), it doesn't
>> seem to be customary as a look at all the call sites of
>> pm_request_resume() shows.  The original three-line sequence,
>> although quite verbose, appears to be what is commonly used in such
>> a case.  For this reason reverting back to the original version
>> seems justified.
> 
> there is no reason to rush this through. With a properly worded commit message that explain the reason, I have no problem to do a last minute -rc inclusion.
> 
> However what I like to have is a single patch with all Acks and also CC: stable tags if required that we can just send off in the direction towards Linus. I saw there is an alternative patch on the mailing list. So I would like to have a good conclusion on what goes to -rc and that we all agree.

I think we are all in agreement now to just go with the revert patch which I did,
Lucas acked that patch this morning.

Regards,

Hans
