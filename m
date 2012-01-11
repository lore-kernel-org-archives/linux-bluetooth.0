Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326214206.6454.211.camel@aeonflux>
References: <1326201988-17651-1-git-send-email-luiz.dentz@gmail.com>
	<1326214206.6454.211.camel@aeonflux>
Date: Wed, 11 Jan 2012 12:07:24 +0200
Message-ID: <CABBYNZJ1YuVFjNX+tTu9qsFSnu=2wiBpALe2BTNQqu1152+n0w@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: make use of MSG_DONTROUTE flag in L2CAP sockets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 10, 2012 at 6:50 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> This use MSG_DONTROUTE to send a single message with highest possible
>> priority without having to rely on socket options.
>>
>> This is useful for RFCOMM which relies on socket interface to send frame=
s
>> to L2CAP, but since some of this frames are actual commands that can
>> timeout they should be sent as soon as possible.
>>
>> For userspace this also offer the convenience of not having to use
>> setsockopt several times when only a single/some messages needs to be
>> prioritize.
>
> are you sure that we are not mis-using the MSG_DONTROUTE flag?

This is the reason Ive sent as RFC, man page says it is only define
for protocols that route, but note that MSG_TRYHARD does map to the
same value (4) so the meaning depend on the protocol. Perhaps creating
a new flag e.g. MSG_HIGHPRIO would be acceptable?

>> + =A0 =A0 priority =3D sk->sk_priority;
>> +
>> + =A0 =A0 /* MSG_DONTROUTE send message at maximum possible priority */
>> + =A0 =A0 if ((msg->msg_flags & MSG_DONTROUTE) && priority < HCI_PRIO_MA=
X - 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 priority =3D HCI_PRIO_MAX - 1;
>> +
>
> you need to enforce the same privilege check that SO_PRIORITY does.
> Otherwise every single application can just go and overwrite it.

Currently HCI_PRIO_MAX - 1 maps to the highest priority without
requiring privileges, but I can change that to HCI_PRIO_MAX so only
privileged processes such bluetoothd can make use of it.

--=20
Luiz Augusto von Dentz
