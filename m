Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm:
 Streamline runtime PM code"
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Robert R. Howell" <rhowell@uwyo.edu>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-2-hdegoede@redhat.com>
 <20180314221603.GB28738@wunner.de>
 <807b74cb-2222-2d47-12c2-0415a9027102@redhat.com>
 <20180314223813.GD28738@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <066d03cc-6dd0-7eca-f8cc-78e81277459c@redhat.com>
Date: Thu, 15 Mar 2018 08:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180314223813.GD28738@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14-03-18 23:38, Lukas Wunner wrote:
> On Wed, Mar 14, 2018 at 11:23:12PM +0100, Hans de Goede wrote:
>> On 14-03-18 23:16, Lukas Wunner wrote:
>>> On Wed, Mar 14, 2018 at 11:06:02PM +0100, Hans de Goede wrote:
>>>> This reverts commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime
>>>> PM code"). The commit msg for this commit states "No functional change
>>>> intended.", but replacing:
>>>>
>>>>   pm_runtime_get();
>>>>   pm_runtime_mark_last_busy();
>>>>   pm_runtime_put_autosuspend();
>>>>
>>>> with:
>>>>
>>>>   pm_request_resume();
>>>>
>>>> Does result in a functional change, pm_request_resume() only calls
>>>> pm_runtime_mark_last_busy() if the device was suspended before the call.
>>>
>>> Yes, Robert Howell (cc) reported this a few days ago:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=198953
>>>
>>> I've worked with him to develop a fix which is better IMHO than a revert,
>>> namely he's replacing the pm_request_resume() in bcm_recv() with
>>> pm_runtime_mark_last_busy(), and the pm_request_resume() in the interrupt
>>> handler can stay.  He says that fixes the issue for him.
>>
>> It makes the race window a lot smaller, but it still leaves a race:
>>
>> 1) some data comes in, gets full read from the device
>> 2) 4.9999 seconds elapse since last byte has been read
>> 3) new data comes in, triggers IRQ, IRQ does nothing because runtime suspend
>> has not yet kicked in
>> 4) runtime suspend kicks in, disabling the uart before the first new byte is received
>> 5) stuck again
> 
> Hm okay, but a call to pm_runtime_mark_last_busy() before the
> pm_request_resume() should avoid that.  Actually I'm wondering
> why we're not calling pm_runtime_mark_last_busy() in rpm_resume()
> if the device was already resumed as clearly an action is requested
> from it.  That needs to be investigated separately.
> 
>>> I hope he'll submit the patch shortly.
>>
>> We're quite far into the cycle already and this is a serious regression,
>> also nothing of great value is lost by the revert, the original commit
>> was a minor cleanup which turns out to have bad side-effects, a simple
>> revert really is the best solution here, esp. in this point of the cycle.
> 
> Just an hour ago he sent me the patch to look over it.  And we're at
> least two and a half weeks away from v4.16.

No we are *only* two and a half weeks away from v4.16 (worst case scenario)
and Linus does not like getting last minute fixes.

I really so no good reason to not fix this with a simple revert, esp.
since as my explanation of the race condition in the fix he send you
shows, getting this right is non trivial. Falling back to the code before
the troublesome commit gives us a known working solution, at 0 cost (as
the reverted commit was just a code cleanup, no functionality is lost).

Anyways this is Marcel's call now.

Regards,

Hans
