Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: arakhov@google.com
In-Reply-To: <2854D296-3CCA-4628-90B5-76D03EF2660D@holtmann.org>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
	<CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com>
	<CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
	<CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
	<574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org>
	<CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com>
	<CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
	<CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com>
	<CAD81oNYbM2tpSbhdfih1ir2BnszwvOkGBKbOiKG70Gcp6qHVRA@mail.gmail.com>
	<CAD81oNYAkFvHhFnvjSPjp+Wwnz8haJZjmE3MCuJmtom1FWfL1w@mail.gmail.com>
	<CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com>
	<2EF4B6C6-2375-45B7-B1AF-D30C4799AC93@holtmann.org>
	<CABBYNZK=t=otqjW1B64MwWO8cc9aLs+RovVp=5KFEBbB3zysow@mail.gmail.com>
	<2854D296-3CCA-4628-90B5-76D03EF2660D@holtmann.org>
Date: Thu, 21 Aug 2014 12:16:43 -0700
Message-ID: <CAD81oNb2p5ux2U2vKvSQb8Z2o+gjbZwEh0H4jb4VdEueBDez0A@mail.gmail.com>
Subject: Re: [A2DP] Incoming connections do not succeed
From: Artem Rakhov <arakhov@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Here is hcitool info:

BD Address:  10:B7:F6:01:31:ED
Device Name: Monster Clarity
LMP Version: 2.1 (0x4) LMP Subversion: 0x189c
Manufacturer: Cambridge Silicon Radio (10)
Features page 0: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<3-slot packets>
Features page 1: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83

Label also says Precision Micro Bluetooth Speaker 100.

Thanks,
Artem

On Thu, Aug 21, 2014 at 7:28 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>>>>> Looks like I found the problem.
>>>>>
>>>>> Creation of all sockets and all the read/write operations are handled
>>>>> in btio.c in BlueZ. It allows to set various options for sockets. One
>>>>> of these options is called 'defer' (BT_IO_OPT_DEFER_TIMEOUT). By
>>>>> default it is equal to 30. In fact, no profile in BlueZ use this
>>>>> option, and it is never equal to anything else. And create_io()
>>>>> function in btio.c also does not use this. The only place 'defer'
>>>>> option is passed to a kernel level is bt_io_listen() function:
>>>>>
>>>>> if (confirm)
>>>>>   setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
>>>>> sizeof(opts.defer));
>>>>
>>>> Yep the use of this API is wrong, we either set or reset the flag but
>>>> there is no timeout involved, but this alone would not cause the
>>>> problem since the kernel ignore the actual value and just set the flag
>>>> properly:
>>>>
>>>> if (opt) {
>>>>   set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
>>>>   set_bit(FLAG_DEFER_SETUP, &chan->flags);
>>>> }
>>>>
>>>>> As far as I understand, BT_DEFER_SETUP is a kernel option which
>>>>> enables Defer Setup feature for L2CAP channel. It is a binary flag,
>>>>> and looks like it has nothing to do with timeout. And it makes no
>>>>> sense to pass 30 as a value for binary flag.
>>>>>
>>>>> So I don't see any connection between these two things. As a result,
>>>>> we almost always turn on Defer Setup feature, which causes connection
>>>>> problems with my speaker and potentially with other BT devices. My
>>>>> suggestion is to completely remove 'defer' option from btio.c
>>>>>
>>>>> Another question is: when and where do we actually need to enable thi=
s
>>>>> Defer Setup feature?
>>>>
>>>> Defer Setup is quite fundamental to be able to authorize connection
>>>> properly otherwise we would have to accept the connection upfront to
>>>> be able to identify who is connecting, L2CAP has the authorization
>>>> pending as response for this very reason and apparently your headset
>>>> cannot handle it properly:
>>>>
>>>> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>>>>                                                            [hci0]
>>>> 22.030160
>>>>     L2CAP: Connection Response (0x03) ident 2 len 8
>>>>       Destination CID: 64
>>>>       Source CID: 65
>>>>       Result: Connection pending (0x0001)
>>>>       Status: Authorization pending (0x0002)
>>>>
>>>>
>>>> But note that bluetoothd accepts the connection almost immediately in
>>>> the next frame (probably because the device is trusted):
>>>>
>>>> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>>>>                                                            [hci0]
>>>> 22.030595
>>>>     L2CAP: Connection Response (0x03) ident 2 len 8
>>>>       Destination CID: 64
>>>>       Source CID: 65
>>>>       Result: Connection successful (0x0000)
>>>>       Status: No further information available (0x0000)
>>>>
>>>> This is part of the core specification, unfortunately it doesn't seems
>>>> that any test of the testing specification do actually test it, so
>>>> chances are that the headset could qualify just because PTS never send
>>>> authorization/connection pending status.
>>>
>>> it is basic L2CAP behavior since Bluetooth 1.0b specification. It alway=
s worked like this. And many many devices are using it exactly like this. I=
t gets ever funnier when the Bluetooth stack puts the Connection Pending an=
d Connection Successful into the same ACL frame.
>>
>> I suspected it is a very basic since iirc we introduce Defer Setup
>> long time ago and never run into this specific problem. Now if that
>> actually gets in the same ACL frame this could cause a stack to ignore
>> the subsequent response which perhaps is the problem here.
>
> I don't think so since there is a test case for this. Question is just if=
 the remote device can really handle the Connection Pending correctly.
>
>>> Is the conclusion that the headset can not handle L2CAP Connection Pend=
ing status? Just for my entertainment, can you run hcitool info against tha=
t headset and see what manufacturer it is. I am really curious on who got t=
his wrong. Which model is this exactly?
>>
>> No idea, perhaps Artem is willing to disclose the model, from the logs
>> it seems it hangs if authorization pending is sent and then at some
>> point it probably timeout and disconnects.
>>
>> We do have some logic to handle devices that connect but do not
>> configure any stream, perhaps we could fit this in the same category
>> and if they disconnect while authorizing we attempt to reconnect, it
>> is probably to much of a hack but if the device is really popular then
>> perhaps it is worth trying.
>
> That is something that could work. Since I rather not change the kernel l=
ogic to handle and accept() plus a read() right after it with a special del=
ay turning this into a Connection Succesful.
>
> It might be also worthwhile to check if there is a firmware update for th=
is speaker available. I can imagine that this causes issues for a few stack=
s.
>
> Regards
>
> Marcel
>
