Return-Path: <cyrus@holtmann.org>
Message-ID: <5189AF61.7020800@asianux.com>
Date: Wed, 08 May 2013 09:50:25 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 David Miller <davem@davemloft.net>,
 Jiri Kosina <jkosina@suse.cz>, andrei.emeltchenko@intel.com,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
Subject: Re: [Suggestion] Bluetooth: hidp: redundant initialization or issue
 for function hidp_copy_session
References: <518906A8.7060708@asianux.com> <51890AC9.7010501@asianux.com> <CANq1E4Q8g6Uy5DMiEf3aEBmfWN=KnVCfqxErYr=ZWD94D4vmAQ@mail.gmail.com>
In-Reply-To: <CANq1E4Q8g6Uy5DMiEf3aEBmfWN=KnVCfqxErYr=ZWD94D4vmAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 2013年05月08日 03:37, David Herrmann wrote:
> Hi
> 
> On Tue, May 7, 2013 at 4:08 PM, Chen Gang <gang.chen@asianux.com> wrote:
>> Hello Maintainers:
>>
>> In net/bluetooth/hidp/core.c, for hidp_copy_session(), the
>> 'session->input' and 'session->hid' are conflict with each other.
>>
>> And excuse me, I do not quit know the details, but I think we have 2
>> choices for fixing it:
>>
>>   one is ''if (session->input) { } else if (session->hid) { };''
>>   the other is ''if (seesion->hid) { } else if (session->input) { };''
>>
>> The first choice assumes the original code has a logical issue; the
>> second choice assumes the original code has redundant initialization.
> 
> The code is fine. Only one of "->input" or "->hid" can be valid at a
> time. And exactly one of them is guaranteed to be valid. See
> hidp_session_dev_init().
> 

Oh, really it is, thanks.

> I fixed all code that I changed during the rework to say:
> 
> if (session->hid)
> ..
> else if (session->input)
> ..
> 
> It makes the code more clear. But I avoided touching all the other
> places that I didn't change, as the code is technically right. Anyway,
> I don't care whether we want to fix all other occurrences to use "else
> if". Feel free to send a patch.
> 

Me too: "avoided touching all the other places that I didn't change, as
the code is technically right".

Thanks.

-- 
Chen Gang

Asianux Corporation
