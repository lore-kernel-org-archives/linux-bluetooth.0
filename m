Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
	<CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com>
	<CADDKRnCsTgDfAZ+rbzKvEXh2ut2=sMKBfS7a7YR+5Rxi02557g@mail.gmail.com>
	<CADDKRnBiB+z2iMc+04ZzntRkGhVW5isNQ+sLt-UVPg3mo+Q7jg@mail.gmail.com>
	<300602D8-9DB7-4F8D-AC97-B60924554093@holtmann.org>
	<CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com>
Date: Fri, 17 Apr 2015 18:59:59 +0200
Message-ID: <CADDKRnAEdpDQ+Ny-kg1Dv3jVXrukCZKZY_Mu04DsOH-w-Jr+6Q@mail.gmail.com>
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2015-04-17 18:55 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> 2015-04-17 18:51 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
>> Hi Joerg,
>>
>>>>> On Fri, Apr 17, 2015 at 5:36 AM, J=C3=B6rg Otte <jrg.otte@gmail.com> =
wrote:
>>>>>> The BT mouse is "death" in v4.1.
>>>>>> The BT mouse has been working in 4.0 and previous kernels, so this
>>>>>> is a regression.
>>>>>
>>>>> Any chance of bisecting it?
>>>>>
>>>>>              Linus
>>>> I will try that.
>>>>
>>>> Thanks, J=C3=B6rg
>>>
>>> I first tried to bisect over all. But than I got an unbootable kernel.
>>> Then I did a bisect over net/bluetooth and I get the following fist bad
>>> commit:
>>>
>>> 5f5da99f1da5b01c7c45473a500c7dbb77a00958 is the first bad commit
>>> commit 5f5da99f1da5b01c7c45473a500c7dbb77a00958
>>> Author: Marcel Holtmann <marcel@holtmann.org>
>>> Date:   Wed Apr 1 13:51:53 2015 -0700
>>>
>>>    Bluetooth: Restrict HIDP flags to only valid ones
>>>
>>>    The HIDP flags should be clearly restricted to valid ones. So this p=
uts
>>>    extra checks in place to ensure this.
>>>
>>>    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>    Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>>
>>> :040000 040000 b51ac3634c9d44f4d9df0e7f548b524954b99c76
>>> 63bfb47283609849f1b3b8f05fe61743ccddfee6 M      net
>>
>> thanks for bi-secting this. I looked at our existing userspace and restr=
icted it to the flags that are currently in use. However it seems that I ma=
de a mistake. What version of BlueZ userspace are you using (bluetoothd --v=
ersion).
>>
>> Regards
>>
>> Marcel
>>
> bluetoothd --version
> 4.98
>
> Thanks, J=C3=B6rg

Just reverted that commit. It fixed the problem for me.

Thanks, J=C3=B6rg
