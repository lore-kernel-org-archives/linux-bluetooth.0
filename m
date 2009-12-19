Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1261188322.4041.127.camel@localhost.localdomain>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1261006596.4041.39.camel@localhost.localdomain> <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
	<1261177540.4041.106.camel@localhost.localdomain> <35c90d960912181523n1067f87cw1d585a17ba57475a@mail.gmail.com>
	<1261180228.4041.111.camel@localhost.localdomain> <35c90d960912181612x494c5626r8cd01168e4991e7@mail.gmail.com>
	<1261182368.4041.114.camel@localhost.localdomain> <35c90d960912181750g6f82c3c1tf89df6aec2ae97cf@mail.gmail.com>
	<1261188322.4041.127.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Fri, 18 Dec 2009 19:00:16 -0800
Message-ID: <35c90d960912181900y42baaefdp6cecb0459ee63fe1@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 18, 2009 at 6:05 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nick,
>
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> Right now Bluez always requests flusha=
ble ACL
>> >> =A0 =A0 =A0 =A0 packets (but does not
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> set a flush timeout, so effectively th=
ey are
>> >> =A0 =A0 =A0 =A0 non-flushable):
>> >> =A0 =A0 =A0 =A0 > > > >> >> >>
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> However it is desirable to use an ACL =
flush
>> >> =A0 =A0 =A0 =A0 timeout on A2DP packets so
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> that if the ACL packets block for some=
 reason
>> >> =A0 =A0 =A0 =A0 then the LM can flush
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> them to make room for newer packets.
>> >> =A0 =A0 =A0 =A0 > > > >> >> >>
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> Is it reasonable for Bluez to use the =
0x00 ACL
>> >> =A0 =A0 =A0 =A0 packet boundary flag by
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> default (non-flushable packet), and le=
t
>> >> =A0 =A0 =A0 =A0 userspace request flushable
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> packets on A2DP L2CAP sockets with the=
 socket
>> >> =A0 =A0 =A0 =A0 option
>> >> =A0 =A0 =A0 =A0 > > > >> >> >> L2CAP_LM_RELIABLE.
>> >> =A0 =A0 =A0 =A0 > > > >> >> >
>> >> =A0 =A0 =A0 =A0 > > > >> >> > the reliable option has a different mea=
ning. It
>> >> =A0 =A0 =A0 =A0 comes back from the old
>> >> =A0 =A0 =A0 =A0 > > > >> >> > Bluetooth 1.1 qualification days where =
we had to
>> >> =A0 =A0 =A0 =A0 tests on L2CAP that had
>> >> =A0 =A0 =A0 =A0 > > > >> >> > to confirm that we can detect malformed=
 packets
>> >> =A0 =A0 =A0 =A0 and report them. These
>> >> =A0 =A0 =A0 =A0 > > > >> >> > days it is just fine to drop them.
>> >> =A0 =A0 =A0 =A0 > > > >> >>
>> >> =A0 =A0 =A0 =A0 > > > >> >> Got it, how about introducing
>> >> =A0 =A0 =A0 =A0 > > > >> >>
>> >> =A0 =A0 =A0 =A0 > > > >> >> #define L2CAP_LM_FLUSHABLE 0x0040
>> >> =A0 =A0 =A0 =A0 > > > >> >
>> >> =A0 =A0 =A0 =A0 > > > >> > that l2cap_sock_setsockopt_old() sets this=
 didn't
>> >> =A0 =A0 =A0 =A0 give you a hint that
>> >> =A0 =A0 =A0 =A0 > > > >> > we might wanna deprecate this socket optio=
ns ;)
>> >> =A0 =A0 =A0 =A0 > > > >> >
>> >> =A0 =A0 =A0 =A0 > > > >> > I need to read up on the flushable stuff, =
but in
>> >> =A0 =A0 =A0 =A0 the end it deserves its
>> >> =A0 =A0 =A0 =A0 > > > >> > own socket option. Also an ioctl() to actu=
ally
>> >> =A0 =A0 =A0 =A0 trigger Enhanced flush
>> >> =A0 =A0 =A0 =A0 > > > >> > might be needed.
>> >> =A0 =A0 =A0 =A0 > > > >> >
>> >> =A0 =A0 =A0 =A0 > > > >> >> struct l2cap_pinfo {
>> >> =A0 =A0 =A0 =A0 > > > >> >> =A0 =A0...
>> >> =A0 =A0 =A0 =A0 > > > >> >> =A0 =A0__u8 flushable;
>> >> =A0 =A0 =A0 =A0 > > > >> >> }
>> >> =A0 =A0 =A0 =A0 > > > >> >
>> >> =A0 =A0 =A0 =A0 > > > >> > Sure. In the long run we need to turn this=
 into a
>> >> =A0 =A0 =A0 =A0 bitmask. We are just
>> >> =A0 =A0 =A0 =A0 > > > >> > wasting memory here.
>> >> =A0 =A0 =A0 =A0 > > > >>
>> >> =A0 =A0 =A0 =A0 > > > >> Attached is an updated patch, that checks th=
e LMP
>> >> =A0 =A0 =A0 =A0 features bitmask
>> >> =A0 =A0 =A0 =A0 > > > >> before using the new non-flushable packet ty=
pe.
>> >> =A0 =A0 =A0 =A0 > > > >>
>> >> =A0 =A0 =A0 =A0 > > > >> I am still using L2CAP_LM_FLUSHABLE socket o=
ption in
>> >> =A0 =A0 =A0 =A0 > > > >> l2cap_sock_setsockopt_old(), which I don't t=
hink you
>> >> =A0 =A0 =A0 =A0 are happy with.
>> >> =A0 =A0 =A0 =A0 > > > >> So how about a new option:
>> >> =A0 =A0 =A0 =A0 > > > >>
>> >> =A0 =A0 =A0 =A0 > > > >> SOL_L2CAP, L2CAP_ACL_FLUSH
>> >> =A0 =A0 =A0 =A0 > > > >> which has a default value of 0, and can be s=
et to 1
>> >> =A0 =A0 =A0 =A0 to make the ACL
>> >> =A0 =A0 =A0 =A0 > > > >> data sent by this L2CAP socket flushable.
>> >> =A0 =A0 =A0 =A0 > > >
>> >> =A0 =A0 =A0 =A0 > > > Was this proposal ok?
>> >> =A0 =A0 =A0 =A0 > >
>> >> =A0 =A0 =A0 =A0 > > Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for t=
his.
>> >> =A0 =A0 =A0 =A0 > >
>> >> =A0 =A0 =A0 =A0 > > > >> In a later commit we would then add
>> >> =A0 =A0 =A0 =A0 > > > >> SOL_ACL, ACL_FLUSH_TIMEOUT
>> >> =A0 =A0 =A0 =A0 > > > >> That is used to set an automatic flush timeo=
ut for
>> >> =A0 =A0 =A0 =A0 the ACL link on a
>> >> =A0 =A0 =A0 =A0 > > > >> L2CAP socket. Note that SOL_ACL is new.
>> >> =A0 =A0 =A0 =A0 > > > >
>> >> =A0 =A0 =A0 =A0 > > > > can I stop you right here (without even looki=
ng at the
>> >> =A0 =A0 =A0 =A0 patch). We do
>> >> =A0 =A0 =A0 =A0 > > > > have the generic SOL_BLUETOOTH that you shoul=
d be
>> >> =A0 =A0 =A0 =A0 using. So adding
>> >> =A0 =A0 =A0 =A0 > > > > SOL_ACL is not a viable option at all.
>> >> =A0 =A0 =A0 =A0 > > >
>> >> =A0 =A0 =A0 =A0 > > > This would be in a later patch, and SOL_BLUETOO=
TH,
>> >> =A0 =A0 =A0 =A0 ACL_FLUSH_TIMEOUT
>> >> =A0 =A0 =A0 =A0 > > > is fine too, or whatever you prefer.
>> >> =A0 =A0 =A0 =A0 > >
>> >> =A0 =A0 =A0 =A0 > > Why not just use BT_FLUSHABLE and have it always =
take a
>> >> =A0 =A0 =A0 =A0 timeout option
>> >> =A0 =A0 =A0 =A0 > > and then 0 means not flushable. And advantage of =
having it
>> >> =A0 =A0 =A0 =A0 separated?
>> >> =A0 =A0 =A0 =A0 >
>> >> =A0 =A0 =A0 =A0 > I think keeping them separate makes it clear that t=
he flush
>> >> =A0 =A0 =A0 =A0 timeout is
>> >> =A0 =A0 =A0 =A0 > global for a given ACL link, whereas the
>> >> =A0 =A0 =A0 =A0 flushable/non-flushable
>> >> =A0 =A0 =A0 =A0 > boolean is specific to a L2CAP channel. (Which is w=
hy I
>> >> =A0 =A0 =A0 =A0 suggested
>> >> =A0 =A0 =A0 =A0 > introducing a new level SOL_ACL for the ACL_FLUSH_T=
IMEOUT
>> >> =A0 =A0 =A0 =A0 option -
>> >> =A0 =A0 =A0 =A0 > since this option applies at the ACL level in the s=
tack).
>> >> =A0 =A0 =A0 =A0 >
>> >> =A0 =A0 =A0 =A0 > A specific advantage of this is that flushable pack=
ets can
>> >> =A0 =A0 =A0 =A0 be enabled
>> >> =A0 =A0 =A0 =A0 > without over-writing a previous flush timeout that =
was set
>> >> =A0 =A0 =A0 =A0 on a
>> >> =A0 =A0 =A0 =A0 > different L2CAP socket on the same ACL link. I gues=
s this
>> >> =A0 =A0 =A0 =A0 can also be
>> >> =A0 =A0 =A0 =A0 > achieved with getsockopt() but that is racy.
>> >>
>> >>
>> >> =A0 =A0 =A0 =A0 I am talking here about Enhanced Flush support and th=
at would
>> >> =A0 =A0 =A0 =A0 happen on
>> >> =A0 =A0 =A0 =A0 a per ACL handle basis. So it actually almost applies=
 on a per
>> >> =A0 =A0 =A0 =A0 L2CAP
>> >> =A0 =A0 =A0 =A0 socket level. Only exception is if you establish two =
or more
>> >> =A0 =A0 =A0 =A0 L2CAP
>> >> =A0 =A0 =A0 =A0 connections to the same remote device and set them al=
l to
>> >> =A0 =A0 =A0 =A0 flushable.
>> >> =A0 =A0 =A0 =A0 Then of course all of them will be flushed. So strict=
ly
>> >> =A0 =A0 =A0 =A0 speaking it
>> >> =A0 =A0 =A0 =A0 might be an ACL link feature, but we don't wanna use =
it that
>> >> =A0 =A0 =A0 =A0 way. And in
>> >> =A0 =A0 =A0 =A0 practice you won't have multiple concurrent flushable=
 L2CAP
>> >> =A0 =A0 =A0 =A0 connections
>> >> =A0 =A0 =A0 =A0 to one remote device anyway.
>> >>
>> >>
>> >> I agree that having 2 flush-able L2CAP channels to the same device
>> >> would probably not be common. But who knows what new profiles the
>> >> Bluetooth SIG will come up with that might also benefit from
>> >> flush-able ACL data. And if a use-case comes up, then your proposed
>> >> API will require programmers to write a racy getsockopt/setsockopt if
>> >> they want to turn on flushing on one l2cap connection without
>> >> affecting the ACL flush timeout set by another connection. Building
>> >> race conditions into an API seems like a sub-optimal design choice.
>> >
>> > are you expecting to change this frequently and from different parts o=
f
>> > the code during the lifetime of a socket. I just don't see that
>> > happening at all actually. Either you create a "flushable" socket or y=
ou
>> > don't. Fill me in on how you wanna actually use this feature.
>>
>> My use case is just for A2DP. I turn on flushing with a timeout of say
>> 160ms just before starting streaming of A2DP data, and turn it off
>> when I finish. This is not a problem with either API proposal.
>
> I count this as creating socket, setting flushable and then using it.
> Then closing it. And especially in A2DP case where the media socket is
> brought up and taken down a lot that is a proper usage. However I do
> expect that each socket should not change from flushable to
> non-flushable in mid term usage. While potentially possible it don't see
> its usage at all.
>
> So we could even force the flushable option into non-changeable after
> the socket has been connected. Like changing the MTU afterwards makes no
> sense.
>
>> Where it becomes a problem is if there is a reason to have two
>> flush-able L2CAP connections to the same host. With your API proposal,
>> the second connection has no way of turning on flushing without
>> over-writing the flush timeout set by the first socket. You could
>> implement another API to read the current flush timeout, and have the
>> second socket read that API, but thats racy.
>>
>> If this is not a use-case you care about, then ok. But I just want to
>> point out that this is a problem that will be baked into the API - and
>> will require ugly workarounds in userspace as soon as someone requires
>> 2 flushable L2CAP connections to one host. Given the rate at which
>> Bluetooth changes and new profiles and use cases are added I would not
>> be so quick to dismiss this use case.
>
> So my idea would actually be that every socket can has its own flush
> timeout, but the core than picks the time to actually do the flushing of
> packets. Also we can not have one socket change a socket option of
> another one. It is a per socket option and not a global one.

I think you are confused. This patch does not implement HCI Enhance
Flush Command. The flush timeout that I am referring to is passed to
the Bluetooth Chipset with the HCI Write Automatic Flush Timeout
command. Which is why it is global for the ACL link.

>
> On other possible way would be to use CMSG details to inform sockets
> about flushable packets. We have to see how useful that is. Since the
> flushable is only useful for the time in between the packet is hold in
> the Bluetooth chip buffers and hasn't been transmitted over the air.
> Once the packet is on the air, there is nothing to flush anymore. And
> with L2CAP ERTM this all becomes obsolete since we can flush at any time
> anyway. The retransmission takes care of any accidental flush.
>
> Regards
>
> Marcel
>
>
>
