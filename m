Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
References: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
	<50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
	<CAHrH25T6tmUO2Zvsr=R7+yHwQE0_hY_sMt4UQAmCBMZBOH0PRQ@mail.gmail.com>
	<ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
Date: Wed, 12 Nov 2014 21:28:14 -0800
Message-ID: <CAHrH25Te4J6ospnJYA00mb1RofwHrS4=KD8LjmTLvo5Y4Jy8EQ@mail.gmail.com>
Subject: Re: Handling EBUSY for LE connections.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Wed, Nov 12, 2014 at 9:10 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> Hi Arman,
>
>>>> We have a use case in which multiple LE connection attempts are made
>>>> in rapid succession to a device that frequently rotates its private
>>>> address. The connect call frequently fails with
>>>> "org.bluez.Error.Failed: Device or resource is busy (16)". I tracked
>>>> this down to a line in net/bluetooth/hci_conn.c:hci_connect_le that
>>>> has the following comment before returning -EBUSY:
>>>>
>>>>   /* Since the controller supports only one LE connection attempt at a
>>>>    * a time, we return -EBUSY if there is any connection attempt runni=
ng.
>>>>    */
>>>>
>>>> This is all fine and good, however the org.bluez.Error.Failed error
>>>> name is too generic for an application to determine how to recover
>>>> from this case and it would be nice if there was a way for an
>>>> application to know that it should perhaps try connecting again later,
>>>> especially without having to parse the error message string to make
>>>> sense of things while there can be a clear error name.
>>>>
>>>> So, would it make sense for bluetoothd to return
>>>> org.bluez.Error.InProgress or even org.bluez.Error.Busy here? Another
>>>> potential solution I had in mind was to have bluetoothd actually queue
>>>> LE connection attempts if one is already pending, or perhaps
>>>> automatically schedule a retry if kernel returns EBUSY.
>>>>
>>>> What do you think is the best solution here?
>>>
>>> we should fix that directly in the kernel. Back in the days we had a si=
milar issue with BR/EDR and some more "dumb" controllers. We queued the con=
nection attempt in the kernel and issued it whenever the controller was fre=
e again.
>>>
>>> One other thing that we should be doing for "direct" LE connection atte=
mpts is to run them through the LE passive background scanning. That way we=
 have the same connection logic handling the background scanning and the co=
nnection attempts.
>>>
>>> Mainly I am thinking that if we have a L2CAP connect() request, we just=
 add it to the LE passive background scanning. The only difference would be=
 that these can actually time out. Otherwise it should be exactly the same.
>>
>> OK, so what is the work that I would need to do here? I'm not super
>> familiar with the kernel code, hence I'd appreciate some guidance.
>> From what you said, I gather two different work items:
>>
>>  1. Queue connection attempts and reissue when the controller becomes fr=
ee.
>>  2. Make use of background scanning.
>>
>> If we do #2 would we need #1 as well? I assume #2 will only be
>> possible on later kernels, is there a solution that would easily
>> backport to older kernels?
>
> the background scanning is part of 3.17 and later, and you want to backpo=
rt that anyway. Main reason is that it using the controller whitelist and i=
s needed for proper LE HID support anyway.
>

OK. For ChromiumOS's 3.10 and 3.14 kernels Scott has already done a
backport from the latest bluetooth-next but we had concerns for kernel
3.8. I guess for now I'll go with your background scan based
suggestion and worry about those older platforms later.

> So the only thing that should be needed is the capabilities to add an ent=
ry to the connection list that has a timeout. Right now only userspace via =
mgmt Add/Remove Device can modify this list. These entries would come from =
L2CAP connect() calls and need to fail if the device in question can not be=
 found in x seconds.
>
> This means the connection logic from the background scanning should get a=
 delayed workqueue for the timeout and we have to add timeout values to eac=
h entry in our list. And then remove them when timeout has been reached and=
 send a proper socket error back to userspace. The real advantage comes int=
o play that as a result the connection handling would then also use the con=
troller whitelist and with that can easily connect multiple device after ea=
ch other. For the automatic connections that we trigger via mgmt Add/Remove=
 Device this already works right now.
>

OK, that sounds straightforward actually. I'll start looking into this
and probably send out some RFC patches later.

> Regards
>
> Marcel
>

Thanks,
Arman
