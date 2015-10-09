Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: Issue with new LE connection creation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8z2c0NDQ-WWB_qjJZZaW13bYGrG2y3oygP57GYNaOE8Pg@mail.gmail.com>
Date: Fri, 9 Oct 2015 23:50:32 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <1F0DD8D2-4810-48B1-8916-82CE2D20E624@holtmann.org>
References: <614A5683-0763-4E64-B178-67577793D8EF@holtmann.org> <51DF00FF-73E9-4E94-A89A-86EBD7220068@holtmann.org> <147B282F-6EBF-4F3A-A74E-33D5A9F54AE9@holtmann.org> <CAD0=r8xFWgeKBtaudHu10zN8w8vfmNkYkwZNDaEVo21sgnRhjg@mail.gmail.com> <CAD0=r8z2c0NDQ-WWB_qjJZZaW13bYGrG2y3oygP57GYNaOE8Pg@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>>>> so when I try to connect a LE L2CAP connection to a device that does not exist and then abort it will not have reached the timeout, I get this:
>>>>> 
>>>>> < HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
>>>>>      Address type: Public (0x00)
>>>>>      Address: 11:22:33:44:55:66 (OUI 11-22-33)
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>    LE Add Device To White List (0x08|0x0011) ncmd 1
>>>>>      Status: Success (0x00)
>>>>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>>>>      Type: Passive (0x00)
>>>>>      Interval: 60.000 msec (0x0060)
>>>>>      Window: 30.000 msec (0x0030)
>>>>>      Own address type: Public (0x00)
>>>>>      Filter policy: Ignore not in white list (0x01)
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>    LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>>>>      Status: Success (0x00)
>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>      Scanning: Enabled (0x01)
>>>>>      Filter duplicates: Enabled (0x01)
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>      Status: Success (0x00)
>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>      Scanning: Disabled (0x00)
>>>>>      Filter duplicates: Disabled (0x00)
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>      Status: Success (0x00)
>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>      Scanning: Disabled (0x00)
>>>>>      Filter duplicates: Disabled (0x00)
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>      Status: Command Disallowed (0x0c)
>>>>> 
>>>>> Notice the two attempts for disabling scanning. We should not do that. This is clearly a bug. This can be easily reproduced with latest bluetooth-next and this command:
>>>>> 
>>>>> l2test -V le_public -n 11:22:33:44:55:66
>>>>> 
>>>>> The same happens when you are waiting for the socket connect timeout. The scanning disable command is sent twice.
>>>>> 
>>>>> I also had a case where the disabling of the scanning is not sent at all and the controller kept scanning. However for that one, I do not have an easy way to reproduce it. But it is essentially the same case, you close the socket / application before the connection has been established.
>>>> 
>>>> in addition when a connect() for LE L2CAP socket call times out, we get an invalid module reference count.
>>>> 
>>>> bluetooth             532480  1
>>>> rfkill                 24576  1 bluetooth
>>>> 
>>>> I see it left with an extra reference count. This is pretty bad and shows that something is clearly wrong.
>>> 
>>> please also look into this. We are not clearing the reference count correctly when aborting a connection attempt while still in scanning phase.
>>> 
>> Ok, I'll look into that
> 
> So I think that patch I've send fixed that.
> I run tools/l2test -V le_public -n 11:22:33:44:55:66
> and kill it, or wait for timeout, and reference count always drops
> down to same initial value as before running that command.

I applied both patches (you are forgetting --signoff on these) and the module reference count is still out of balance. Try to unload all modules. You will see that bluetooth.ko is left with a reference count.

Regards

Marcel

