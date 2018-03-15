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
 <066d03cc-6dd0-7eca-f8cc-78e81277459c@redhat.com>
 <20180315081408.GC4615@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <acec3f85-559c-3910-b53b-91300338aec2@redhat.com>
Date: Thu, 15 Mar 2018 11:23:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180315081408.GC4615@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15-03-18 09:14, Lukas Wunner wrote:
> On Thu, Mar 15, 2018 at 08:49:04AM +0100, Hans de Goede wrote:
>> On 14-03-18 23:38, Lukas Wunner wrote:
>>> On Wed, Mar 14, 2018 at 11:23:12PM +0100, Hans de Goede wrote:
>>>> We're quite far into the cycle already and this is a serious regression,
>>>> also nothing of great value is lost by the revert, the original commit
>>>> was a minor cleanup which turns out to have bad side-effects, a simple
>>>> revert really is the best solution here, esp. in this point of the cycle.
>>>
>>> Just an hour ago he sent me the patch to look over it.  And we're at
>>> least two and a half weeks away from v4.16.
>>
>> No we are *only* two and a half weeks away from v4.16 (worst case scenario)
>> and Linus does not like getting last minute fixes.
> 
> That doesn't preclude allowing a few hours to discuss things.
> There is never such a rush.  In the present case, a new contributor
> was willing to debug the issue and submit a patch.  Onboarding new
> contributors is important and IMO it's worth waiting a few days for
> them to sort things out, even if it means a regression stays present
> a little longer.

I completely agree that onboarding new contributors is important.

Regards,

Hans
