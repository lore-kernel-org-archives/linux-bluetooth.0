Return-Path: <cyrus@holtmann.org>
Message-ID: <521DDDF1.1090703@ahsoftware.de>
Date: Wed, 28 Aug 2013 13:24:33 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: gustavo@padovan.org, Gianluca Anzolin <gianluca@sottospazio.it>,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.cz
Subject: Re: [PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it> <51F94E67.3040402@hurleysoftware.com> <52127E0A.6060208@hurleysoftware.com> <521CB03B.1030003@ahsoftware.de> <521CE6E1.2020206@hurleysoftware.com>
In-Reply-To: <521CE6E1.2020206@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Am 27.08.2013 19:50, schrieb Peter Hurley:
> On 08/27/2013 09:57 AM, Alexander Holler wrote:
>> Am 19.08.2013 22:20, schrieb Peter Hurley:
>>> On 07/31/2013 01:50 PM, Peter Hurley wrote:
>>
>>>> I reviewed these changes and retested. All ok.
>>>
>>> Gustavo,
>>>
>>> This series fixes a crashing regression from 3.10+ forward.
>>> Why is this not in linux-next yet?
>>
>> 3.8+ to be exact, just in case someone has to deal with older kernels.
> 
> Thanks for the reminder.
> 
> This series is too extensive to consider for -stable. Any ideas for
> how to address this crash for -stable?

Besides the BUG_ON() to prevent that something really bad happens, no.

Btw, I've just tested the series with 3.10.9, seems to work.

Thanks a lot,

Alexander Holler
