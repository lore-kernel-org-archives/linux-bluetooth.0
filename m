Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1261006596.4041.39.camel@localhost.localdomain>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260335175.2901.20.camel@violet> <35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>
	<1260482634.2901.70.camel@violet> <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
	<1261006596.4041.39.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Wed, 16 Dec 2009 15:48:31 -0800
Message-ID: <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 16, 2009 at 3:36 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nick,
>
>> >> >> Right now Bluez always requests flushable ACL packets (but does no=
t
>> >> >> set a flush timeout, so effectively they are non-flushable):
>> >> >>
>> >> >> However it is desirable to use an ACL flush timeout on A2DP packet=
s so
>> >> >> that if the ACL packets block for some reason then the LM can flus=
h
>> >> >> them to make room for newer packets.
>> >> >>
>> >> >> Is it reasonable for Bluez to use the 0x00 ACL packet boundary fla=
g by
>> >> >> default (non-flushable packet), and let userspace request flushabl=
e
>> >> >> packets on A2DP L2CAP sockets with the socket option
>> >> >> L2CAP_LM_RELIABLE.
>> >> >
>> >> > the reliable option has a different meaning. It comes back from the=
 old
>> >> > Bluetooth 1.1 qualification days where we had to tests on L2CAP tha=
t had
>> >> > to confirm that we can detect malformed packets and report them. Th=
ese
>> >> > days it is just fine to drop them.
>> >>
>> >> Got it, how about introducing
>> >>
>> >> #define L2CAP_LM_FLUSHABLE 0x0040
>> >
>> > that l2cap_sock_setsockopt_old() sets this didn't give you a hint that
>> > we might wanna deprecate this socket options ;)
>> >
>> > I need to read up on the flushable stuff, but in the end it deserves i=
ts
>> > own socket option. Also an ioctl() to actually trigger Enhanced flush
>> > might be needed.
>> >
>> >> struct l2cap_pinfo {
>> >> =A0 =A0...
>> >> =A0 =A0__u8 flushable;
>> >> }
>> >
>> > Sure. In the long run we need to turn this into a bitmask. We are just
>> > wasting memory here.
>>
>> Attached is an updated patch, that checks the LMP features bitmask
>> before using the new non-flushable packet type.
>>
>> I am still using L2CAP_LM_FLUSHABLE socket option in
>> l2cap_sock_setsockopt_old(), which I don't think you are happy with.
>> So how about a new option:
>>
>> SOL_L2CAP, L2CAP_ACL_FLUSH
>> which has a default value of 0, and can be set to 1 to make the ACL
>> data sent by this L2CAP socket flushable.

Was this proposal ok?

>> In a later commit we would then add
>> SOL_ACL, ACL_FLUSH_TIMEOUT
>> That is used to set an automatic flush timeout for the ACL link on a
>> L2CAP socket. Note that SOL_ACL is new.
>
> can I stop you right here (without even looking at the patch). We do
> have the generic SOL_BLUETOOTH that you should be using. So adding
> SOL_ACL is not a viable option at all.

This would be in a later patch, and SOL_BLUETOOTH, ACL_FLUSH_TIMEOUT
is fine too, or whatever you prefer.

Nick
