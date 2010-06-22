Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimkZQRzE39WG6Kw9PlYJpXONwA-BvEZxym2J6gi@mail.gmail.com>
References: <w2ra6ca4e821005071241w9d7d982ezb78ad0ba4480e73d@mail.gmail.com>
	<s2oa6ca4e821005071249tdfd2e197i2595b57ae2ccb705@mail.gmail.com>
	<20100507195325.GB4857@vigoh>
	<AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
	<20100517023917.GI23754@vigoh>
	<AANLkTin3FNuVegPI013fzLQn7YsHzpfr7ZymnCG1mpt-@mail.gmail.com>
	<AANLkTin0B-f2i5e2TvDVDLuRZ7eRND-u4lVor1GSIhGT@mail.gmail.com>
	<AANLkTimkZQRzE39WG6Kw9PlYJpXONwA-BvEZxym2J6gi@mail.gmail.com>
Date: Wed, 23 Jun 2010 01:48:10 +0300
Message-ID: <AANLkTimrGNPtiuzB_coV6VwHmNvb7taZvePNL1QZ555G@mail.gmail.com>
Subject: Re: Software caused connection abort (103 )
From: john michelle <jhnmichelle@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, torvalds@osdl.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Bluetooth community,

You are committing version after version and have time to add new
Features and the core stack have a major bug (software Caused
connection abort) that i
Have reported on the 7th of may the problem seems to be either in the
usb part of the
Kernel or the bluez stack, i am no kernel engineer so i came directly
to you for reporting
This problem and my requests to look into this problem are just
ignored. this is a blocker
Issue that would prevent and discourage any one from developing
application that rely on
Bluez sco capabilities, since during transmission the above mentioned
error just occurs.
I hope that my voice is heared and i would get a reply from the bluez commu=
nity.

John



On Wed, Jun 16, 2010 at 3:11 PM, john michelle <jhnmichelle@gmail.com> wrot=
e:
> On Sun, May 30, 2010 at 1:12 PM, john michelle <jhnmichelle@gmail.com> wr=
ote:
>> Hi Gustavo,
>>
>>>> Please post the output of hcidump when the connection abort happens.
>>>>
>>
>> Below is the output of hcidump the moments the software caused connectio=
n abort
>>
>> Dongle 1:
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>> =A0. * . . .
>> < HCI Command: Reset (0x03|0x0003) plen 0
>> device: disconnected
>>
>> Dongle 2:
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>> =A0. * . . .
>> < HCI Command: Reset (0x03|0x0003) plen 0
>> device: disconnected
>>
>>
>> I think something triggers hci reset which causes this problem, but what=
 exactly
>> Triggers it i don't know.
>>
>>
>> John
>>
>>
>
>
> Hi all,
>
> Is anyone going to give this problem a try, it has been like a month now
> This is a real problem in the bluez stack and someone have to look in thi=
s
> Issue.
>
> John
>
>> On Mon, May 17, 2010 at 5:21 PM, john michelle <jhnmichelle@gmail.com> w=
rote:
>>>> Hi Jonh,
>>>>
>>>> First of all, don't do top posting in this mailing list. ;)
>>>>
>>>
>>> Thanks for the advise , will keep that in mind for future posts.
>>>
>>>> In which bluez/kernel version the problem started? Any hardware update
>>>> during this time? The problem happens when you are already tranfering
>>>> SCO data?
>>>>
>>>
>>> I tried bluez versions 3.XX =A0and kernel 2.6.26(I think) the problem
>>> occurs and the kernel panics with no core dumps.then i tried with
>>> bluez 4.53-4.62 with
>>> Kernel 2.6.31 and 2.6.32. the connection abort problem occurs but the
>>> kernel doesn't
>>> Panic. regarding the hardware update you mean the dongle or the box.Any=
way
>>> i changed both and tried different box's, this even happens on a box
>>> with 2 giga ram
>>> And core2 processor . as for the dongles i am using trust
>>>
>>> http://www.twenga.co.uk/prices-Bluetooth-2-USB-Adapter-10m-BT-2250p-TRU=
ST-Wireless-network-card-adapter-176178-0
>>>
>>> =A0and also using no name dongles all the same problem.
>>>
>>>> Please post the output of hcidump when the connection abort happens.
>>>>
>>>
>>> well that is going to be a hard one since i have more than one dongle i=
n place
>>> And very hard to predict which one will crash.i will work on this and u=
pdate
>>> You as soon as i have the hcidump log.
>>>
>>>
>>>
>>>> I tried reproduce this issue in L2CAP but it is a bit hard, lets
>>>> say it happen once in a thousand, so it's not easy to track it. I have
>>>> to try reproduce that using the SCO, but I'm not used to that layer ye=
t.
>>>> ;)
>>>
>>> I hoped that it happens 1 in 1000 in SCO , but it actually happens 1 in=
 15
>>>
>>>
>>> John
>>>
>>>
>>>
>>>>
>>>> Regards,
>>>>
>>>>>
>>>>> John
>>>>>
>>>>> On Fri, May 7, 2010 at 3:53 PM, Gustavo F. Padovan <gustavo@padovan.o=
rg> wrote:
>>>>> > * john michelle <jhnmichelle@gmail.com> [2010-05-07 15:49:05 -0400]=
:
>>>>> >
>>>>> >> Hi Bluetooth hackers,
>>>>> >>
>>>>> >> i am having this consistent problem with bluez , from time to time=
 i
>>>>> >> get the error Software caused connection abort (103 )
>>>>> >> And the bluetooth stick seems to disconnect and reconnects. this
>>>>> >> happens during an sco connection and it occurs even
>>>>> >> More when i am having the voice stream comming through the interne=
t
>>>>> >> rather than the lan.i don't know what exact
>>>>> >> Details you need to solve this problem please tell me and i will g=
ive
>>>>> >> you an immediate reply . i have linux kernel 2.6.33 and bluez 4.62
>>>>> >
>>>>> > I get the same problem sometimes when testing ERTM with l2test. So =
the
>>>>> > problem is on l2cap too. I didn't have time to debug this yet. Now =
that
>>>>> > someone else have confirmed it too, I'll to take a look at the prob=
lem.
>>>>> >
>>>>> >>
>>>>
>>>> --
>>>> Gustavo F. Padovan
>>>> http://padovan.org
>>>>
>>>
>>
>
