Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [A2DP] Incoming connections do not succeed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com>
Date: Thu, 21 Aug 2014 08:33:58 -0500
Cc: Artem Rakhov <arakhov@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <2EF4B6C6-2375-45B7-B1AF-D30C4799AC93@holtmann.org>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com> <CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com> <CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com> <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com> <574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org> <CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com> <CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com> <CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com> <CAD81oNYbM2tpSbhdfih1ir2BnszwvOkGBKbOiKG70Gcp6qHVRA@mail.gmail.com> <CAD81oNYAkFvHhFnvjSPjp+Wwnz8haJZjmE3MCuJmtom1FWfL1w@mail.gmail.com> <CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Looks like I found the problem.
>> 
>> Creation of all sockets and all the read/write operations are handled
>> in btio.c in BlueZ. It allows to set various options for sockets. One
>> of these options is called 'defer' (BT_IO_OPT_DEFER_TIMEOUT). By
>> default it is equal to 30. In fact, no profile in BlueZ use this
>> option, and it is never equal to anything else. And create_io()
>> function in btio.c also does not use this. The only place 'defer'
>> option is passed to a kernel level is bt_io_listen() function:
>> 
>> if (confirm)
>>    setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
>> sizeof(opts.defer));
> 
> Yep the use of this API is wrong, we either set or reset the flag but
> there is no timeout involved, but this alone would not cause the
> problem since the kernel ignore the actual value and just set the flag
> properly:
> 
> if (opt) {
>    set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
>    set_bit(FLAG_DEFER_SETUP, &chan->flags);
> }
> 
>> As far as I understand, BT_DEFER_SETUP is a kernel option which
>> enables Defer Setup feature for L2CAP channel. It is a binary flag,
>> and looks like it has nothing to do with timeout. And it makes no
>> sense to pass 30 as a value for binary flag.
>> 
>> So I don't see any connection between these two things. As a result,
>> we almost always turn on Defer Setup feature, which causes connection
>> problems with my speaker and potentially with other BT devices. My
>> suggestion is to completely remove 'defer' option from btio.c
>> 
>> Another question is: when and where do we actually need to enable this
>> Defer Setup feature?
> 
> Defer Setup is quite fundamental to be able to authorize connection
> properly otherwise we would have to accept the connection upfront to
> be able to identify who is connecting, L2CAP has the authorization
> pending as response for this very reason and apparently your headset
> cannot handle it properly:
> 
> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>                                                             [hci0]
> 22.030160
>      L2CAP: Connection Response (0x03) ident 2 len 8
>        Destination CID: 64
>        Source CID: 65
>        Result: Connection pending (0x0001)
>        Status: Authorization pending (0x0002)
> 
> 
> But note that bluetoothd accepts the connection almost immediately in
> the next frame (probably because the device is trusted):
> 
> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>                                                             [hci0]
> 22.030595
>      L2CAP: Connection Response (0x03) ident 2 len 8
>        Destination CID: 64
>        Source CID: 65
>        Result: Connection successful (0x0000)
>        Status: No further information available (0x0000)
> 
> This is part of the core specification, unfortunately it doesn't seems
> that any test of the testing specification do actually test it, so
> chances are that the headset could qualify just because PTS never send
> authorization/connection pending status.

it is basic L2CAP behavior since Bluetooth 1.0b specification. It always worked like this. And many many devices are using it exactly like this. It gets ever funnier when the Bluetooth stack puts the Connection Pending and Connection Successful into the same ACL frame.

Is the conclusion that the headset can not handle L2CAP Connection Pending status? Just for my entertainment, can you run hcitool info against that headset and see what manufacturer it is. I am really curious on who got this wrong. Which model is this exactly?

Regards

Marcel

