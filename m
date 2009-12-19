Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1261182368.4041.114.camel@localhost.localdomain>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260482634.2901.70.camel@violet> <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
	<1261006596.4041.39.camel@localhost.localdomain> <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
	<1261177540.4041.106.camel@localhost.localdomain> <35c90d960912181523n1067f87cw1d585a17ba57475a@mail.gmail.com>
	<1261180228.4041.111.camel@localhost.localdomain> <35c90d960912181612x494c5626r8cd01168e4991e7@mail.gmail.com>
	<1261182368.4041.114.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Fri, 18 Dec 2009 17:50:15 -0800
Message-ID: <35c90d960912181750g6f82c3c1tf89df6aec2ae97cf@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 18, 2009 at 4:26 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nick,
>
>> =A0 =A0 =A0 =A0 > > > >> >> >> Right now Bluez always requests flushable=
 ACL
>> =A0 =A0 =A0 =A0 packets (but does not
>> =A0 =A0 =A0 =A0 > > > >> >> >> set a flush timeout, so effectively they =
are
>> =A0 =A0 =A0 =A0 non-flushable):
>> =A0 =A0 =A0 =A0 > > > >> >> >>
>> =A0 =A0 =A0 =A0 > > > >> >> >> However it is desirable to use an ACL flu=
sh
>> =A0 =A0 =A0 =A0 timeout on A2DP packets so
>> =A0 =A0 =A0 =A0 > > > >> >> >> that if the ACL packets block for some re=
ason
>> =A0 =A0 =A0 =A0 then the LM can flush
>> =A0 =A0 =A0 =A0 > > > >> >> >> them to make room for newer packets.
>> =A0 =A0 =A0 =A0 > > > >> >> >>
>> =A0 =A0 =A0 =A0 > > > >> >> >> Is it reasonable for Bluez to use the 0x0=
0 ACL
>> =A0 =A0 =A0 =A0 packet boundary flag by
>> =A0 =A0 =A0 =A0 > > > >> >> >> default (non-flushable packet), and let
>> =A0 =A0 =A0 =A0 userspace request flushable
>> =A0 =A0 =A0 =A0 > > > >> >> >> packets on A2DP L2CAP sockets with the so=
cket
>> =A0 =A0 =A0 =A0 option
>> =A0 =A0 =A0 =A0 > > > >> >> >> L2CAP_LM_RELIABLE.
>> =A0 =A0 =A0 =A0 > > > >> >> >
>> =A0 =A0 =A0 =A0 > > > >> >> > the reliable option has a different meanin=
g. It
>> =A0 =A0 =A0 =A0 comes back from the old
>> =A0 =A0 =A0 =A0 > > > >> >> > Bluetooth 1.1 qualification days where we =
had to
>> =A0 =A0 =A0 =A0 tests on L2CAP that had
>> =A0 =A0 =A0 =A0 > > > >> >> > to confirm that we can detect malformed pa=
ckets
>> =A0 =A0 =A0 =A0 and report them. These
>> =A0 =A0 =A0 =A0 > > > >> >> > days it is just fine to drop them.
>> =A0 =A0 =A0 =A0 > > > >> >>
>> =A0 =A0 =A0 =A0 > > > >> >> Got it, how about introducing
>> =A0 =A0 =A0 =A0 > > > >> >>
>> =A0 =A0 =A0 =A0 > > > >> >> #define L2CAP_LM_FLUSHABLE 0x0040
>> =A0 =A0 =A0 =A0 > > > >> >
>> =A0 =A0 =A0 =A0 > > > >> > that l2cap_sock_setsockopt_old() sets this di=
dn't
>> =A0 =A0 =A0 =A0 give you a hint that
>> =A0 =A0 =A0 =A0 > > > >> > we might wanna deprecate this socket options =
;)
>> =A0 =A0 =A0 =A0 > > > >> >
>> =A0 =A0 =A0 =A0 > > > >> > I need to read up on the flushable stuff, but=
 in
>> =A0 =A0 =A0 =A0 the end it deserves its
>> =A0 =A0 =A0 =A0 > > > >> > own socket option. Also an ioctl() to actuall=
y
>> =A0 =A0 =A0 =A0 trigger Enhanced flush
>> =A0 =A0 =A0 =A0 > > > >> > might be needed.
>> =A0 =A0 =A0 =A0 > > > >> >
>> =A0 =A0 =A0 =A0 > > > >> >> struct l2cap_pinfo {
>> =A0 =A0 =A0 =A0 > > > >> >> =A0 =A0...
>> =A0 =A0 =A0 =A0 > > > >> >> =A0 =A0__u8 flushable;
>> =A0 =A0 =A0 =A0 > > > >> >> }
>> =A0 =A0 =A0 =A0 > > > >> >
>> =A0 =A0 =A0 =A0 > > > >> > Sure. In the long run we need to turn this in=
to a
>> =A0 =A0 =A0 =A0 bitmask. We are just
>> =A0 =A0 =A0 =A0 > > > >> > wasting memory here.
>> =A0 =A0 =A0 =A0 > > > >>
>> =A0 =A0 =A0 =A0 > > > >> Attached is an updated patch, that checks the L=
MP
>> =A0 =A0 =A0 =A0 features bitmask
>> =A0 =A0 =A0 =A0 > > > >> before using the new non-flushable packet type.
>> =A0 =A0 =A0 =A0 > > > >>
>> =A0 =A0 =A0 =A0 > > > >> I am still using L2CAP_LM_FLUSHABLE socket opti=
on in
>> =A0 =A0 =A0 =A0 > > > >> l2cap_sock_setsockopt_old(), which I don't thin=
k you
>> =A0 =A0 =A0 =A0 are happy with.
>> =A0 =A0 =A0 =A0 > > > >> So how about a new option:
>> =A0 =A0 =A0 =A0 > > > >>
>> =A0 =A0 =A0 =A0 > > > >> SOL_L2CAP, L2CAP_ACL_FLUSH
>> =A0 =A0 =A0 =A0 > > > >> which has a default value of 0, and can be set =
to 1
>> =A0 =A0 =A0 =A0 to make the ACL
>> =A0 =A0 =A0 =A0 > > > >> data sent by this L2CAP socket flushable.
>> =A0 =A0 =A0 =A0 > > >
>> =A0 =A0 =A0 =A0 > > > Was this proposal ok?
>> =A0 =A0 =A0 =A0 > >
>> =A0 =A0 =A0 =A0 > > Even SOL_L2CAP goes away. Use SOL_BLUETOOTH for this=
.
>> =A0 =A0 =A0 =A0 > >
>> =A0 =A0 =A0 =A0 > > > >> In a later commit we would then add
>> =A0 =A0 =A0 =A0 > > > >> SOL_ACL, ACL_FLUSH_TIMEOUT
>> =A0 =A0 =A0 =A0 > > > >> That is used to set an automatic flush timeout =
for
>> =A0 =A0 =A0 =A0 the ACL link on a
>> =A0 =A0 =A0 =A0 > > > >> L2CAP socket. Note that SOL_ACL is new.
>> =A0 =A0 =A0 =A0 > > > >
>> =A0 =A0 =A0 =A0 > > > > can I stop you right here (without even looking =
at the
>> =A0 =A0 =A0 =A0 patch). We do
>> =A0 =A0 =A0 =A0 > > > > have the generic SOL_BLUETOOTH that you should b=
e
>> =A0 =A0 =A0 =A0 using. So adding
>> =A0 =A0 =A0 =A0 > > > > SOL_ACL is not a viable option at all.
>> =A0 =A0 =A0 =A0 > > >
>> =A0 =A0 =A0 =A0 > > > This would be in a later patch, and SOL_BLUETOOTH,
>> =A0 =A0 =A0 =A0 ACL_FLUSH_TIMEOUT
>> =A0 =A0 =A0 =A0 > > > is fine too, or whatever you prefer.
>> =A0 =A0 =A0 =A0 > >
>> =A0 =A0 =A0 =A0 > > Why not just use BT_FLUSHABLE and have it always tak=
e a
>> =A0 =A0 =A0 =A0 timeout option
>> =A0 =A0 =A0 =A0 > > and then 0 means not flushable. And advantage of hav=
ing it
>> =A0 =A0 =A0 =A0 separated?
>> =A0 =A0 =A0 =A0 >
>> =A0 =A0 =A0 =A0 > I think keeping them separate makes it clear that the =
flush
>> =A0 =A0 =A0 =A0 timeout is
>> =A0 =A0 =A0 =A0 > global for a given ACL link, whereas the
>> =A0 =A0 =A0 =A0 flushable/non-flushable
>> =A0 =A0 =A0 =A0 > boolean is specific to a L2CAP channel. (Which is why =
I
>> =A0 =A0 =A0 =A0 suggested
>> =A0 =A0 =A0 =A0 > introducing a new level SOL_ACL for the ACL_FLUSH_TIME=
OUT
>> =A0 =A0 =A0 =A0 option -
>> =A0 =A0 =A0 =A0 > since this option applies at the ACL level in the stac=
k).
>> =A0 =A0 =A0 =A0 >
>> =A0 =A0 =A0 =A0 > A specific advantage of this is that flushable packets=
 can
>> =A0 =A0 =A0 =A0 be enabled
>> =A0 =A0 =A0 =A0 > without over-writing a previous flush timeout that was=
 set
>> =A0 =A0 =A0 =A0 on a
>> =A0 =A0 =A0 =A0 > different L2CAP socket on the same ACL link. I guess t=
his
>> =A0 =A0 =A0 =A0 can also be
>> =A0 =A0 =A0 =A0 > achieved with getsockopt() but that is racy.
>>
>>
>> =A0 =A0 =A0 =A0 I am talking here about Enhanced Flush support and that =
would
>> =A0 =A0 =A0 =A0 happen on
>> =A0 =A0 =A0 =A0 a per ACL handle basis. So it actually almost applies on=
 a per
>> =A0 =A0 =A0 =A0 L2CAP
>> =A0 =A0 =A0 =A0 socket level. Only exception is if you establish two or =
more
>> =A0 =A0 =A0 =A0 L2CAP
>> =A0 =A0 =A0 =A0 connections to the same remote device and set them all t=
o
>> =A0 =A0 =A0 =A0 flushable.
>> =A0 =A0 =A0 =A0 Then of course all of them will be flushed. So strictly
>> =A0 =A0 =A0 =A0 speaking it
>> =A0 =A0 =A0 =A0 might be an ACL link feature, but we don't wanna use it =
that
>> =A0 =A0 =A0 =A0 way. And in
>> =A0 =A0 =A0 =A0 practice you won't have multiple concurrent flushable L2=
CAP
>> =A0 =A0 =A0 =A0 connections
>> =A0 =A0 =A0 =A0 to one remote device anyway.
>>
>>
>> I agree that having 2 flush-able L2CAP channels to the same device
>> would probably not be common. But who knows what new profiles the
>> Bluetooth SIG will come up with that might also benefit from
>> flush-able ACL data. And if a use-case comes up, then your proposed
>> API will require programmers to write a racy getsockopt/setsockopt if
>> they want to turn on flushing on one l2cap connection without
>> affecting the ACL flush timeout set by another connection. Building
>> race conditions into an API seems like a sub-optimal design choice.
>
> are you expecting to change this frequently and from different parts of
> the code during the lifetime of a socket. I just don't see that
> happening at all actually. Either you create a "flushable" socket or you
> don't. Fill me in on how you wanna actually use this feature.

My use case is just for A2DP. I turn on flushing with a timeout of say
160ms just before starting streaming of A2DP data, and turn it off
when I finish. This is not a problem with either API proposal.

Where it becomes a problem is if there is a reason to have two
flush-able L2CAP connections to the same host. With your API proposal,
the second connection has no way of turning on flushing without
over-writing the flush timeout set by the first socket. You could
implement another API to read the current flush timeout, and have the
second socket read that API, but thats racy.

If this is not a use-case you care about, then ok. But I just want to
point out that this is a problem that will be baked into the API - and
will require ugly workarounds in userspace as soon as someone requires
2 flushable L2CAP connections to one host. Given the rate at which
Bluetooth changes and new profiles and use cases are added I would not
be so quick to dismiss this use case.

>
>> But its not worth arguing over. SOL_BLUETOOTH, BT_FLUSHABLE is fine
>> (or BT_FLUSH_TIMEOUT instead).
>
> I would call it BT_FLUSHABLE as of now. Since that is how the
> specification calls it. However I do have to refresh my memory with the
> actual details. I haven't read that part of the specification in a long
> time.
>
> Regards
>
> Marcel
>
>
>
