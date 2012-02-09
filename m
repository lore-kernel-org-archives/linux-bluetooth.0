Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328797634.28848.21.camel@aeonflux>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797634.28848.21.camel@aeonflux>
Date: Thu, 9 Feb 2012 15:54:44 -0200
Message-ID: <CAA37ikYriwfbS9SQKwqnPn+X6z6OoU1AGvqVnqa1vvsUWptmkg@mail.gmail.com>
Subject: Re: [RFCv3 02/16] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 9, 2012 at 12:27 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> Usage of RCU list looks not reasonalbe for a number of reasons:
>> our code sleep and we have to use socket spinlocks, some parts
>> of code are updaters thus we need to use mutexes anyway.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> ---
>> =A0net/bluetooth/l2cap_core.c | =A0108 ++++++++++++++++++++++-----------=
-----------
>> =A01 files changed, 54 insertions(+), 54 deletions(-)
>
> I am fine with this, but I wanna get an ack from Ulisses as well.

Please, refer to my previous review because it seems you haven't
changed anything at all. For instance, l2cap_disconnect_rsp() is still
missing an unlock of chan_lock and I see no changes to l2cap_sock.c
which are needed. Moreover, you need to use the unlocked versions of
the chan lookup functions and check if we still need the locked ones.
If I wasn't clear in some points please just ask in that thread.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
