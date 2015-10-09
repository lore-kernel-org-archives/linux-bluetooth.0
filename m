Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0C972A55-F518-47CD-A9DC-FF23B1218B0B@holtmann.org>
References: <614A5683-0763-4E64-B178-67577793D8EF@holtmann.org>
	<51DF00FF-73E9-4E94-A89A-86EBD7220068@holtmann.org>
	<147B282F-6EBF-4F3A-A74E-33D5A9F54AE9@holtmann.org>
	<CAD0=r8xFWgeKBtaudHu10zN8w8vfmNkYkwZNDaEVo21sgnRhjg@mail.gmail.com>
	<CAD0=r8z2c0NDQ-WWB_qjJZZaW13bYGrG2y3oygP57GYNaOE8Pg@mail.gmail.com>
	<0C972A55-F518-47CD-A9DC-FF23B1218B0B@holtmann.org>
Date: Fri, 9 Oct 2015 14:50:05 -0700
Message-ID: <CAD0=r8z7R4r3GiaSZBw-wmuA12uvTkLRsgOhxqC62BV9jsSz0A@mail.gmail.com>
Subject: Re: Issue with new LE connection creation
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 9, 2015 at 2:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Jakub,
>
>>>>>> so when I try to connect a LE L2CAP connection to a device that does=
 not exist and then abort it will not have reached the timeout, I get this:
>>>>>>
>>>>>> < HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
>>>>>>      Address type: Public (0x00)
>>>>>>      Address: 11:22:33:44:55:66 (OUI 11-22-33)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>    LE Add Device To White List (0x08|0x0011) ncmd 1
>>>>>>      Status: Success (0x00)
>>>>>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>>>>>      Type: Passive (0x00)
>>>>>>      Interval: 60.000 msec (0x0060)
>>>>>>      Window: 30.000 msec (0x0030)
>>>>>>      Own address type: Public (0x00)
>>>>>>      Filter policy: Ignore not in white list (0x01)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>    LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>>>>>      Status: Success (0x00)
>>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>>      Scanning: Enabled (0x01)
>>>>>>      Filter duplicates: Enabled (0x01)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>>      Status: Success (0x00)
>>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>>      Scanning: Disabled (0x00)
>>>>>>      Filter duplicates: Disabled (0x00)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>>      Status: Success (0x00)
>>>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>>>      Scanning: Disabled (0x00)
>>>>>>      Filter duplicates: Disabled (0x00)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>    LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>>>      Status: Command Disallowed (0x0c)
>>>>>>
>>>>>> Notice the two attempts for disabling scanning. We should not do tha=
t. This is clearly a bug. This can be easily reproduced with latest bluetoo=
th-next and this command:
>>>>>>
>>>>>> l2test -V le_public -n 11:22:33:44:55:66
>>>>>>
>>>>>> The same happens when you are waiting for the socket connect timeout=
. The scanning disable command is sent twice.
>>>>>>
>>>>>> I also had a case where the disabling of the scanning is not sent at=
 all and the controller kept scanning. However for that one, I do not have =
an easy way to reproduce it. But it is essentially the same case, you close=
 the socket / application before the connection has been established.
>>>>>
>>>>> in addition when a connect() for LE L2CAP socket call times out, we g=
et an invalid module reference count.
>>>>>
>>>>> bluetooth             532480  1
>>>>> rfkill                 24576  1 bluetooth
>>>>>
>>>>> I see it left with an extra reference count. This is pretty bad and s=
hows that something is clearly wrong.
>>>>
>>>> please also look into this. We are not clearing the reference count co=
rrectly when aborting a connection attempt while still in scanning phase.
>>>>
>>> Ok, I'll look into that
>>
>> So I think that patch I've send fixed that.
>> I run tools/l2test -V le_public -n 11:22:33:44:55:66
>> and kill it, or wait for timeout, and reference count always drops
>> down to same initial value as before running that command.
>
> have you tried to unload all modules. Including bluetooth.ko?
>
Ok, now I see the problem :) thanks.

> Regards
>
> Marcel
>
