Return-Path: <cyrus@holtmann.org>
Message-ID: <4EE1CA0F.2040402@linux.intel.com>
Date: Fri, 09 Dec 2011 09:42:55 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH hciemu v2 1/2] Process Read Local AMP Info in hciemu
References: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <20111208094032.GA28204@x220> <4EE0D0A0.2000401@linux.intel.com> <20111209081637.GB7256@aemeltch-MOBL1>
In-Reply-To: <20111209081637.GB7256@aemeltch-MOBL1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Andrei,

Le 09/12/2011 09:16, Emeltchenko Andrei a écrit :
> Hi Frederic,
>
> On Thu, Dec 08, 2011 at 03:58:40PM +0100, Frederic Danis wrote:
>> Hello,
>>
>> Le 08/12/2011 10:40, Johan Hedberg a écrit :
>>> Hi Andrei,
>>>
>>> On Thu, Dec 08, 2011, Emeltchenko Andrei wrote:
>>>> Add processing of Read Local AMP Info in hciemu, the values returned are
>>>> used to emulate AMP HCI.
>>>> ---
>>>>   test/hciemu.c |   35 +++++++++++++++++++++++++++++++++++
>>>>   1 files changed, 35 insertions(+), 0 deletions(-)
>>>
>>> Both patches have been applied. Thanks.
>>>
>>> Johan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> This patch breaks the build on Ubuntu 10.10 32 bits with messages:
>>
>> fdanis@fdanis-linux:bluez (master %)$ make
>> make --no-print-directory all-am
>>    CC     test/hciemu.o
>> cc1: warnings being treated as errors
>> test/hciemu.c: In function ‘hci_host_control’:
>> test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does
>> break strict-aliasing rules
>> test/hciemu.c:431: note: initialized from here
>> make[1]: *** [test/hciemu.o] Error 1
>> make: *** [all] Error 2
>
> Cannot reproduce this problem on my Ubuntu 11.04. Are you sure the error is
> attributed to my patch?

Yes, I replaced line 431 by:
	sa.sin_port = ba.b[4];
and there is no more build error.

Best regards

Fred


-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

