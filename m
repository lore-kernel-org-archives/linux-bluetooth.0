Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <38429B86-0E46-4C6A-9954-3260D864B10C@holtmann.org>
Date: Fri, 17 Apr 2015 10:19:06 -0700
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <A87C84EA-0EB3-4CED-AD10-76509C74A778@holtmann.org>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com> <CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com> <CADDKRnCsTgDfAZ+rbzKvEXh2ut2=sMKBfS7a7YR+5Rxi02557g@mail.gmail.com> <CADDKRnBiB+z2iMc+04ZzntRkGhVW5isNQ+sLt-UVPg3mo+Q7jg@mail.gmail.com> <300602D8-9DB7-4F8D-AC97-B60924554093@holtmann.org> <CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com> <38429B86-0E46-4C6A-9954-3260D864B10C@holtmann.org>
To: =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joerg,

>>>>>> On Fri, Apr 17, 2015 at 5:36 AM, Jörg Otte <jrg.otte@gmail.com> wrote:
>>>>>>> The BT mouse is "death" in v4.1.
>>>>>>> The BT mouse has been working in 4.0 and previous kernels, so this
>>>>>>> is a regression.
>>>>>> 
>>>>>> Any chance of bisecting it?
>>>>>> 
>>>>>>            Linus
>>>>> I will try that.
>>>>> 
>>>>> Thanks, Jörg
>>>> 
>>>> I first tried to bisect over all. But than I got an unbootable kernel.
>>>> Then I did a bisect over net/bluetooth and I get the following fist bad
>>>> commit:
>>>> 
>>>> 5f5da99f1da5b01c7c45473a500c7dbb77a00958 is the first bad commit
>>>> commit 5f5da99f1da5b01c7c45473a500c7dbb77a00958
>>>> Author: Marcel Holtmann <marcel@holtmann.org>
>>>> Date:   Wed Apr 1 13:51:53 2015 -0700
>>>> 
>>>>  Bluetooth: Restrict HIDP flags to only valid ones
>>>> 
>>>>  The HIDP flags should be clearly restricted to valid ones. So this puts
>>>>  extra checks in place to ensure this.
>>>> 
>>>>  Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>>  Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>>> 
>>>> :040000 040000 b51ac3634c9d44f4d9df0e7f548b524954b99c76
>>>> 63bfb47283609849f1b3b8f05fe61743ccddfee6 M      net
>>> 
>>> thanks for bi-secting this. I looked at our existing userspace and restricted it to the flags that are currently in use. However it seems that I made a mistake. What version of BlueZ userspace are you using (bluetoothd --version).
>>> 
>>> 
>> bluetoothd --version
>> 4.98
> 
> okay. I only looked at BlueZ 5.x and that might have been my mistake. Let me check this and fix this properly.

I think that I know what I screwed up here. I sent you a patch to fix this. Can you please test it and report back. If that fixes it for you, then I will send it to Linus for inclusion.

Regards

Marcel

