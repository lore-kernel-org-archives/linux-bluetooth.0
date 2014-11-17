Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <7ED5AE30-EF53-47EA-A9CE-DD371CE10910@holtmann.org>
References: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
	<50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
	<CAHrH25T6tmUO2Zvsr=R7+yHwQE0_hY_sMt4UQAmCBMZBOH0PRQ@mail.gmail.com>
	<ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
	<CAHrH25Te4J6ospnJYA00mb1RofwHrS4=KD8LjmTLvo5Y4Jy8EQ@mail.gmail.com>
	<CAHrH25S5X5UZJwH0JuoWGW70bDdO48iS8Ex5pF0K9Cd7JsRV8A@mail.gmail.com>
	<7ED5AE30-EF53-47EA-A9CE-DD371CE10910@holtmann.org>
Date: Mon, 17 Nov 2014 15:07:11 -0800
Message-ID: <CAHrH25QzAYG-uHgEJ2rBmpJ_RMgW9zZ0+WvwtY3Mo0zKUxgB9w@mail.gmail.com>
Subject: Re: Handling EBUSY for LE connections.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Fri, Nov 14, 2014 at 4:35 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> Hi Arman,
>
>>>>>>> We have a use case in which multiple LE connection attempts are mad=
e
>>>>>>> in rapid succession to a device that frequently rotates its private
>>>>>>> address. The connect call frequently fails with
>>>>>>> "org.bluez.Error.Failed: Device or resource is busy (16)". I tracke=
d
>>>>>>> this down to a line in net/bluetooth/hci_conn.c:hci_connect_le that
>>>>>>> has the following comment before returning -EBUSY:
>>>>>>>
>>>>>>>  /* Since the controller supports only one LE connection attempt at=
 a
>>>>>>>   * a time, we return -EBUSY if there is any connection attempt run=
ning.
>>>>>>>   */
>>>>>>>
>>>>>>> This is all fine and good, however the org.bluez.Error.Failed error
>>>>>>> name is too generic for an application to determine how to recover
>>>>>>> from this case and it would be nice if there was a way for an
>>>>>>> application to know that it should perhaps try connecting again lat=
er,
>>>>>>> especially without having to parse the error message string to make
>>>>>>> sense of things while there can be a clear error name.
>>>>>>>
>>>>>>> So, would it make sense for bluetoothd to return
>>>>>>> org.bluez.Error.InProgress or even org.bluez.Error.Busy here? Anoth=
er
>>>>>>> potential solution I had in mind was to have bluetoothd actually qu=
eue
>>>>>>> LE connection attempts if one is already pending, or perhaps
>>>>>>> automatically schedule a retry if kernel returns EBUSY.
>>>>>>>
>>>>>>> What do you think is the best solution here?
>>>>>>
>>>>>> we should fix that directly in the kernel. Back in the days we had a=
 similar issue with BR/EDR and some more "dumb" controllers. We queued the =
connection attempt in the kernel and issued it whenever the controller was =
free again.
>>>>>>
>>>>>> One other thing that we should be doing for "direct" LE connection a=
ttempts is to run them through the LE passive background scanning. That way=
 we have the same connection logic handling the background scanning and the=
 connection attempts.
>>>>>>
>>>>>> Mainly I am thinking that if we have a L2CAP connect() request, we j=
ust add it to the LE passive background scanning. The only difference would=
 be that these can actually time out. Otherwise it should be exactly the sa=
me.
>>>>>
>>>>> OK, so what is the work that I would need to do here? I'm not super
>>>>> familiar with the kernel code, hence I'd appreciate some guidance.
>>>>> From what you said, I gather two different work items:
>>>>>
>>>>> 1. Queue connection attempts and reissue when the controller becomes =
free.
>>>>> 2. Make use of background scanning.
>>>>>
>>>>> If we do #2 would we need #1 as well? I assume #2 will only be
>>>>> possible on later kernels, is there a solution that would easily
>>>>> backport to older kernels?
>>>>
>>>> the background scanning is part of 3.17 and later, and you want to bac=
kport that anyway. Main reason is that it using the controller whitelist an=
d is needed for proper LE HID support anyway.
>>>>
>>>
>>> OK. For ChromiumOS's 3.10 and 3.14 kernels Scott has already done a
>>> backport from the latest bluetooth-next but we had concerns for kernel
>>> 3.8. I guess for now I'll go with your background scan based
>>> suggestion and worry about those older platforms later.
>>>
>>>> So the only thing that should be needed is the capabilities to add an =
entry to the connection list that has a timeout. Right now only userspace v=
ia mgmt Add/Remove Device can modify this list. These entries would come fr=
om L2CAP connect() calls and need to fail if the device in question can not=
 be found in x seconds.
>>>>
>>>> This means the connection logic from the background scanning should ge=
t a delayed workqueue for the timeout and we have to add timeout values to =
each entry in our list. And then remove them when timeout has been reached =
and send a proper socket error back to userspace. The real advantage comes =
into play that as a result the connection handling would then also use the =
controller whitelist and with that can easily connect multiple device after=
 each other. For the automatic connections that we trigger via mgmt Add/Rem=
ove Device this already works right now.
>>>>
>>>
>>> OK, that sounds straightforward actually. I'll start looking into this
>>> and probably send out some RFC patches later.
>>>
>>
>> I guess I'm seeking some programming advice now as a net/bluetooth
>> noob. So it looks like in l2cap_code.c:l2cap_chan_connect I want to
>> replace the call to "hci_connect_le" with some variant of
>> hci_conn_params_set. Based on my understanding, eventually if an ADV
>> report is received, hci_event.c:process_adv_report will handle
>> creating the connection for us (in hci_event.c:check_pending_le_conn).
>>
>> From here, what would be the best (and proper) way to propagate this
>> information and the newly created hci_conn structure to the l2cap
>> layer so that the l2cap_conn structure can be set up?
>
> that is a good question. I think Johan is a bit deeper in the code. Might=
 worthwhile to jump on IRC and brainstorm with him on this.
>

I'm pretty much always out of luck getting ahold of people on IRC, so
hopefully Johan will see this thread and respond eventually.

> He has done connection creation for the slave side using direct advertisi=
ng and that would have some similar logical handling. At least I think it d=
oes. And if not, we might first need a few cleanups to make the LE connecti=
on handling for L2CAP sockets more streamlined and easy to integrate.
>

So, from looking at the code, I see that l2cap_sock_connect calls
l2cap_chan_connect, which internally creates the hci_conn via
hci_connect_le. If all goes well, l2cap_sock_connect simply sits and
waits until the socket state becomes BT_CONNECTED. So, I guess we may
want something similar to that. We could revise hci_connect_le so that
it automatically creates the temporary whitelist entry and listens for
AD. Or perhaps we could have an additional API that sends an LE Create
Connection that accepts an hci_conn instead of an hci_dev, which can
then be called from hci_event.c:check_pending_le_conn.

Anyway, I think I have a rough idea of what needs to be done overall
but I'd appreciate Johan's input.

> Regards
>
> Marcel
>

Thanks,
Arman
