Return-Path: <cyrus@holtmann.org>
Message-ID: <5562D4F0.6000605@gmail.com>
Date: Mon, 25 May 2015 09:53:20 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ v5] tools/mgmt_tester: expect 0 rp when removing all adv
 inst
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1432507209-23081-1-git-send-email-fgrandel@gmail.com> <0C49B0C6-E9DA-4A01-A54B-917E63F6C0E5@holtmann.org>
In-Reply-To: <0C49B0C6-E9DA-4A01-A54B-917E63F6C0E5@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 05/25/2015 02:52 AM, Marcel Holtmann wrote:
> Hi Florian,
>
>> The kernel would previously return a hard coded instance value of 0x01
>> even when removing multiple advertising instances. This was ok as long
>> as we only had a single advertising instance but no longer makes sense
>> now that we allow for multiple advertising instances.
>>
>> We therefore expect the mgmt API to return zero when multiple instances
>> have been removed. This corresponds to the semantics of the mgmt API
>> call made in the first place.
>>
>> The corresponding test is updated to reflect that logic.
>
> this sounds like a bug that exists already today. It should make no difference is you support only once instance or multiple. If you remove all of them (aka clear them), the return value should be 0.

Not sure whether this implies any action for me? Should I single out the 
bug fix into a separate patch set?

Regards,

Florian
